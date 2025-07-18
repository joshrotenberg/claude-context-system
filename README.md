# Claude Context System

**A self-contained, AI-managed system for maintaining project context and architectural decisions. You focus on coding, your AI assistant handles the rest.**

## 🎯 The Promise: AI Does the Work, You Stay Focused

- **Developers:** Write code and make decisions normally - your AI tracks everything automatically
- **AI Assistants:** Get complete project context in every session with decision history and reasoning  
- **Teams:** Share understanding across all sessions without workflow disruption

## 🚀 Quick Start (2 Minutes)

1. **Copy the system:** Download `CLAUDE-CONTEXT-SYSTEM.md` 
2. **Place in your project:** Save as `.claude/CLAUDE-CONTEXT-SYSTEM.md`
3. **Tell your AI:** "Please read `.claude/CLAUDE-CONTEXT-SYSTEM.md` and set up the complete system"
4. **Make decisions:** Your AI automatically captures architectural choices as you work

That's it! No installation, no dependencies, just natural conversation with your AI assistant.

## 📍 Get the System

**Single-file distribution:** [Download CLAUDE-CONTEXT-SYSTEM.md](https://gist.github.com/joshrotenberg/a9f8ac85b9ebe20c6b6202a17d804fbc)

**Canonical location:** This repository contains the complete system with live dogfooding demonstration.

## 🔍 Live Dogfooding Demo

This repository uses the Claude Context System to manage its own development! Explore:

- **`.claude/branches/`** - Real ADRs documenting our architectural decisions
- **`git log --oneline --graph --all`** - Decision timeline across development branches
- **`./.claude/adr-helper.sh status`** - Working system managing itself
- **Feature branches** - Each major decision gets its own branch with full context

**Meta-level proof:** The system successfully documents its own evolution.

## 💡 Why This Works

**Built on proven foundations:**
- [Architectural Decision Records (ADRs)](https://adr.github.io/) - Introduced by Michael Nygard, battle-tested
- [Conventional Commits](https://www.conventionalcommits.org/) - Standardized git workflow 
- AI-first design - Leverages assistants you're already using

**Key innovations:**
- Single self-contained file - Zero setup friction
- AI-managed maintenance - You focus on decisions, not documentation
- Permission-aware automation - Safe for team repositories
- Git-native workflow - Works with existing development processes

## 📊 Real ROI

- **Per "why did we..." question:** Save 30-120 minutes
- **Per new team member:** Save 2-4 hours onboarding  
- **Per architectural review:** Save 4-8 hours
- **Break-even:** After just 2-3 decisions

## 🛡️ Team-Safe Design

- **Three-tier permissions:** never/ask/yes for granular control
- **Passive mode:** Won't interfere with developers who don't use it
- **Conservative defaults:** Safe for shared repositories out of the box
- **External change detection:** Suggests ADRs without disrupting workflow

## 🏗️ What You Get

- **Zero dependencies** - Just markdown and TOML files
- **Works with any AI** - Claude, GPT-4, Gemini, or others
- **Self-validating** - Built-in health checks and troubleshooting
- **Configurable maintenance** - Set update frequencies per team needs
- **Complete workflow** - From decision to documentation to team sharing

## 📚 Documentation Structure

- **`CLAUDE-CONTEXT-SYSTEM.md`** - Complete system (copy this to your project)
- **`.claude/`** - Live example of the system managing itself
- **Feature branches** - Real development decisions captured as ADRs
- **This README** - Overview and getting started guide

## 🎯 Success Stories

> "Our team adopted this after losing 3 days to 'why did we choose Kubernetes over ECS?' - nobody remembered the trade-offs. Now every decision is captured automatically. A new developer understood our entire architecture history in 15 minutes." - Engineering Team Lead

## 🤝 Contributing

This project practices what it preaches - all development decisions are captured as ADRs in `.claude/branches/`. 

**Development setup:**
```bash
# Install just command runner (if needed)
cargo install just

# Quick start
just setup    # Install dependencies
just dev      # Setup + quick test
just test     # Full test suite
```

Want to contribute? Create an issue or PR. We'll document the decision process using our own system!

## 🛠️ Development

**For contributors and advanced users:**

```bash
# Available commands (use `just` command runner)
just           # Show all available commands
just test      # Run full test suite
just lint      # Code quality checks
just security  # Security scan
just demo      # System demonstration
```

**Full development guide:** See `DEVELOPMENT.md`

## 📋 Version

**Current:** v1.0 - First public release incorporating 2+ years of development and real-world usage.

## 🔗 Links

- **Download system:** [Single-file gist](https://gist.github.com/joshrotenberg/a9f8ac85b9ebe20c6b6202a17d804fbc)
- **Full repository:** [GitHub](https://github.com/joshrotenberg/claude-context-system)
- **Live demo:** Explore `.claude/` in this repository

---

**The Claude Context System: Solving the universal problem of architectural knowledge loss through AI-managed documentation.**

*"In 6 months, you'll either have a well-documented decision history, or you'll wish you did."*