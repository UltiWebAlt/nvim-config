return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-frappe",
    },
  },
}

-- require("catppuccin").setup({
--   flavour = "frappe", -- Specify your flavor (latte, frappe, macchiato, mocha)
--   custom_highlights = function(colors)
--     return {
--       LineNr = { fg = colors.text },
--       CursorLineNr = { fg = colors.blue, bold = true },
--       LineNrAbove = { fg = colors.overlay1 },
--       LineNrBelow = { fg = colors.overlay1 },
--     }
--   end,
-- })
--
-- -- IMPORTANT: This line must come AFTER the setup block above
-- vim.cmd.colorscheme("catppuccin")
