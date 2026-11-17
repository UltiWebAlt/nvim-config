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
      lint.linters_by_ft.zsh = { "zsh" }

      require("lint_actions").setup(opts)

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
        pattern = "*.sh",
        "*.zsh",
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
