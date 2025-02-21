# 💤 LazyVim

## C# post setup

```
MasonInstall roslyn csharpier
```

### DAP

If on Linux, `MasonInstall netcoredbg` is sufficient.

For macOS, you need to install netcoredbg manually, builds are available at [Cliffback/netcoredbg-macOS-arm64.nvim](https://github.com/Cliffback/netcoredbg-macOS-arm64.nvim). Below is a simple script to install netcoredbg to ~/.local/bin.

```sh
curl https://github.com/Cliffback/netcoredbg-macOS-arm64.nvim/releases/download/3.1.0-1031/netcoredbg-osx-arm64.tar.gz -Lo '/tmp/netcoredbg-osx-arm64.tar.gz'
mkdir -p ~/.local/bin/lib
tar -xvzf /tmp/netcoredbg-osx-arm64.tar.gz -C ~/.local/bin/lib
ln -s ~/.local/bin/lib/netcoredbg/netcoredbg ~/.local/bin/netcoredbg
```
