return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- LazyVim's Java extra starts jdtls; avoid attaching a second Java server.
        java_language_server = { enabled = false },
      },
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      -- JDTLS requires Java 25; project builds can keep using their own JDK.
      local java = vim.fn.expand("~/.sdkman/candidates/java/25.0.4+1.1-zulu/bin/java")
      if vim.fn.executable(java) == 1 then
        table.insert(opts.cmd, 2, "--java-executable=" .. java)
      else
        vim.notify("JDTLS requires Java 25, but " .. java .. " is unavailable", vim.log.levels.ERROR)
      end
    end,
  },
}
