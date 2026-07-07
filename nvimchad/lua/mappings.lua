require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

local map = vim.keymap.set

-- Telescope Stuff
local map = vim.keymap.set

map("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")

map("n", "<leader>gg", "<cmd>LazyGit<CR>")

-- Harpoon

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

-- add file
map("n", "<leader>a", mark.add_file)

-- toggle menu
map("n", "<leader>h", ui.toggle_quick_menu)

-- jump to files
map("n", "<leader>1", function()
  ui.nav_file(1)
end)

map("n", "<leader>2", function()
  ui.nav_file(2)
end)

map("n", "<leader>3", function()
  ui.nav_file(3)
end)

map("n", "<leader>4", function()
  ui.nav_file(4)
end)


-- dubbuger
local dap = require("dap")

map("n", "<F5>", dap.continue)
map("n", "<F10>", dap.step_over)
map("n", "<F11>", dap.step_into)
map("n", "<F12>", dap.step_out)

-- dap 
map("n", "<leader>b", dap.toggle_breakpoint)

-- TMUX Stuff
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>")
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>")
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
