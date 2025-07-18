# ADR: Bash Script Reliability Improvements

**Status**: Accepted
**Date**: 2025-07-18
**Author**: Claude Context System Team
**Tags**: [critical-fix, bash, reliability, arithmetic, error-handling]

## Context

From-scratch implementation testing revealed critical bash script reliability issues that completely broke system functionality:

**Critical Issues Discovered**:
1. **Variable Arithmetic Errors**: `wc -l` output includes newlines causing "syntax error in expression" 
2. **Fragile Variable Handling**: Whitespace contamination breaking bash arithmetic operations
3. **Poor Error Handling**: Script failures with `set -e` but no clear error context
4. **No Input Validation**: Missing validation of prerequisites and file existence
5. **Template Date Expansion**: `$(date)` appearing literally instead of expanding properly

**Specific Error Example**: `2 + 2 + 1 + 0\n0 : syntax error in expression (error token is "0 ")`

**Impact**: Core functionality (status, counting, ADR creation) completely broken in fresh installations.

## Decision

We will implement comprehensive bash script reliability improvements:

1. **Variable Sanitization**: Add consistent `tr -d '[:space:]'` sanitization for all command output
2. **Safe Arithmetic Operations**: Create `safe_add()` function with input validation and fallback handling
3. **TOML Validation**: Add `validate_toml()` function with basic syntax checking before file modifications
4. **Backup System**: Automatic backup creation before TOML modifications with restore capability
5. **Enhanced Error Handling**: Comprehensive error context, prerequisite validation, and clear error messages
6. **Template Fix**: Proper variable expansion in ADR templates using intermediate variables

## Consequences

### Positive:
- System reliability dramatically improved - no more arithmetic failures
- Better debugging capabilities with comprehensive error context
- TOML corruption prevention with validation and backup/restore
- Template generation works correctly with proper date expansion
- Clear error messages guide users to solutions

### Neutral:
- Slight increase in helper script complexity and execution time
- Additional backup files created (cleanable with standard tools)

### Negative:
- Minimal - these are essential reliability fixes for core functionality

## Alternatives Considered

1. **External Dependencies**: Use python/node for more robust scripting
   - Rejected: Violates zero-dependency principle

2. **Simplified Functionality**: Remove complex counting and status features
   - Rejected: These features provide significant value when working properly

3. **Different Shell**: Switch to zsh or fish with better error handling
   - Rejected: Bash is more universally available

## References

- Source: From-scratch implementation retrospective and critical bug reports
- Priority: Critical (system-breaking issues)
- Functions Added: `validate_toml()`, `backup_toml()`, `sanitize_var()`, `safe_add()`
- Implementation: Immediate - these prevent system failures in new installations
