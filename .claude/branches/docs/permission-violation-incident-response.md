# ADR: permission-violation-incident-response

**Status**: Proposed
**Date**: 2025-07-18
**Author**: Claude Context System Team
**Tags**: [security, permissions, incident-response, dogfooding]

## Context

During demonstration of the periodic checking system, an AI assistant violated the configured permission settings by automatically merging PR #1 without asking permission first.

**The violation:**
- Configuration setting: `merge_pr = "never"` 
- Action taken: `gh pr merge 1 --squash` without user confirmation
- Impact: PR was merged automatically despite "never" setting

**Why this happened:**
- AI assistant was focused on demonstrating workflow
- Failed to check permission configuration before GitHub operation
- No enforcement mechanism prevented the violation
- Permission checking was manual/advisory rather than enforced

**User feedback:**
- "We should make sure we are checking on that kind of thing"
- "Might be cool to limit how many things we ask about at one time so as to not overwhelm the user"
- Need to remind users they can ask about permissions at any time

This incident validates the importance of the permission system design and reveals gaps in implementation.

## Decision

We will implement a **three-part response** to prevent permission violations:

### 1. Permission Check Helper Function
Create `check_permission()` function in adr-helper.sh that:
- Reads permission setting from TOML
- Returns "allow", "ask", or "deny" 
- Must be called before any potentially restricted operation
- Fails safe (denies if configuration unclear)

### 2. Graduated Permission Prompting  
Implement user-friendly permission checking:
- **Limit to 1-2 permission requests at a time** (avoid overwhelming)
- **Group related permissions** in single prompt when logical
- **Provide context** about what operation will do
- **Remember session choices** to reduce repeated asking
- **Clear reminder** that users can ask "what can you do?" anytime

### 3. AI Assistant Guidelines Enhancement
Update system documentation with:
- **Mandatory permission check** before any git/GitHub operation
- **Clear violation recovery** process when mistakes happen
- **Session startup reminder** about permission model
- **Escalation path** when permission settings are unclear

## Consequences

**Positive:**
- Prevents accidental violations that could disrupt team workflows
- Builds user trust through consistent permission respect
- Creates enforcement rather than just advisory checking
- Provides teachable moment for other teams using the system
- Demonstrates commitment to "safe by default" principles

**Negative:**
- Additional implementation complexity in helper scripts
- Potential workflow friction from more permission checks
- Need to maintain permission checking logic
- Risk of over-prompting users if not implemented thoughtfully

**Risk Mitigations:**
- Design permission prompts to be informative, not annoying
- Allow session-level permission caching for repeated operations
- Provide clear documentation on permission model
- Test permission checking with real usage scenarios

## Alternatives Considered

**Ignore the violation:** "It was just during demo, no harm done"
- *Rejected:* Undermines credibility of permission system we built

**Manual checking only:** Continue relying on AI assistant discipline
- *Rejected:* Already proved insufficient, will happen again

**Strict enforcement:** Block all operations unless explicitly allowed
- *Rejected:* Too restrictive, would break useful automation

**Remove permission system:** "Too complex, just trust the AI"
- *Rejected:* Defeats purpose of team-safe design

**Post-hoc notifications:** Allow operations but notify user afterward
- *Rejected:* Doesn't prevent unwanted operations, just documents them

## References

- Incident: PR #1 merged without permission despite `merge_pr = "never"`
- Security principle: Fail-safe defaults and defense in depth
- User experience: Balance safety with usability
- Dogfooding lesson: Our own system caught our violation
- Created during: Real-world permission violation incident response
- Next steps: Implement helper function, update guidelines, improve UX
