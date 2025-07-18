#!/bin/bash
# ADR Helper Script v2.0 - Enhanced with Authorization & Multi-Developer Support

set -e

CLAUDE_DIR=".claude"
INDEX_FILE="$CLAUDE_DIR/adr-index.toml"

# Color output for better UX
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Validate TOML syntax (basic check)
validate_toml() {
    local file="$1"
    if [[ ! -f "$file" ]]; then
        echo -e "${RED}ERROR: File not found: $file${NC}"
        return 1
    fi

    # Basic TOML validation checks
    if ! grep -q "^\[metadata\]" "$file"; then
        echo -e "${RED}ERROR: Missing [metadata] section in TOML${NC}"
        return 1
    fi

    # Check for unmatched braces (basic check)
    local open_braces=$(grep -o '{' "$file" | wc -l | tr -d '[:space:]')
    local close_braces=$(grep -o '}' "$file" | wc -l | tr -d '[:space:]')

    if [[ ${open_braces:-0} -ne ${close_braces:-0} ]]; then
        echo -e "${RED}ERROR: Unmatched braces in TOML file (${open_braces} open, ${close_braces} close)${NC}"
        return 1
    fi

    return 0
}

# Backup TOML file before modifications
backup_toml() {
    local file="$1"
    if [[ -f "$file" ]]; then
        mkdir -p "$CLAUDE_DIR/backups"
        cp "$file" "$CLAUDE_DIR/backups/adr-index.toml.backup.$(date +%s)"
        echo -e "${BLUE}📋 Created backup of index file${NC}"
    fi
}

# Create full system backup before major operations
backup_system() {
    mkdir -p .claude/backups
    local backup_name=".claude/backups/system-backup-$(date +%s).tar.gz"
    if tar -czf "$backup_name" .claude/ --exclude='.claude/backups' 2>/dev/null; then
        echo -e "${GREEN}✅ Created full system backup: $backup_name${NC}"
        return 0
    else
        echo -e "${YELLOW}⚠️ Failed to create system backup${NC}"
        return 1
    fi
}

# Restore from most recent backup
restore_system() {
    local latest_backup=$(find .claude/backups -name "system-backup-*.tar.gz" -type f 2>/dev/null | sort -r | head -1)
    if [[ -n "$latest_backup" ]]; then
        echo -e "${YELLOW}🔄 Restoring from backup: $latest_backup${NC}"
        local temp_dir=$(mktemp -d)
        tar -xzf "$latest_backup" -C "$temp_dir"
        rm -rf .claude/
        mv "$temp_dir/.claude" .
        rmdir "$temp_dir"
        echo -e "${GREEN}✅ System restored from backup${NC}"
        return 0
    else
        echo -e "${RED}❌ No backup files found${NC}"
        return 1
    fi
}

# Sanitize variable output (remove whitespace, newlines)
sanitize_var() {
    echo "$1" | tr -d '[:space:]'
}

# Safe arithmetic operation
safe_add() {
    local sum=0
    for arg in "$@"; do
        local clean_arg=$(sanitize_var "$arg")
        if [[ "$clean_arg" =~ ^[0-9]+$ ]]; then
            sum=$((sum + clean_arg))
        fi
    done
    echo "$sum"
}

# Ensure we're in a project with the system
if [[ ! -f "$INDEX_FILE" ]]; then
    echo -e "${RED}ERROR: No ADR index found. Run this from a project with Claude Context System.${NC}"
    echo -e "${YELLOW}HINT: Run this from a directory containing .claude/adr-index.toml${NC}"
    exit 1
fi

# Validate TOML on startup
if ! validate_toml "$INDEX_FILE"; then
    echo -e "${RED}ERROR: TOML validation failed. Please fix the index file.${NC}"
    echo -e "${YELLOW}HINT: Check for missing braces, duplicate sections, or syntax errors${NC}"
    exit 1
fi

# Get current date in ISO format
current_date() {
    date +%Y-%m-%d
}

# Create new ADR
new_adr() {
    local category_input="${1:-feat}"
    local title="${2:-new-decision}"
    local sanitized_title=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g')

    # Parse category and optional component
    local category=""
    local component=""

    # Handle component syntax: feat/auth or feat(auth)
    if [[ "$category_input" =~ ^([a-z]+)\(([a-z0-9-]+)\)$ ]]; then
        # Pattern: feat(auth)
        category="${BASH_REMATCH[1]}"
        component="${BASH_REMATCH[2]}"
    elif [[ "$category_input" =~ ^([a-z]+)/([a-z0-9-]+)$ ]]; then
        # Pattern: feat/auth
        category="${BASH_REMATCH[1]}"
        component="${BASH_REMATCH[2]}"
    else
        # Simple pattern: feat
        category="$category_input"
    fi

    # Build file path with optional component
    local adr_file=""
    if [[ -n "$component" ]]; then
        adr_file="$CLAUDE_DIR/branches/$category/$component/$sanitized_title.md"
        mkdir -p "$CLAUDE_DIR/branches/$category/$component"
    else
        adr_file="$CLAUDE_DIR/branches/$category/$sanitized_title.md"
    fi

    # Ensure category directory exists
    mkdir -p "$CLAUDE_DIR/branches/$category"

    if [[ -f "$adr_file" ]]; then
        echo -e "${RED}ERROR: ADR already exists: $adr_file${NC}"
        exit 1
    fi

    mkdir -p "$(dirname "$adr_file")"

    # Generate template with proper date expansion
    local creation_date=$(current_date)
    cat > "$adr_file" << EOF
# ADR: $title

**Status**: Proposed
**Date**: $creation_date
**Author**: Claude Context System Team
**Tags**: [simulation, $category, $creation_date]

## Context

[This section describes the situation and context that led to this decision.]

## Decision

[This section describes the architectural decision made.]

## Consequences

[This section describes the expected outcomes and trade-offs of this decision.]

## Alternatives Considered

[This section lists other options that were evaluated.]

## References

- Related to: Claude Context System v2.0
- Created during: Enhanced system with improved tooling
EOF

    echo -e "${GREEN}✓ Created ADR: $adr_file${NC}"

    # Add to index (simplified version)
    local section_name="active.$category"
    if ! grep -q "\[$section_name\]" "$INDEX_FILE"; then
        echo "" >> "$INDEX_FILE"
        echo "[$section_name]" >> "$INDEX_FILE"
    fi

    # Backup before modifying TOML
    backup_toml "$INDEX_FILE"

    # Add ADR entry to index with component support
    local adr_path=""
    local creation_date=$(current_date)
    if [[ -n "$component" ]]; then
        adr_path="$category/$component/$sanitized_title.md"
        echo "\"$sanitized_title\" = { file = \"$adr_path\", status = \"proposed\", created = \"$creation_date\", component = \"$component\" }" >> "$INDEX_FILE"
    else
        adr_path="$category/$sanitized_title.md"
        echo "\"$sanitized_title\" = { file = \"$adr_path\", status = \"proposed\", created = \"$creation_date\" }" >> "$INDEX_FILE"
    fi

    # Validate TOML after modification
    if validate_toml "$INDEX_FILE"; then
        echo -e "${BLUE}📝 Updated index: $INDEX_FILE${NC}"
    else
        echo -e "${RED}ERROR: TOML validation failed after update. Restoring backup.${NC}"
        # Restore from backup if validation fails
        local latest_backup=$(find "$CLAUDE_DIR/backups" -name "adr-index.toml.backup.*" -type f 2>/dev/null | sort -r | head -1)
        if [[ -n "$latest_backup" ]]; then
            cp "$latest_backup" "$INDEX_FILE"
            echo -e "${YELLOW}Restored from backup: $latest_backup${NC}"
        fi
        exit 1
    fi
}

# Check due dates and overdue maintenance
check_due() {
    echo -e "${BLUE}🗓️ Maintenance Check - $(date +%Y-%m-%d)${NC}"
    echo ""

    local current_date=$(date +%Y-%m-%d)

    if [[ -f "$INDEX_FILE" ]]; then
        # Check each type of maintenance
        local system_due=$(grep "next_due_system" "$INDEX_FILE" | cut -d'"' -f2 || echo "")
        local permissions_due=$(grep "next_due_permissions" "$INDEX_FILE" | cut -d'"' -f2 || echo "")
        local team_config_due=$(grep "next_due_team_config" "$INDEX_FILE" | cut -d'"' -f2 || echo "")
        local adr_maintenance_due=$(grep "next_due_adr_maintenance" "$INDEX_FILE" | cut -d'"' -f2 || echo "")
        local context_due=$(grep "next_due_context" "$INDEX_FILE" | cut -d'"' -f2 || echo "")

        echo "📅 Due Dates Status:"
        echo "  System updates: ${system_due:-Not set}"
        echo "  Permission review: ${permissions_due:-Not set}"
        echo "  Team config review: ${team_config_due:-Not set}"
        echo "  ADR maintenance: ${adr_maintenance_due:-Not set}"
        echo "  Context update: ${context_due:-Not set}"

        # Check for overdue items
        local overdue=0
        if [[ "$current_date" > "$system_due" ]]; then
            echo -e "  ${RED}⚠️ System update overdue!${NC}"
            ((overdue++))
        fi
        if [[ "$current_date" > "$permissions_due" ]]; then
            echo -e "  ${RED}⚠️ Permission review overdue!${NC}"
            ((overdue++))
        fi
        if [[ "$current_date" > "$context_due" ]]; then
            echo -e "  ${RED}⚠️ Context update overdue!${NC}"
            ((overdue++))
        fi

        if [[ $overdue -eq 0 ]]; then
            echo -e "  ${GREEN}✓ All maintenance up to date${NC}"
        fi
    else
        echo -e "${YELLOW}⚠️ No ADR index found${NC}"
    fi
}

# Quick project status
status_brief() {
    echo -e "${BLUE}📊 Project Status Brief${NC}"
    echo ""

    if [[ -f "$INDEX_FILE" ]]; then
        local project_name=$(grep "^description" "$INDEX_FILE" | cut -d'"' -f2 || echo "Unknown Project")
        local version=$(grep "^version" "$INDEX_FILE" | cut -d'"' -f2 || echo "Unknown")

        echo "Project: $project_name"
        echo "Version: $version"
        echo ""

        # Count ADRs by category using robust counting
        local arch_count=$(sanitize_var "$(find "$CLAUDE_DIR/branches/arch" -name "*.md" 2>/dev/null | wc -l)")
        local feat_count=$(sanitize_var "$(find "$CLAUDE_DIR/branches/feat" -name "*.md" 2>/dev/null | wc -l)")
        local docs_count=$(sanitize_var "$(find "$CLAUDE_DIR/branches/docs" -name "*.md" 2>/dev/null | wc -l)")
        local chore_count=$(sanitize_var "$(find "$CLAUDE_DIR/branches/chore" -name "*.md" 2>/dev/null | wc -l)")

        echo "📋 Active ADRs:"
        echo "  Architecture: ${arch_count:-0}"
        echo "  Features: ${feat_count:-0}"
        echo "  Documentation: ${docs_count:-0}"
        echo "  Process/Chore: ${chore_count:-0}"

        local total=$(safe_add "$arch_count" "$feat_count" "$docs_count" "$chore_count")
        echo "  Total: $total decisions tracked"
    else
        echo -e "${RED}No ADR index found${NC}"
    fi
}

# Update context with current date
context_update() {
    echo -e "${BLUE}🔄 Context Update - $(date +%Y-%m-%d)${NC}"
    echo ""

    # Update last check times
    local current_date=$(date +%Y-%m-%d)
    local current_datetime=$(date -u +%Y-%m-%dT%H:%M:%SZ)

    if [[ -f "$INDEX_FILE" ]]; then
        # Update context check time
        sed -i.bak "s/last_check_context = .*/last_check_context = \"$current_date\"/" "$INDEX_FILE"
        echo -e "${GREEN}✓ Updated context check time${NC}"

        # Show current priorities
        echo ""
        echo "🎯 Current Focus Areas:"
        if [[ -d "$CLAUDE_DIR/branches" ]]; then
            find "$CLAUDE_DIR/branches" -name "*.md" -newer "$CLAUDE_DIR/adr-index.toml" 2>/dev/null | while read -r recent_adr; do
                echo "  • $(basename "$recent_adr" .md)"
            done
        fi

        echo ""
        echo "📅 Next maintenance due:"
        grep "next_due_" "$INDEX_FILE" | head -3
    else
        echo -e "${RED}No ADR index found${NC}"
    fi
}

# Scan for external changes (simplified version)
scan() {
    echo -e "${BLUE}🔍 Scanning for external changes...${NC}"
    echo ""

    if [[ ! -d ".git" ]]; then
        echo -e "${YELLOW}⚠️ Not a git repository. Skipping external change detection.${NC}"
        return 0
    fi

    # Get current branches with error handling
    echo "📊 Repository Status:"
    if git branch -a >/dev/null 2>&1; then
        local branch_count=$(sanitize_var "$(git branch -a | wc -l)")
        echo "  Total branches: ${branch_count:-0}"
    else
        echo "  Total branches: Unable to determine"
    fi

    # Get recent commits with error handling
    if git log --oneline --since="7 days ago" >/dev/null 2>&1; then
        local recent_commits=$(sanitize_var "$(git log --oneline --since="7 days ago" | wc -l)")
        echo "  Recent commits (7 days): ${recent_commits:-0}"
    else
        echo "  Recent commits (7 days): Unable to determine"
    fi

    # Show recent branches
    echo ""
    echo "🌿 Recent branches:"
    git branch -a --sort=-committerdate | head -5 | sed 's/^/  /'

    echo ""
    echo -e "${GREEN}✓ Scan complete${NC}"
}

# Show current priorities and blockers
priorities() {
    echo -e "${BLUE}🎯 Current Priorities${NC}"
    echo ""

    if [[ -d "$CLAUDE_DIR/branches" ]]; then
        echo "📋 Active Decision Areas:"
        for category in arch feat docs chore; do
            if [[ -d "$CLAUDE_DIR/branches/$category" ]]; then
                local count=$(sanitize_var "$(find "$CLAUDE_DIR/branches/$category" -name "*.md" 2>/dev/null | wc -l)")
                if [[ ${count:-0} -gt 0 ]]; then
                    echo "  ${category}: $count decisions"
                fi
            else
                echo "  ${category}: 0 decisions (directory not found)"
            fi
        done
    fi

    echo ""
    echo "🚧 Status Summary:"
    if [[ -f "$INDEX_FILE" ]]; then
        grep -c "status.*proposed" "$INDEX_FILE" 2>/dev/null | xargs -I {} echo "  Proposed: {} decisions"
        echo "  Ready for review: Check individual ADR files"
    fi
}

# List all ADRs
list_adrs() {
    echo -e "${BLUE}📋 Active ADRs:${NC}"

    if [[ -f "$INDEX_FILE" ]]; then
        grep -E '^\[active\.' "$INDEX_FILE" | while read -r section; do
            category=$(echo "$section" | sed 's/\[active\.//' | sed 's/\]//')
            echo -e "  ${GREEN}$category${NC}:"

            # Find ADRs in this category
            if [[ -d "$CLAUDE_DIR/branches/$category" ]]; then
                find "$CLAUDE_DIR/branches/$category" -name "*.md" -type f | while read -r adr; do
                    basename=$(basename "$adr" .md)
                    echo -e "    • $basename"
                done
            fi
        done
    else
        echo "No ADR index found"
    fi
}

# Show system status
status() {
    echo -e "${BLUE}📊 Claude Context System Status${NC}"
    echo ""

    if [[ -f "$INDEX_FILE" ]]; then
        echo -e "${GREEN}✓ System initialized${NC}"

        # Count ADRs by category with error handling
        for category in feat arch docs chore; do
            if [[ -d "$CLAUDE_DIR/branches/$category" ]]; then
                local count=$(sanitize_var "$(find "$CLAUDE_DIR/branches/$category" -name "*.md" -type f 2>/dev/null | wc -l)")
                echo -e "  $category: ${count:-0} ADRs"
            else
                echo -e "  $category: 0 ADRs (directory missing)"
            fi
        done

        echo ""
        echo -e "Last context update: $(grep 'last_check_context' "$INDEX_FILE" | cut -d'"' -f2)"
        echo -e "Next maintenance due: $(grep 'next_due_adr_maintenance' "$INDEX_FILE" | cut -d'"' -f2)"
    else
        echo -e "${RED}✗ System not initialized${NC}"
    fi
}

# Validate system integrity
validate() {
    echo -e "${BLUE}🔍 Validating Claude Context System...${NC}"

    local errors=0

    # Check required files
    if [[ ! -f "$CLAUDE_DIR/CLAUDE-CONTEXT-SYSTEM.md" ]]; then
        echo -e "${RED}✗ Missing system documentation${NC}"
        ((errors++))
    else
        echo -e "${GREEN}✓ System documentation found${NC}"
    fi

    if [[ ! -f "$INDEX_FILE" ]]; then
        echo -e "${RED}✗ Missing ADR index${NC}"
        ((errors++))
    else
        echo -e "${GREEN}✓ ADR index found${NC}"
    fi

    # Check directory structure
    for dir in branches branches/feat branches/arch branches/docs branches/chore merged templates; do
        if [[ ! -d "$CLAUDE_DIR/$dir" ]]; then
            echo -e "${YELLOW}⚠ Missing directory: $dir${NC}"
            # Auto-create missing directories
            mkdir -p "$CLAUDE_DIR/$dir"
            echo -e "${GREEN}✓ Created missing directory: $dir${NC}"
        else
            echo -e "${GREEN}✓ Directory exists: $dir${NC}"
        fi
    done

    # Validate TOML syntax using our validation function
    if validate_toml "$INDEX_FILE"; then
        echo -e "${GREEN}✓ TOML syntax validation passed${NC}"
    else
        echo -e "${RED}✗ TOML syntax validation failed${NC}"
        ((errors++))
    fi

    if [[ $errors -eq 0 ]]; then
        echo -e "\n${GREEN}✓ System validation passed${NC}"
        return 0
    else
        echo -e "\n${RED}✗ System validation failed with $errors errors${NC}"
        return 1
    fi
}

# Update context tracking date
update_context() {
    if [[ -f "$INDEX_FILE" ]]; then
        # Update last_check_context date (simplified)
        sed -i.bak "s/last_check_context = \"[^\"]*\"/last_check_context = \"$(current_date)\"/" "$INDEX_FILE"
        rm -f "$INDEX_FILE.bak"
        echo -e "${GREEN}✓ Context update timestamp refreshed${NC}"
    fi
}

# Show help
show_help() {
    echo "Claude Context System Helper v2.0"
    echo ""
    echo "Usage: $0 <command> [arguments]"
    echo ""
    echo "Commands:"
    echo "  new <category> <title>  Create new ADR"
    echo "                          Examples:"
    echo "                            $0 new feat \"user-authentication\""
    echo "                            $0 new feat/auth \"oauth-integration\""
    echo "                            $0 new \"chore(docs)\" \"readme-update\""
    echo "  list                    List all ADRs"
    echo "  status                  Show system status"
    echo "  validate                Validate system integrity"
    echo "  update-context          Update context timestamp"
    echo ""
    echo "Enhanced Commands:"
    echo "  check-due               Show overdue maintenance items"
    echo "  status-brief            Quick project status summary"
    echo "  context-update          Manual context refresh"
    echo "  scan                    Check for external changes"
    echo "  priorities              Show current priorities"
    echo ""
    echo "Safety Commands:"
    echo "  backup                  Create full system backup"
    echo "  restore                 Restore from most recent backup"
    echo "  help                    Show this help"
    echo ""
    echo "Categories: feat, arch, docs, chore"
    echo ""
    echo "Examples:"
    echo "  $0 new arch 'database-selection'"
    echo "  $0 new feat 'user-authentication'"
    echo "  $0 check-due"
    echo "  $0 status-brief"
}

# Main command dispatch
case "${1:-help}" in
    new)
        if [[ -z "$2" || -z "$3" ]]; then
            echo -e "${RED}ERROR: Usage: $0 new <category> <title>${NC}"
            echo -e "${BLUE}Examples:${NC}"
            echo -e "  $0 new feat \"user-authentication\""
            echo -e "  $0 new feat/auth \"oauth-integration\""
            echo -e "  $0 new \"chore(docs)\" \"readme-update\""
            exit 1
        fi
        new_adr "$2" "$3"
        ;;
    list)
        list_adrs
        ;;
    status)
        status
        ;;
    validate)
        validate
        ;;
    update-context)
        update_context
        ;;
    check-due)
        check_due
        ;;
    status-brief)
        status_brief
        ;;
    context-update)
        context_update
        ;;
    scan)
        scan
        ;;
    priorities)
        priorities
        ;;
    backup)
        backup_system
        ;;
    restore)
        restore_system
        ;;
    help|*)
        show_help
        ;;
esac
