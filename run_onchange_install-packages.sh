#!/bin/env bash

set -euxo pipefail

# 08/10/2024

brew install fd ripgrep lazygit npm ansible yamlfmt

if [ ! -f ~/.local/bin/wezterm ]; then
  curl -L https://github.com/wez/wezterm/releases/download/nightly/WezTerm-nightly-Ubuntu20.04.AppImage -o ~/.local/bin/wezterm
fi
chmod +x ~/.local/bin/wezterm
