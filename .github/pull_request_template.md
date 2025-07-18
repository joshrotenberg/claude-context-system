## Pull Request Template

### Title Requirements
**Your PR title MUST follow conventional commit format:**
- `feat: description` - New feature
- `fix: description` - Bug fix
- `docs: description` - Documentation changes
- `chore: description` - Maintenance tasks
- `refactor: description` - Code refactoring
- `test: description` - Adding tests
- `ci: description` - CI/CD changes

**Examples:**
- ✅ `feat: add automated backup functionality`
- ✅ `fix: resolve TOML parsing errors`
- ✅ `docs: update troubleshooting guide`
- ❌ `Add new feature`
- ❌ `Update docs`

### Checklist
- [ ] Title follows conventional commit format
- [ ] Description clearly explains the change
- [ ] Related ADR files are included (if architectural decision)
- [ ] Documentation updated (if applicable)
- [ ] Self-review completed
- [ ] Ready for review

### Description
Brief summary of what this PR does:

### Related ADRs
List any ADR files created or modified:
- `.claude/branches/[category]/[adr-name].md`

### Type of Change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update
- [ ] Code refactoring
- [ ] Performance improvement
- [ ] Test improvement

### Testing
Describe how this change was tested:

### Context
Why is this change needed? What problem does it solve?

### Impact
What areas of the system are affected?

---
*This template helps ensure consistent PR titles and thorough change documentation.*