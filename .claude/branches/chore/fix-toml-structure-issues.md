# ADR: Fix TOML Structure Issues

**Status**: Accepted
**Date**: 2025-07-18
**Author**: Claude Context System Team
**Tags**: [critical-fix, toml, parsing, reliability]

## Context

A from-scratch implementation of the Claude Context System revealed critical TOML structure and parsing issues that completely break system functionality:

**Critical Issues Discovered**:
1. **Malformed TOML Structure**: Missing closing braces, duplicate fields, inconsistent table syntax
2. **Fragile Grep-Based Parsing**: Simple grep patterns fail with complex TOML structures
3. **Mixed TOML Patterns**: Inconsistent use of `"key" = { ... }` vs `[section.key]` styles
4. **No TOML Validation**: No verification that generated TOML is actually valid

**Impact**: System completely fails to parse index file, causing all commands to error out.

## Decision

We will implement robust TOML handling to fix these critical issues:

1. **Standardize TOML Structure**: Use consistent `"key" = { ... }` pattern for ADR entries
2. **Add TOML Validation**: Implement proper TOML parsing validation before file writes
3. **Improve Variable Sanitization**: Fix bash arithmetic issues with whitespace contamination
4. **Robust Counting Logic**: Replace fragile grep patterns with reliable counting methods
5. **Better Error Handling**: Add comprehensive error context and debugging capabilities

## Consequences

### Positive:
- System reliability dramatically improved
- Setup process becomes much more robust
- Better debugging capabilities for future issues
- Consistent TOML structure across all installations

### Neutral:
- Slight increase in helper script complexity
- Need to test existing installations for compatibility

### Negative:
- Breaking change may require existing users to regenerate their TOML files

## Alternatives Considered

1. **Switch to JSON**: More reliable tooling but less human-readable
   - Rejected: TOML is more appropriate for configuration files

2. **Use External TOML Parser**: Add dependency on python/node
   - Rejected: Violates zero-dependency principle

3. **Simplify Structure**: Use flat key-value pairs only
   - Rejected: Loses valuable hierarchical organization

## References

- Source: From-scratch implementation retrospective
- Priority: Critical (system-breaking issues)
- Related: Bash script arithmetic errors, counting logic issues
- Implementation: Immediate - these break core functionality
