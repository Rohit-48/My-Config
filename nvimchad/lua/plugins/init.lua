return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      local conf = require "nvchad.configs.nvimtree"
      conf.view.width = 35
      conf.view.relativenumber = true
      conf.renderer.group_empty = true
      conf.renderer.highlight_git = true
      conf.renderer.root_folder_label = false
      conf.filters.git_ignored = false
      return conf
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      require "configs.dap"
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
  },

  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      auto_restore = true,
      suppressed_dirs = {
        "~/",
        "~/Downloads",
        "/",
      },
    },
  },

  { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "rust",
        "go",
        "c",
        "cpp",
        "bash",
        "json",
        "python",
      },
    },
  },

  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  {
    "wakatime/vim-wakatime",
    lazy = false,
  },

  {
    "andweeb/presence.nvim",
    lazy = false,
    opts = {
      auto_update = true,
      neovim_image_text = "vim guy now🌴",
      main_image = "neovim",
      client_id = "793271441293967371",
      debounce_timeout = 10,
      enable_line_number = false,
      buttons = true,
      show_time = true,
      editing_text = "Editing %s",
      file_explorer_text = "Browsing %s",
      git_commit_text = "Committing changes",
      workspace_text = "Working on %s",
    },
  },

  {
    "nvzone/timerly",
    cmd = "TimerlyToggle",
    dependencies = { "nvzone/volt" },
  },

  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function()
      require("crates").setup()
    end,
  },

  -- Diagnostics / TODOs
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
  },

  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- Motions / editing
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },

  -- Auto-install LSPs / formatters used in this config
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        -- LSP
        "lua-language-server",
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",
        "typescript-language-server",
        "json-lsp",
        "bash-language-server",
        "gopls",
        "clangd",
        "pyright",
        "ruff",
        "rust-analyzer",
        -- Formatters
        "stylua",
        "gofumpt",
        "goimports-reviser",
        "golines",
        "black",
        "prettierd",
        "djlint",
        "clang-format",
      },
      auto_update = false,
      run_on_start = true,
    },
  },
}
