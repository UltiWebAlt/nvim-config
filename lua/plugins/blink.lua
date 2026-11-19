return {
  "saghen/blink.cmp",
  opts = {
    cmdline = {
      keymap = {
        ["<C-space>"] = {
          function(cmp)
            if vim.fn.getcmdtype() == ":" then
              return cmp.select_and_accept()
            end
          end,
          "show",
          "fallback",
        },
      },
    },
    completion = {
      menu = { direction_priority = { "n", "s" } },
      ghost_text = { enabled = false },
    },
  },
}
