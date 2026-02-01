#\!/usr/bin/env bash
set -euo pipefail

echo "Installing Flywheel-Lite..."

# Create directories
mkdir -p ~/.local/bin ~/.config/flywheel

# Copy script
cp bin/flywheel ~/.local/bin/flywheel
chmod +x ~/.local/bin/flywheel

# Copy config (don't overwrite existing)
if [[ \! -f ~/.config/flywheel/config.env ]]; then
    cp config/config.env ~/.config/flywheel/config.env
    echo "Created ~/.config/flywheel/config.env"
else
    echo "Config already exists, skipping"
fi

# Ensure PATH
if \! grep -q '\.local/bin' ~/.bashrc 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
fi
if \! grep -q '\.local/bin' ~/.zshrc 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc 2>/dev/null || true
fi

# Create bd symlink if br exists but bd doesn't
if command -v br &>/dev/null && \! command -v bd &>/dev/null; then
    ln -sf "$(which br)" ~/.local/bin/bd
    echo "Created bd -> br symlink"
fi

echo ""
echo "Installation complete\!"
echo "Run: source ~/.bashrc && flywheel doctor"
