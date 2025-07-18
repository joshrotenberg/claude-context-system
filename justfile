# Claude Context System - Development Commands
# Modern command runner using `just` instead of make

# Default recipe shows help
default:
    @just --list

# Variables
version := `grep -o "v[0-9]\+\.[0-9]\+\.[0-9]\+" CLAUDE-CONTEXT-SYSTEM.md | head -1 || echo "v0.0.0"`
project_name := "claude-context-system"

# Show help with current version
help:
    @echo "🔧 Claude Context System - Development Commands"
    @echo "=============================================="
    @echo ""
    @echo "Available commands:"
    @just --list
    @echo ""
    @echo "Current version: {{version}}"

# Install development dependencies
setup:
    @echo "🔧 Setting up development environment..."
    @if command -v apt-get >/dev/null 2>&1; then \
        echo "Installing dependencies via apt..."; \
        sudo apt-get update && sudo apt-get install -y shellcheck; \
        if [ ! -d "/tmp/bats-core" ]; then \
            git clone https://github.com/bats-core/bats-core.git /tmp/bats-core; \
            cd /tmp/bats-core && sudo ./install.sh /usr/local; \
        fi; \
    elif command -v brew >/dev/null 2>&1; then \
        echo "Installing dependencies via brew..."; \
        brew install shellcheck bats-core; \
    else \
        echo "❌ Please install shellcheck and bats manually"; \
        exit 1; \
    fi
    @echo "✅ Development environment ready"

# Run full test suite
test:
    @echo "🧪 Running full test suite..."
    @chmod +x scripts/run-tests.sh
    @./scripts/run-tests.sh

# Run quick validation tests
test-quick:
    @echo "⚡ Running quick tests..."
    @chmod +x scripts/run-tests.sh
    @./scripts/run-tests.sh quick

# Run BATS unit tests only
test-bats:
    @echo "🔍 Running BATS tests..."
    @chmod +x scripts/run-tests.sh
    @./scripts/run-tests.sh bats

# Run shellcheck on all shell scripts
lint:
    @echo "🔍 Linting shell scripts..."
    @chmod +x scripts/run-tests.sh
    @./scripts/run-tests.sh lint

# Run security scan
security:
    @echo "🔒 Running security scan..."
    @chmod +x scripts/run-tests.sh
    @./scripts/run-tests.sh security

# Validate documentation format
docs:
    @echo "📖 Validating documentation..."
    @chmod +x scripts/run-tests.sh
    @./scripts/run-tests.sh docs

# Run integration tests
integration:
    @echo "🔄 Running integration tests..."
    @chmod +x scripts/run-tests.sh
    @./scripts/run-tests.sh integration

# Run code quality checks (lint + docs)
check: lint docs
    @echo "✅ Code quality checks completed"

# Validate file structure and permissions
validate:
    @echo "📁 Validating project structure..."
    @chmod +x scripts/run-tests.sh
    @./scripts/run-tests.sh structure

# Install the system locally for testing
install:
    @echo "📦 Installing Claude Context System locally..."
    @mkdir -p ~/.local/share/claude-context-system
    @cp -r .claude ~/.local/share/claude-context-system/
    @cp CLAUDE-CONTEXT-SYSTEM.md ~/.local/share/claude-context-system/
    @chmod +x ~/.local/share/claude-context-system/.claude/adr-helper.sh
    @echo "✅ Installed to ~/.local/share/claude-context-system/"
    @echo "To use: cp -r ~/.local/share/claude-context-system/.claude ."

# Clean up temporary files and test artifacts
clean:
    @echo "🧹 Cleaning up..."
    @find . -name "*.tmp" -delete 2>/dev/null || true
    @find . -name "*.log" -delete 2>/dev/null || true
    @rm -rf /tmp/test-* 2>/dev/null || true
    @echo "✅ Cleanup completed"

# Format shell scripts (if shfmt is available)
format:
    @if command -v shfmt >/dev/null 2>&1; then \
        echo "🎨 Formatting shell scripts..."; \
        find . -name "*.sh" -type f -exec shfmt -w -i 4 {} \; ; \
        echo "✅ Scripts formatted"; \
    else \
        echo "⚠️  shfmt not available, skipping formatting"; \
    fi

# Show current version
version:
    @echo "Current version: {{version}}"
    @grep -A 5 "{{version}}" CLAUDE-CONTEXT-SYSTEM.md | head -10 || echo "Version details not found"

# Show recent changelog entries
changelog:
    @echo "📋 Recent changelog entries:"
    @grep -A 20 "## 📋 Changelog" CLAUDE-CONTEXT-SYSTEM.md | head -30

# Create distribution packages
dist: test
    @echo "📦 Creating distribution packages..."
    @mkdir -p dist
    @tar -czf dist/{{project_name}}-{{version}}.tar.gz .claude CLAUDE-CONTEXT-SYSTEM.md README.md
    @cd dist && zip -r {{project_name}}-{{version}}.zip ../.claude ../CLAUDE-CONTEXT-SYSTEM.md ../README.md
    @echo "✅ Distribution packages created in dist/"

# Validate release readiness
release-check:
    @echo "🏷️ Checking release readiness..."
    @if [ -z "{{version}}" ]; then \
        echo "❌ No version found in documentation"; \
        exit 1; \
    fi
    @if ! grep -q "{{version}}" CLAUDE-CONTEXT-SYSTEM.md; then \
        echo "❌ Version {{version}} not found in changelog"; \
        exit 1; \
    fi
    @if [ $(wc -l < CLAUDE-CONTEXT-SYSTEM.md) -lt 1000 ]; then \
        echo "❌ Documentation seems incomplete"; \
        exit 1; \
    fi
    @echo "✅ Release readiness validated"

# Create and push version tag
tag: release-check
    @echo "🏷️ Creating version tag {{version}}..."
    @git tag -a {{version}} -m "Release {{version}}"
    @echo "📌 Created tag {{version}}"
    @echo "To push: git push origin {{version}}"

# Create full release (tag + packages)
release: tag dist
    @echo "🚀 Release {{version}} prepared!"
    @echo "Next steps:"
    @echo "  1. git push origin {{version}}"
    @echo "  2. GitHub Actions will create the release"
    @echo "  3. Upload dist/* to GitHub release"

# Run CI-equivalent checks locally
ci: setup test security release-check
    @echo "🎉 All CI checks passed!"

# Set up for development and run tests
dev: setup test-quick
    @echo "✅ Development setup complete"

# Run a quick demo of the system
demo:
    @echo "🎬 Claude Context System Demo"
    @echo "=========================="
    @echo ""
    @echo "System files:"
    @ls -la .claude/
    @echo ""
    @echo "Helper script help:"
    @./.claude/adr-helper.sh --help || echo "Run 'just install' first"
    @echo ""
    @echo "Configuration preview:"
    @head -20 .claude/adr-index.toml

# Run performance benchmarks
benchmark:
    @echo "⚡ Running performance benchmarks..."
    @echo "Testing script execution time..."
    @time ./.claude/adr-helper.sh --help >/dev/null 2>&1 || echo "Script not executable"
    @echo ""
    @echo "Testing file sizes:"
    @du -h CLAUDE-CONTEXT-SYSTEM.md .claude/adr-helper.sh .claude/adr-index.toml

# Show project size statistics
size:
    @echo "📊 Project Size Statistics"
    @echo "======================="
    @echo "Total project size:"
    @du -sh .
    @echo ""
    @echo "File breakdown:"
    @du -h CLAUDE-CONTEXT-SYSTEM.md README.md .claude/*
    @echo ""
    @echo "Line counts:"
    @wc -l CLAUDE-CONTEXT-SYSTEM.md README.md .claude/adr-helper.sh

# Watch for file changes and run tests (requires fswatch or inotifywait)
watch:
    @if command -v fswatch >/dev/null 2>&1; then \
        echo "👁️  Watching for changes... (Press Ctrl+C to stop)"; \
        fswatch -o . | xargs -n1 -I{} just test-quick; \
    elif command -v inotifywait >/dev/null 2>&1; then \
        echo "👁️  Watching for changes... (Press Ctrl+C to stop)"; \
        while inotifywait -r -e modify .; do just test-quick; done; \
    else \
        echo "❌ Install fswatch or inotify-tools for file watching"; \
    fi

# Prepare a new release with version bump
prepare-release version:
    @echo "🚀 Preparing release {{version}}..."
    @chmod +x scripts/prepare-release.sh
    @./scripts/prepare-release.sh {{version}}

# Dry run of release preparation
prepare-release-dry version:
    @echo "🔍 Dry run: Preparing release {{version}}..."
    @chmod +x scripts/prepare-release.sh
    @./scripts/prepare-release.sh --dry-run {{version}}

# Fix common issues automatically
fix:
    @echo "🔧 Fixing common issues..."
    @chmod +x scripts/*.sh .claude/adr-helper.sh
    @if command -v dos2unix >/dev/null 2>&1; then \
        find . -name "*.sh" -type f -exec dos2unix {} \; ; \
    fi
    @echo "✅ Common issues fixed"

# Update dependencies and tools
update:
    @echo "📦 Updating dependencies..."
    @if command -v brew >/dev/null 2>&1; then \
        brew update && brew upgrade shellcheck bats-core; \
    elif command -v apt-get >/dev/null 2>&1; then \
        sudo apt-get update && sudo apt-get upgrade shellcheck; \
    fi
    @echo "✅ Dependencies updated"

# Run complete validation pipeline
all: clean setup test security docs release-check
    @echo "🎉 Complete validation pipeline passed!"

# Show system status and health
status:
    @echo "📊 Claude Context System Status"
    @echo "============================="
    @echo "Version: {{version}}"
    @echo "Project: {{project_name}}"
    @echo ""
    @echo "Files:"
    @ls -la CLAUDE-CONTEXT-SYSTEM.md README.md .claude/adr-helper.sh .claude/adr-index.toml 2>/dev/null || echo "Some files missing"
    @echo ""
    @echo "Git status:"
    @git status --porcelain || echo "Not a git repository"
    @echo ""
    @echo "Dependencies:"
    @echo "just: $(which just >/dev/null 2>&1 && echo "✅" || echo "❌")"
    @echo "shellcheck: $(which shellcheck >/dev/null 2>&1 && echo "✅" || echo "❌")"
    @echo "bats: $(which bats >/dev/null 2>&1 && echo "✅" || echo "❌")"

# Initialize new project with context system
init target_dir:
    @echo "🚀 Initializing new project with Claude Context System..."
    @mkdir -p {{target_dir}}
    @cp -r .claude {{target_dir}}/
    @cp CLAUDE-CONTEXT-SYSTEM.md {{target_dir}}/
    @chmod +x {{target_dir}}/.claude/adr-helper.sh
    @echo "✅ Initialized {{target_dir}} with Claude Context System"
    @echo "Next steps:"
    @echo "  1. cd {{target_dir}}"
    @echo "  2. Tell your AI assistant: 'I have the Claude Context System installed'"
