require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "telescope find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help tags" })

map("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "lazygit" })

-- Harpoon (avoid <leader>h — used by NvChad terminal)
map("n", "<leader>a", function()
  require("harpoon.mark").add_file()
end, { desc = "harpoon add file" })

map("n", "<leader>hm", function()
  require("harpoon.ui").toggle_quick_menu()
end, { desc = "harpoon menu" })

for i = 1, 4 do
  map("n", "<leader>" .. i, function()
    require("harpoon.ui").nav_file(i)
  end, { desc = "harpoon file " .. i })
end

-- Debugger (avoid <leader>b — used by NvChad buffer new)
map("n", "<F5>", function()
  require("dap").continue()
end, { desc = "dap continue" })
map("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "dap step over" })
map("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "dap step into" })
map("n", "<F12>", function()
  require("dap").step_out()
end, { desc = "dap step out" })
map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "dap toggle breakpoint" })

-- Tmux navigator
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "tmux left" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "tmux right" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "tmux down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "tmux up" })

-- Gitsigns (bundled with NvChad)
map("n", "]c", function()
  if vim.wo.diff then
    vim.cmd.normal { "]c", bang = true }
  else
    require("gitsigns").nav_hunk "next"
  end
end, { desc = "gitsigns next hunk" })

map("n", "[c", function()
  if vim.wo.diff then
    vim.cmd.normal { "[c", bang = true }
  else
    require("gitsigns").nav_hunk "prev"
  end
end, { desc = "gitsigns prev hunk" })

map("n", "<leader>gs", function()
  require("gitsigns").stage_hunk()
end, { desc = "gitsigns stage hunk" })
map("n", "<leader>gr", function()
  require("gitsigns").reset_hunk()
end, { desc = "gitsigns reset hunk" })
map("n", "<leader>gp", function()
  require("gitsigns").preview_hunk()
end, { desc = "gitsigns preview hunk" })
map("n", "<leader>gb", function()
  require("gitsigns").blame_line { full = true }
end, { desc = "gitsigns blame line" })

-- Trouble
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "trouble diagnostics" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "trouble buffer diagnostics" })
map("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<CR>", { desc = "trouble symbols" })
map("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>", { desc = "trouble loclist" })
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<CR>", { desc = "trouble quickfix" })

-- Todo comments
map("n", "<leader>st", "<cmd>TodoTelescope<CR>", { desc = "todo telescope" })
map("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "todo next" })
map("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "todo prev" })

-- Flash
map({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "flash jump" })
map({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { desc = "flash treesitter" })
map("o", "r", function()
  require("flash").remote()
end, { desc = "flash remote" })
map({ "o", "x" }, "R", function()
  require("flash").treesitter_search()
end, { desc = "flash treesitter search" })
