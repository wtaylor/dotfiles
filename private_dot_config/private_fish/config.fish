set fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path ~/.local/bin
fish_add_path ~/.dotnet
fish_add_path ~/.bun/bin

set -x DOTNET_ROOT "$HOME/.dotnet"

starship init fish | source
