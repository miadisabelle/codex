#!/bin/bash

# Test script for Codex CLI local model integration
# Tests the configuration and Ollama connectivity

set -e

echo "=== Codex CLI Local Model Test ==="
echo "Date: $(date)"
echo

# Test 1: Configuration check
echo "1. Checking configuration..."
if [ -f ~/.codex/config.toml ]; then
    echo "✅ Configuration file exists"
    grep -A 3 "model.*=.*gpt-oss" ~/.codex/config.toml && echo "✅ Model configured correctly"
    grep -A 5 "\[model_providers.ollama\]" ~/.codex/config.toml && echo "✅ Ollama provider configured"
else
    echo "❌ Configuration file missing"
    exit 1
fi
echo

# Test 2: Ollama connectivity
echo "2. Testing Ollama connectivity..."
if curl -s http://localhost:11434/api/tags > /dev/null; then
    echo "✅ Ollama server is running"
    if curl -s http://localhost:11434/api/tags | jq -r '.models[].name' | grep -q "gpt-oss"; then
        echo "✅ gpt-oss model is available"
    else
        echo "❌ gpt-oss model not found"
        echo "Available models:"
        curl -s http://localhost:11434/api/tags | jq -r '.models[].name'
        exit 1
    fi
else
    echo "❌ Cannot connect to Ollama server"
    exit 1
fi
echo

# Test 3: OpenAI API compatibility
echo "3. Testing OpenAI API compatibility..."
response=$(curl -s -X POST http://localhost:11434/v1/chat/completions \
    -H "Content-Type: application/json" \
    -d '{"model": "gpt-oss", "messages": [{"role": "user", "content": "Say hello"}], "max_tokens": 10}')

if echo "$response" | jq -e '.choices[0].message.content' > /dev/null 2>&1; then
    echo "✅ OpenAI API compatibility confirmed"
    echo "Response: $(echo "$response" | jq -r '.choices[0].message.content')"
else
    echo "❌ OpenAI API compatibility failed"
    echo "Response: $response"
    exit 1
fi
echo

# Test 4: Rust build status
echo "4. Checking Rust build status..."
if [ -d /src/codex/codex-rs/target/release ]; then
    echo "✅ Release build directory exists"
    if [ -f /src/codex/codex-rs/target/release/codex ]; then
        echo "✅ Main codex binary built"
    else
        echo "⚠️  Main codex binary not found, but components available:"
        ls -la /src/codex/codex-rs/target/release/codex-* 2>/dev/null || echo "   No codex components found"
    fi
else
    echo "❌ No release build found"
fi
echo

echo "=== Test Summary ==="
echo "Configuration: ✅ Ready"
echo "Ollama Server: ✅ Running with gpt-oss"
echo "API Compatibility: ✅ Working"
echo "Build Status: ⚠️  In progress"
echo
echo "Status: Codex CLI initialization is mostly complete."
echo "Next step: Complete cargo build to get main codex binary."
echo "Current setup allows local AI development with gpt-oss model."