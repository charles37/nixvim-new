# nixvim-new

A fully declarative Neovim distribution written in **Nix**.  
The goal is a “batteries-included” editing experience that stays reproducible across machines while remaining easy to tweak.

---

## Quick start

```bash
# 1. Install flakes (if you haven’t already)
nix registry add nixpkgs github:NixOS/nixpkgs
# 2. Clone this repo
git clone https://github.com/charles37/nixvim-new.git
cd nixvim-new
# 3. Build & run Neovim
nix run .        # or `nix develop` to enter a shell with nvim in $PATH
```

````

---

## Switching themes

All built-in colour-schemes live in **`config/colors/`**.
Pick the one you like and set the option in `config/default.nix`:

```nix
# config/default.nix
{
  config.theme = "everblush";   # <─ change this string
}
```

Because the config uses **base16** everywhere, your chosen palette will cascade automatically to the UI, status-line, Telescope, etc.

---

## Directory map

| Path                   | What it contains                                    |
| ---------------------- | --------------------------------------------------- |
| `config/plug/**`       | One file per plugin (makes enabling/disabling easy) |
| `config/colors/*.nix`  | Base16 palettes                                     |
| `config/keys.nix`      | All custom key-maps (leader is <Space>)             |
| `config/sets.nix`      | Editor options (`number`, `tabstop`, …)             |
| `config/highlight.nix` | Extra UI highlight groups driven by the theme       |

---

## Plugin tour

Below each heading you’ll find every plugin file that lives in that folder, followed by a one-liner explaining _why it’s here_.

### UI / UX

| Plugin file                  | Why it’s useful                                                                        |
| ---------------------------- | -------------------------------------------------------------------------------------- |
| `ui/alpha.nix`               | Programmable start-screen (“dashboard”) based on **alpha-nvim** ([github.com][1])      |
| `ui/bufferline.nix`          | Beautiful tab-like buffer list with close/pin actions                                  |
| `ui/lualine.nix`             | Super-fast Lua status-line (**lualine.nvim**) ([github.com][2])                        |
| `ui/noice.nix`               | Replaces noisy `:messages` and cmd-line pop-ups with a modern UI                       |
| `ui/nvim-notify.nix`         | Drop-in, animated notification window ([github.com][3])                                |
| `ui/telescope.nix`           | Fuzzy-finder for files, buffers, git, LSP, etc. (**telescope.nvim**) ([github.com][4]) |
| `utils/flash.nix`            | Jump anywhere with labelled on-screen hints (search + motions) ([github.com][5])       |
| `utils/grapple.nix`          | Tag important files & hop between them instantly ([github.com][6])                     |
| `utils/oil.nix`              | Edit your filesystem “like a buffer” (vim-vinegar-style) ([github.com][7])             |
| `utils/whichkey.nix`         | Pop-up that reminds you what `<leader>` keys do                                        |
| `utils/nvim-autopairs.nix`   | Automatic `()[]{}` pair insertion                                                      |
| `utils/undotree.nix`         | Visual, time-travel-style undo history                                                 |
| `utils/ufo.nix` _(disabled)_ | Fast, LSP-aware code-folding panel                                                     |

### Completion & AI

| Plugin file                          | Why it’s useful                                                         |
| ------------------------------------ | ----------------------------------------------------------------------- |
| `completion/cmp.nix`                 | **nvim-cmp**: source-agnostic completion engine                         |
| `completion/lspkind.nix`             | VS-Code-style kind icons in the popup                                   |
| `completion/cmp-emoji/path/luasnip…` | Extra cmp sources (emoji, buffer, path, snippets)                       |
| `snippets/luasnip.nix`               | LuaSnip snippet engine + `friendly-snippets`                            |
| `completion/copilot-cmp.nix`         | GitHub Copilot completions as just another cmp source                   |
| `utils/copilot.nix`                  | **CopilotChat.nvim**: chat with Copilot inside Neovim ([github.com][8]) |

### LSP, Formatting & Diagnostics

| Plugin file       | Why it’s useful                                                      |
| ----------------- | -------------------------------------------------------------------- |
| `lsp/lsp.nix`     | Wraps **nvim-lspconfig** with sane defaults & many language servers  |
| `lsp/lspsaga.nix` | Rich UI for code actions, diagnostics, breadcrumbs ([github.com][9]) |
| `lsp/trouble.nix` | Togglable problem-list panel (`:Trouble`)                            |
| `lsp/fidget.nix`  | Minimal progress spinners for LSP tasks                              |
| `lsp/conform.nix` | Formatter dispatcher that runs on save (toggle with `<leader>tf`)    |
| `lsp/none-ls.nix` | Use external linters/formatters _as if_ they were LSP servers        |
| `lsp/hlchunk.nix` | Live coloured indent guides / scope highlights                       |
| `lsp-format.nix`  | Auto-formatting fallback for servers that don’t offer it             |

### Syntax & Code-Awareness

| Plugin file                                           | Why it’s useful                                                   |
| ----------------------------------------------------- | ----------------------------------------------------------------- |
| `treesitter/treesitter.nix`                           | **nvim-treesitter** for AST-based highlighting ([github.com][10]) |
| `treesitter/treesitter-context.nix`                   | Sticky function/class header at top while you scroll              |
| `treesitter/treesitter-textobjects.nix` _(commented)_ | Text-objects powered by Treesitter queries                        |

### Git

| Plugin file         | Why it’s useful                                |
| ------------------- | ---------------------------------------------- |
| `git/gitsigns.nix`  | Gutter signs, inline blame, stage/reset hunks  |
| `git/lazygit.nix`   | Opens **lazygit** inside Neovim (`<leader>gg`) |
| `git/gitlinker.nix` | Copy permalink/branch URL for the current line |
| `git/worktree.nix`  | Manage git work-trees from Telescope           |

### Misc / Quality-of-Life

| Plugin file                                   | Why it’s useful                                       |
| --------------------------------------------- | ----------------------------------------------------- |
| `statusline/staline.nix` _(alt but disabled)_ | Lightweight statusline alternative                    |
| `utils/flash.nix`                             | Fast, labelled jumps (see above)                      |
| `utils/hardtime.nix` _(disabled)_             | Helps break bad `hjkl` habits by nagging              |
| `utils/illuminate.nix`                        | Highlights other occurrences of the word under cursor |

---

## Key-maps at a glance

| Leader chord    | What it triggers                               |
| --------------- | ---------------------------------------------- |
| `<leader>f`     | **Telescope** file pickers                     |
| `<leader>g`     | All Git-related commands                       |
| `<leader>u`     | UI toggles (line numbers, wrap, notifications) |
| `<leader>w`     | Window management                              |
| `<leader><Tab>` | Tab pages                                      |
| `<leader>d`     | Debug (placeholder)                            |
| `<leader>c`     | Code actions / formatting                      |
| `<leader>t`     | Tests (placeholder)                            |

(For the exhaustive list open **which-key** with `<leader>`.)

---

## Tips for customisation

1. **Enable/disable plugins** by toggling the `enable = true;` flag in each `plug/*.nix` file or commenting out the import in `config/default.nix`.
2. **Add extra language servers** inside `lsp.lsp.servers`—every server shipped in Nixpkgs is one attribute away.
3. **Change colours on the fly** with `:Telescope colorscheme` (`<leader>uC`).
4. **Toggle “format-on-save”** quickly with `<leader>tf`.

Happy hacking! 🎉


``

[1]: https://github.com/goolord/alpha-nvim 'goolord/alpha-nvim: a lua powered greeter like vim-startify ... - GitHub'
[2]: https://github.com/nvim-lualine/lualine.nvim 'nvim-lualine/lualine.nvim: A blazing fast and easy to ... - GitHub'
[3]: https://github.com/rcarriga/nvim-notify 'rcarriga/nvim-notify: A fancy, configurable, notification ... - GitHub'
[4]: https://github.com/nvim-telescope/telescope.nvim 'nvim-telescope/telescope.nvim: Find, Filter, Preview, Pick ... - GitHub'
[5]: https://github.com/folke/flash.nvim 'folke/flash.nvim: Navigate your code with search labels ... - GitHub'
[6]: https://github.com/cbochs/grapple.nvim 'cbochs/grapple.nvim: Neovim plugin for tagging important files'
[7]: https://github.com/stevearc/oil.nvim 'stevearc/oil.nvim: Neovim file explorer: edit your filesystem like a buffer'
[8]: https://github.com/CopilotC-Nvim/CopilotChat.nvim 'CopilotC-Nvim/CopilotChat.nvim: Chat with GitHub Copilot in Neovim'
[9]: https://github.com/nvimdev/lspsaga.nvim 'nvimdev/lspsaga.nvim: improve neovim lsp experience - GitHub'
[10]: https://github.com/nvim-treesitter/nvim-treesitter 'Nvim Treesitter configurations and abstraction layer - GitHub'
````
