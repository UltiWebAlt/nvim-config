-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("n", ";", ":", { desc = "Command mode" })
-- vim.keymap.set("n", "<F5>", vim.cmd.UndotreeToggle)
-- to get out of insert/append when in TERMINAL mode hit <esc>
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

local function diff_copy_line(to_right)
  if not vim.wo.diff then
    vim.api.nvim_feedkeys(to_right and ">" or "<", "n", false)
    return
  end

  local wins = vim.tbl_filter(function(w)
    return vim.wo[w].diff
  end, vim.api.nvim_tabpage_list_wins(0))

  if #wins ~= 2 then
    vim.notify("Expected two diff windows", vim.log.levels.WARN)
    return
  end

  table.sort(wins, function(a, b)
    return vim.api.nvim_win_get_position(a)[2] < vim.api.nvim_win_get_position(b)[2]
  end)

  local in_left = vim.api.nvim_get_current_win() == wins[1]
  local put = in_left == to_right

  vim.cmd(put and ".diffput" or ".diffget")
end

vim.keymap.set("n", ">", function()
  diff_copy_line(true)
end, { desc = "Diff: Copy line left to right" })

vim.keymap.set("n", "<", function()
  diff_copy_line(false)
end, { desc = "Diff: Copy line right to left" })

vim.keymap.set("n", "<leader>cf", "<cmd>ShellcheckFix<cr>", {
  desc = "Apply ShellCheck fixes",
})
