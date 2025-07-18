#!/bin/bash
# ADR Helper Script v1.0 - For Claude Context System Simulation

set -e

CLAUDE_DIR=".claude"
INDEX_FILE="$CLAUDE_DIR/adr-index.toml"

# Color output for better UX
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Ensure we're in a project with the system
if [[ ! -f "$INDEX_FILE" ]]; then
    echo -e "${RED}ERROR: No ADR index found. Run this from a project with Claude Context System.${NC}"
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

    cat > "$adr_file" << EOF
# ADR: $title

**Status**: Proposed
**Date**: $(current_date)
**Author**: Claude Context System Team
**Tags**: [simulation, $category, $(current_date)]

## Context

[This section describes the situation and context that led to this decision.]

## Decision

[This section describes the architectural decision made.]

## Consequences

[This section describes the expected outcomes and trade-offs of this decision.]

## Alternatives Considered

[This section lists other options that were evaluated.]

## References

- Related to: Claude Context System v1.0
- Created during: Automated simulation
EOF

    echo -e "${GREEN}✓ Created ADR: $adr_file${NC}"

    # Add to index (simplified version)
    local section_name="active.$category"
    if ! grep -q "\[$section_name\]" "$INDEX_FILE"; then
        echo "" >> "$INDEX_FILE"
        echo "[$section_name]" >> "$INDEX_FILE"
    fi

    # Add ADR entry to index with component support
    local adr_path=""
    if [[ -n "$component" ]]; then
        adr_path="$category/$component/$sanitized_title.md"
        echo "\"$sanitized_title\" = { file = \"$adr_path\", status = \"proposed\", created = \"$(current_date)\", component = \"$component\" }" >> "$INDEX_FILE"
    else
        adr_path="$category/$sanitized_title.md"
        echo "\"$sanitized_title\" = { file = \"$adr_path\", status = \"proposed\", created = \"$(current_date)\" }" >> "$INDEX_FILE"
    fi

    echo -e "${BLUE}📝 Updated index: $INDEX_FILE${NC}"
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

        # Count ADRs by category
        for category in feat arch docs chore; do
            if [[ -d "$CLAUDE_DIR/branches/$category" ]]; then
                count=$(find "$CLAUDE_DIR/branches/$category" -name "*.md" -type f | wc -l)
                echo -e "  $category: $count ADRs"
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
        else
            echo -e "${GREEN}✓ Directory exists: $dir${NC}"
        fi
    done

    # Validate TOML syntax (basic check)
    if command -v grep &> /dev/null; then
        if grep -q "ERROR" "$INDEX_FILE" 2>/dev/null; then
            echo -e "${RED}✗ TOML syntax errors detected${NC}"
            ((errors++))
        else
            echo -e "${GREEN}✓ TOML syntax appears valid${NC}"
        fi
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
    echo "Claude Context System Helper v1.0"
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
    echo "  help                    Show this help"
    echo ""
    echo "Categories: feat, arch, docs, chore"
    echo ""
    echo "Examples:"
    echo "  $0 new arch 'database-selection'"
    echo "  $0 new feat 'user-authentication'"
    echo "  $0 list"
    echo "  $0 status"
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
    help|*)
        show_help
        ;;
esac
