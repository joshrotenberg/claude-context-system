# ADR: SESSION-CONTEXT Pattern Implementation

**Status:** Proposed
**Date:** 2025-07-22
**Decision ID:** feat/session-context-pattern

## Context

Real-world usage of the Claude Context System in projects like Radar Agent revealed critical gaps in session management and context continuity. Users reported confusion about where to start each session, inconsistent AI assistant behavior across sessions, and difficulty with session handoffs between team members.

### Problems Identified
1. **Multiple entry points**: Various files at root level without clear starting point
2. **Context confusion**: AI assistants inconsistently oriented across sessions
3. **Poor session handoffs**: No standard way to transfer work between sessions
4. **File organization chaos**: Projects grow beyond simple ADR tracking without clear organization patterns
5. **No maintenance protocols**: Context becomes stale without systematic upkeep

### User Feedback
- "Our team adopted this after losing 3 days to context confusion across AI sessions"
- "Multiple context files create confusion about 'source of truth'"
- "Need better patterns for session handoff and continuation"
- "File organization becomes unwieldy as projects grow"

## Decision

Implement the **SESSION-CONTEXT Pattern** as an optional enhancement to the Claude Context System, providing:

### 1. Single Point of Entry
- `SESSION-CONTEXT.md` serves as daily working context file
- Contains current status, immediate next actions, today's goals
- Links to relevant ADRs and supporting documentation
- Eliminates confusion about where to start each session

### 2. Enhanced AI Assistant Guidelines
Replace basic quick start with comprehensive checklist:
- Essential pre-session checks (date verification, context reading)
- Session maintenance protocols (update context, document decisions)
- Session handoff procedures (status updates, next actions)
- Maintenance reminders (ADR completion, link updates)

### 3. Scalable File Organization
```
.claude/
├── SESSION-CONTEXT.md          # Single point of entry
├── CLAUDE-CONTEXT-SYSTEM.md    # System reference
├── adr-index.toml              # ADR index
├── arch/                       # Architecture ADRs
├── docs/                       # Supporting documentation
└── archive/                    # Historical context
```

### 4. Session Continuity Patterns
- AI-to-AI session handoff protocols
- Human team member handoff templates
- Long-term maintenance schedules (daily/weekly/monthly/quarterly)
- Context health indicators and emergency recovery procedures

### 5. Template System
- SESSION-CONTEXT.md template with clear structure
- Project README template for .claude directory
- Archive organization patterns
- Handoff documentation templates

## Implementation Approach

### Backward Compatibility
- All improvements are **additive only** - no breaking changes
- Existing installations continue working unchanged
- SESSION-CONTEXT.md is **optional pattern**, not requirement
- Core ADR system remains unchanged

### Integration Strategy
1. **Enhance existing sections** in CLAUDE-CONTEXT-SYSTEM.md
2. **Add new sections** for session management patterns
3. **Create template directory** with example files
4. **Update quick start** to mention session management option
5. **Test on canonical repository** before public release

### Core Principles Maintained
- ✅ **Zero setup friction** - All additions are optional
- ✅ **AI-first design** - Enhanced guidelines improve AI behavior
- ✅ **Single-file distribution** - CLAUDE-CONTEXT-SYSTEM.md remains self-contained
- ✅ **Team-safe defaults** - No impact on existing team workflows

## Consequences

### Positive
- **Eliminates session confusion**: Clear single entry point for all contexts
- **Improves AI consistency**: Enhanced guidelines ensure better behavior across sessions
- **Enables smooth handoffs**: Both AI-to-AI and human-to-human transfers
- **Scales with project growth**: File organization patterns handle complexity
- **Reduces context drift**: Systematic maintenance protocols keep information current
- **Faster onboarding**: New team members orient quickly using structured context

### Negative
- **Additional file maintenance**: SESSION-CONTEXT.md needs regular updates
- **Learning curve**: Teams need to adopt new patterns and protocols
- **Optional complexity**: More features to understand, though adoption is voluntary

### Neutral
- **File count increases**: More template files, but organized in subdirectories
- **Documentation length**: CLAUDE-CONTEXT-SYSTEM.md grows, but remains single-file
- **Process overhead**: Structured maintenance, but prevents larger problems

## Alternatives Considered

### 1. Status Quo - No Session Management
**Rejected**: Real-world feedback shows clear need for session continuity patterns

### 2. Separate Session Management System
**Rejected**: Would violate single-file distribution principle and create setup friction

### 3. Required SESSION-CONTEXT.md
**Rejected**: Would break backward compatibility and force changes on existing users

### 4. Multiple Entry Point Files
**Rejected**: Would increase rather than reduce context confusion

## Success Metrics

### Implementation Success
- [ ] All text additions drafted and tested
- [ ] Template system created and validated
- [ ] Enhanced AI guidelines tested on canonical repository
- [ ] File organization patterns proven to scale
- [ ] Backward compatibility verified

### Adoption Success (Post-Release)
- **Week 1**: Teams report clearer session orientation
- **Month 1**: Reduced questions about where to start and current status
- **Month 3**: Improved session handoffs and context maintenance
- **Month 6**: Enhanced long-term context preservation and team onboarding

### Quality Indicators
- No context confusion reports from new implementations
- Smooth AI assistant behavior across sessions
- Effective team member handoffs using provided templates
- Sustainable context maintenance with minimal overhead

## References

- **Real-world usage**: Radar Agent project implementation insights
- **User feedback**: Multiple teams reporting session management gaps
- **Core principles**: Single-file distribution, AI-first design, team-safe defaults
- **Existing system**: CLAUDE-CONTEXT-SYSTEM.md v1.0 specification
- **Template examples**: Created and tested in `.claude/templates/`

## Implementation Notes

**Testing completed on canonical repository**:
- SESSION-CONTEXT.md created and used successfully
- Enhanced AI guidelines validated (date checking, context reading)
- File organization patterns tested with docs/ and archive/ directories
- Template system created and proven functional

**Ready for integration**: All improvements tested and validated, maintaining core system principles while addressing real-world usage gaps.