#!/bin/sh

set -euxo pipefail

# 08/10/2024

brew install fd ripgrep lazygit

if [ ! -f ~/.local/bin/wezterm ]; then
  curl -L https://github.com/wez/wezterm/releases/download/nightly/WezTerm-nightly-Ubuntu20.04.AppImage -o ~/.local/bin/wezterm
fi
chmod +x ~/.local/bin/wezterm

mkdir -p ~/.local/share/fonts

if [ ! -d "~/.local/share/fonts/BlexMono Nerd Font" ]; then
  pushd ~/.local/share/fonts/
  curl -LO "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/IBMPlexMono.zip"
  mkdir "BlexMono Nerd Font"
  unzip IBMPlexMono.zip -d "BlexMono Nerd Font"
  popd
fi
