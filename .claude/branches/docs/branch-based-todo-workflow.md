# ADR: branch-based-todo-workflow

**Status**: Proposed
**Date**: 2025-07-18
**Author**: Claude Context System Team
**Tags**: [workflow, productivity, branch-management, 2025-07-18]

## Context

Traditional TODO lists and task management often lack context and become stale. When working on multiple projects or features simultaneously, developers face several challenges:

- **Context Switching Overhead**: Moving between different tasks requires mental reloading of context
- **Stale Task Lists**: Traditional TODO lists don't capture the full context needed to resume work
- **Scattered Information**: Related files, thoughts, and progress are spread across different tools
- **Lost Momentum**: Returning to a task after days/weeks requires significant ramp-up time

A real-world workflow has emerged that addresses these issues by using git branches as TODO items with embedded context.

## Decision

**Adopt Branch-Based TODO Workflow as a recommended practice:**

**Core Principle**: Each TODO item becomes a git branch with full context preserved

**Workflow Steps:**

1. **Capture Phase** - "Figure out what's currently pending, what I want to work on, what I might work on"
   - Create branches immediately for all identified work items
   - Don't wait until you're ready to work on something
   - Capture the idea while it's fresh

2. **Context Creation** - "Create a branch with context for each right away"
   - Branch name describes the work: `feat/user-auth`, `fix/memory-leak`, `docs/api-guide`
   - Add initial commit with context: notes, links, preliminary research
   - Include ADR stub if architectural decision involved

3. **Visual TODO Management** - "Now I have a list of branches with matching context"
   - `git branch -a` becomes your TODO list
   - Each branch name indicates work type and scope
   - Branch age indicates priority/urgency

4. **Context Preservation** - "I can easily bounce between and see right away what I am or want to work on"
   - Switch branches: `git checkout feat/user-auth`
   - Full context is immediately available: files, commits, notes
   - No mental overhead to resume work

**Implementation Guidelines:**

- **Branch Naming**: Use conventional commit prefixes (`feat/`, `fix/`, `docs/`, `chore/`)
- **Initial Commit**: Always make an initial commit with context, even if just notes
- **README Pattern**: Consider adding `BRANCH_NOTES.md` with:
  - Why this work is needed
  - Current progress/thoughts
  - Next steps
  - Relevant links/references
- **Regular Cleanup**: Archive completed branches, merge or delete stale ones

## Consequences

**Positive:**
- **Zero Context Loss**: Full project state preserved with each task
- **Instant Resume**: No ramp-up time when switching back to a branch
- **Visual Priority Management**: `git branch` shows current work landscape
- **Integrated Documentation**: Context lives with the code, not separate tools
- **Collaborative Transparency**: Team can see what everyone is working on
- **Natural Progress Tracking**: Commit history shows evolution of thought
- **Tool Integration**: Works with existing git workflows and IDE branch switchers

**Negative:**
- **Branch Proliferation**: Can lead to many branches if not managed
- **Repository Clutter**: Unfinished work remains visible in branch lists
- **Discipline Required**: Must commit to making initial context commits
- **Learning Curve**: Different from traditional task management approaches

**Mitigations:**
- **Regular Cleanup**: Weekly review to archive/delete stale branches
- **Branch Prefixes**: Use consistent naming to group related work
- **Time Boxing**: Set expiration dates for experimental branches
- **Documentation**: Clear guidelines on when to create vs. abandon branches

## Alternatives Considered

**Traditional TODO Lists/Apps**: Separate task management tools
- *Rejected*: Context lives outside code, becomes stale, requires tool switching

**Issue Tracking Only**: Use GitHub Issues/Jira as TODO list
- *Rejected*: Doesn't preserve working state, no immediate context access

**Single Long-Running Branch**: Keep all work on one development branch
- *Rejected*: Mixes contexts, makes it hard to focus on specific tasks

**Stash-Based Workflow**: Use `git stash` to preserve work-in-progress
- *Rejected*: Stashes are temporary, don't preserve full context, hard to name/organize

**Directory-Based Organization**: Create folders for different work areas
- *Rejected*: Doesn't leverage git's branching power, less integrated workflow

**Commit Message TODOs**: Embed TODO items in commit messages
- *Rejected*: Hard to discover, doesn't preserve working state

## References

- **Practice Origin**: Real-world developer workflow observation
- **Git Integration**: Leverages existing git branch management capabilities
- **Context Preservation**: Builds on the principle that context is critical for productivity
- **Conventional Commits**: Aligns with conventional commit prefixes for consistency
- **Related**: Works well with the Claude Context System for AI assistant continuity
- **Tools**: Compatible with IDE branch switchers, git CLI, GitHub branch views
