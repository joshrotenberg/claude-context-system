# Draft Updates for Claude Context System

This document contains the specific text additions to implement the SESSION-CONTEXT pattern and enhanced AI guidelines based on real-world usage insights.

## 1. Enhanced AI Assistant Quick Start Section

**Replace existing section starting at line 5 with:**

```markdown
## 🚀 AI Assistant Quick Start & Guidelines

**If you're an AI assistant getting oriented on this project for the first time, follow this sequence:**

### 0. Essential Checklist (Always Start Here)
- [ ] Verify current date is correct (update if wrong)
- [ ] Read entire context before taking action
- [ ] Check for SESSION-CONTEXT.md (single point of entry)
- [ ] Review ADR index for architectural decisions
- [ ] Maintain consistency with existing choices

### 1. Session Orientation Sequence
1. **Check for SESSION-CONTEXT.md**: If present, start here for current status and immediate next actions
2. **Read ADR Index**: `.claude/adr-index.toml` - shows current decisions and project metadata
3. **Review Recent ADRs**: Look in `.claude/branches/` for latest architectural decisions
4. **Understand Permissions**: Check `.claude/adr-index.toml` configuration for allowed operations
5. **Current Branch Structure**: Use `git branch -a` to see active development

### 2. Session Maintenance (Do This Throughout)
- [ ] Update SESSION-CONTEXT.md after completing significant tasks
- [ ] Document new architectural decisions as ADRs
- [ ] Keep context files current and accurate
- [ ] Check for system updates periodically

### 3. Session Handoff (Before Ending)
- [ ] Update SESSION-CONTEXT.md with current status
- [ ] Note any pending decisions or next actions
- [ ] Ensure all work is properly documented
- [ ] Update today's goals completion status

### 4. Key Files for Context
- **`SESSION-CONTEXT.md`** - Daily working context (if present)
- **`.claude/adr-index.toml`** - Project metadata, permissions, active ADRs
- **`.claude/branches/*/`** - All architectural decisions organized by type
- **`README.md`** - Public-facing overview and quick start
- **This file** - Complete system specification and setup guide

**Quick Command**: To see all recent decisions: `find .claude/branches -name "*.md" -exec basename {} \; | sort`
```

## 2. Session Management Pattern Section

**Add new section after line 40 (after current Quick Start):**

```markdown
## 📋 Session Management Pattern (Recommended)

For projects with frequent AI assistant sessions or team handoffs, the **Single Point of Entry** pattern eliminates context confusion and improves session continuity.

### When to Use This Pattern
- Multiple AI sessions per day
- Team collaboration with context handoffs
- Long-running projects with evolving context
- Need for quick session orientation

### Implementation

**Create `SESSION-CONTEXT.md` as your daily working file:**

```
.claude/
├── SESSION-CONTEXT.md          # ← Single point of entry
├── CLAUDE-CONTEXT-SYSTEM.md    # System setup and reference
├── adr-index.toml              # ADR index
├── adr-helper.sh               # Management scripts
├── arch/                       # ADRs when needed
├── docs/                       # Supporting documentation
└── archive/                    # Historical context
```

### Benefits of This Pattern
- **No confusion about where to start** - One clear entry point
- **Essential info without overwhelming detail** - Focused on current needs
- **Easy session handoff and continuation** - Clear status and next actions
- **Only one file needs regular updates** - Reduces maintenance overhead
- **Historical preservation** - Archive keeps long-term context separate

### Integration with Existing System
- SESSION-CONTEXT.md complements, doesn't replace, the core ADR system
- ADRs remain the authoritative source for architectural decisions
- Supporting documentation stays organized in subdirectories
- All existing workflows continue unchanged
```

## 3. Improved File Organization Section

**Add after existing File Structure section (around line 400):**

```markdown
### Scaling File Organization

As projects grow beyond initial ADR tracking, organize supporting files to keep the root `.claude/` directory clean and navigable.

**Recommended Structure for Growing Projects:**

```
.claude/
├── SESSION-CONTEXT.md          # Single point of entry (optional)
├── README.md                   # System usage guide for your project
├── CLAUDE-CONTEXT-SYSTEM.md    # This system file
├── adr-index.toml              # ADR index
├── adr-helper.sh               # Management scripts
├── arch/                       # Architecture ADRs
│   ├── database-choice.md
│   ├── microservices-approach.md
│   └── deployment-strategy.md
├── docs/                       # Supporting documentation
│   ├── project-context.md      # Project background and goals
│   ├── api-guidelines.md       # Development standards
│   ├── deployment-guide.md     # Operational documentation
│   └── team-processes.md       # Workflow documentation
└── archive/                    # Historical context
    ├── old-decisions/          # Superseded ADRs
    ├── meeting-notes/          # Historical discussions
    └── session-history/        # Old SESSION-CONTEXT.md files
```

**Organization Guidelines:**
- **Keep root clean**: Only essential working files at root level
- **Use subdirectories**: Group related documentation logically
- **Archive old content**: Move historical content to `archive/` monthly
- **Single source of truth**: Avoid duplicating information across files
- **Clear naming**: Use descriptive names that indicate content purpose

**Migration Strategy:**
1. **Start simple**: Begin with basic structure, add subdirectories as needed
2. **Move gradually**: Relocate files when they're no longer actively referenced
3. **Update links**: Ensure SESSION-CONTEXT.md and ADRs point to new locations
4. **Archive regularly**: Monthly cleanup prevents accumulation of stale content
```

## 4. Session Continuity Patterns Section

**Add new section before "Team Workflow Integration" (around line 1650):**

```markdown
## 🔄 Session Continuity & Team Handoffs

Effective context management across sessions and team members prevents knowledge loss and reduces ramp-up time.

### AI-to-AI Session Handoffs

When continuing work across AI assistant sessions:

1. **Start with SESSION-CONTEXT.md** (if present) for immediate orientation
2. **Check recent git commits** for work completed since last session
3. **Review pending ADRs** in `branches/` that may need completion
4. **Scan adr-index.toml** for any new decisions or status changes
5. **Update SESSION-CONTEXT.md** with new status before ending session

**Handoff Quality Checklist:**
- [ ] Current status clearly documented
- [ ] Next actions explicitly stated
- [ ] Any blockers or open questions noted
- [ ] Relevant context links provided

### Human Team Member Handoffs

When transferring work between team members:

1. **Complete in-progress ADRs** or clearly mark them as pending with context
2. **Update project documentation** in `docs/` with current architectural state
3. **Document open questions** and decision points in SESSION-CONTEXT.md
4. **Provide context links** to relevant background ADRs and documentation
5. **Schedule handoff discussion** if complex context exists

**Team Handoff Template:**
```markdown
## Handoff Summary
**From:** [Previous team member]
**To:** [New team member]
**Date:** [Handoff date]

### Current Status
[Brief summary of current state]

### Completed This Week
- [List of completed work]

### Pending Decisions
- [List of decisions that need to be made]

### Context References
- Key ADRs: [links]
- Background docs: [links]
- Open questions: [details]
```

### Long-term Continuity Maintenance

**Weekly (AI Assistant or Team Member):**
- Review SESSION-CONTEXT.md for outdated information
- Archive completed tasks and resolved issues
- Update priorities for the coming week
- Check for orphaned or incomplete ADRs

**Monthly (Human Team Member):**
- Comprehensive file organization review
- Archive old SESSION-CONTEXT.md versions
- Update PROJECT-CONTEXT.md with major architectural evolution
- Clean up and reorganize supporting documentation
- Check for Claude Context System updates

**Quarterly (Project Lead):**
- Full context audit and cleanup
- Review ADR relationships and dependencies
- Evaluate and improve team context management processes
- Plan improvements based on what's working and what isn't
- Update team training on context management practices
```

## 5. Context Maintenance Protocols Section

**Add new section in the troubleshooting area (around line 2000):**

```markdown
## 🔧 Context Maintenance Protocols

Systematic maintenance prevents context drift and ensures the system remains valuable over time.

### Daily Maintenance (AI Assistant)
- **Update SESSION-CONTEXT.md** with current status after significant work
- **Complete ADRs** for any architectural decisions made during the session
- **Link new decisions** to existing context and related ADRs
- **Note blockers or questions** that need human input

### Weekly Maintenance (Human or AI)
- **Review SESSION-CONTEXT.md** for accuracy and relevance
- **Archive completed tasks** and resolved issues
- **Update next week's priorities** based on current progress
- **Check for stale links** or outdated references

### Monthly Maintenance (Human)
- **File organization review**: Move old content to appropriate archive locations
- **Documentation cleanup**: Remove or update outdated information
- **ADR relationship review**: Ensure decision dependencies are properly linked
- **System update check**: Review Claude Context System for improvements
- **Team process evaluation**: Assess what's working and what needs adjustment

### Quarterly Maintenance (Project Lead)
- **Comprehensive context audit**: Full review of all documentation for accuracy
- **Architecture documentation update**: Ensure high-level docs reflect current reality
- **Team training refresh**: Update team on best practices and new patterns
- **Tool evaluation**: Assess if additional tools or improvements are needed
- **Process optimization**: Refine workflows based on quarterly experience

### Maintenance Quality Indicators

**Good Context Health:**
- SESSION-CONTEXT.md is current (updated within last week)
- ADRs are complete and properly linked
- Supporting documentation is organized and findable
- Team members can orient quickly from context files
- No duplicate or conflicting information

**Context Needs Attention:**
- SESSION-CONTEXT.md is stale (not updated in 2+ weeks)
- Multiple incomplete or orphaned ADRs
- Scattered documentation in root directory
- Team members asking repeated questions about decisions
- Conflicting information in different files

### Emergency Context Recovery

If context becomes severely fragmented or outdated:

1. **Preserve existing content**: Move everything to `archive/emergency-backup-[date]/`
2. **Start fresh with core files**: Create new SESSION-CONTEXT.md and update adr-index.toml
3. **Gradually restore**: Move back only actively needed documentation
4. **Document lessons learned**: Create ADR about what went wrong and how to prevent it
5. **Implement stricter maintenance**: Increase review frequency temporarily
```

## 6. Updated Quick Setup Section

**Modify existing Quick Setup section to include SESSION-CONTEXT option:**

```markdown
### 3. Tell Claude

"Please read `.claude/CLAUDE-CONTEXT-SYSTEM.md` and set up the complete system. Also create a SESSION-CONTEXT.md file using the template for daily context management."

**Alternative for basic setup without session management:**
"Please read `.claude/CLAUDE-CONTEXT-SYSTEM.md` and set up the complete system."
```

## 7. Success Metrics Update

**Add to existing Success Metrics section:**

```markdown
### Session Management Success Indicators

**Week 1:**
- SESSION-CONTEXT.md created and used daily
- AI assistants consistently start sessions by reading SESSION-CONTEXT.md
- Clear handoff notes between sessions

**Month 1:**
- Team members can orient to project state in under 5 minutes
- No repeated questions about recent decisions or current status
- Smooth handoffs between team members and AI sessions

**Month 3:**
- File organization scales cleanly with project growth
- Context maintenance becomes routine habit
- New team members onboard effectively using context system
```
