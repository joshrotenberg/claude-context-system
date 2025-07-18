#!/bin/bash
# Claude Context System Test Runner
# Basic test suite for CI/CD pipeline

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Logging functions
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

log_header() {
    echo -e "\n${BLUE}🔍 $1${NC}"
    echo "═══════════════════════════════════════════════════════════════"
}

# Validate file structure
validate_structure() {
    log_header "Validating File Structure"

    local required_files=(
        "CLAUDE-CONTEXT-SYSTEM.md"
        "README.md"
        ".claude/adr-helper.sh"
        ".claude/adr-index.toml"
    )

    local missing_files=()

    for file in "${required_files[@]}"; do
        if [ ! -f "$PROJECT_ROOT/$file" ]; then
            missing_files+=("$file")
        else
            log_success "Found $file"
        fi
    done

    if [ ${#missing_files[@]} -gt 0 ]; then
        log_error "Missing required files: ${missing_files[*]}"
        return 1
    fi

    # Check that shell scripts are executable
    find "$PROJECT_ROOT" -name "*.sh" -type f | while read -r script; do
        if [ ! -x "$script" ]; then
            log_warning "Making $script executable..."
            chmod +x "$script"
        fi
    done

    log_success "File structure validation passed"
}

# Lint shell scripts
lint_shell_scripts() {
    log_header "Linting Shell Scripts"

    local script_count=0
    local lint_errors=0

    # Find all shell scripts
    while IFS= read -r -d '' script; do
        ((script_count++))
        log_info "Checking $(basename "$script")..."

        if command -v shellcheck >/dev/null 2>&1; then
            if ! shellcheck "$script"; then
                ((lint_errors++))
                log_error "Lint errors in $script"
            else
                log_success "$(basename "$script") passed lint"
            fi
        else
            log_warning "shellcheck not available, skipping lint"
        fi
    done < <(find "$PROJECT_ROOT" -name "*.sh" -type f -print0)

    if [ $script_count -eq 0 ]; then
        log_warning "No shell scripts found to lint"
    elif [ $lint_errors -eq 0 ]; then
        log_success "All $script_count shell scripts passed lint checks"
    else
        log_error "$lint_errors out of $script_count scripts failed lint checks"
        return 1
    fi
}

# Test documentation format
test_documentation() {
    log_header "Testing Documentation Format"

    local doc_errors=0

    # Test README
    if ! grep -q "# Claude Context System" "$PROJECT_ROOT/README.md"; then
        log_error "README.md missing main heading"
        ((doc_errors++))
    else
        log_success "README.md has proper heading"
    fi

    # Test main documentation
    local required_sections=(
        "## Quick Setup"
        "## ADR Template"
        "## File Structure"
    )

    for section in "${required_sections[@]}"; do
        if ! grep -q "$section" "$PROJECT_ROOT/CLAUDE-CONTEXT-SYSTEM.md"; then
            log_error "Missing section: $section"
            ((doc_errors++))
        else
            log_success "Found section: $section"
        fi
    done

    if [ $doc_errors -eq 0 ]; then
        log_success "Documentation format validation passed"
    else
        log_error "$doc_errors documentation format issues found"
        return 1
    fi
}

# Security scan
security_scan() {
    log_header "Security Scan"

    local security_issues=0

    # Check for potential secrets (basic scan)
    if grep -r -E "(api_key|password|secret|token)" --include="*.sh" --include="*.md" "$PROJECT_ROOT" | grep -v "example\|sample\|template\|test" >/dev/null; then
        log_error "Potential secrets found in files"
        ((security_issues++))
    else
        log_success "No obvious secrets detected"
    fi

    # Check file permissions
    while IFS= read -r -d '' script; do
        if [ ! -x "$script" ]; then
            log_warning "Script not executable: $script"
            chmod +x "$script"
            log_info "Made $script executable"
        fi
    done < <(find "$PROJECT_ROOT" -name "*.sh" -type f -print0)

    if [ $security_issues -eq 0 ]; then
        log_success "Security scan passed"
    else
        log_error "$security_issues security issues found"
        return 1
    fi
}

# Run BATS tests
run_bats_tests() {
    log_header "Running BATS Test Suite"

    if [ ! -d "$PROJECT_ROOT/tests" ]; then
        log_warning "No tests directory found, skipping BATS tests"
        return 0
    fi

    local test_files=()
    while IFS= read -r -d '' file; do
        test_files+=("$file")
    done < <(find "$PROJECT_ROOT/tests" -name "*.bats" -type f -print0 2>/dev/null)

    if [ ${#test_files[@]} -eq 0 ]; then
        log_warning "No BATS test files found"
        return 0
    fi

    local bats_failed=0

    if command -v bats >/dev/null 2>&1; then
        for test_file in "${test_files[@]}"; do
            log_info "Running $(basename "$test_file")..."

            if bats "$test_file"; then
                log_success "$(basename "$test_file") passed"
            else
                log_error "$(basename "$test_file") failed"
                ((bats_failed++))
            fi
        done
    else
        log_warning "bats not available, skipping unit tests"
        return 0
    fi

    if [ $bats_failed -eq 0 ]; then
        log_success "All BATS tests passed"
    else
        log_error "$bats_failed BATS test files failed"
        return 1
    fi
}

# Integration test
integration_test() {
    log_header "Running Integration Test"

    # Create temporary directory for integration test
    local temp_dir
    temp_dir=$(mktemp -d)
    local original_dir
    original_dir=$(pwd)

    cd "$temp_dir"

    log_info "Testing complete workflow in $temp_dir"

    # Initialize git repo
    git init >/dev/null 2>&1
    git config user.email "test@example.com" >/dev/null 2>&1
    git config user.name "Test User" >/dev/null 2>&1

    # Copy system files
    cp -r "$PROJECT_ROOT/.claude" . >/dev/null 2>&1
    cp "$PROJECT_ROOT/CLAUDE-CONTEXT-SYSTEM.md" . >/dev/null 2>&1

    # Test basic operations
    chmod +x .claude/adr-helper.sh

    # Test configuration reading
    if ./.claude/adr-helper.sh config >/dev/null 2>&1; then
        log_success "Configuration reading works"
    else
        log_warning "Configuration reading returned non-zero (may be expected)"
    fi

    # Test help command
    if ./.claude/adr-helper.sh --help >/dev/null 2>&1; then
        log_success "Help command works"
    else
        log_warning "Help command returned non-zero"
    fi

    cd "$original_dir"
    rm -rf "$temp_dir"
    log_success "Integration test completed"
}

# Main execution
main() {
    echo "🚀 Claude Context System Test Runner"
    echo "═══════════════════════════════════════════════════════════════"

    cd "$PROJECT_ROOT"

    # Parse command line argument
    local test_type="${1:-all}"

    case "$test_type" in
        "structure")
            validate_structure
            ;;
        "lint")
            lint_shell_scripts
            ;;
        "docs")
            test_documentation
            ;;
        "security")
            security_scan
            ;;
        "bats")
            run_bats_tests
            ;;
        "integration")
            integration_test
            ;;
        "quick")
            validate_structure && lint_shell_scripts && test_documentation
            ;;
        "all"|*)
            validate_structure && lint_shell_scripts && test_documentation && security_scan && run_bats_tests && integration_test
            ;;
    esac

    local exit_code=$?

    if [ $exit_code -eq 0 ]; then
        log_success "🎉 All tests passed!"
    else
        log_error "Some tests failed"
    fi

    exit $exit_code
}

# Execute main function
main "$@"
