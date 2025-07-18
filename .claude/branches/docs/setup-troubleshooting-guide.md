# ADR: Setup Troubleshooting Guide

**Status**: Accepted
**Date**: 2025-07-18
**Author**: Claude Context System Team
**Tags**: [documentation, troubleshooting, user-experience, setup-issues]

## Context

From-scratch implementation testing revealed numerous setup issues that new users encounter, but our documentation lacks a comprehensive troubleshooting guide. The current 800+ line main documentation is difficult to navigate when users encounter problems.

**Issues Identified from Real Implementations**:
1. **TOML Structure Problems**: Users get malformed TOML that breaks the system
2. **Bash Script Failures**: Arithmetic errors and variable handling issues
3. **Missing Dependencies**: No clear prerequisite validation
4. **Permission Issues**: Script executability problems
5. **Directory Structure**: Missing directories causing validation failures
6. **Template Problems**: Date expansion and placeholder replacement issues

**Current State**: Users experiencing setup issues have no clear debugging path and may abandon the system.

## Decision

We will add a comprehensive "Setup Troubleshooting Guide" section to the main Claude Context System documentation with:

1. **Common Setup Issues**: TOML syntax errors, bash arithmetic failures, permission problems
2. **Diagnostic Commands**: How to validate system state and identify problems
3. **Recovery Procedures**: How to fix corrupted TOML, restore from backups, regenerate files
4. **Platform-Specific Notes**: macOS vs Linux differences, WSL considerations
5. **Prerequisites Checklist**: Required tools, permissions, and environment setup
6. **Emergency Recovery**: Complete system reset and reinstallation procedures

This will be added as a prominent section in the main documentation, not buried at the end.

## Consequences

### Positive:
- Dramatically improved user experience for new installations
- Reduced support burden and user frustration
- Better system adoption due to easier troubleshooting
- Clear diagnostic and recovery procedures for AI assistants
- Prevention of user abandonment due to setup issues

### Neutral:
- Slight increase in documentation length and maintenance burden
- Need to keep troubleshooting guide updated with new issues

### Negative:
- Minimal - essential for system usability and adoption

## Alternatives Considered

1. **Separate Troubleshooting Document**: Create standalone troubleshooting file
   - Rejected: Users need troubleshooting info integrated with main setup docs

2. **Auto-Detection and Fixes**: Build self-healing capabilities into helper script
   - Partially adopted: Added validation and auto-repair to helper script
   - Still need manual troubleshooting guide for complex issues

3. **Video Tutorials**: Create video walkthroughs for common issues
   - Rejected: Text-based troubleshooting is more searchable and maintainable

## References

- Source: From-scratch implementation retrospective and setup failure analysis
- Priority: High (impacts user adoption and system usability)
- Integration: Add to main CLAUDE-CONTEXT-SYSTEM.md as prominent section
- Related ADRs: TOML structure fixes, bash script reliability improvements
