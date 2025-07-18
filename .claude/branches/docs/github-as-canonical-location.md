# ADR: github-as-canonical-location

**Status**: Proposed
**Date**: 2025-07-18
**Author**: Claude Context System Team
**Tags**: [simulation, docs, 2025-07-18]

## Context

We initially used a GitHub Gist as the canonical location for the Claude Context System because:
- Gists are perfect for single-file distribution
- Easy to share and embed
- Simple version control for documentation
- No repository management overhead

However, as we've implemented dogfooding with the `.claude/` directory containing real ADRs, we face a limitation: **Gists don't support directories**.

This creates a distribution challenge:
- Users want the single-file experience (gist is perfect)
- We want to demonstrate live dogfooding (requires full repository)
- The system needs a canonical home that can evolve with directories
- We need to maintain both use cases without confusion

## Decision

We will establish **GitHub repository as the canonical location** while maintaining gist for distribution:

**Primary canonical location:** https://github.com/joshrotenberg/claude-context-system
- Complete system with live dogfooding demonstration
- Full `.claude/` directory with real ADRs
- Working helper scripts and validation
- Issue tracking and contribution workflow
- Complete git history and branch structure

**Secondary distribution:** https://gist.github.com/joshrotenberg/a9f8ac85b9ebe20c6b6202a17d804fbc  
- Single-file `CLAUDE-CONTEXT-SYSTEM.md` for easy copying
- Updated automatically from canonical repository
- Perfect for users who just want to copy the system

**Update references:** All canonical URLs in documentation and configuration files point to GitHub repository.

## Consequences

**Positive:**
- Repository can contain live dogfooding demonstration with directories
- Users can explore real ADRs and working system in action
- Issue tracking and contribution workflow available
- Full git history shows authentic development decisions
- README and proper project structure for GitHub discovery
- Gist remains available for single-file distribution
- Best of both worlds: full project + portable distribution

**Negative:**
- Slight complexity in maintaining two locations
- Users might be confused about which to use when
- Need to keep gist synchronized with repository updates
- Repository feels "heavier" than simple gist for some users

**Mitigations:**
- Clear documentation about when to use repository vs gist
- Automated or semi-automated gist updates from repository
- README clearly explains the dual-distribution strategy
- Prominent links between both locations

## Alternatives Considered

**Gist-only approach:** Keep everything in gist, abandon directory structure
- *Rejected:* Loses powerful dogfooding demonstration and real examples

**Repository-only:** Abandon gist distribution entirely
- *Rejected:* Gist provides perfect single-file copying experience

**Separate repositories:** One for distribution, one for development
- *Rejected:* Creates confusion and maintenance overhead

**Documentation-only repository:** Repository without dogfooding, just docs
- *Rejected:* Misses opportunity to prove the system works in practice

**Monorepo approach:** Multiple systems in one repository
- *Rejected:* System is designed to be self-contained

## References

- Constraint: Gist directory limitation discovered during dogfooding implementation
- Strategy: Dual-distribution model serving different user needs
- Precedent: Many open source projects use GitHub + alternative distribution methods
- Impact: Enables both casual adoption (gist) and deep exploration (repository)
- Created during: Repository setup and canonical location establishment
