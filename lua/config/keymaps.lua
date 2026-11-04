-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("n", ";", ":", { desc = "Command mode" })
-- vim.keymap.set("n", "<F5>", vim.cmd.UndotreeToggle)
-- to get out of insert/append when in TERMINAL mode hit <esc>
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
