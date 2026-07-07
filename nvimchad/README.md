# My Neovim Config

This is my personal Neovim setup, built on top of [NvChad](https://nvchad.com/) and managed with
[lazy.nvim](https://github.com/folke/lazy.nvim). It is meant to feel fast, keyboard-first, and practical for
daily development rather than overloaded with visual extras.

The config is tuned mainly for web development, Go, Python, Rust, C/C++, Lua, Bash, JSON, and Markdown. It includes
LSP support, formatting on save, fuzzy finding, quick file jumping, debugging, tmux navigation, sessions, Git tooling,
and a few quality-of-life plugins.

## What This Setup Gives You

- NvChad as the base UI and plugin foundation
- Catppuccin theme through Base46
- lazy.nvim plugin management
- Treesitter parsers for the main languages I use
- LSP setup for web, Lua, JSON, Bash, Go, C/C++, Python, and Rust
- Format-on-save through Conform
- Telescope for finding files, searching text, buffers, and help tags
- Harpoon for jumping between important files quickly
- Oil.nvim for editing directories like normal buffers
- LazyGit integration inside Neovim
- nvim-dap and dap-ui for debugging, with Python debugging configured
- auto-session for restoring project sessions
- tmux pane navigation from inside Neovim
- WakaTime and Discord presence support
- crates.nvim for Rust `Cargo.toml` dependency help

## Requirements

Install Neovim first. This config uses the newer `vim.lsp.config` and `vim.lsp.enable` APIs, so use Neovim 0.11 or
newer.

You should also have these basics available:

- `git`
- `node` and `npm`
- `ripgrep` for Telescope live grep
- a Nerd Font for icons
- `lazygit` if you want `<leader>gg` to work
- `tmux` if you want the tmux navigation mappings

## Installation

Back up your current config first:

```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

Clone this config:

```bash
git clone https://codeberg.org/Spaceeeeeh/NVIM.git ~/.config/nvim
```

Start Neovim:

```bash
nvim
```

lazy.nvim will bootstrap itself and install the plugins on the first launch.

## External Tools

Neovim plugins are installed automatically, but language servers, formatters, and debuggers still need to exist on your
system. Install the tools for the languages you actually use.

### Web, Lua, JSON, Bash, and Markdown

```bash
npm install -g prettierd
pip install djlint
cargo install stylua
```

For language servers, install them with Mason inside Neovim or through your system package manager. This config enables:

- `html`
- `cssls`
- `tailwindcss`
- `ts_ls`
- `lua_ls`
- `jsonls`
- `bashls`

`prettierd` handles web files and Markdown, `djlint` is used for HTML, and `stylua` is used for Lua formatting.

### Go

```bash
go install golang.org/x/tools/gopls@latest
go install mvdan.cc/gofumpt@latest
go install github.com/incu6us/goimports-reviser/v3@latest
go install github.com/segmentio/golines@latest
```

Go files use `gopls` for LSP and `gofumpt`, `goimports_reviser`, and `golines` for formatting.

### Python

```bash
pip install black debugpy
```

The config expects `pyright` and `ruff` for LSP. Install them with Mason, your package manager, or Python tooling:

```bash
npm install -g pyright
pip install ruff
```

`debugpy` is used by `nvim-dap-python`.

### Rust

```bash
rustup component add rust-analyzer rustfmt clippy
```

Rust Analyzer is configured with all Cargo features enabled, proc macros enabled, Clippy checks on save, and several
inlay hints.

### C and C++

Install `clangd` and `clang-format` through your system package manager.

On Arch-based systems:

```bash
sudo pacman -S clang
```

## Keymaps

The leader key is Space.

| Key | Action |
| --- | --- |
| `;` | Enter command mode |
| `jk` | Leave insert mode |
| `<leader>ff` | Find files with Telescope |
| `<leader>fg` | Search text with Telescope live grep |
| `<leader>fb` | Show open buffers |
| `<leader>fh` | Search help tags |
| `<leader>gg` | Open LazyGit |
| `<leader>a` | Add current file to Harpoon |
| `<leader>h` | Open the Harpoon quick menu |
| `<leader>1` | Jump to Harpoon file 1 |
| `<leader>2` | Jump to Harpoon file 2 |
| `<leader>3` | Jump to Harpoon file 3 |
| `<leader>4` | Jump to Harpoon file 4 |
| `-` | Open Oil.nvim |
| `<F5>` | Continue or start debugger |
| `<F10>` | Debug step over |
| `<F11>` | Debug step into |
| `<F12>` | Debug step out |
| `<leader>b` | Toggle breakpoint |
| `<C-h>` | Move to tmux pane on the left |
| `<C-j>` | Move to tmux pane below |
| `<C-k>` | Move to tmux pane above |
| `<C-l>` | Move to tmux pane on the right |

NvChad also provides its own default mappings. This file only lists the custom mappings added in
[`lua/mappings.lua`](lua/mappings.lua).

## Project Structure

```text
.
├── init.lua
├── lazy-lock.json
├── lua
│   ├── autocmds.lua
│   ├── chadrc.lua
│   ├── mappings.lua
│   ├── options.lua
│   ├── configs
│   │   ├── conform.lua
│   │   ├── dap.lua
│   │   ├── lazy.lua
│   │   └── lspconfig.lua
│   └── plugins
│       └── init.lua
└── .stylua.toml
```

## How The Config Is Organized

`init.lua` bootstraps lazy.nvim, loads NvChad, imports the custom plugins, loads the cached Base46 theme files, then
loads options, autocmds, and mappings.

`lua/options.lua` keeps the editor behavior simple: relative numbers, four-space indentation, expanded tabs, smart
indentation, cursorline, and some scroll padding.

`lua/plugins/init.lua` is the main plugin list. Most plugins are lazy-loaded where it makes sense, while tools like
auto-session, tmux navigation, WakaTime, and Discord presence are loaded immediately.

`lua/configs/lspconfig.lua` contains the language server setup. Simple servers are enabled directly, while Go, C/C++,
Python, and Rust get extra settings.

`lua/configs/conform.lua` defines formatters by filetype and enables format-on-save with a five-second timeout.

`lua/configs/dap.lua` opens dap-ui when a debug session starts, closes it when the session ends, and wires Python
debugging through `dap-python`.

## Notes

This is a personal config, so it assumes a terminal-focused workflow. It works best with a proper Nerd Font, tmux,
LazyGit, and the external language tools installed. If something opens but a language feature does not work, the first
thing to check is usually whether the matching language server or formatter is installed.

## License

This repository is licensed under the MIT License. See [`LICENSE`](LICENSE) for details.
