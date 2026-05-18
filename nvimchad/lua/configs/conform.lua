return {
  formatters_by_ft = {
    -- Lua
    lua = { "stylua" },

    -- Go
    go = {
      "gofumpt",
      "goimports_reviser",
      "golines",
    },

    -- Python
    python = { "black" },

    -- Web Dev
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },

    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },

    css = { "prettierd" },

    html = {
      "prettierd",
      "djlint",
    },

    markdown = { "prettierd" },

    -- C/C++
    c = { "clang-format" },
    cpp = { "clang-format" },

    -- Rust
    rust = { "rustfmt" },
  },

  format_on_save = {
    timeout_ms = 5000,
    lsp_fallback = true,
  },
}
