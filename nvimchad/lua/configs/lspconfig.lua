require("nvchad.configs.lspconfig").defaults()

local servers = {
  -- Web
  "html",
  "cssls",
  "tsserver",
  "jsonls",
  "eslint",
  "tailwindcss",
  "emmet_ls",

  -- AI / ML
  "pyright",
  "ruff_lsp",

  -- CS / Systems
  "clangd",
  "rust_analyzer",
  "gopls",
  "bashls",
  "cmake",
  "marksman",
  "lua_ls",
}

vim.lsp.enable(servers)


-- read :h vim.lsp.config for changing options of lsp servers 
