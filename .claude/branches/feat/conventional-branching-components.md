# ADR: conventional-branching-components

**Status**: Proposed
**Date**: 2025-07-18
**Author**: Claude Context System Team
**Tags**: [feat, branching, conventional-commits, organization, 2025-07-18]

## Context

Teams using conventional commits often extend this pattern to their branching strategy, using components for better organization:

**Conventional Commits Pattern:**
- `feat(auth): add OAuth integration`
- `chore(docs): update README`
- `fix(api): resolve rate limiting issue`

**Current Claude Context System:**
- Uses only top-level types: `feat/`, `chore/`, `docs/`, `arch/`
- Stores ADRs as: `.claude/branches/feat/feature-name.md`
- Doesn't align with teams already using component-based branching

**Gap Identified:**
Teams want their ADR organization to match their existing branching and commit conventions. Currently, a team with branches like `feat/auth/oauth-integration` would have to flatten their ADR structure to `feat/oauth-integration.md`, losing the component organization they use everywhere else.

This misalignment creates friction for adoption and feels unnatural to teams with established conventional commit workflows.

## Decision

We will enhance the Claude Context System to support **optional conventional branching components** while maintaining backward compatibility:

### **Flexible Branch-to-ADR Mapping**

**Simple Pattern (unchanged):**
- Branch: `feat/user-authentication`
- ADR: `.claude/branches/feat/user-authentication.md`

**Component Pattern (new):**
- Branch: `feat/auth/oauth-integration`
- ADR: `.claude/branches/feat/auth/oauth-integration.md`

**Alternative Component Syntax:**
- Branch: `feat(auth)/oauth-integration` 
- ADR: `.claude/branches/feat/auth/oauth-integration.md`

### **Implementation Details**

**Directory Structure Support:**
```
.claude/branches/
├── feat/
│   ├── simple-feature.md              # Simple pattern
│   ├── auth/
│   │   ├── oauth-integration.md       # Component pattern
│   │   └── session-management.md
│   └── api/
│       ├── rate-limiting.md
│       └── versioning-strategy.md
├── chore/
│   ├── build-optimization.md          # Simple pattern
│   ├── docs/
│   │   └── readme-restructure.md      # Component pattern
│   └── ci/
│       └── github-actions.md
```

**ADR Index Enhancement:**
```toml
[active.feat]
"simple-feature" = { file = "feat/simple-feature.md", component = null }
"oauth-integration" = { file = "feat/auth/oauth-integration.md", component = "auth" }
"rate-limiting" = { file = "feat/api/rate-limiting.md", component = "api" }

[active.chore]
"build-optimization" = { file = "chore/build-optimization.md", component = null }
"readme-restructure" = { file = "chore/docs/readme-restructure.md", component = "docs" }
```

**Helper Script Enhancements:**
```bash
# Simple pattern (unchanged)
./adr-helper.sh new feat "user-authentication"

# Component patterns (new)
./adr-helper.sh new feat/auth "oauth-integration"
./adr-helper.sh new "feat(auth)" "oauth-integration"
./adr-helper.sh new chore/docs "readme-restructure"
```

**Branch Detection Logic:**
- Parse branch names for optional components
- Support both `/` and `()` component syntax
- Create directory structure automatically
- Maintain compatibility with existing simple pattern

## Consequences

**Positive:**
- **Natural Team Alignment**: Matches existing conventional commit/branch workflows
- **Better Organization**: Component-level grouping within decision types
- **Improved Discoverability**: Related decisions grouped by component
- **Backward Compatible**: Existing simple pattern continues to work
- **Flexible Adoption**: Teams choose their preferred convention style
- **Scalable Structure**: Large projects can organize by component/module
- **Git Integration**: ADR structure mirrors branch organization
- **Tool Familiarity**: Leverages patterns developers already know

**Negative:**
- **Increased Complexity**: More directory structure to manage
- **Helper Script Updates**: Need to handle component parsing
- **Index Complexity**: ADR index becomes more complex with components
- **Migration Consideration**: Existing ADRs remain in simple structure
- **Path Resolution**: More complex file path handling required

**Risk Mitigations:**
- Maintain full backward compatibility with simple pattern
- Provide clear migration guidance for teams wanting to adopt components
- Update helper scripts to handle both patterns seamlessly
- Validate component parsing with comprehensive test cases
- Document both patterns clearly in usage examples

## Alternatives Considered

**Mandatory components**: Require all ADRs to use components
- *Rejected:* Breaking change for existing users and unnecessary complexity for simple projects

**Separate component field**: Store components as metadata rather than directory structure
- *Rejected:* Doesn't match natural git workflow and file organization expectations

**Component prefix in filename**: Use `feat-auth-oauth-integration.md` naming
- *Rejected:* Doesn't provide organizational benefits of directory structure

**Git submodules for components**: Separate repositories per component
- *Rejected:* Massive complexity increase, violates single-repository principle

**Configuration-driven components**: Define valid components in config file
- *Rejected:* Adds unnecessary configuration overhead for flexible system

## Implementation Plan

### Phase 1: Core Enhancement
- Update helper scripts to parse component syntax
- Add directory creation logic for component paths
- Enhance ADR index to track component information
- Update file path resolution throughout system

### Phase 2: Validation & Testing
- Add comprehensive test cases for component patterns
- Validate backward compatibility with existing ADRs
- Test integration with branch detection logic
- Verify git workflow compatibility

### Phase 3: Documentation & Migration
- Update documentation with component examples
- Provide migration guidance for existing projects
- Create examples for different team conventions
- Update Quick Start section with component options

## Success Metrics

**Immediate (1-2 weeks):**
- Helper scripts support component syntax
- Directory structure automatically created
- ADR index tracks components correctly
- Backward compatibility maintained

**Short-term (1 month):**
- Teams report natural integration with existing workflows
- Component organization improves ADR discoverability
- No regression in simple pattern usage
- Clear documentation and examples available

**Long-term (3-6 months):**
- Adoption increases due to conventional commit alignment
- Large projects leverage component organization effectively
- Community contributes component organization best practices
- System becomes standard for component-based teams

## Examples

### Team Using Simple Pattern
```bash
# Branch: feat/user-dashboard
./adr-helper.sh new feat "user-dashboard"
# Creates: .claude/branches/feat/user-dashboard.md
```

### Team Using Component Pattern
```bash
# Branch: feat/auth/social-login
./adr-helper.sh new feat/auth "social-login"
# Creates: .claude/branches/feat/auth/social-login.md

# Branch: chore(ci)/docker-optimization  
./adr-helper.sh new "chore(ci)" "docker-optimization"
# Creates: .claude/branches/chore/ci/docker-optimization.md
```

### Mixed Usage (Flexible)
```bash
# Simple decisions
./adr-helper.sh new docs "api-guidelines"

# Component-specific decisions
./adr-helper.sh new feat/payment "stripe-integration"
./adr-helper.sh new arch/database "sharding-strategy"
```

## References

- **Conventional Commits**: https://www.conventionalcommits.org/
- **Team Workflow Integration**: Aligning system with existing development practices
- **Precedent**: Git directory structure, conventional commit component syntax
- **User Feedback**: "Should match our branching conventions"
- **Related**: Single-file approach (maintains simplicity), AI-first messaging
- **Impact**: Reduces adoption friction through familiar patterns
- **Created during**: Post-v1.0 enhancement phase focusing on team workflow integration