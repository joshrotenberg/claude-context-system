# Claude Context System - Project Guide

This directory contains the Claude Context System for managing architectural decisions and project context with AI assistance.

## 🚀 Quick Start for AI Assistants

1. **Check for SESSION-CONTEXT.md** - Start here if present for current status
2. **Read adr-index.toml** - Project metadata and permissions
3. **Review recent ADRs** - Check `branches/` for latest decisions
4. **Follow maintenance checklist** - See guidelines below

## 📁 File Organization

```
.claude/
├── SESSION-CONTEXT.md          # Daily working context (if used)
├── README.md                   # This guide
├── CLAUDE-CONTEXT-SYSTEM.md    # Complete system reference
├── adr-index.toml              # ADR index and configuration
├── adr-helper.sh               # Management scripts
├── arch/                       # Architecture decisions
├── docs/                       # Supporting documentation
├── templates/                  # File templates
└── archive/                    # Historical context
```

## 🔄 Session Management

### AI Assistant Checklist
- [ ] Verify current date is correct
- [ ] Read entire context before taking action
- [ ] Update SESSION-CONTEXT.md after significant tasks
- [ ] Document new architectural decisions as ADRs
- [ ] Maintain consistency with existing choices

### Daily Workflow
1. Start with SESSION-CONTEXT.md for current status
2. Check recent commits for context since last session
3. Complete any pending ADRs or architectural decisions
4. Update SESSION-CONTEXT.md before ending session

## 📝 Creating Documentation

### When to Create ADRs
- Technology choices (database, framework, language)
- Architecture decisions (patterns, structure, integrations)
- Process changes (deployment, testing, workflows)
- Any decision that's hard to reverse or has broad impact

### When to Create Supporting Docs
- Project background and context
- Setup and deployment guides
- API documentation and standards
- Team processes and workflows

## 🛠️ Management Commands

```bash
# Create new ADR
./adr-helper.sh new [type] "decision-title"

# List all ADRs
./adr-helper.sh list

# Check system status
./adr-helper.sh status

# Update ADR index
./adr-helper.sh update-index
```

## 🎯 Success Indicators

- New team members can understand project architecture in <15 minutes
- No repeated questions about past decisions
- Smooth handoffs between sessions and team members
- Architectural knowledge preserved and accessible

## 📋 Maintenance Schedule

- **Daily:** Update SESSION-CONTEXT.md, complete ADRs for decisions
- **Weekly:** Review context accuracy, archive completed items
- **Monthly:** File organization cleanup, update project docs
- **Quarterly:** Full context audit and process improvements

## 🔗 Key References

- **Full System Guide:** `CLAUDE-CONTEXT-SYSTEM.md`
- **ADR Index:** `adr-index.toml`
- **Templates:** `templates/` directory
- **Project Context:** `docs/project-context.md` (if present)

---

**Need Help?** Check the troubleshooting section in `CLAUDE-CONTEXT-SYSTEM.md` or create an ADR documenting the issue and resolution process.