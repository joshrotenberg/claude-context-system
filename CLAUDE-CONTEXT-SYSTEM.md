# Claude Context System: Complete Setup & Guide

**A self-contained system for maintaining project context, architectural decisions, and AI assistant continuity.**

## Why Your Team Needs This (2-Minute Pitch)

### The Problem We're Solving
- **"Why did we choose X?"** - Asked 6 months later, nobody remembers
- **"What did the last person try?"** - Context lost when team members change
- **"What should our AI assistant know?"** - Inconsistent recommendations across sessions
- **Technical debt from undocumented decisions** - Costs compound over time

### The Solution: Architectural Decision Records (ADRs)
A lightweight system that:
- Takes 5 minutes to set up
- Requires ~10 minutes per major decision
- Saves hours of confusion and rework
- Makes AI assistants 10x more helpful

### Real ROI Example
**Without ADRs:** 2 hours finding why Redis was chosen over Postgres  
**With ADRs:** 2 minutes reading `cache-technology-decision.md`  
**Break-even:** After just 3-4 "why did we..." questions

## Quick Setup (Copy → Paste → Done)

### 1. Create the Directory Structure

```bash
mkdir -p .claude/{branches/{feat,docs,chore,arch},merged,templates}
```

### 2. Copy This File

Save this file as `.claude/CLAUDE-CONTEXT-SYSTEM.md` in your project root.

### 3. Tell Claude

"Please read `.claude/CLAUDE-CONTEXT-SYSTEM.md` and set up the complete system for our project."

That's it! Claude will create all the files, templates, and scripts needed.

## Quick Reference Card

### Essential Commands
```bash
# Daily workflow
./adr-helper.sh status          # Check system health
./adr-helper.sh list            # See active decisions
./adr-helper.sh new feat "name" # Create new ADR

# Maintenance
./adr-helper.sh validate        # Verify integrity
find .claude -name "*.md"       # Find all ADRs
grep -r "Status: Proposed"      # Find pending decisions
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

### For AI Assistants

- **Rich Context**: Understand project history and current state
- **Consistent Recommendations**: Decisions align with previous reasoning
- **Faster Onboarding**: Get up to speed quickly on complex projects

## File Structure

```
.claude/
├── CLAUDE-CONTEXT-SYSTEM.md    # This file (setup + guide)
├── adr-index.toml               # Machine-readable ADR index
├── adr-helper.sh                # Validation scripts
├── branches/                    # Active ADRs by category
│   ├── feat/                    # Feature decisions
│   ├── docs/                    # Documentation decisions
│   ├── chore/                   # Process/tooling decisions
│   └── arch/                    # Architecture decisions
├── merged/                      # Completed/finalized ADRs
└── templates/                   # ADR templates
```

## When to Create ADRs

- **Technology choices**: Why Rust over Go? Why Postgres over MongoDB?
- **Architecture decisions**: Microservices vs monolith? Event-driven vs REST?
- **Process changes**: New deployment strategy, testing approach
- **Requirements specifications**: Major feature requirements and constraints
- **Any decision that's hard to reverse or has broad impact**

## ADR Template

```markdown
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

```bash
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
    help|*)
        echo "Usage: $0 {validate|list|status|new [category] [title]}"
        echo ""
        echo "Commands:"
        echo "  validate  - Validate ADR structure and references"
        echo "  list      - List all active ADRs"
        echo "  status    - Show system status and statistics"
        echo "  new       - Create new ADR (category defaults to 'feat')"
        echo "  help      - Show this help message"
        ;;
esac
```

### Quick Management Commands

```bash
# Validate ADR system
./.claude/adr-helper.sh validate

# List all ADRs
./.claude/adr-helper.sh list

# Show status
./.claude/adr-helper.sh status

# Create new ADR
./.claude/adr-helper.sh new feat "api-architecture-decision"
```

## Sample ADR Index (adr-index.toml)

```toml
# ADR Index for [PROJECT_NAME]

[metadata]
version = "1.0"
language = "your-language"
project_type = "your-type"
description = "Project description"
created = "2025-07-18"

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

### Starting a New AI Session
```markdown
I'm working on [project-name] which uses the Claude Context System.
Please start by reading:
1. .claude/adr-index.toml - for decision history
2. .claude/branches/feat/*.md - for recent decisions
3. README.md - for current project state

Current focus: [specific area/feature]
Open questions: [list any pending decisions]
```

## Common Objections & Responses

**"We don't have time for more documentation"**
> You don't have time NOT to do this. How much time do you waste explaining past decisions?

**"Our codebase is too small/simple"**
> Perfect time to start. It scales with your project and prevents future complexity.

**"We use [other documentation system]"**
> This complements existing docs. It's specifically for decisions, not general documentation.

**"What if people don't maintain it?"**
> The helper scripts make it trivial. Plus, AI assistants will remind you when decisions aren't documented.

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

```markdown
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
- [ ] System set up
- [ ] First ADR created
- [ ] Team knows it exists

### Month 1
- [ ] 5+ ADRs documented
- [ ] Used in at least one technical discussion
- [ ] New team member used it for onboarding

### Month 3
- [ ] Part of regular workflow
- [ ] Prevented at least one repeated discussion
- [ ] AI assistants consistently reference ADRs

## Troubleshooting

### Common Issues

**ADR validation fails**

```bash
# Make script executable
chmod +x .claude/adr-helper.sh

# Check file paths in index
./.claude/adr-helper.sh validate
```

**Missing ADR files**

```bash
# List what should exist vs what does
./.claude/adr-helper.sh status
find .claude/branches -name "*.md"
```

**TOML syntax errors**

```bash
# Validate TOML syntax (if you have a TOML parser)
python3 -c "import tomllib; tomllib.load(open('.claude/adr-index.toml', 'rb'))"
```

### Emergency Recovery

```bash
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

```toml
[relationships.depends_on]
"new-feature" = ["api-architecture", "database-choice"]

[relationships.conflicts_with]
"microservices" = ["monolith-architecture"]

[relationships.supersedes]
"api-v2" = ["api-v1"]
```

### Status Tracking

```toml
"decision-name" = {
    status = "proposed" | "accepted" | "superseded" | "rejected",
    superseded_by = "new-decision-id",
    # ...
}
```

### Integration with CI/CD

```yaml
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

## Getting Started Checklist

- [ ] Create `.claude` directory structure
- [ ] Copy this file to `.claude/CLAUDE-CONTEXT-SYSTEM.md`
- [ ] Create `adr-index.toml` with your project metadata
- [ ] Make `adr-helper.sh` executable
- [ ] Create your first ADR for an existing major decision
- [ ] Add ADR creation to your team workflow
- [ ] Set up validation in CI (optional)
- [ ] Train team on ADR creation process

## Live Demo Script (2 minutes)

```bash
# 1. Show the 3-step setup (30 seconds)
mkdir -p .claude/{branches/{feat,docs,chore,arch},merged,templates}
cp CLAUDE-CONTEXT-SYSTEM.md .claude/
echo "Setup complete!"

# 2. Create a sample ADR (1 minute)
./.claude/adr-helper.sh new arch "database-selection"
echo "We chose PostgreSQL because we need ACID compliance"

# 3. Show AI integration (30 seconds)
echo "Claude, read .claude/adr-index.toml and tell me our database decision"
# Claude responds with context-aware answer
```

---

**This system scales from small teams to large organizations. Start simple and evolve based on your team's needs.**

_"In 6 months, you'll either have a well-documented decision history, or you'll wish you did."_

For questions or improvements, reference this system in your AI assistant conversations - it's designed to be self-documenting and self-improving.