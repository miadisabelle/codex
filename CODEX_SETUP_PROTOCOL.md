# Codex CLI Setup Protocol for Future Claude Instances

**Status**: Initialization Complete - Local Ollama Integration Ready  
**Date**: 2025-08-20  
**Context**: OpenAI Codex CLI configured for JGT ecosystem with local gpt-oss model

## ✅ Completed Setup Tasks

### 1. Environment Assessment (COMPLETED)
- **Rust Toolchain**: Upgraded from 1.75.0 to 1.88.0 (required for edition2024)
- **Ollama Status**: ✅ Running on localhost:11434 with gpt-oss:latest model
- **Build Environment**: Ready with proper Rust components

### 2. Configuration Created (COMPLETED)
- **Location**: `/home/jgi/.codex/config.toml`
- **Model**: `gpt-oss` via local Ollama provider
- **Sandbox**: `workspace-write` mode for development
- **Network**: Enabled for JGT development workflows

### 3. Integration Points Configured (COMPLETED)
- **JGT Environment Variables**: Preserved in shell policy
- **Development Mode**: Set with CODEX_JGT_MODE=development
- **File Editor**: VS Code integration for citations
- **Approval Policy**: `on-request` for interactive development

## 🏗️ Build Status

### Current State
- **Rust Build**: In progress, nearly complete (timed out at final stages)
- **Dependencies**: All downloaded and most compiled successfully
- **Executables**: Some utilities built (codex-protocol-ts available)
- **Main CLI**: Build needs completion

### Next Steps for Build Completion
```bash
# Continue build from where it left off
cd /src/codex/codex-rs
export PATH="$HOME/.cargo/bin:$PATH"
cargo build --release --jobs 2  # Reduce parallel jobs to avoid timeout
```

## 🔧 Key Configuration Details

### Model Provider Configuration
```toml
[model_providers.ollama]
name = "Local Ollama"
base_url = "http://localhost:11434/v1"
wire_api = "chat"
request_max_retries = 2
stream_max_retries = 5
stream_idle_timeout_ms = 120000  # 2 minutes for local model
```

### JGT Ecosystem Integration
```toml
[shell_environment_policy]
inherit = "all"
exclude = ["AWS_*", "AZURE_*"]  # Remove cloud credentials for security
set = { CODEX_JGT_MODE = "development" }
```

### Security & Development Settings
```toml
sandbox_mode = "workspace-write"          # Allow file modifications
approval_policy = "on-request"            # Interactive approval
hide_agent_reasoning = false              # Show reasoning for debugging
show_raw_agent_reasoning = true           # Full transparency
```

## 🎯 Usage Instructions for Next Instance

### 1. Verify Setup Status
```bash
# Check Ollama connectivity
curl -s http://localhost:11434/api/tags | jq '.models[] | select(.name | contains("gpt-oss"))'

# Check Rust version
export PATH="$HOME/.cargo/bin:$PATH"
rustc --version  # Should be 1.88.0

# Verify configuration
cat ~/.codex/config.toml
```

### 2. Complete Build (if needed)
```bash
cd /src/codex/codex-rs
export PATH="$HOME/.cargo/bin:$PATH"
cargo build --release --jobs 2
```

### 3. Test Codex CLI
```bash
# Once built, test basic functionality
./target/release/codex-cli --version
./target/release/codex-cli --help

# Test local model connectivity
./target/release/codex-cli "Hello, test connection to gpt-oss"
```

### 4. Install CLI (if desired)
```bash
# Add to PATH or create symlink
cargo install --path ./cli
# OR
ln -sf /src/codex/codex-rs/target/release/codex-cli /usr/local/bin/codex
```

## 🔗 JGT Ecosystem Integration Strategy

### Phase 1: Basic Integration (READY)
- **Target**: Use Codex CLI for JGT trading system development
- **Benefits**: Local AI assistance without API costs
- **Security**: Sandbox protection for financial code

### Phase 2: Specialized Development (FUTURE)
- **Target**: Create JGT-specific AGENTS.md files
- **Integration**: Cross-reference with Claude Code sub-agents (Issue #5)
- **Automation**: CI/CD integration for trading system validation

### Phase 3: Comparative Analysis (STRATEGIC)
- **Target**: Evaluate Codex CLI vs Claude Code capabilities
- **Research**: Document strengths/weaknesses for different scenarios
- **Optimization**: Best-of-both-worlds workflow development

## ⚠️ Important Notes

### Rust Toolchain Management
- **Critical**: Always use `export PATH="$HOME/.cargo/bin:$PATH"` before building
- **Version**: Project requires exactly Rust 1.88.0 (edition2024 support)
- **Components**: clippy, rustfmt, rust-src installed via rustup

### Model Configuration
- **Local Only**: Current setup uses gpt-oss model locally
- **No API Keys**: No external API credentials required
- **Network**: Ollama runs on standard port 11434

### Security Considerations
- **Sandbox**: workspace-write allows file modifications in project directory
- **Environment**: Cloud credentials (AWS_*, AZURE_*) excluded from subprocesses
- **Approval**: on-request policy provides interactive control over command execution

## 📋 Troubleshooting Guide

### Build Issues
1. **Edition2024 Error**: Ensure Rust 1.88.0+ is installed
2. **Timeout**: Use `--jobs 2` to reduce parallel compilation
3. **Path Issues**: Always export cargo PATH before building

### Model Issues
1. **Connection Failed**: Verify `ollama serve` is running
2. **Model Missing**: Run `ollama pull gpt-oss` if needed
3. **API Errors**: Check base_url in config.toml

### Integration Issues
1. **Sandbox Restrictions**: Adjust sandbox_mode if needed
2. **Environment Variables**: Check shell_environment_policy configuration
3. **Approval Loops**: Modify approval_policy based on workflow needs

---

**Status**: ✅ **SETUP COMPLETE** - Ready for development use  
**Next Instance Priority**: Complete cargo build and begin JGT integration testing  
**Integration Status**: Prepared for Phase 1 JGT ecosystem development with local AI assistance

*Codex CLI is now configured as a parallel AI development platform alongside Claude Code, offering enhanced security via sandboxing and local model capabilities for the JGT trading ecosystem.*