require("nvchad.configs.lspconfig").defaults()

local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- Simple servers
vim.lsp.enable {
  "html",
  "cssls",
  "tailwindcss",
  "ts_ls",
  "lua_ls",
  "jsonls",
  "bashls",
}

-- Go
vim.lsp.config("gopls", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,

  cmd = { "gopls" },

  filetypes = {
    "go",
    "gomod",
    "gowork",
    "gotmpl",
  },

  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,

      analyses = {
        unusedparams = true,
      },

      gofumpt = true,
    },
  },
})

vim.lsp.enable("gopls")

-- C/C++
vim.lsp.config("clangd", {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    on_attach(client, bufnr)
  end,

  on_init = on_init,
  capabilities = capabilities,
})

vim.lsp.enable("clangd")

-- Python
local python_servers = { "pyright", "ruff" }

for _, server in ipairs(python_servers) do
  vim.lsp.config(server, {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,

    filetypes = { "python" },

    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace",
        },
      },
    },
  })

  vim.lsp.enable(server)
end

-- Rust
vim.lsp.config("rust_analyzer", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,

  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },

      checkOnSave = true,

      check = {
        command = "clippy",
      },

      procMacro = {
        enable = true,
      },

      inlayHints = {
        bindingModeHints = {
          enable = true,
        },

        closingBraceHints = {
          enable = true,
          minLines = 25,
        },

        closureReturnTypeHints = {
          enable = "with_block",
        },

        lifetimeElisionHints = {
          enable = "skip_trivial",
        },

        maxLength = 25,
      },
    },
  },
})

vim.lsp.enable("rust_analyzer")
