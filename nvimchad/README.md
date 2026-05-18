````md
# Neovim Config

A modern Neovim setup focused on:
- Rust
- Go
- Python
- Web development
- Terminal-native workflows

Built using NvChad + lazy.nvim.

---

## Preview

![Preview](./assets/preview.png)

---

## Features

- Modern LSP setup
- Treesitter syntax highlighting
- Conform formatting pipeline
- DAP debugging support
- Telescope fuzzy finder
- Harpoon quick navigation
- tmux integration
- Discord Rich Presence
- WakaTime tracking
- Oil.nvim filesystem editing
- Auto session management

---

## Stack

- Neovim
- NvChad
- lazy.nvim
- Treesitter
- Telescope
- Conform.nvim
- nvim-dap
- Harpoon
- Oil.nvim
- tmux

---

## Installation

Backup existing config:

```bash
mv ~/.config/nvim ~/.config/nvim.bak
````

Clone repository:

```bash
git clone https://github.com/your-username/nvim ~/.config/nvim
```

Start Neovim:

```bash
nvim
```

Install external dependencies:

### Node.js tools

```bash
npm install -g prettierd
```

### Python tools

```bash
pip install black debugpy
```

### Go tools

```bash
go install mvdan.cc/gofumpt@latest
go install github.com/incu6us/goimports-reviser/v3@latest
go install github.com/segmentio/golines@latest
```

### Rust tools

```bash
rustup component add rust-analyzer
rustup component add rustfmt
rustup component add clippy
```

### C/C++

```bash
sudo pacman -S clang
```

---

## Keymaps

| Key          | Action           |
| ------------ | ---------------- |
| `<leader>ff` | Find files       |
| `<leader>fg` | Live grep        |
| `<leader>fb` | Buffers          |
| `<leader>a`  | Harpoon add file |
| `<leader>h`  | Harpoon menu     |
| `<leader>gg` | Open LazyGit     |
| `-`          | Open Oil.nvim    |
| `F5`         | Start debugger   |
| `F10`        | Step over        |
| `F11`        | Step into        |
| `F12`        | Step out         |

---

## Structure

```txt
lua/
├── configs/
│   ├── conform.lua
│   ├── dap.lua
│   └── lspconfig.lua
│
├── plugins/
│   └── init.lua
│
├── mappings.lua
├── options.lua
└── autocmds.lua
```

---

## Philosophy

This setup focuses on:

* speed
* minimalism
* keyboard-first workflows
* terminal-native development
* practical tooling over visual bloat

---

## TODO

* Improve Rust debugging
* Add declarative Nix integration
* Better statusline customization
* Session persistence improvements

---

## License

MIT

```
```

