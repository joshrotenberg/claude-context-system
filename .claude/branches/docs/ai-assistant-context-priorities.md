# ADR: AI Assistant Context Priorities

**Status**: Accepted
**Date**: 2025-07-18
**Author**: Claude Context System Team
**Tags**: [context-priorities, ai-assistant, workflow, github-cli, organization]

## Context

Through real-world usage, we've identified key context priorities that AI assistants frequently overlook when working with the Claude Context System and GitHub repositories:

**Critical Issues Observed**:
1. **Forgetting GitHub CLI (`gh`)**: AI assistants often forget that `gh` is available for GitHub operations, defaulting to manual web-based workflows
2. **Poor File Organization**: Backup files and temporary artifacts clutter the top-level directory, making repositories messy
3. **Outdated Remotes**: Legacy remotes (like old gist references) remain in git configuration, causing confusion
4. **Inconsistent Tooling**: Not leveraging available tools consistently across sessions

**Impact**: Inefficient workflows, cluttered repositories, missed automation opportunities, and inconsistent user experience.

## Decision

We will establish **AI Assistant Context Priorities** as explicit guidelines that should be prominently documented:

### **Priority 1: Always Use GitHub CLI (`gh`) When Available**
- Check `gh auth status` before manual GitHub operations
- Use `gh pr create`, `gh issue create`, `gh repo clone`, etc. instead of manual web workflows
- Leverage `gh` for repository management, PR creation, and issue tracking

### **Priority 2: Maintain Clean Repository Organization**
- Keep top-level directory clean - no backup files, temporary artifacts, or build outputs
- Use proper subdirectories: `.claude/backups/` for backup files, `tmp/` for temporary files
- Clean up after operations and remove unnecessary files

### **Priority 3: Regular Repository Maintenance**
- Remove outdated git remotes (like old gist references)
- Clean up unused branches and stale references
- Validate and organize file structures regularly

### **Priority 4: Leverage Available Tooling Consistently**
- Use helper scripts and automation tools consistently
- Prefer command-line tools over manual processes when available
- Document and reuse effective workflows

## Consequences

### Positive:
- **Dramatically improved workflow efficiency** through consistent tool usage
- **Cleaner repositories** with better organization and maintenance
- **Reduced cognitive load** for users through consistent AI assistant behavior
- **Better automation** through proper tool utilization
- **Professional appearance** of repositories and workflows

### Neutral:
- AI assistants need to remember and check these priorities
- Slight increase in validation steps before operations
- Need to maintain awareness of available tools

### Negative:
- Minimal - these improve efficiency and user experience

## Alternatives Considered

1. **Implicit Behavior**: Rely on AI assistants to remember these patterns naturally
   - Rejected: Real-world usage shows these are frequently forgotten

2. **Per-Session Reminders**: Mention these priorities at the start of each session
   - Partially adopted: Should be documented for reference

3. **Automated Enforcement**: Build tools to enforce these priorities
   - Future consideration: Could add linting or validation scripts

4. **User Training**: Require users to remind AI assistants of these priorities
   - Rejected: Places burden on users rather than improving system design

## References

- Source: Real-world usage patterns and observed inefficiencies
- Priority: High (impacts every AI assistant interaction)
- Integration: Should be prominently documented in system guides
- Related: GitHub CLI usage, repository organization, workflow optimization
- Implementation: Add to AI Assistant Quick Start section and troubleshooting guides
