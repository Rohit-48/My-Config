return {
  formatters_by_ft = {
    lua = { "stylua" },

    go = {
      "gofumpt",
      "goimports-reviser",
      "golines",
    },

    python = { "black" },

    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    css = { "prettierd" },
    html = { "prettierd", "djlint" },
    markdown = { "prettierd" },

    c = { "clang-format" },
    cpp = { "clang-format" },

    rust = { "rustfmt" },
  },

  format_on_save = {
    timeout_ms = 5000,
    lsp_format = "fallback",
  },
}
