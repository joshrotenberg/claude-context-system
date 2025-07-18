# ADR: team-permission-model

**Status**: Proposed
**Date**: 2025-07-18
**Author**: Claude Context System Team
**Tags**: [simulation, docs, 2025-07-18]

## Context

Teams have legitimate concerns about AI assistants performing git operations without explicit permission:
- Accidental commits or pushes to shared repositories
- Automated operations interfering with team workflows
- Non-users being disrupted by system-generated content
- Security concerns about unauthorized repository modifications
- Need for different permission levels based on team size and trust

The system must be safe for shared repositories while remaining useful for individual developers. We need granular control that respects team dynamics and organizational policies.

## Decision

We will implement a **three-tier permission system** with granular controls:

**Permission Levels:**
- `never` - Operation completely disabled
- `ask` - Request explicit permission each time (default for safety)
- `yes` - Auto-approve operation (convenience for trusted environments)

**Operation Categories:**
- Git operations: add files, commit changes, create branches, merge, push
- GitHub operations: create PRs, merge PRs, create issues, add labels
- System operations: update configs, scan for changes, suggest ADRs

**Smart Defaults:**
- High-impact operations (merge, auto-PR) default to "never"
- Medium-impact operations (commit, push) default to "ask"
- Low-impact operations (add files, labels) default to "yes" where safe
- Team repositories enable "passive mode" by default

## Consequences

**Positive:**
- Teams can adopt without fear of workflow disruption
- Granular control allows customization for different organizational needs
- Conservative defaults prevent accidental automation
- Clear permission model builds trust with security-conscious teams
- Passive mode enables adoption in shared repositories
- Individual developers can relax permissions for convenience

**Negative:**
- Additional configuration complexity for power users
- Permission prompts may interrupt workflow initially
- Some useful automation requires explicit enablement
- Documentation must explain permission model clearly

**Risk Mitigations:**
- Prominent "safe mode" option for maximum security
- Clear descriptions of what each permission controls
- Easy reset to conservative defaults
- Validation that prevents dangerous configurations

## Alternatives Considered

**All-or-nothing permissions:** Single "allow automation" toggle
- *Rejected:* Too coarse-grained, doesn't address varying risk levels

**Role-based permissions:** Different permission sets for developers/leads/admins
- *Rejected:* Adds user management complexity to simple system

**Repository-level permissions:** Permissions set at repo level, not user level
- *Rejected:* Doesn't account for individual developer preferences

**Opt-out model:** Default to full automation, require explicit disabling
- *Rejected:* Unsafe for team adoption, creates security concerns

**External permission service:** Delegate authorization to external system
- *Rejected:* Violates zero-dependency principle

## References

- Security principle: Principle of least privilege
- Inspiration: SSH key permissions, Docker security models
- Team feedback: "We need to trust the system before we can use it"
- Created during: Documentation phase addressing team adoption concerns
