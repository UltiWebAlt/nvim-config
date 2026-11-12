return {
  {
    "geodimm/lint-actions.nvim",
    dependencies = { "mfussenegger/nvim-lint" },
    opts = {
      integrations = {
        nvim_lint = {
          shellcheck = true,
        },
      },
    },
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft.sh = { "shellcheck" }

      require("lint_actions").setup(opts)

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
        pattern = "*.sh",
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
