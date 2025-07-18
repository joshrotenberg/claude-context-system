# Claude Context System: Complete Setup & Guide

**A self-contained system for maintaining project context, architectural decisions, and AI assistant continuity.**

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

- **Current version**: Based on gist updated 2025-07-18
- **Last local update**: 2025-07-18
- **Next recommended check**: 2025-08-18

## Why Your Team Needs This (2-Minute Pitch)

### The Problem We're Solving

- **"Why did we choose X?"** - Asked 6 months later, nobody remembers
- **"What did the last person try?"** - Context lost when team members change
- **"What should our AI assistant know?"** - Inconsistent recommendations across sessions
- **"Where did we leave off?"** - AI agents lose context between sessions, leading to repeated mistakes
- **Technical debt from undocumented decisions** - Costs compound over time

### The Solution: Architectural Decision Records (ADRs)

A lightweight system that:
- Takes 5 minutes to set up
- Requires ~10 minutes per major decision
- Saves hours of confusion and rework
- Makes AI assistants 10x more helpful

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

This creates a decision management system that's both lightweight and powerful - perfect for teams using AI assistants in their development workflow.

**Credits**: Huge thanks to Michael Nygard for ADRs and the Conventional Commits community for commit standardization. This system builds on their foundational work.

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

### For AI Assistants

- **Rich Context**: Understand project history and current state
- **Consistent Recommendations**: Decisions align with previous reasoning
- **Faster Onboarding**: Get up to speed quickly on complex projects
- **Session Continuity**: Resume work exactly where you left off, avoiding repeated discussions
- **Structured Information**: Machine-readable index and organized content

### Enhanced Features

- **🧹 Automatic Cleanup**: `cleanup` command organizes documents and removes redundancy
- **📁 Document Organization**: Separates core ADR workflow from supporting documentation
- **🔧 Enhanced Tooling**: Management commands for validation, organization, and maintenance
- **📚 Multiple Document Types**: Handles ADRs, guides, context docs, and templates appropriately
- **🎯 Scalable Structure**: Grows with project complexity without becoming unwieldy

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
# ADR Helper Script

set -e

CLAUDE_DIR=".claude"
INDEX_FILE="$CLAUDE_DIR/adr-index.toml"

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
        echo "  help      - Show this help message"
        ;;
esac
```

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

# Configure updates
./.claude/adr-helper.sh configure
./.claude/adr-helper.sh check-updates
```

## Sample ADR Index (adr-index.toml)

```
# ADR Index for [PROJECT_NAME]

[metadata]
version = "1.0"
language = "your-language"
project_type = "your-type"
description = "Project description"
created = "2025-07-18"

# Update configuration
[updates]
frequency = "monthly"                    # Options: "never", "quarterly", "monthly", "weekly", "daily"
last_check = "2025-07-18"
next_check = "2025-08-18"
canonical_url = "https://gist.github.com/joshrotenberg/a9f8ac85b9ebe20c6b6202a17d804fbc"

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
- **Always read the ADR index first** to understand current decisions
- **Reference specific ADRs** when making recommendations
- **Suggest new ADRs** when major decisions are needed
- **Update ADRs** when decisions change or evolve
- **Maintain consistency** with existing architectural choices
- **Check for system updates** when explicitly asked or monthly

### System Update Protocol

When asked to check for updates:
1. Fetch the canonical gist: https://gist.github.com/joshrotenberg/a9f8ac85b9ebe20c6b6202a17d804fbc
2. Compare with local `.claude/CLAUDE-CONTEXT-SYSTEM.md`
3. Identify new features, improvements, or fixes
4. Present summary of changes with benefits/impact
5. Ask user which updates to implement
6. Update local system accordingly
7. Update "Last local update" date in this file

### Starting a New AI Session

```
I'm working on [project-name] which uses the Claude Context System.
Please start by reading:
1. .claude/adr-index.toml - for decision history
2. .claude/branches/feat/*.md - for recent decisions
3. .claude/docs/project-context.md - for current project state
4. README.md - for project overview

Current focus: [specific area/feature]
Open questions: [list any pending decisions]
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

-  Create `.claude` directory structure
-  Copy this file to `.claude/CLAUDE-CONTEXT-SYSTEM.md`
-  Create `adr-index.toml` with your project metadata
-  Make `adr-helper.sh` executable
-  Run `./adr-helper.sh organize` to ensure proper structure
-  Run `./adr-helper.sh cleanup` to organize any existing docs
-  Run `./adr-helper.sh configure` to set update frequency preference
-  Create your first ADR for an existing major decision
-  Add ADR creation to your team workflow
-  Set up validation in CI (optional)
-  Train team on ADR creation process

## Live Demo Script (2 minutes)

```
# 1. Show the 3-step setup (30 seconds)
mkdir -p .claude/{branches/{feat,docs,chore,arch},merged,templates,docs}
cp CLAUDE-CONTEXT-SYSTEM.md .claude/
echo "Setup complete!"

# 2. Create a sample ADR (1 minute)
./.claude/adr-helper.sh new arch "database-selection"
echo "We chose PostgreSQL because we need ACID compliance"

# 3. Show organization features (30 seconds)
./.claude/adr-helper.sh status
./.claude/adr-helper.sh cleanup
echo "System organized and ready!"

# 4. Show AI integration (30 seconds)
echo "Claude, read .claude/adr-index.toml and tell me our database decision"
# Claude responds with context-aware answer
```

**This system scales from small teams to large organizations. Start simple and evolve based on your team's needs.**

_"In 6 months, you'll either have a well-documented decision history, or you'll wish you did."_

## 🔄 Staying Updated

This system is continuously improved. The canonical version at https://gist.github.com/joshrotenberg/a9f8ac85b9ebe20c6b6202a17d804fbc receives regular enhancements from real-world usage across multiple projects.

**Configurable Update Frequency**: Set your preferred update frequency in `.claude/adr-index.toml` (never, quarterly, monthly, weekly, or daily) and ask your AI assistant to check for improvements accordingly.

For questions or improvements, reference this system in your AI assistant conversations - it's designed to be self-documenting and self-improving.