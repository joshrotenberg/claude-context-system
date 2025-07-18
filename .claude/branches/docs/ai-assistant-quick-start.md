# ADR: ai-assistant-quick-start

**Status**: Proposed
**Date**: 2025-01-18
**Author**: Claude Context System Team
**Tags**: [docs, ai-optimization, onboarding]

## Context

When AI assistants encounter this project for the first time or in a new session, they need to efficiently understand:
- The current project status and phase
- Key architectural decisions and their reasoning
- The structure of the `.claude/` directory and ADR organization
- Permission settings and operational constraints
- Recent development activity and context

Currently, AI assistants must discover this information through exploration, which is inefficient and may miss critical context. This leads to:
- Repeated questions about project basics
- Incomplete understanding of system constraints
- Time wasted re-discovering project structure
- Inconsistent context acquisition across sessions

The system needs a standardized, efficient onboarding path for AI assistants to quickly achieve full project context.

## Decision

We will add an **"AI Assistant Quick Start"** section at the top of `CLAUDE-CONTEXT-SYSTEM.md` that provides:

**Structured Onboarding Sequence:**
1. Essential context summary (status, purpose, innovations)
2. Rapid orientation checklist with specific files to read
3. Key file locations and their purposes
4. Current development phase and active work
5. Quick commands for exploring recent decisions

**Placement Strategy:**
- Top of main CLAUDE-CONTEXT-SYSTEM.md file for immediate visibility
- Before general documentation to prioritize AI efficiency
- Consistent across both root and `.claude/` copies

**Content Design:**
- Concise bullet points for rapid scanning
- Specific file paths and commands for immediate action
- Current status updates to avoid outdated assumptions
- Progressive disclosure from essential to detailed context

## Consequences

**Positive:**
- AI assistants achieve full project context in 2-3 minutes instead of 10-15 minutes
- Consistent onboarding experience across different AI sessions
- Reduced repeated questions about project basics
- More productive conversations focused on current work rather than orientation
- Self-documenting system that evolves with project status
- Template for other projects to optimize AI onboarding

**Negative:**
- Additional maintenance overhead to keep quick start section current
- Adds length to already substantial system file
- Risk of quick start section becoming outdated if not maintained
- Potential duplication with other documentation sections

**Mitigations:**
- Include quick start section in regular review cycles
- Keep content high-level to reduce maintenance frequency
- Use relative references that remain valid as project evolves
- Clear date stamps to indicate freshness

## Alternatives Considered

**Separate onboarding file:** Create dedicated AI-onboarding.md file
- *Rejected:* Violates single-file principle, adds discoverability issues

**Bottom-of-file placement:** Add quick start at end of system file
- *Rejected:* AI assistants read top-down, would still encounter inefficiency

**ADR index enhancement:** Expand adr-index.toml with onboarding guidance
- *Rejected:* TOML format less readable for prose instructions

**README enhancement:** Add AI quick start to README.md
- *Rejected:* README is user-focused, this is AI-assistant specific

**Interactive questionnaire:** AI asks questions to determine context needs
- *Rejected:* Slower than providing structured information upfront

## References

- Problem: Observed AI assistant inefficiency during project onboarding
- Solution pattern: Progressive disclosure with structured sequences
- Inspiration: Software installation quick start guides, API documentation
- Target: Reduce AI context acquisition time by 70%
- Scope: Benefits any AI assistant working with this project
- Created during: Post-v1.0 optimization phase focusing on user experience