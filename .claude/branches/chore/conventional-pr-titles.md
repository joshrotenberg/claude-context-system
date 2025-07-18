# ADR: conventional-pr-titles

**Status**: Proposed
**Date**: 2025-07-18
**Author**: Claude Context System Team
**Tags**: [workflow, pr-standards, conventional-commits, 2025-07-18]

## Context

Following our adoption of branch-and-PR workflow (see `branch-and-pr-workflow.md`), we need to establish standards for PR titles. Currently, PR titles are freeform, which creates several issues:

- **Inconsistent commit history**: When PRs are squash-merged, the PR title becomes the commit message
- **Poor changelog generation**: Release tools rely on conventional commit format for automated changelogs
- **Difficult categorization**: Hard to quickly identify the type and scope of changes
- **Missing semantic versioning signals**: No clear indication of breaking changes or feature additions

Since we're using release-please for automated releases, conventional commit format in PR titles will enable:
- Automatic semantic versioning
- Generated changelogs
- Clear change categorization
- Better integration with our existing conventional commit standards

## Decision

**Enforce conventional commit format for all PR titles:**

**Required Format:**
```
type(scope): description
```

**Core Types (required):**
- `feat:` - New features
- `fix:` - Bug fixes  
- `docs:` - Documentation changes
- `chore:` - Maintenance tasks, dependencies
- `refactor:` - Code changes that neither fix bugs nor add features
- `test:` - Adding or modifying tests
- `ci:` - CI/CD pipeline changes

**Optional Scope Examples:**
- `feat(auth): add OAuth integration`
- `fix(toml): resolve parsing errors`
- `docs(readme): update installation guide`

**Breaking Changes:**
- Add `!` after type: `feat!: redesign API`
- Or use `BREAKING CHANGE:` in PR body

**Implementation:**
1. **PR Template**: Created `.github/pull_request_template.md` with:
   - Clear conventional commit examples
   - Title format requirements
   - Checklist enforcement
2. **Documentation**: Update contribution guidelines
3. **Review Process**: Reviewers verify title format before approval
4. **Automation**: Future GitHub Action could validate titles

## Consequences

**Positive:**
- **Automated Release Notes**: release-please generates meaningful changelogs
- **Semantic Versioning**: Automatic version bumps based on change types
- **Clear History**: Consistent commit message format in main branch
- **Better Categorization**: Easy to filter and search changes by type
- **Professional Standards**: Aligns with widely-adopted conventional commit specification
- **Tool Integration**: Works with existing release automation

**Negative:**
- **Learning Curve**: Contributors must learn conventional commit format
- **Enforcement Overhead**: Requires reviewer attention to title format
- **Potential Friction**: May slow down quick fixes if format is wrong
- **Template Maintenance**: Need to keep examples current and clear

**Mitigations:**
- Clear examples in PR template
- Link to conventional commit documentation
- Reviewer can suggest title changes instead of rejecting
- Allow scope flexibility for edge cases

## Alternatives Considered

**Freeform PR titles with manual changelog:** Continue current approach
- *Rejected:* Doesn't scale, prone to inconsistency, manual release note generation

**GitHub labels for categorization:** Use labels instead of title format
- *Rejected:* Labels don't carry through to commit messages, less discoverable in git history

**Automated title generation:** Generate titles from file changes
- *Rejected:* Can't capture intent or business context of changes

**Conventional commits in individual commits only:** Don't enforce at PR level
- *Rejected:* We use squash merge, so individual commits don't appear in main branch history

**Strict scope requirements:** Mandate scope for all PRs
- *Rejected:* Too restrictive, many changes don't have clear scope

**Custom prefix system:** Create our own format instead of conventional commits
- *Rejected:* Reinventing standard, poor tool integration

## References

- [Conventional Commits Specification](https://www.conventionalcommits.org/)
- Related: `.claude/branches/chore/branch-and-pr-workflow.md`
- Integration: Works with existing release-please workflow
- Template: `.github/pull_request_template.md`
- Tools: Enables automated changelog and semantic versioning
- Created during: Post-conflict resolution workflow improvements
