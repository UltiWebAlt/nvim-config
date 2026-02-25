return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },

              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                  vim.fn.stdpath("config") .. "/lua",
                  vim.fn.stdpath("data") .. "/lazy",
                },
              },

              telemetry = { enable = false },
            },
          },
        },
      },
    },
  },
}
