# ADR: branch-and-pr-workflow

**Status**: Proposed
**Date**: 2025-07-18
**Author**: Claude Context System Team
**Tags**: [workflow, dogfooding, best-practices, v1.0]

## Context

Now that the Claude Context System is live on GitHub with active dogfooding, we need to decide on our development workflow. Currently we've been committing directly to main branch, but this creates several issues:

- We're not modeling the best practices we recommend to teams using our system
- No opportunity to review architectural decisions before they're implemented
- Missing the chance to demonstrate ADR + PR workflow integration
- Direct commits bypass the collaborative decision-making we advocate

As a public repository that teams will reference, we should exemplify the workflow patterns we recommend. Our development process should showcase how the system integrates with modern git workflows.

## Decision

We will adopt a **branch-and-PR workflow** for all future changes to the Claude Context System:

**Branch Strategy:**
- Create feature branches for each change using conventional commit prefixes
- Branch names follow pattern: `type/brief-description` (e.g., `feat/new-feature`, `docs/update-readme`)
- Each branch includes relevant ADR if architectural decision is involved

**Pull Request Process:**
- All changes go through PR review, even for maintainers
- PRs must reference relevant ADRs in description
- ADR files reviewed as part of PR process
- Merge only after review and all checks pass

**Protection Rules:**
- Protect main branch from direct pushes
- Require PR review before merging
- Enable status checks and branch up-to-date requirements

**Exception:** This ADR represents the last direct commit to main - all future changes via PRs

## Consequences

**Positive:**
- Models the exact workflow we recommend to teams using our system
- Creates reviewable timeline of architectural decisions
- Demonstrates integration between ADRs and modern git workflows
- Shows how AI assistants can help with PR descriptions and ADR references
- Provides authentic examples of decision-making process for users to study
- Enables community contributions through standard GitHub workflow
- Protects main branch from accidental direct commits

**Negative:**
- Slightly slower for quick documentation fixes
- Overhead of creating PRs for simple changes
- Need to maintain branch protection rules
- Solo maintainer still needs to create PRs (good discipline but slower)

**Mitigations:**
- Use GitHub CLI for faster PR creation
- Batch small related changes into single PRs
- Clear guidelines on what changes require ADRs vs simple fixes
- ADR helper script can suggest when branch workflow is needed

## Alternatives Considered

**Direct commits for maintainers, PRs for contributors:** Hybrid approach
- *Rejected:* Creates inconsistent workflow demonstration, undermines best practices messaging

**Trunk-based development:** All commits to main with short-lived branches
- *Rejected:* Doesn't showcase PR-based review process that many teams use

**Gitflow workflow:** Feature/develop/release branch structure
- *Rejected:* Too complex for documentation project, doesn't match simple workflow we recommend

**No branch protection:** Trust-based direct commits
- *Rejected:* Misses opportunity to demonstrate protective measures teams need

**Documentation-only changes bypass PR:** Different rules for different change types
- *Rejected:* Creates workflow complexity, undermines consistent practice demonstration

## References

- Practice: "Eating your own dog food" - demonstrate what we recommend
- Workflow integration: Show ADRs work with modern git practices
- Community standards: GitHub PR workflow familiar to developers
- Teaching moment: Repository serves as example of good practices
- Created during: Transition from development to maintenance phase
- Impact: This decision establishes sustainable contribution workflow
