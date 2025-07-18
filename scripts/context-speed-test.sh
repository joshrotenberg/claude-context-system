#!/bin/bash
# Context Ingestion Speed Test Framework
# Tests how quickly AI assistants can get oriented on project context

set -e

# Configuration
CLAUDE_DIR=".claude"
RESULTS_DIR="test-results"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
# TEST_SESSION_FILE="$RESULTS_DIR/session_$TIMESTAMP.json"  # Unused for now

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test questions that AI should be able to answer after context ingestion
CONTEXT_QUESTIONS=(
    "What is the project's current development phase?"
    "What are the 3 most recent architectural decisions?"
    "What permission model does the system use?"
    "Where are ADRs stored and how are they organized?"
    "What is the single-file approach and why was it chosen?"
    "How does the update checking mechanism work?"
    "What was the purpose of the previous simulation?"
    "What files should an AI read first to get oriented?"
)

show_help() {
    echo "Context Ingestion Speed Test Framework"
    echo ""
    echo "Usage: $0 [command]"
    echo ""
    echo "Commands:"
    echo "  setup     - Create test environment and validate prerequisites"
    echo "  baseline  - Run baseline test (no guidance)"
    echo "  guided    - Run guided test (with Quick Start section)"
    echo "  compare   - Compare latest baseline vs guided results"
    echo "  questions - Show the context questions used for testing"
    echo "  results   - Show recent test results"
    echo "  cleanup   - Clean up test artifacts"
    echo ""
    echo "Examples:"
    echo "  $0 setup                    # Initialize testing environment"
    echo "  $0 baseline                 # Run baseline measurement"
    echo "  $0 guided                   # Run optimized measurement"
    echo "  $0 compare                  # Compare performance"
}

setup_test_environment() {
    echo -e "${BLUE}Setting up Context Ingestion Speed Test environment...${NC}"

    # Create results directory
    mkdir -p "$RESULTS_DIR"

    # Validate prerequisites
    if [[ ! -d "$CLAUDE_DIR" ]]; then
        echo -e "${RED}Error: .claude directory not found${NC}"
        echo "This test must be run from a repository with Claude Context System installed"
        exit 1
    fi

    if [[ ! -f "$CLAUDE_DIR/CLAUDE-CONTEXT-SYSTEM.md" ]]; then
        echo -e "${RED}Error: CLAUDE-CONTEXT-SYSTEM.md not found${NC}"
        exit 1
    fi

    if [[ ! -f "$CLAUDE_DIR/adr-index.toml" ]]; then
        echo -e "${RED}Error: adr-index.toml not found${NC}"
        exit 1
    fi

    # Create test configuration
    cat > "$RESULTS_DIR/test-config.json" <<EOF
{
    "test_framework": "context-ingestion-speed",
    "version": "1.0",
    "created": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "project_name": "$(basename "$(pwd)")",
    "question_count": ${#CONTEXT_QUESTIONS[@]},
    "test_scenarios": [
        "baseline",
        "guided"
    ]
}
EOF

    echo -e "${GREEN}✓ Test environment ready${NC}"
    echo "  Results directory: $RESULTS_DIR"
    echo "  Questions to test: ${#CONTEXT_QUESTIONS[@]}"
    echo "  Configuration: $RESULTS_DIR/test-config.json"
}

show_questions() {
    echo -e "${BLUE}Context Questions for AI Assistant Testing:${NC}"
    echo ""
    for i in "${!CONTEXT_QUESTIONS[@]}"; do
        echo "  $((i+1)). ${CONTEXT_QUESTIONS[$i]}"
    done
    echo ""
    echo "An AI assistant should be able to answer all these questions"
    echo "after properly ingesting the project context."
}

run_baseline_test() {
    echo -e "${YELLOW}Running Baseline Context Ingestion Test${NC}"
    echo ""
    echo -e "${BLUE}Scenario: Fresh AI with no guidance${NC}"
    echo "Simulates an AI assistant exploring the project naturally"
    echo ""

    # Record test start
    local start_time
    start_time=$(date +%s)
    local test_file="$RESULTS_DIR/baseline_$TIMESTAMP.json"

    cat > "$test_file" <<EOF
{
    "test_type": "baseline",
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "scenario": "Natural exploration without Quick Start guidance",
    "start_time": $start_time,
    "files_to_explore": [
        "README.md",
        ".claude/adr-index.toml",
        ".claude/CLAUDE-CONTEXT-SYSTEM.md",
        ".claude/branches/ (directory exploration)",
        "Recent ADR files"
    ],
    "exploration_strategy": "discover-then-read",
    "guidance_level": "none"
}
EOF

    echo "Test Instructions for AI Assistant:"
    echo "=================================="
    echo "1. Start fresh - assume no prior knowledge of this project"
    echo "2. Explore the project structure naturally"
    echo "3. Read files in the order you discover them"
    echo "4. Take notes on key information as you learn"
    echo "5. When ready, answer the context questions"
    echo ""
    echo "Files available for exploration:"
    echo "  - README.md (project overview)"
    echo "  - .claude/ directory (system files)"
    echo "  - Various ADR files and documentation"
    echo ""
    echo -e "${YELLOW}Timer started. Press ENTER when AI has finished context ingestion...${NC}"
    read -r

    local end_time
    end_time=$(date +%s)
    local duration=$((end_time - start_time))

    # Update test results
    cat > "$test_file" <<EOF
{
    "test_type": "baseline",
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "scenario": "Natural exploration without Quick Start guidance",
    "start_time": $start_time,
    "end_time": $end_time,
    "duration_seconds": $duration,
    "duration_minutes": $(echo "scale=2; $duration/60" | bc -l),
    "files_to_explore": [
        "README.md",
        ".claude/adr-index.toml",
        ".claude/CLAUDE-CONTEXT-SYSTEM.md",
        ".claude/branches/ (directory exploration)",
        "Recent ADR files"
    ],
    "exploration_strategy": "discover-then-read",
    "guidance_level": "none",
    "status": "completed"
}
EOF

    echo -e "${GREEN}✓ Baseline test completed${NC}"
    echo "  Duration: $(echo "scale=1; $duration/60" | bc -l) minutes"
    echo "  Results: $test_file"
    echo ""
    echo "Next: Run 'guided' test and then 'compare' to see improvement"
}

run_guided_test() {
    echo -e "${YELLOW}Running Guided Context Ingestion Test${NC}"
    echo ""
    echo -e "${BLUE}Scenario: AI following Quick Start guidance${NC}"
    echo "Simulates an AI assistant using our optimized onboarding"
    echo ""

    local start_time
    start_time=$(date +%s)
    local test_file="$RESULTS_DIR/guided_$TIMESTAMP.json"

    cat > "$test_file" <<EOF
{
    "test_type": "guided",
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "scenario": "Following AI Assistant Quick Start section",
    "start_time": $start_time,
    "guidance_level": "structured"
}
EOF

    echo "Test Instructions for AI Assistant:"
    echo "=================================="
    echo "1. Start fresh - assume no prior knowledge of this project"
    echo "2. Read the 'AI Assistant Quick Start' section FIRST"
    echo "3. Follow the structured onboarding sequence exactly"
    echo "4. Use the provided file list and reading order"
    echo "5. When ready, answer the context questions"
    echo ""
    echo "Quick Start Location:"
    echo "  - .claude/CLAUDE-CONTEXT-SYSTEM.md (top section)"
    echo "  - OR CLAUDE-CONTEXT-SYSTEM.md (top section)"
    echo ""
    echo -e "${YELLOW}Timer started. Press ENTER when AI has finished context ingestion...${NC}"
    read -r

    local end_time
    end_time=$(date +%s)
    local duration=$((end_time - start_time))

    # Update test results
    cat > "$test_file" <<EOF
{
    "test_type": "guided",
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "scenario": "Following AI Assistant Quick Start section",
    "start_time": $start_time,
    "end_time": $end_time,
    "duration_seconds": $duration,
    "duration_minutes": $(echo "scale=2; $duration/60" | bc -l),
    "guidance_sequence": [
        "Read AI Assistant Quick Start section",
        "Check .claude/adr-index.toml",
        "Review recent ADRs in .claude/branches/feat/",
        "Understand architecture from arch/ ADRs",
        "Review permissions model",
        "Check current branch structure"
    ],
    "guidance_level": "structured",
    "status": "completed"
}
EOF

    echo -e "${GREEN}✓ Guided test completed${NC}"
    echo "  Duration: $(echo "scale=1; $duration/60" | bc -l) minutes"
    echo "  Results: $test_file"
    echo ""
    echo "Next: Run 'compare' to see improvement metrics"
}

compare_results() {
    echo -e "${BLUE}Comparing Context Ingestion Performance${NC}"
    echo ""

    # Find most recent test results
    local latest_baseline
    local latest_guided
    latest_baseline=$(find "$RESULTS_DIR" -name "baseline_*.json" -type f 2>/dev/null | head -1)
    latest_guided=$(find "$RESULTS_DIR" -name "guided_*.json" -type f 2>/dev/null | head -1)

    if [[ -z "$latest_baseline" ]] || [[ -z "$latest_guided" ]]; then
        echo -e "${RED}Error: Need both baseline and guided test results${NC}"
        echo "Run: $0 baseline && $0 guided"
        exit 1
    fi

    # Extract durations
    local baseline_duration
    local guided_duration
    baseline_duration=$(jq -r '.duration_minutes' "$latest_baseline")
    guided_duration=$(jq -r '.duration_minutes' "$latest_guided")

    # Calculate improvement
    local improvement
    local time_saved
    improvement=$(echo "scale=1; (($baseline_duration - $guided_duration) / $baseline_duration) * 100" | bc -l)
    time_saved=$(echo "scale=1; $baseline_duration - $guided_duration" | bc -l)

    echo "Performance Comparison:"
    echo "======================"
    echo -e "Baseline (no guidance):     ${baseline_duration} minutes"
    echo -e "Guided (Quick Start):       ${guided_duration} minutes"
    echo -e "Time saved:                 ${time_saved} minutes"
    echo -e "Improvement:                ${improvement}%"
    echo ""

    if (( $(echo "$improvement > 50" | bc -l) )); then
        echo -e "${GREEN}✓ Excellent improvement! Quick Start is working effectively.${NC}"
    elif (( $(echo "$improvement > 25" | bc -l) )); then
        echo -e "${YELLOW}✓ Good improvement! Quick Start provides measurable benefit.${NC}"
    else
        echo -e "${RED}⚠ Limited improvement. Quick Start may need optimization.${NC}"
    fi

    # Generate comparison report
    local report_file="$RESULTS_DIR/comparison_$TIMESTAMP.md"
    cat > "$report_file" <<EOF
# Context Ingestion Speed Test Results

**Test Date**: $(date)
**Project**: $(basename "$(pwd)")

## Results Summary

| Metric | Baseline | Guided | Improvement |
|--------|----------|--------|-------------|
| Duration | ${baseline_duration} min | ${guided_duration} min | ${improvement}% faster |
| Time Saved | - | ${time_saved} min | - |

## Test Details

### Baseline Test
- **Scenario**: Natural exploration without guidance
- **Strategy**: Discover-then-read approach
- **Duration**: ${baseline_duration} minutes
- **Files**: README, ADR index, system file, branch exploration

### Guided Test
- **Scenario**: Following AI Assistant Quick Start section
- **Strategy**: Structured onboarding sequence
- **Duration**: ${guided_duration} minutes
- **Guidance**: Step-by-step orientation checklist

## Conclusions

$(if (( $(echo "$improvement > 50" | bc -l) )); then
    echo "The Quick Start section provides excellent improvement (>${improvement}%), significantly reducing AI onboarding time."
elif (( $(echo "$improvement > 25" | bc -l) )); then
    echo "The Quick Start section provides good improvement (${improvement}%), offering measurable benefits for AI context acquisition."
else
    echo "The Quick Start section provides limited improvement (${improvement}%). Consider further optimization."
fi)

## Next Steps

- Validate results with additional test runs
- Consider refinements to Quick Start section if improvement < 50%
- Document successful onboarding patterns for future optimization

EOF

    echo ""
    echo -e "${GREEN}✓ Comparison report generated: $report_file${NC}"
}

show_results() {
    echo -e "${BLUE}Recent Context Ingestion Test Results${NC}"
    echo ""

    if [[ ! -d "$RESULTS_DIR" ]] || [[ -z "$(ls -A $RESULTS_DIR)" ]]; then
        echo "No test results found. Run some tests first:"
        echo "  $0 setup"
        echo "  $0 baseline"
        echo "  $0 guided"
        return
    fi

    echo "Test Files:"
    find "$RESULTS_DIR" -name "*.json" -type f 2>/dev/null | while read -r file; do
        echo "  $(basename "$file")"
    done

    echo ""
    echo "Reports:"
    find "$RESULTS_DIR" -name "*.md" -type f 2>/dev/null | while read -r file; do
        echo "  $(basename "$file")"
    done
}

cleanup_tests() {
    echo -e "${YELLOW}Cleaning up test artifacts...${NC}"

    if [[ -d "$RESULTS_DIR" ]]; then
        echo "Removing: $RESULTS_DIR"
        rm -rf "$RESULTS_DIR"
        echo -e "${GREEN}✓ Cleanup completed${NC}"
    else
        echo "No test artifacts to clean up"
    fi
}

# Main command handling
case "${1:-help}" in
    setup)
        setup_test_environment
        ;;
    baseline)
        run_baseline_test
        ;;
    guided)
        run_guided_test
        ;;
    compare)
        compare_results
        ;;
    questions)
        show_questions
        ;;
    results)
        show_results
        ;;
    cleanup)
        cleanup_tests
        ;;
    help|*)
        show_help
        ;;
esac
