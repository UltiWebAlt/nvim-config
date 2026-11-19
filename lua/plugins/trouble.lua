return {
  "folke/trouble.nvim",
  opts = {
    modes = {
      lsp = {
        win = { size = 42 },
        auto_preview = false,
      },
      lsp_type_definitions = { source = "local_type_definitions" },
    },
  },
  config = function(_, opts)
    require("trouble.sources").register("local_type_definitions", {
      get = function(callback, context)
        -- JDTLS can omit both result and error for a type-definition lookup.
        if #vim.lsp.get_clients({ bufnr = context.main.buf, name = "jdtls" }) > 0 then
          return callback({})
        end
        local get_type_definitions = require("trouble.sources").get("lsp.type_definitions")
        return get_type_definitions(callback, context)
      end,
    })
    require("trouble").setup(opts)
  end,
}
