return {
  {
    "scalameta/nvim-metals",
    ft = function()
      return { "scala", "sbt" }
    end,
  },
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

      opts.root_dir = function(path)
        if path == "" then
          return nil
        end

        local home = vim.uv.os_homedir()
        local root = vim.fs.root(path, {
          { "mvnw", "gradlew", "settings.gradle", "settings.gradle.kts" },
          { "pom.xml", "build.gradle", "build.gradle.kts", "build.xml", ".project", ".classpath" },
        })
        if root and root ~= home then
          return root
        end

        local git_root = vim.fs.root(path, ".git")
        if git_root and git_root ~= home then
          return git_root
        end

        return vim.fs.dirname(path)
      end

      -- Different projects can share a directory name. Key the cache by the full root.
      opts.project_name = function(root)
        return root and (vim.fs.basename(root) .. "-" .. vim.fn.sha256(root):sub(1, 12))
      end

      -- nvim-dap can discover main classes when debugging actually starts.
      opts.dap_main = false
    end,
  },
}
