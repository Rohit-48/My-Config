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
  "nvim-telescope/telescope.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
    },
  },

  {
  "ThePrimeagen/harpoon",

  dependencies = {
    "nvim-lua/plenary.nvim",
  },
},

{
  "kdheepak/lazygit.nvim",

  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
  },

  dependencies = {
    "nvim-lua/plenary.nvim",
  },
},

{
  "mfussenegger/nvim-dap",
},

{
  "rcarriga/nvim-dap-ui",

  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },
},

{
  "mfussenegger/nvim-dap",

  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "mfussenegger/nvim-dap-python",
  },

  config = function()
    require("configs.dap")
  end,
},

{
  "stevearc/oil.nvim",

  cmd = "Oil",

  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  opts = {},
},

{
  "rmagatti/auto-session",

  lazy = false,

  opts = {
    auto_restore_enabled = true,

    auto_session_suppress_dirs = {
      "~/",
      "~/Downloads",
      "/",
    },
  },
},

-- blink completion
  { import = "nvchad.blink.lazyspec" },

  -- Treesitter
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

  -- Auto tag
  {
    "windwp/nvim-ts-autotag",

    ft = {
      "html",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "tsx",
      "jsx",
    },

    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- tmux navigator
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  -- WakaTime
  {
    "wakatime/vim-wakatime",
    lazy = false,
  },

  -- Discord presence
  {
    "andweeb/presence.nvim",

    lazy = false,

    opts = {
      auto_update = true,

      neovim_image_text = "One missing comma away from madness",

      main_image = "neovim",

      client_id = "793271441293967371",

      debounce_timeout = 10,

      enable_line_number = false,

      buttons = true,

      show_time = true,

      editing_text = "Editing %s",

      workspace_text = "Working on %s",
    },
  },

  -- Timerly
  {
    "nvzone/timerly",

    cmd = "TimerlyToggle",

    dependencies = {
      "nvzone/volt",
    },
  },

  -- crates.nvim
  {
    "saecki/crates.nvim",

    ft = { "toml" },

    config = function()
      require("crates").setup()
    end,
  },
}
