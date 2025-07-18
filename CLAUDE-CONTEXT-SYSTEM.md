# Claude Context System: Complete Setup & Guide

**A self-contained, AI-managed system for maintaining project context and architectural decisions. You focus on coding, your AI assistant handles the rest.**

## 🎯 The Promise: AI Does the Work, You Stay Focused

**For Developers:**
- Write code and make decisions normally
- Your AI assistant automatically tracks everything
- Never lose context between sessions
- Skip documentation busywork

**For AI Assistants:**
- Complete project context in every session
- Architectural decision history and reasoning
- Current work status and priorities
- Permission-aware automation

**For Teams:**
- Shared understanding across all sessions
- Safe collaboration without workflow disruption
- Decision traceability without overhead

## 🔄 Canonical Reference & Updates

**📍 Canonical Location**: https://gist.github.com/joshrotenberg/a9f8ac85b9ebe20c6b6202a17d804fbc

This document is maintained in the above gist as the **canonical reference**. You should periodically check for updates and implement them as appropriate for your project.

### Automated Update Checking

To stay current with improvements, ask your AI assistant:

```
"Check the canonical Claude Context System gist at https://gist.github.com/joshrotenberg/a9f8ac85b9ebe20c6b6202a17d804fbc 
for any updates since [last-check-date]. Compare it with our current .claude/CLAUDE-CONTEXT-SYSTEM.md 
and present a summary of new or changed functionality. Ask if I want to implement these changes."
```

**Recommended check frequency**: Monthly, or before major project milestones.

### Version Tracking

- **Current version**: v2.0 - Enhanced with Authorization & Multi-Developer Support
- **Last local update**: 2025-07-18
- **Next recommended check**: 2025-08-18

## The Problem This Solves (2-Minute Pitch)

### The Problem We're Solving

- **"Why did we choose X?"** - Asked 6 months later, nobody remembers
- **"What did the last person try?"** - Context lost when team members change
- **"What should our AI assistant know?"** - Inconsistent recommendations across sessions
- **"Where did we leave off?"** - AI agents lose context between sessions, leading to repeated mistakes
- **"Will this break my team's workflow?"** - Non-users shouldn't be hindered by the system
- **"Can I trust it with git operations?"** - Unauthorized automation can be disruptive
- **Technical debt from undocumented decisions** - Costs compound over time

### The Solution: Architectural Decision Records (ADRs)

A lightweight system that:
- Takes 5 minutes to set up
- Requires ~10 minutes per major decision
- Saves hours of confusion and rework
- Makes AI assistants 10x more helpful
- **Works safely in shared repositories** without disrupting non-users
- **Asks permission** before any git/GitHub operations
- **Detects external changes** and suggests relevant ADRs

### Real ROI Example

**Without ADRs:** 2 hours finding why Redis was chosen over Postgres **With ADRs:** 2 minutes reading `cache-technology-decision.md` **Break-even:** After just 3-4 "why did we..." questions

## Quick Setup (Copy → Paste → Done)

### 1. Create the Directory Structure

```
mkdir -p .claude/{branches/{feat,docs,chore,arch},merged,templates}
```

### 2. Copy This File

Save this file as `.claude/CLAUDE-CONTEXT-SYSTEM.md` in your project root.

### 3. Tell Claude

"Please read `.claude/CLAUDE-CONTEXT-SYSTEM.md` and set up the complete system for our project."

That's it! Claude will create all the files, templates, and scripts needed.

### 4. Set Up Update Checking (Recommended)

Add a reminder to check for system updates:

```
"Remind me to check the canonical Claude Context System gist 
(https://gist.github.com/joshrotenberg/a9f8ac85b9ebe20c6b6202a17d804fbc) 
for updates next month and implement any improvements."
```

## 🚀 You're Looking at an AI-First System

**IMPORTANT: This document looks comprehensive because your AI assistant manages all of it.** You don't need to learn or maintain any of this manually.

### How It Actually Works:
1. **You:** "Let's use PostgreSQL instead of Redis for caching"
2. **AI:** Creates ADR, updates context, tracks implementation  
3. **You:** Keep coding while AI handles documentation

### Three Weeks Later:
1. **You:** "Why did we choose PostgreSQL for caching?"
2. **AI:** "ADR #7 from Jan 15th: Redis caused memory issues in production, PostgreSQL provides ACID guarantees we needed for transaction caching"
3. **You:** Get answer instantly, keep working

### The Files Are Human-Readable But AI-Managed
- **Markdown/TOML** format so you CAN read them
- **AI assistant** maintains them so you DON'T HAVE TO
- **Git-friendly** so teams can collaborate
- **Zero external dependencies** so it works everywhere

**The rest of this document is your AI assistant's manual, not yours.**

## Built on Proven Foundations

This system combines two foundational practices in modern software development:

### 🤝 Conventional Commits + Architectural Decision Records

**Conventional Commits** - A specification for standardized commit messages that enable automated tooling and clear communication. Created by the open-source community and inspired by Angular's commit guidelines, it provides structure for `feat:`, `fix:`, `docs:` and other commit types.

**Architectural Decision Records (ADRs)** - Introduced by Michael Nygard in 2011, ADRs capture the context, decision, and consequences of architecturally significant choices. They solve the "why did we choose X?" problem that plagues every software project.

### 🚀 Our Innovation: Unified Context System

We've merged these practices into something new:
- **Conventional commit structure** for ADR organization and workflow
- **ADR decision tracking** with modern git-native tooling
- **AI assistant integration** that understands both commit history and decision context
- **Self-contained system** that requires no external dependencies
- **🔐 Tiered authorization system** for safe git/GitHub operations
- **👥 Multi-developer repository support** with passive monitoring
- **🔍 Smart change detection** that suggests ADRs for external decisions

This creates a decision management system that's both lightweight and powerful - perfect for teams using AI assistants in their development workflow.

**Credits**: Huge thanks to Michael Nygard for ADRs and the Conventional Commits community for commit standardization. This system builds on their foundational work.

## 🗓️ CRITICAL: AI Assistant Date Awareness

**AI Assistant: ALWAYS start every session with:**

1. **Check current date first** - Never assume dates
2. Read `.claude/adr-index.toml` [updates] section  
3. Compare current date with `next_due_*` fields
4. Alert user to any overdue maintenance
5. Provide context update if due

**Never assume dates - always check current date first!**

## Quick Reference Card

### Essential Commands

```
# Daily workflow
./adr-helper.sh status          # Check system health
./adr-helper.sh list            # See active decisions
./adr-helper.sh new feat "name" # Create new ADR

# Maintenance
./adr-helper.sh validate        # Verify integrity
./adr-helper.sh cleanup         # Organize and clean directory
./adr-helper.sh organize        # Ensure proper structure
find .claude -name "*.md"       # Find all ADRs
grep -r "Status: Proposed"      # Find pending decisions

# New: Authorization & Collaboration
./adr-helper.sh permissions     # Configure authorization levels
./adr-helper.sh scan            # Check for external changes
./adr-helper.sh suggest         # AI-powered decision detection
./adr-helper.sh safe-mode       # Enable maximum safety settings
./adr-helper.sh team-setup      # Configure for team environment

# System updates
./adr-helper.sh check-updates   # Check for updates from canonical source
./adr-helper.sh configure       # Configure update frequency (never to daily)
"Check canonical gist for updates to Claude Context System"
```

### ADR Lifecycle

```
Proposed → Accepted → Implemented → (Superseded/Archived)
         ↘ Rejected → Archived

```

## What This System Provides

### For Engineering Teams

- **Decision History**: Why did we choose technology X over Y?
- **Context Preservation**: New team members understand project evolution
- **Reduced Cognitive Load**: No more "I forgot why we made this choice"
- **AI Assistant Continuity**: Consistent help across different sessions
- **Fresh AI Context**: Agents can quickly resume work without repeating past mistakes
- **Automated Organization**: Built-in cleanup and structure management
- **Document Type Management**: Clear separation of ADRs vs supporting docs
- **🔐 Safe Operations**: Permission-gated git/GitHub operations
- **👥 Team Harmony**: Non-intrusive operation in shared repositories
- **🔍 Smart Discovery**: Automatic detection of external decisions and changes

### For AI Assistants

- **Rich Context**: Understand project history and current state
- **Consistent Recommendations**: Decisions align with previous reasoning
- **Faster Onboarding**: Get up to speed quickly on complex projects
- **Session Continuity**: Resume work exactly where you left off, avoiding repeated discussions
- **Structured Information**: Machine-readable index and organized content
- **🔐 Permission Awareness**: Respect user authorization preferences for operations
- **👥 Team Context**: Understand changes made by other developers
- **🔍 Decision Detection**: Identify architectural decisions from commit patterns

### Enhanced Features

- **🧹 Automatic Cleanup**: `cleanup` command organizes documents and removes redundancy
- **📁 Document Organization**: Separates core ADR workflow from supporting documentation
- **🔧 Enhanced Tooling**: Management commands for validation, organization, and maintenance
- **📚 Multiple Document Types**: Handles ADRs, guides, context docs, and templates appropriately
- **🎯 Scalable Structure**: Grows with project complexity without becoming unwieldy
- **🔐 Authorization Framework**: Tiered permission system for git/GitHub operations
- **👥 Multi-Developer Support**: Passive monitoring and external change detection
- **🔍 Smart Suggestions**: AI-powered decision detection from commit analysis

## File Structure

```
.claude/
├── CLAUDE-CONTEXT-SYSTEM.md    # This file (setup + guide)
├── adr-index.toml               # Machine-readable ADR index
├── adr-helper.sh                # Management and automation scripts
├── branches/                    # Active ADRs by category
│   ├── feat/                    # Feature decisions
│   ├── docs/                    # Documentation decisions
│   ├── chore/                   # Process/tooling decisions
│   └── arch/                    # Architecture decisions
├── merged/                      # Completed/finalized ADRs
├── templates/                   # ADR templates
└── docs/                        # Supporting documentation

```

## Document Types and Organization

### Core ADR System (Root Level)
- `CLAUDE-CONTEXT-SYSTEM.md` - Complete system guide and setup
- `adr-index.toml` - Machine-readable decision index
- `adr-helper.sh` - Management and automation scripts
- `branches/` - Active architectural decisions by category
- `merged/` - Completed/archived decisions
- `templates/` - ADR and document templates

### Supporting Documentation (`docs/` Subdirectory)
- `project-context.md` - Project-specific context and overview
- Language-specific guides (e.g., `RUST-PROJECT-SETUP.md`)
- AI context management patterns
- Team-specific documentation
- Reference materials and guides

### How to Handle Different Document Types

**When to Create ADRs** (in `branches/`):
- **Technology choices**: Why Rust over Go? Why Postgres over MongoDB?
- **Architecture decisions**: Microservices vs monolith? Event-driven vs REST?
- **Process changes**: New deployment strategy, testing approach
- **Requirements specifications**: Major feature requirements and constraints
- **Any decision that's hard to reverse or has broad impact**

**When to Create Supporting Docs** (in `docs/`):
- **Project context**: Current state, goals, and background
- **Setup guides**: Language-specific or tool-specific guidance
- **Process documentation**: Workflows, standards, and procedures
- **Reference materials**: Links, resources, and background information
- **Team knowledge**: Onboarding docs, tribal knowledge, and context

## ADR Template

```
# ADR: [Decision Title]

**Status**: Proposed | Accepted | Superseded
**Date**: YYYY-MM-DD
**Author**: Team/Person
**Tags**: [tag1, tag2, tag3]

## Context
What situation are we addressing? What forces are at play?

## Decision
What are we doing? What specific choice are we making?

## Consequences
What becomes easier or more difficult to do because of this change?

## Alternatives Considered
What other options did we evaluate? Why did we reject them?

## References
Links to relevant discussions, RFCs, documentation
```

## System Setup Scripts

### ADR Helper Script (adr-helper.sh)

```
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

# 🔐 Permission checking functions
check_permission() {
    local operation="$1"
    local permission_key="$2"
    local default="${3:-ask}"
    
    if [[ ! -f "$INDEX_FILE" ]]; then
        echo -e "${YELLOW}Warning: No ADR index found. Using safe defaults.${NC}"
        permission="ask"
    else
        permission=$(grep "^$permission_key" "$INDEX_FILE" 2>/dev/null | cut -d'"' -f2 || echo "$default")
    fi
    
    case "$permission" in
        "never")
            echo -e "${RED}❌ Operation '$operation' is disabled by configuration${NC}"
            return 1
            ;;
        "ask")
            echo -e "${YELLOW}🤔 Permission required for: $operation${NC}"
            read -p "Proceed? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                return 0
            else
                echo -e "${YELLOW}⏭️  Operation cancelled by user${NC}"
                return 1
            fi
            ;;
        "yes")
            echo -e "${GREEN}✅ Auto-approved: $operation${NC}"
            return 0
            ;;
        *)
            echo -e "${YELLOW}⚠️  Unknown permission '$permission', asking for safety${NC}"
            read -p "Proceed with '$operation'? (y/N): " -n 1 -r
            echo
            [[ $REPLY =~ ^[Yy]$ ]]
            ;;
    esac
}

# Git operation wrapper
safe_git() {
    local operation="$1"
    local permission_key="$2"
    shift 2
    
    if check_permission "$operation" "$permission_key"; then
        echo -e "${BLUE}🔧 Executing: git $*${NC}"
        git "$@"
    else
        return 1
    fi
}

# GitHub CLI operation wrapper
safe_gh() {
    local operation="$1"
    local permission_key="$2"
    shift 2
    
    if ! command -v gh &> /dev/null; then
        echo -e "${YELLOW}⚠️  GitHub CLI not found. Install 'gh' for GitHub operations.${NC}"
        return 1
    fi
    
    if check_permission "$operation" "$permission_key"; then
        echo -e "${BLUE}🔧 Executing: gh $*${NC}"
        gh "$@"
    else
        return 1
    fi
}
```

validate() {
    echo "Validating ADR structure..."
    
    if [[ ! -f "$INDEX_FILE" ]]; then
        echo "ERROR: ADR index not found at $INDEX_FILE"
        exit 1
    fi
    
    # Check if all referenced ADR files exist
    if command -v grep &> /dev/null; then
        while IFS= read -r line; do
            if [[ $line =~ file[[:space:]]*=[[:space:]]*\"([^\"]+)\" ]]; then
                adr_file="$CLAUDE_DIR/branches/${BASH_REMATCH[1]}"
                if [[ ! -f "$adr_file" ]]; then
                    echo "ERROR: Missing ADR file: $adr_file"
                    exit 1
                fi
            fi
        done < "$INDEX_FILE"
    fi
    
    echo "Validation complete"
}

list() {
    echo "Active ADRs:"
    echo ""
    
    if [[ -f "$INDEX_FILE" ]]; then
        grep -E '^".*" = \{' "$INDEX_FILE" | \
        sed 's/"//g' | sed 's/ = {//' | \
        while read -r adr; do
            echo "  • $adr"
        done
    else
        echo "No ADR index found"
    fi
}

status() {
    echo "ADR System Status:"
    echo ""
    
    if [[ -f "$INDEX_FILE" ]]; then
        active_count=$(grep -c '\[active\.' "$INDEX_FILE" 2>/dev/null || echo "0")
        echo "  Active ADR sections: $active_count"
        
        total_adrs=$(grep -c '^".*" = {' "$INDEX_FILE" 2>/dev/null || echo "0")
        echo "  Total ADRs: $total_adrs"
        
        if [[ -d "$CLAUDE_DIR/merged" ]]; then
            merged_count=$(find "$CLAUDE_DIR/merged" -name "*.md" 2>/dev/null | wc -l)
            echo "  Merged ADRs: $merged_count"
        fi
        
        echo ""
        echo "  Categories:"
        grep '\[active\.' "$INDEX_FILE" 2>/dev/null | sed 's/\[active\./  • /' | sed 's/\]//' || echo "  None"
    else
        echo "ERROR: No ADR index found"
    fi
}

new_adr() {
    local category="${1:-feat}"
    local title="${2:-new-decision}"
    local sanitized_title=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g')
    local adr_file="$CLAUDE_DIR/branches/$category/$sanitized_title.md"
    local template_file="$CLAUDE_DIR/templates/adr-template.md"
    
    if [[ -f "$adr_file" ]]; then
        echo "ERROR: ADR already exists: $adr_file"
        exit 1
    fi
    
    mkdir -p "$(dirname "$adr_file")"
    
    if [[ -f "$template_file" ]]; then
        cp "$template_file" "$adr_file"
    else
        cat > "$adr_file" << 'EOF'
# ADR: [Decision Title]

**Status**: Proposed
**Date**: $(date +%Y-%m-%d)
**Author**: [Your Name]
**Tags**: [tag1, tag2, tag3]

## Context
What situation are we addressing? What forces are at play?

## Decision
What are we doing? What specific choice are we making?

## Consequences
What becomes easier or more difficult to do because of this change?

## Alternatives Considered
What other options did we evaluate? Why did we reject them?

## References
Links to relevant discussions, RFCs, documentation
EOF
    fi
    
    echo "Created ADR: $adr_file"
    echo "Don't forget to update the ADR index!"
}

cleanup() {
    echo "Cleaning up .claude directory..."
    echo ""

    # Create docs/ subdirectory for non-ADR documents
    mkdir -p "$CLAUDE_DIR/docs"

    # Legacy/redundant files to remove or consolidate
    local legacy_files=(
        "ADR-SYSTEM-GUIDE.md"
        "README.md"
    )

    # Specialized docs to move to docs/ subdirectory
    local specialized_docs=(
        "RUST-PROJECT-SETUP.md"
        "context-management-prompt.md"
        "project-context.md"
    )

    echo "Moving specialized documents to docs/ subdirectory:"
    for doc in "${specialized_docs[@]}"; do
        if [[ -f "$CLAUDE_DIR/$doc" ]]; then
            mv "$CLAUDE_DIR/$doc" "$CLAUDE_DIR/docs/"
            echo "  ✓ Moved $doc to docs/"
        fi
    done

    echo ""
    echo "Legacy files found (will prompt for removal):"
    for legacy in "${legacy_files[@]}"; do
        if [[ -f "$CLAUDE_DIR/$legacy" ]]; then
            echo "  • $legacy"
            read -p "Remove $legacy? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                rm "$CLAUDE_DIR/$legacy"
                echo "    ✓ Removed $legacy"
            else
                echo "    ○ Keeping $legacy"
            fi
        fi
    done

    echo ""
    echo "Creating docs/README.md to explain document organization..."
    cat > "$CLAUDE_DIR/docs/README.md" << 'EOF'
# Claude Context Documentation

This directory contains specialized documentation that supports the ADR system but isn't part of the core decision tracking workflow.

## Document Types

### Project Context
- `project-context.md` - Current project state and overview

### Guides & References
- `RUST-PROJECT-SETUP.md` - Rust-specific development guidance
- `context-management-prompt.md` - AI context management patterns

## Usage

These documents provide background context and guidance but aren't part of the formal ADR decision tracking in `../branches/` and `../merged/`.

For active architectural decisions, see:
- `../adr-index.toml` - Master index
- `../branches/` - Active decisions
- `../merged/` - Completed decisions
EOF

    echo "✓ Created docs/README.md"
    echo ""
    echo "Cleanup complete! New structure:"
    echo "  .claude/"
    echo "  ├── CLAUDE-CONTEXT-SYSTEM.md  # Main system guide"
    echo "  ├── adr-index.toml            # Decision index"
    echo "  ├── adr-helper.sh             # This script"
    echo "  ├── branches/                 # Active ADRs"
    echo "  ├── merged/                   # Completed ADRs"
    echo "  ├── templates/                # ADR templates"
    echo "  └── docs/                     # Supporting documentation"
}

organize() {
    echo "Organizing .claude directory structure..."

    # Ensure all required directories exist
    mkdir -p "$CLAUDE_DIR"/{branches/{arch,feat,docs,chore},merged,templates,docs}

    echo "Directory structure:"
    find "$CLAUDE_DIR" -type d | sort | sed 's/^/  /'

    echo ""
    echo "✓ Directory structure organized"
}

case "${1:-help}" in
    validate)
        validate
        ;;
    list)
        list
        ;;
    status)
        status
        ;;
    new)
        new_adr "$2" "$3"
        ;;
    cleanup)
        cleanup
        ;;
    organize)
        organize
        ;;
    help|*)
        echo "Usage: $0 {validate|list|status|new|cleanup|organize [category] [title]}"
        echo ""
        echo "Commands:"
        echo "  validate  - Validate ADR structure and references"
        echo "  list      - List all active ADRs"
        echo "  status    - Show system status and statistics"
        echo "  new       - Create new ADR (category defaults to 'feat')"
        echo "  cleanup   - Clean up legacy/redundant files and organize docs"
        echo "  organize  - Ensure proper directory structure exists"
        echo ""
        echo "🔐 Authorization & Team Commands:"
        echo "  permissions - Configure authorization levels"
        echo "  scan        - Check for external changes"
        echo "  suggest     - AI-powered decision detection"
        echo "  safe-mode   - Enable maximum safety settings"
        echo "  team-setup  - Configure for team environment"
        echo "  help        - Show this help message"
        ;;
    scan)
        scan_external_changes
        ;;
    suggest)
        suggest_decisions
        ;;
    permissions)
        configure_permissions
        ;;
    safe-mode)
        enable_safe_mode
        ;;
    team-setup)
        team_setup
        ;;
esac

# 👥 Multi-Developer Support Functions

scan_external_changes() {
    echo -e "${BLUE}🔍 Scanning for external changes...${NC}"
    
    if [[ ! -d ".git" ]]; then
        echo -e "${YELLOW}⚠️  Not a git repository. Skipping external change detection.${NC}"
        return 0
    fi
    
    # Fetch latest changes
    if check_permission "fetch remote changes" "permissions.git.fetch" "yes"; then
        git fetch --all --quiet 2>/dev/null || true
    fi
    
    # Get current user
    current_user=$(git config user.email 2>/dev/null || echo "unknown")
    
    # Check for new branches since last scan
    local last_scan=""
    if [[ -f "$INDEX_FILE" ]]; then
        last_scan=$(grep "last_scan" "$INDEX_FILE" 2>/dev/null | cut -d'"' -f2 || echo "1970-01-01T00:00:00Z")
    fi
    
    echo "📊 External Change Summary:"
    echo ""
    
    # Find branches created by others
    local external_branches=()
    while IFS= read -r line; do
        if [[ -n "$line" ]]; then
            branch_name=$(echo "$line" | awk '{print $1}' | sed 's/origin\///')
            branch_author=$(git log --format="%ae" "$line" -1 2>/dev/null || echo "unknown")
            
            if [[ "$branch_author" != "$current_user" && "$branch_name" != "main" && "$branch_name" != "master" && "$branch_name" != "develop" ]]; then
                external_branches+=("$branch_name:$branch_author")
                echo -e "  ${GREEN}•${NC} New branch: ${BLUE}$branch_name${NC} by $branch_author"
            fi
        fi
    done < <(git for-each-ref --format='%(refname:short) %(committerdate:iso8601)' refs/remotes/origin --sort=-committerdate 2>/dev/null | head -10)
    
    if [[ ${#external_branches[@]} -eq 0 ]]; then
        echo -e "  ${GREEN}✓${NC} No new external changes detected"
    else
        echo ""
        echo -e "${YELLOW}💡 Suggestions:${NC}"
        for branch_info in "${external_branches[@]}"; do
            branch_name=$(echo "$branch_info" | cut -d':' -f1)
            echo -e "  • Consider creating ADR for decisions in ${BLUE}$branch_name${NC}"
        done
        
        echo ""
        read -p "Would you like to analyze these branches for potential decisions? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            suggest_decisions_from_branches "${external_branches[@]}"
        fi
    fi
    
    # Update last scan time
    update_last_scan_time
}

suggest_decisions() {
    echo -e "${BLUE}🤖 AI-Powered Decision Detection${NC}"
    echo ""
    
    if [[ ! -d ".git" ]]; then
        echo -e "${YELLOW}⚠️  Not a git repository. Cannot analyze commits.${NC}"
        return 0
    fi
    
    # Analyze recent commits for decision keywords
    local decision_keywords=("choose" "decision" "architecture" "database" "framework" "library" "migrate" "replace" "switch")
    local commit_patterns=("feat:" "arch:" "breaking:" "refactor:")
    
    echo "🔍 Analyzing recent commits for architectural decisions..."
    echo ""
    
    local suggestions=()
    
    # Check commits in the last 30 days
    while IFS= read -r commit_line; do
        if [[ -n "$commit_line" ]]; then
            commit_hash=$(echo "$commit_line" | awk '{print $1}')
            commit_msg=$(echo "$commit_line" | cut -d' ' -f2-)
            
            # Check for decision indicators
            for keyword in "${decision_keywords[@]}"; do
                if echo "$commit_msg" | grep -qi "$keyword"; then
                    suggestions+=("$commit_hash: $commit_msg")
                    break
                fi
            done
            
            # Check for architectural commit patterns
            for pattern in "${commit_patterns[@]}"; do
                if echo "$commit_msg" | grep -q "^$pattern"; then
                    suggestions+=("$commit_hash: $commit_msg")
                    break
                fi
            done
        fi
    done < <(git log --oneline --since="30 days ago" 2>/dev/null)
    
    if [[ ${#suggestions[@]} -eq 0 ]]; then
        echo -e "  ${GREEN}✓${NC} No obvious architectural decisions detected in recent commits"
    else
        echo -e "${YELLOW}💡 Potential decisions detected:${NC}"
        echo ""
        for suggestion in "${suggestions[@]}"; do
            echo -e "  ${GREEN}•${NC} $suggestion"
        done
        
        echo ""
        echo -e "${BLUE}💭 Consider creating ADRs for these decisions if they haven't been documented yet.${NC}"
        
        read -p "Would you like to create an ADR for any of these? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "Which decision would you like to document? (Enter commit hash or description)"
            read -r decision_input
            if [[ -n "$decision_input" ]]; then
                suggest_adr_template "$decision_input"
            fi
        fi
    fi
}

suggest_adr_template() {
    local decision_context="$1"
    echo ""
    echo -e "${BLUE}📝 Suggested ADR Template:${NC}"
    echo ""
    
    # Try to infer category from commit message
    local category="feat"
    if echo "$decision_context" | grep -qi "arch\|architecture\|system\|service"; then
        category="arch"
    elif echo "$decision_context" | grep -qi "doc\|documentation"; then
        category="docs"
    elif echo "$decision_context" | grep -qi "tool\|process\|workflow"; then
        category="chore"
    fi
    
    # Generate a suggested filename
    local suggested_name=$(echo "$decision_context" | sed 's/.*: //' | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g' | cut -c1-50)
    
    echo "Suggested category: $category"
    echo "Suggested filename: $suggested_name.md"
    echo ""
    read -p "Create this ADR? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        new_adr "$category" "$suggested_name"
    fi
}

configure_permissions() {
    echo -e "${BLUE}🔐 Authorization Configuration${NC}"
    echo ""
    
    if [[ ! -f "$INDEX_FILE" ]]; then
        echo -e "${YELLOW}⚠️  No ADR index found. Creating basic configuration...${NC}"
        create_basic_index
    fi
    
    echo "Current authorization settings:"
    echo ""
    
    # Show current settings
    show_current_permissions
    
    echo ""
    echo "Available permission levels:"
    echo "  • never - Never perform this operation"
    echo "  • ask   - Ask for permission each time"
    echo "  • yes   - Always allow (use with caution)"
    echo ""
    
    local settings=("use_git" "use_gh" "auto_commit" "auto_push" "auto_pr")
    local descriptions=("Use git commands" "Use GitHub CLI" "Auto-commit changes" "Auto-push to remote" "Auto-create PRs")
    
    for i in "${!settings[@]}"; do
        setting="${settings[$i]}"
        description="${descriptions[$i]}"
        
        current_value=$(grep "^$setting" "$INDEX_FILE" 2>/dev/null | cut -d'"' -f2 || echo "ask")
        
        echo -e "${YELLOW}$description${NC} (current: $current_value)"
        read -p "New value (never/ask/yes) [Enter to keep current]: " new_value
        
        if [[ -n "$new_value" ]]; then
            update_permission "$setting" "$new_value"
        fi
    done
    
    echo ""
    echo -e "${GREEN}✅ Authorization configuration updated${NC}"
}

show_current_permissions() {
    if [[ -f "$INDEX_FILE" ]]; then
        echo "Git operations:"
        echo "  use_git: $(grep '^use_git' "$INDEX_FILE" 2>/dev/null | cut -d'"' -f2 || echo 'ask')"
        echo "  auto_commit: $(grep '^auto_commit' "$INDEX_FILE" 2>/dev/null | cut -d'"' -f2 || echo 'no')"
        echo "  auto_push: $(grep '^auto_push' "$INDEX_FILE" 2>/dev/null | cut -d'"' -f2 || echo 'no')"
        echo ""
        echo "GitHub operations:"
        echo "  use_gh: $(grep '^use_gh' "$INDEX_FILE" 2>/dev/null | cut -d'"' -f2 || echo 'ask')"
        echo "  auto_pr: $(grep '^auto_pr' "$INDEX_FILE" 2>/dev/null | cut -d'"' -f2 || echo 'never')"
    else
        echo "No configuration found - using safe defaults"
    fi
}

enable_safe_mode() {
    echo -e "${BLUE}🛡️  Enabling Safe Mode${NC}"
    echo ""
    
    if [[ ! -f "$INDEX_FILE" ]]; then
        echo "Creating ADR index with safe defaults..."
        create_basic_index
    fi
    
    # Set the most restrictive permissions
    update_permission "use_git" "ask"
    update_permission "use_gh" "ask"
    update_permission "auto_commit" "no"
    update_permission "auto_push" "no"
    update_permission "auto_pr" "never"
    
    # Enable passive mode for collaboration
    update_toml_value "collaboration" "passive_mode" "true"
    update_toml_value "collaboration" "track_external_changes" "true"
    update_toml_value "collaboration" "auto_discover_decisions" "false"
    
    echo -e "${GREEN}✅ Safe mode enabled. The system will:${NC}"
    echo "  • Ask permission for all git operations"
    echo "  • Never auto-commit or auto-push"
    echo "  • Never create PRs automatically"
    echo "  • Operate in passive mode for team repositories"
    echo "  • Track but not interfere with external changes"
}

team_setup() {
    echo -e "${BLUE}👥 Team Environment Setup${NC}"
    echo ""
    
    echo "This will configure the Claude Context System for a team environment."
    echo ""
    
    read -p "Team size (small/medium/large): " team_size
    read -p "Your email (for identifying your changes): " user_email
    read -p "Should the system track external changes? (y/N): " track_external
    
    echo ""
    echo "Setting up team configuration..."
    
    if [[ ! -f "$INDEX_FILE" ]]; then
        create_basic_index
    fi
    
    # Update metadata
    update_toml_value "metadata" "team_size" "\"$team_size\""
    
    if [[ -n "$user_email" ]]; then
        # Add user to primary_users array (simplified - in real implementation would parse TOML properly)
        update_toml_value "metadata" "primary_users" "[\"$user_email\"]"
    fi
    
    # Configure collaboration settings
    update_toml_value "collaboration" "passive_mode" "true"
    
    if [[ "$track_external" =~ ^[Yy]$ ]]; then
        update_toml_value "collaboration" "track_external_changes" "true"
        update_toml_value "collaboration" "notify_on_unknown_branches" "true"
        update_toml_value "monitoring" "check_frequency" "\"daily\""
    else
        update_toml_value "collaboration" "track_external_changes" "false"
    fi
    
    # Set team-appropriate permissions
    case "$team_size" in
        "small")
            update_permission "use_git" "yes"
            update_permission "auto_commit" "ask"
            ;;
        "medium"|"large")
            update_permission "use_git" "ask"
            update_permission "auto_commit" "no"
            update_permission "auto_push" "no"
            ;;
    esac
    
    echo -e "${GREEN}✅ Team setup complete!${NC}"
    echo ""
    echo "Configuration:"
    echo "  • Team size: $team_size"
    echo "  • Primary user: ${user_email:-not set}"
    echo "  • External tracking: ${track_external:-no}"
    echo "  • Passive mode: enabled"
    
    if [[ "$track_external" =~ ^[Yy]$ ]]; then
        echo ""
        echo -e "${BLUE}💡 Run './adr-helper.sh scan' daily to check for external changes${NC}"
    fi
}

# Helper functions for TOML manipulation (simplified)
update_permission() {
    local key="$1"
    local value="$2"
    
    if [[ ! -f "$INDEX_FILE" ]]; then
        create_basic_index
    fi
    
    # Simple TOML update (in production, use proper TOML parser)
    if grep -q "^$key" "$INDEX_FILE"; then
        sed -i.bak "s/^$key.*/$key = \"$value\"/" "$INDEX_FILE"
    else
        # Add to permissions section
        if grep -q "^\[permissions\]" "$INDEX_FILE"; then
            sed -i.bak "/^\[permissions\]/a\\
$key = \"$value\"" "$INDEX_FILE"
        else
            echo "" >> "$INDEX_FILE"
            echo "[permissions]" >> "$INDEX_FILE"
            echo "$key = \"$value\"" >> "$INDEX_FILE"
        fi
    fi
}

update_toml_value() {
    local section="$1"
    local key="$2"
    local value="$3"
    
    if [[ ! -f "$INDEX_FILE" ]]; then
        create_basic_index
    fi
    
    # Simple TOML section update
    if grep -q "^\[$section\]" "$INDEX_FILE"; then
        if grep -q "^$key" "$INDEX_FILE"; then
            sed -i.bak "s/^$key.*/$key = $value/" "$INDEX_FILE"
        else
            sed -i.bak "/^\[$section\]/a\\
$key = $value" "$INDEX_FILE"
        fi
    else
        echo "" >> "$INDEX_FILE"
        echo "[$section]" >> "$INDEX_FILE"
        echo "$key = $value" >> "$INDEX_FILE"
    fi
}

create_basic_index() {
    local project_name=${PWD##*/}
    
    cat > "$INDEX_FILE" << EOF
# ADR Index for $project_name

[metadata]
version = "2.0"
project_type = "enhanced"
description = "Project with Claude Context System v2.0"
created = "$(date +%Y-%m-%d)"
team_size = "medium"
primary_users = ["$(git config user.email 2>/dev/null || echo 'user@example.com')"]

[permissions]
use_git = "ask"
use_gh = "ask" 
auto_commit = "no"
auto_push = "no"
auto_pr = "never"

[collaboration]
passive_mode = true
track_external_changes = true
notify_on_unknown_branches = true
auto_discover_decisions = false

[monitoring]
check_frequency = "daily"
last_scan = "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
branch_patterns = ["feat/*", "arch/*", "docs/*"]
ignore_branches = ["main", "develop", "temp/*"]

[categories.architecture]
description = "System design, module organization, and service structure"

[categories.features]
description = "Feature implementation and user-facing functionality"

[categories.processes]
description = "Development workflow, tooling, and operational procedures"

[categories.documentation]
description = "Documentation strategy and knowledge management"

[active.arch]

[active.feat]

[active.docs]

[active.chore]
EOF

    echo -e "${GREEN}✅ Created basic ADR index at $INDEX_FILE${NC}"
}

update_last_scan_time() {
    if [[ -f "$INDEX_FILE" ]]; then
        local current_time=$(date -u +%Y-%m-%dT%H:%M:%SZ)
        update_toml_value "monitoring" "last_scan" "\"$current_time\""
    fi
}

suggest_decisions_from_branches() {
    local branches=("$@")
    echo ""
    echo -e "${BLUE}🔍 Analyzing branches for potential decisions...${NC}"
    
    for branch_info in "${branches[@]}"; do
        local branch_name=$(echo "$branch_info" | cut -d':' -f1)
        echo ""
        echo -e "📊 Branch: ${BLUE}$branch_name${NC}"
        
        # Get recent commits from this branch
        local commits=$(git log --oneline "origin/$branch_name" --not main --not master 2>/dev/null | head -5)
        
        if [[ -n "$commits" ]]; then
            echo "Recent commits:"
            echo "$commits" | sed 's/^/  • /'
            
            # Simple decision detection
            if echo "$commits" | grep -qi "database\|db\|postgres\|mysql\|redis"; then
                echo -e "  ${YELLOW}💡 Potential database decision detected${NC}"
            fi
            if echo "$commits" | grep -qi "api\|endpoint\|rest\|graphql"; then
                echo -e "  ${YELLOW}💡 Potential API design decision detected${NC}"
            fi
            if echo "$commits" | grep -qi "auth\|login\|oauth\|jwt"; then
                echo -e "  ${YELLOW}💡 Potential authentication decision detected${NC}"
            fi
        fi
    done
}

### Quick Management Commands

```
# Validate ADR system
./.claude/adr-helper.sh validate

# List all ADRs
./.claude/adr-helper.sh list

# Show status
./.claude/adr-helper.sh status

# Create new ADR
./.claude/adr-helper.sh new feat "api-architecture-decision"

# Organize and clean up
./.claude/adr-helper.sh cleanup
./.claude/adr-helper.sh organize

# 🔐 Authorization & Team Features
./.claude/adr-helper.sh permissions      # Configure authorization levels
./.claude/adr-helper.sh scan            # Check for external changes
./.claude/adr-helper.sh suggest         # AI-powered decision detection
./.claude/adr-helper.sh safe-mode       # Enable maximum safety settings
./.claude/adr-helper.sh team-setup      # Configure for team environment

# Configure updates
./.claude/adr-helper.sh configure
./.claude/adr-helper.sh check-updates
```

## Sample ADR Index (adr-index.toml)

```
# ADR Index for [PROJECT_NAME]

[metadata]
version = "2.0"
language = "your-language"
project_type = "your-type"
description = "Project description"
created = "2025-07-18"
team_size = "medium"                     # Options: "small", "medium", "large"
primary_users = ["user@company.com"]     # Who actively uses the system

# Update configuration - Simple per-item frequencies  
[updates]
system = "monthly"              # Check canonical gist for system updates
permissions = "quarterly"       # Review authorization settings  
team_config = "quarterly"       # Review team/collaboration settings
adr_maintenance = "weekly"      # ADR cleanup, archiving, status updates
context = "daily"               # Current project status, active branches, priorities

# Last check tracking (ISO 8601 format - AI updates these)
last_check_system = "2025-01-15"
last_check_permissions = "2025-01-15" 
last_check_team_config = "2025-01-15"
last_check_adr_maintenance = "2025-01-13"
last_check_context = "2025-01-17"

# Next due dates (calculated automatically)
next_due_system = "2025-02-15"        # +1 month
next_due_permissions = "2025-04-15"   # +3 months  
next_due_team_config = "2025-04-15"   # +3 months
next_due_adr_maintenance = "2025-01-20" # +1 week
next_due_context = "2025-01-18"       # +1 day

canonical_url = "https://gist.github.com/joshrotenberg/a9f8ac85b9ebe20c6b6202a17d804fbc"

# 🔐 Authorization Configuration
[permissions]
use_git = "ask"                         # Options: "never", "ask", "yes"
use_gh = "ask"                          # Options: "never", "ask", "yes"
auto_commit = "no"                      # Options: "no", "ask", "yes"
auto_push = "no"                        # Options: "no", "ask", "yes"
auto_pr = "never"                       # Options: "never", "ask", "yes"

# More granular git controls
[permissions.git]
add_files = "ask"                       # Can stage files
commit_changes = "ask"                  # Can commit changes
create_branches = "ask"                 # Can create branches
merge_branches = "never"                # Can merge branches
push_to_remote = "ask"                  # Can push to remote

# GitHub/GitLab operations
[permissions.github]
create_pr = "ask"                       # Can create pull requests
merge_pr = "never"                      # Can merge pull requests
create_issues = "ask"                   # Can create issues
add_labels = "yes"                      # Can add labels (safer operation)

# 👥 Multi-Developer Repository Support
[collaboration]
passive_mode = true                     # Don't interfere with non-users
track_external_changes = true           # Monitor but don't auto-act
notify_on_unknown_branches = true       # Alert on new branches
auto_discover_decisions = false         # Don't auto-create ADRs for others' work
suggest_adrs_for_external_changes = true # Suggest ADRs for detected decisions

# 🔍 Change Detection & Monitoring
[monitoring]
check_frequency = "daily"               # How often to scan for changes
last_scan = "2025-07-18T09:00:00Z"     # Last external change scan
branch_patterns = ["feat/*", "arch/*", "docs/*", "fix/*"]  # What to watch
ignore_branches = ["main", "develop", "temp/*", "dependabot/*"]  # What to ignore
ignore_authors = ["dependabot[bot]", "github-actions[bot]"]      # Automated commits to ignore

# Detected external changes (populated by scan command)
external_branches_detected = []         # Will be populated by monitoring

# AI Decision Detection Settings
[ai_detection]
enabled = true                          # Enable AI-powered decision detection
confidence_threshold = 0.7             # Minimum confidence for suggestions
keywords = ["choose", "decision", "architecture", "database", "framework", "library"]
commit_patterns = ["feat:", "arch:", "breaking:"]  # Patterns that suggest decisions
```

# Categories
[categories.architecture]
description = "System design, module organization, and service structure"

[categories.features]
description = "Feature implementation and user-facing functionality"

[categories.processes]
description = "Development workflow, tooling, and operational procedures"

[categories.documentation]
description = "Documentation strategy and knowledge management"

# Active ADRs
[active.arch]
"initial-architecture" = {
    file = "arch/initial-architecture.md",
    created = "2025-07-18",
    author = "Team",
    tags = ["architecture", "initial"],
    description = "Initial system architecture and technology choices"
}

[active.feat]
"api-design" = {
    file = "feat/api-design.md",
    created = "2025-07-18", 
    author = "Team",
    tags = ["api", "design", "rest"],
    description = "API design patterns and conventions"
}

# Relationships between ADRs
[relationships.depends_on]
"api-design" = ["initial-architecture"]

[relationships.enables]
"initial-architecture" = ["api-design"]

# Tags for filtering
[tags]
architecture = ["initial-architecture"]
api = ["api-design"]
design = ["api-design"]
```

## AI Assistant Integration

### For Claude/AI Assistants

When working with this project:
- **Always read the ADR index first** to understand current decisions and authorization settings
- **Check permission settings** before suggesting git/GitHub operations
- **Respect authorization levels** - never override user permission preferences
- **Reference specific ADRs** when making recommendations
- **Suggest new ADRs** when major decisions are needed
- **Update ADRs** when decisions change or evolve
- **Maintain consistency** with existing architectural choices
- **Check for system updates** when explicitly asked or monthly
- **Use team features** like `scan` and `suggest` to detect external changes
- **Respect passive mode** in multi-developer environments

### Authorization Guidelines for AI Assistants

**Before any git/GitHub operation:**
1. Check the `[permissions]` section in `adr-index.toml`
2. For "never" - inform user the operation is disabled
3. For "ask" - request explicit permission from user
4. For "yes" - proceed but inform user what you're doing

**Example permission check:**
```
I see you want me to commit these ADR changes. 
Your current setting is 'use_git = "ask"'.
May I proceed with: git add .claude/branches/feat/new-feature.md && git commit -m "Add feature ADR"?
```

### System Update Protocol

When asked to check for updates:
1. Check user's authorization for git operations first
2. Fetch the canonical gist: https://gist.github.com/joshrotenberg/a9f8ac85b9ebe20c6b6202a17d804fbc
3. Compare with local `.claude/CLAUDE-CONTEXT-SYSTEM.md`
4. Identify new features, improvements, or fixes
5. Present summary of changes with benefits/impact
6. Ask user which updates to implement
7. Update local system accordingly (respecting permissions)
8. Update "Last local update" date in this file

### Starting a New AI Session

```
Starting session for [project]. Please:

1. **Check current date first** (what is today's date?)
2. Read .claude/adr-index.toml [updates] section  
3. Compare current date with next_due_* fields
4. Show me any overdue maintenance:
   - System updates overdue?
   - Permission review overdue? 
   - ADR maintenance overdue?
   - Context update overdue?
5. If context update is due/overdue, give me current project status
6. Update last_check_* dates for completed items

Authorization level: [check my permissions for git/GitHub operations]
Team environment: [check if passive_mode is enabled]

Then let's start today's work with current context.
Current focus: [specific area/feature]
Open questions: [list any pending decisions]

If this is a team repository, please run './adr-helper.sh scan' to check for external changes.
```

### Enhanced AI Commands

**Permission-aware operations:**
- `"Check my authorization settings and suggest any changes"`
- `"Scan for external changes in team repository"`
- `"Suggest ADRs based on recent commit patterns"`
- `"Enable safe mode for this repository"`

**Team collaboration:**
- `"Set up this repository for team use"`
- `"Check what changes others have made"`
- `"Suggest ADRs for decisions I might have missed"`

## 🔐 Authorization & 👥 Collaboration Features

### Authorization Framework

The enhanced Claude Context System includes a comprehensive permission system to ensure safe operation in any environment:

#### Permission Levels
- **`never`** - Operation is completely disabled
- **`ask`** - Request permission each time (safest for shared environments)
- **`yes`** - Auto-approve operation (convenient for personal projects)

#### Key Authorization Categories

**Git Operations:**
```toml
[permissions]
use_git = "ask"          # Basic git command permission
auto_commit = "no"       # Automatic commits
auto_push = "no"         # Automatic pushes
```

**GitHub/GitLab Operations:**
```toml
[permissions]
use_gh = "ask"           # GitHub CLI operations
auto_pr = "never"        # Automatic PR creation (usually kept restrictive)
```

**Granular Controls:**
```toml
[permissions.git]
add_files = "ask"        # Stage files
create_branches = "ask"  # Create new branches
merge_branches = "never" # Merge operations (high-impact)
```

### Multi-Developer Repository Support

#### Passive Mode Operation
- **Non-intrusive**: System won't interfere with developers who don't use it
- **Change detection**: Monitors external changes without disrupting workflow
- **Smart suggestions**: Offers ADR creation for detected architectural decisions

#### External Change Detection
```bash
# Daily workflow for team environments
./adr-helper.sh scan     # Check for new branches and commits by others
./adr-helper.sh suggest  # AI analysis of potential decisions in recent commits
```

**Example scan output:**
```
🔍 Scanning for external changes...
📊 External Change Summary:

  • New branch: feat/payment-gateway by alice@company.com
  • New branch: arch/microservices by bob@company.com

💡 Suggestions:
  • Consider creating ADR for payment gateway decision
  • Consider creating ADR for microservices architecture choice
```

#### Team Configuration
```bash
# One-time setup for team repositories
./adr-helper.sh team-setup
```

This configures:
- Appropriate permission levels based on team size
- External change tracking preferences
- Passive mode for non-disruptive operation
- Branch monitoring patterns

### Safety-First Design

#### Safe Mode
```bash
./adr-helper.sh safe-mode
```

Enables maximum safety settings:
- All git operations require explicit permission
- No automatic commits or pushes
- Passive mode enabled for team compatibility
- External change tracking without interference

#### Permission-Aware AI Operations
AI assistants automatically:
- Check permission settings before suggesting operations
- Respect "never" settings completely
- Request explicit permission for "ask" settings
- Inform users about "yes" operations before executing

### Quick Setup for Different Environments

#### Personal Project (Relaxed permissions)
```bash
./adr-helper.sh permissions
# Set: use_git="yes", auto_commit="ask"
```

#### Small Team (Moderate permissions)
```bash
./adr-helper.sh team-setup
# Choose: small team, enable external tracking
```

#### Large Organization (Strict permissions)
```bash
./adr-helper.sh safe-mode
# Maximum security and team compatibility
```

## Common Objections & Responses

**"We don't have time for more documentation"**

You don't have time NOT to do this. How much time do you waste explaining past decisions?

**"Our codebase is too small/simple"**

Perfect time to start. It scales with your project and prevents future complexity.

**"We use [other documentation system]"**

This complements existing docs. It's specifically for decisions, not general documentation.

**"What if people don't maintain it?"**

The helper scripts make it trivial. Plus, AI assistants will remind you when decisions aren't documented.

**"Will this interfere with my team's workflow?"**

No! The system operates in passive mode by default. Non-users are completely unaffected, while users get enhanced context and decision tracking.

**"I'm worried about unauthorized git operations"**

The authorization framework prevents this. Every operation respects your permission settings, defaulting to "ask" for safety. You can even set "never" for operations you don't want.

**"How do I know what my teammates are working on?"**

The external change detection automatically scans for new branches and commits by others, suggesting relevant ADRs without interfering with their work.

## Team Workflow Integration

### 1. Development Workflow

- Create ADRs in feature branches for major decisions
- Review ADRs as part of code review process
- Merge ADRs when decisions are finalized
- Archive completed ADRs to `merged/` directory

### 2. Decision Process

```
1. Identify decision point
2. Create ADR in appropriate category
3. Document context and alternatives
4. Review with team
5. Update status to "Accepted"
6. Implement decision
7. Update ADR with actual consequences

```

### 3. GitHub PR Template

```
## Related ADRs
- [ ] I've checked for existing ADRs that might be affected
- [ ] New ADR created: [link to ADR file]
- [ ] ADR status updated: [which ADR, what change]

## Decision Impact
- Architecture: [High/Medium/Low/None]
- Security: [High/Medium/Low/None]
- Performance: [High/Medium/Low/None]
```

## Success Metrics

### Week 1

-  System set up
-  First ADR created
-  Team knows it exists

### Month 1

-  5+ ADRs documented
-  Used in at least one technical discussion
-  New team member used it for onboarding

### Month 3

-  Part of regular workflow
-  Prevented at least one repeated discussion
-  AI assistants consistently reference ADRs

## Troubleshooting

**Remember: Your AI assistant should handle most maintenance automatically. If you're manually debugging TOML files or running complex commands, ask your AI to help instead.**

### Common Issues

**ADR validation fails**

```
# Make script executable
chmod +x .claude/adr-helper.sh

# Check file paths in index
./.claude/adr-helper.sh validate
```

**Missing ADR files**

```
# List what should exist vs what does
./.claude/adr-helper.sh status
find .claude/branches -name "*.md"
```

**TOML syntax errors**

```
# Validate TOML syntax (if you have a TOML parser)
python3 -c "import tomllib; tomllib.load(open('.claude/adr-index.toml', 'rb'))"
```

### Emergency Recovery

```
# If index is corrupted
cp .claude/adr-index.toml .claude/adr-index.toml.backup

# Find all ADRs
find .claude -name "*.md" -type f

# Validate structure
./.claude/adr-helper.sh validate 2>&1 | grep "ERROR"
```

## Customization for Different Teams

### Small Teams (2-5 people)

- Use fewer categories (just `feat/` and `arch/`)
- Simpler ADR template
- Less formal approval process

### Large Teams (10+ people)

- More detailed templates
- Formal review process
- Integration with issue tracking
- Regular ADR review meetings

### Different Technology Stacks

- **Frontend**: Add UI/UX decision categories
- **Backend**: Focus on data architecture, API design
- **DevOps**: Emphasize deployment, monitoring decisions
- **Product**: Include feature prioritization, user research

## Advanced Features

### ADR Relationships

Track how decisions relate to each other:

```
[relationships.depends_on]
"new-feature" = ["api-architecture", "database-choice"]

[relationships.conflicts_with]
"microservices" = ["monolith-architecture"]

[relationships.supersedes]
"api-v2" = ["api-v1"]
```

### Status Tracking

```
"decision-name" = {
    status = "proposed" | "accepted" | "superseded" | "rejected",
    superseded_by = "new-decision-id",
    # ...
}
```

### Integration with CI/CD

```
# .github/workflows/adr-validation.yml
name: ADR Validation
on: [push, pull_request]
jobs:
  validate-adrs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Validate ADRs
        run: ./.claude/adr-helper.sh validate
```

## Document Migration and Cleanup

### Automatic Organization

The system includes tools to handle existing documentation:

```bash
# Organize directory structure
./adr-helper.sh organize

# Clean up and organize existing docs
./adr-helper.sh cleanup
```

The `cleanup` command will:
- Move project-specific docs to `docs/` subdirectory
- Identify and optionally remove redundant files
- Create explanatory documentation for the new structure
- Preserve all valuable content in appropriate locations

### Manual Organization Guidelines

**If you have existing documentation:**

1. **ADR-like documents** → Move to appropriate `branches/` category
2. **Project context/overview** → Move to `docs/project-context.md`
3. **Setup/guide documents** → Move to `docs/` with descriptive names
4. **Redundant system guides** → Consider removing if superseded
5. **Reference materials** → Keep in `docs/` with clear names

**Document naming conventions:**
- ADRs: `kebab-case-description.md` in appropriate `branches/` category
- Supporting docs: `DESCRIPTIVE-NAME.md` in `docs/` subdirectory
- Avoid generic names like `README.md` in favor of specific purposes

## Getting Started Checklist

- Create `.claude` directory structure
- Copy this file to `.claude/CLAUDE-CONTEXT-SYSTEM.md`
- Create `adr-index.toml` with your project metadata
- Make `adr-helper.sh` executable
- Run `./adr-helper.sh organize` to ensure proper structure
- Run `./adr-helper.sh cleanup` to organize any existing docs
- **🔐 Configure authorization**: Run `./adr-helper.sh permissions` to set permission levels
- **👥 Team setup**: Run `./adr-helper.sh team-setup` for multi-developer repositories
- **🛡️ Enable safe mode**: Run `./adr-helper.sh safe-mode` for maximum safety (optional)
- Run `./adr-helper.sh configure` to set update frequency preference
- Create your first ADR for an existing major decision
- **🔍 Scan for changes**: Run `./adr-helper.sh scan` to check for external changes (team repos)
- Add ADR creation to your team workflow
- Set up validation in CI (optional)
- Train team on ADR creation process and new authorization features

## Live Demo Script (2 minutes)

```
# 1. Show the 3-step setup (30 seconds)
mkdir -p .claude/{branches/{feat,docs,chore,arch},merged,templates,docs}
cp CLAUDE-CONTEXT-SYSTEM.md .claude/
echo "Setup complete!"

# 2. Create a sample ADR with authorization (1 minute)
./.claude/adr-helper.sh new arch "database-selection"
echo "We chose PostgreSQL because we need ACID compliance"

# 3. Show enhanced features (45 seconds)
./.claude/adr-helper.sh status
./.claude/adr-helper.sh permissions    # Configure authorization
./.claude/adr-helper.sh safe-mode     # Enable safety features
echo "System organized and secured!"

# 4. Show team and AI integration (45 seconds)
./.claude/adr-helper.sh scan          # Check for external changes
./.claude/adr-helper.sh suggest       # AI-powered decision detection
echo "Claude, read .claude/adr-index.toml and tell me our database decision"
# Claude responds with context-aware answer, respecting permissions
```

**This system scales from small teams to large organizations with built-in safety and team collaboration features. Start simple and evolve based on your team's needs.**

_"In 6 months, you'll either have a well-documented decision history with seamless team collaboration, or you'll wish you did."_

## 🔄 Staying Updated

This system is continuously improved. The canonical version at https://gist.github.com/joshrotenberg/a9f8ac85b9ebe20c6b6202a17d804fbc receives regular enhancements from real-world usage across multiple projects.

**Configurable Update Frequency**: Set your preferred update frequency in `.claude/adr-index.toml` (never, quarterly, monthly, weekly, or daily) and ask your AI assistant to check for improvements accordingly.

For questions or improvements, reference this system in your AI assistant conversations - it's designed to be self-documenting and self-improving.