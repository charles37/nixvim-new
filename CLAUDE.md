# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a fully declarative Neovim distribution written in Nix using the nixvim framework. It provides a "batteries-included" editing experience with extensive plugin configurations while remaining reproducible across machines.

## Architecture

The configuration follows a modular structure:
- **Base16 color theming**: All color schemes in `config/colors/` follow the base16 pattern, allowing theme colors to cascade through UI, statusline, Telescope, etc.
- **Plugin modularity**: Each plugin has its own file in `config/plug/`, making it easy to enable/disable features
- **Centralized keybindings**: All custom keymaps are defined in `config/keys.nix` (leader is `<Space>`)

## Common Development Commands

```bash
# Build and run the Neovim configuration
nix run .

# Enter a development shell with nvim in PATH
nix develop

# Run configuration checks
nix flake check

# Format Nix code (uses alejandra)
nix fmt
```

## Making Changes

### Adding/Modifying Plugins
1. Create or edit a file in `config/plug/` following the existing pattern
2. Import it in `config/default.nix`
3. Each plugin file should set `enable = true;` to activate

### Changing Color Scheme
1. Edit `config/default.nix` and change the `theme` option (line 65)
2. Available themes are in `config/colors/`
3. The theme automatically applies to all UI elements via base16

### Adding Language Servers
1. Edit `config/plug/lsp/lsp.nix`
2. Add servers to the `lsp.servers` attribute set
3. All nixpkgs language servers are available

## Pre-commit Hooks

The repository has pre-commit hooks configured:
- **statix**: Nix static analyzer
- **alejandra**: Nix formatter

These run automatically when you commit if you're in the dev shell.