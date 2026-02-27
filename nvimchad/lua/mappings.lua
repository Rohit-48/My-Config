require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Rust-specific keybindings (rustaceanvim)
map("n", "<leader>rr", "<cmd>RustLsp runnables<cr>", { desc = "Rust runnables" })
map("n", "<leader>re", "<cmd>RustLsp expandMacro<cr>", { desc = "Rust expand macro" })
map("n", "<leader>rm", "<cmd>RustLsp parentModule<cr>", { desc = "Rust parent module" })
map("n", "<leader>rc", "<cmd>RustLsp openCargo<cr>", { desc = "Rust open Cargo.toml" })
map("n", "<leader>rd", "<cmd>RustLsp hover actions<cr>", { desc = "Rust hover actions" })
map("n", "<leader>rj", "<cmd>RustLsp joinLines<cr>", { desc = "Rust join lines" })
map("n", "<leader>rt", "<cmd>RustLsp testables<cr>", { desc = "Rust testables" })



-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
