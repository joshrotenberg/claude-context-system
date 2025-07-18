# ADR: single-file-approach

**Status**: Proposed
**Date**: 2025-07-18
**Author**: Claude Context System Team
**Tags**: [simulation, arch, 2025-07-18]

## Context

Teams struggle with architectural decision documentation because traditional approaches require:
- Multiple files to maintain and keep synchronized
- Complex directory structures that become unwieldy
- Separate installation and setup processes
- External dependencies that can break or become outdated
- Learning curves for new team members

We need a solution that maximizes adoption by minimizing friction. The system should be self-contained and immediately usable without setup complexity.

## Decision

We will design the Claude Context System as a **single, self-contained markdown file** that includes:
- Complete setup instructions
- All necessary templates and examples  
- The full helper script embedded within the documentation
- Configuration schema and examples
- Troubleshooting and usage guidance

Users copy one file (`.claude/CLAUDE-CONTEXT-SYSTEM.md`) to their project, and their AI assistant can immediately understand and implement the entire system.

## Consequences

**Positive:**
- Zero setup friction - copy one file and you're done
- Self-documenting - everything needed is in one place
- Version control friendly - one file to track, diff, and merge
- AI-parseable - any AI can read the entire system context in one pass
- No external dependencies or installation requirements
- Easy to share, fork, and customize
- Immediate adoption - no "getting started" barriers

**Negative:**
- Single file becomes large (~2000 lines)
- Could feel overwhelming to human readers
- Updates require replacing entire file rather than modular updates
- Harder to modularize for different use cases

**Mitigations:**
- Emphasize AI-first approach - humans don't need to read everything
- Use clear section headers and table of contents
- Provide minimal usage examples upfront
- Include validation tools to verify system integrity

## Alternatives Considered

**Multi-file approach:** Separate documentation, scripts, templates, and configuration files
- *Rejected:* Creates setup complexity and synchronization issues

**NPM/pip package:** Installable tool with CLI
- *Rejected:* Adds dependency management overhead and external failure points

**GitHub template repository:** Fork-and-customize approach
- *Rejected:* Requires GitHub-specific knowledge and creates maintenance burden

**Configuration-driven:** Small core with external config files
- *Rejected:* Still requires multiple files and setup coordination

## References

- Inspired by: Self-contained scripts in DevOps (install.sh patterns)
- Related to: Unix philosophy of "do one thing well" - but applied to documentation
- Created during: Architecture phase of Claude Context System v1.0
