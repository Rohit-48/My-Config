require("nvchad.configs.lspconfig").defaults()

-- Get capabilities from NvChad
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- LSP servers organized by category
local servers = {
  -- Web Development
  "html",           -- HTML
  "cssls",          -- CSS
  "ts_ls",          -- TypeScript/JavaScript (formerly tsserver)
  "eslint",         -- JavaScript/TypeScript linting
  "tailwindcss",    -- Tailwind CSS
  "emmet_ls",       -- Emmet for HTML/CSS
  "jsonls",         -- JSON
  "graphql",        -- GraphQL
  
  -- DevOps & Infrastructure
  "dockerls",       -- Dockerfile
  "docker_compose_language_service", -- Docker Compose
  "terraformls",    -- Terraform
  "ansiblels",      -- Ansible
  "helm_ls",        -- Helm charts
  "yamlls",         -- YAML (K8s manifests, CI/CD configs)
  "bashls",         -- Bash scripts
  
  -- Cloud Providers
  "azure_pipelines_ls", -- Azure Pipelines
  "tflint",         -- Terraform linter
  
  -- Networking & Systems
  "nginx_language_server", -- Nginx configs
  
  -- AI/ML & Data
  "pyright",        -- Python (primary for AI/ML)
  "ruff_lsp",       -- Python linter/formatter (fast)
  "marksman",       -- Markdown (documentation)
  
  -- Additional useful servers
  "lua_ls",         -- Lua (for Neovim config)
  "vimls",          -- Vimscript
  
  -- Note: rust-analyzer is handled by rustaceanvim plugin, not lspconfig
}

-- Custom on_attach function for LSP-specific keybindings
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format { async = true }
  end, bufopts)
end

-- Helper function to safely require schemastore
local function get_schemastore_schemas()
  local ok, schemastore = pcall(require, 'schemastore')
  if ok then
    return schemastore.json.schemas()
  end
  return {}
end

-- Configure specific LSP servers before enabling them
-- These configurations will be picked up by vim.lsp.enable()

-- Python (Pyright) configuration for AI/ML
vim.lsp.config.pyright = {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      }
    }
  },
  capabilities = capabilities,
  on_attach = on_attach,
}

-- YAML configuration for Kubernetes
vim.lsp.config.yamlls = {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  root_markers = { ".git" },
  settings = {
    yaml = {
      schemas = {
        kubernetes = "*.yaml",
        ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
        ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
        ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
        ["http://json.schemastore.org/docker-compose"] = "docker-compose*.{yml,yaml}",
      },
      format = { enable = true },
      validate = true,
      hover = true,
      completion = true,
    }
  },
  capabilities = capabilities,
  on_attach = on_attach,
}

-- JSON configuration
vim.lsp.config.jsonls = {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_markers = { ".git" },
  settings = {
    json = {
      schemas = get_schemastore_schemas(),
      validate = { enable = true },
    }
  },
  capabilities = capabilities,
  on_attach = on_attach,
}

-- TypeScript/JavaScript configuration
vim.lsp.config.ts_ls = {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionParameterTypeHints = true,
      }
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionParameterTypeHints = true,
      }
    }
  },
  capabilities = capabilities,
  on_attach = on_attach,
}

-- Tailwind CSS configuration
vim.lsp.config.tailwindcss = {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
  root_markers = { "tailwind.config.js", "tailwind.config.ts", "tailwind.config.cjs", ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
}

-- Terraform configuration
vim.lsp.config.terraformls = {
  cmd = { "terraform-ls", "serve" },
  filetypes = { "terraform", "tf", "hcl" },
  root_markers = { ".terraform", ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
}

-- Lua configuration (for Neovim)
vim.lsp.config.lua_ls = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { 
    ".luarc.json", 
    ".luarc.jsonc", 
    ".luacheckrc", 
    ".stylua.toml", 
    "stylua.toml", 
    "selene.toml", 
    "selene.yml", 
    ".git" 
  },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          vim.fn.expand("$VIMRUNTIME/lua"),
          vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
          vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/luv/library",
        },
        checkThirdParty = false,
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
      telemetry = {
        enable = false,
      },
    }
  },
  capabilities = capabilities,
  on_attach = on_attach,
}

-- HTML configuration
vim.lsp.config.html = {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- CSS configuration
vim.lsp.config.cssls = {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- ESLint configuration
vim.lsp.config.eslint = {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    -- Auto-fix on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
}

-- Enable all LSP servers
vim.lsp.enable(servers)
