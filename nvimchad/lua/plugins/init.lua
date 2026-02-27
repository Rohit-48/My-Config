return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- JSON/YAML schema support
      "b0o/schemastore.nvim",
    },
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Mason: LSP/DAP/Linter/Formatter installer
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- Web Development
        "html-lsp",
        "css-lsp",
        "typescript-language-server",
        "eslint-lsp",
        "tailwindcss-language-server",
        "emmet-ls",
        "json-lsp",
        "graphql-language-service-cli",
        
        -- Formatters (Web)
        "prettier",
        "stylua",
        
        -- DevOps & Infrastructure
        "dockerfile-language-server",
        "docker-compose-language-service",
        "terraform-ls",
        "ansible-language-server",
        "helm-ls",
        "yaml-language-server",
        "bash-language-server",
        "tflint",
        
        -- Formatters (DevOps)
        "shfmt",
        "yamlfmt",
        
        -- Cloud
        "azure-pipelines-language-server",
        
        -- Networking
        "nginx-language-server",
        
        -- Python/AI/ML
        "pyright",
        "ruff-lsp",
        "ruff",
        "black",
        "isort",
        
        -- Documentation
        "marksman",
        "markdown-toc",
        
        -- Lua/Vim
        "lua-language-server",
        "vim-language-server",
        
        -- Rust
        "rust-analyzer",
        "rustfmt",
      },
    },
  },

  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Base
        "vim", "lua", "vimdoc",
        
        -- Web Development
        "html", "css", "scss", "javascript", "typescript", "tsx", "jsx",
        "json", "jsonc", "graphql", "vue", "svelte",
        
        -- DevOps & Infrastructure
        "dockerfile", "yaml", "toml", "hcl", "terraform",
        "bash", "fish", "make",
        
        -- Python/AI/ML
        "python", "requirements",
        
        -- Documentation & Config
        "markdown", "markdown_inline",
        "regex", "comment",
        
        -- Rust
        "rust",
        
        -- Additional
        "git_config", "gitignore", "gitcommit",
        "ssh_config",
      },
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      indent = { enable = true },
    },
  },

  -- Blink completion
  { import = "nvchad.blink.lazyspec" },

  -- Additional helpful plugins for development

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- Better comments
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
    config = function()
      require("Comment").setup()
    end,
  },

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "󰍵" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
    },
  },

  -- Docker integration
  {
    "https://codeberg.org/esensar/nvim-dev-container",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },

  -- Terraform/HCL support
  {
    "hashivim/vim-terraform",
    ft = { "terraform", "hcl" },
    config = function()
      vim.g.terraform_fmt_on_save = 1
      vim.g.terraform_align = 1
    end,
  },

  -- YAML helper (Kubernetes, Ansible, etc.)
  {
    "cuducos/yaml.nvim",
    ft = { "yaml" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
  },

  -- REST client (for API testing)
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("rest-nvim").setup({
        result_split_horizontal = false,
        result_split_in_place = false,
        skip_ssl_verification = false,
        encode_url = true,
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          show_url = true,
          show_http_info = true,
          show_headers = true,
        },
      })
    end,
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- Database client
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },

  -- Python virtual environment selector
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    branch = "regexp",
    ft = "python",
    cmd = "VenvSelect",
    opts = {
      name = { "venv", ".venv", "env", ".env" },
    },
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select Python venv" },
    },
  },

  -- Debugger (DAP)
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- UI for DAP
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function()
          require("dapui").setup()
        end,
      },
      -- Python DAP
      {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        config = function()
          require("dap-python").setup("python")
        end,
      },
      -- Node.js DAP
      {
        "mxsdev/nvim-dap-vscode-js",
        ft = { "javascript", "typescript" },
      },
    },
  },

  -- Trouble (better diagnostics)
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope = { char = "│", highlight = "IblScope" },
    },
  },

  -- Rust tools (enhanced Rust development) - using rustaceanvim (successor to rust-tools)
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    ft = "rust",
    lazy = false,
    config = function()
      vim.g.rustaceanvim = {
        tools = {
          inlay_hints = {
            auto = true,
            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
          },
          hover_actions = {
            auto_focus = true,
          },
        },
        server = {
          on_attach = function(client, bufnr)
            -- You can add custom on_attach logic here
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              checkOnSave = true,
              check = {
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
              },
            },
          },
        },
      }
    end,
  },

  -- Cargo.toml syntax highlighting
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup()
    end,
  },

  -- Color highlighter
  {
    "NvChad/nvim-colorizer.lua",
    event = "User FilePost",
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
    config = function(_, opts)
      require("colorizer").setup(opts)
      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Tmux left" },
      { "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Tmux down" },
      { "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Tmux up" },
      { "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Tmux right" },
      { "<C-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "Tmux previous" },
    },
  },

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      return { override = require "nvchad.icons.devicons" }
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "devicons")
      require("nvim-web-devicons").setup(opts)
    end,
  },
}
