return {
  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle", "UndotreeShow", "UndotreeHide", "UndotreeFocus" },
    init = function()
      -- Persist undo history across sessions
      vim.opt.undofile = true
      vim.opt.undodir = vim.fn.expand("$HOME/.undodir")
      -- Put undo files somewhere sane (cross-platform)

      -- Undotree plugin options (vimscript globals)
      vim.g.undotree_WindowLayout = 2 -- 2 = tree on left, diff on right (common preference)
      vim.g.undotree_SplitWidth = 35
      vim.g.undotree_DiffpanelHeight = 10
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_HelpLine = 0

      -- make the mapping "real" and late (so nothing stomps it)
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          vim.keymap.set("n", "<F5>", "<cmd>UndotreeToggle<CR>", { desc = "UndoTree Toggle" })
        end,
      })
    end,
  },
}
-- return {
--   "mbbill/undotree",
--   -- keys = {
--   --   { "<leader>F5", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" },
--   -- },
--   config = function()
--     vim.o.undodir = os.getenv("HOME") .. "/.undodir"
--     vim.o.undofile = true
--   end,
-- <-- }
