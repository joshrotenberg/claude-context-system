# ADR: configurable-update-frequencies

**Status**: Proposed
**Date**: 2025-07-18
**Author**: Claude Context System Team
**Tags**: [simulation, chore, 2025-07-18]

## Context

Different aspects of the system require different update frequencies:
- System updates from canonical source: Infrequent but important for new features
- Permission reviews: Quarterly for team changes and security audits  
- ADR maintenance: Weekly to keep decision index clean and current
- Context updates: Daily to maintain AI assistant awareness of active work

A one-size-fits-all approach either creates maintenance burden (too frequent) or staleness (too infrequent). Teams need control over what gets checked when, based on their change velocity and risk tolerance.

Additionally, AI assistants are notoriously bad with dates - they need explicit reminders to check current dates and compare against update schedules.

## Decision

We will implement **per-item configurable update frequencies** in the TOML configuration:

```toml
[updates]
system = "monthly"              # Check canonical gist for system updates
permissions = "quarterly"       # Review authorization settings  
team_config = "quarterly"       # Review team/collaboration settings
adr_maintenance = "weekly"      # ADR cleanup, archiving, status updates
context = "daily"               # Current project status, active branches, priorities
```

**Frequency Options:** `never`, `daily`, `weekly`, `monthly`, `quarterly`

**Date Tracking:** Automatic tracking of `last_check_*` and `next_due_*` dates for each item

**AI Integration:** Prominent reminders for AI assistants to always check current date first, then compare against due dates

## Consequences

**Positive:**
- Teams can set `context = "daily"` for active projects, `system = "quarterly"` for stable ones
- Conservative teams can use `permissions = "never"` and manual reviews only
- AI assistants get current project status without overwhelming maintenance overhead
- Granular control prevents both staleness and maintenance fatigue
- Date awareness solves AI assistant temporal confusion issues

**Negative:**
- More configuration options to understand and set
- AI assistants must remember to check dates (solved with prominent reminders)
- Some complexity in calculating next due dates across different frequencies
- Risk of teams setting everything to "never" and losing maintenance benefits

**Mitigations:**
- Sensible defaults for different team sizes (personal/small/large)
- Helper commands to show what's overdue and what's coming up
- Automatic date calculations in helper script
- Clear documentation on recommended frequencies per team type

## Alternatives Considered

**Single global frequency:** One setting like `update_frequency = "weekly"`
- *Rejected:* Too rigid, doesn't account for different maintenance needs

**Time-based triggers:** Cron-like scheduling for automated checks
- *Rejected:* Requires external scheduling, violates zero-dependency principle

**Manual-only updates:** No automatic tracking, rely on human memory
- *Rejected:* Defeats purpose of AI-managed system, leads to staleness

**Event-driven updates:** Update when specific events occur (commits, PRs, etc.)
- *Rejected:* Too complex to implement reliably across different workflows

**Always-current approach:** Check for updates on every AI session
- *Rejected:* Creates unnecessary overhead and API rate limiting issues

## References

- Inspired by: Package manager update frequencies (apt, npm, etc.)
- Problem source: AI assistants losing temporal context between sessions  
- Design principle: Configuration should match team velocity and risk tolerance
- Created during: Process optimization phase addressing maintenance overhead
