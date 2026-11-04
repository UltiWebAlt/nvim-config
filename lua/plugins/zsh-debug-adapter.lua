local adapter_dir = vim.fn.expand("~/Projects/Linux/vscode-zsh-debug")

return {
  {
    "rogalmic/vscode-zsh-debug",
    dir = adapter_dir,
    build = "npm ci --ignore-scripts && npm run compile",
    lazy = true,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = { "rogalmic/vscode-zsh-debug" },

    opts = function()
      local dap = require("dap")

      dap.adapters.zshdb = {
        type = "executable",
        command = "node",
        args = { adapter_dir .. "/out/zshDebug.js" },
      }

      local config = {
        type = "zshdb",
        request = "launch",
        name = "Zsh: current file",
        program = "${file}",
        cwd = "${workspaceFolder}",
        pathZsh = "/usr/bin/zsh",
        pathZshdb = adapter_dir .. "/zshdb_dir/zshdb",
        pathZshdbLib = adapter_dir .. "/zshdb_dir",
        pathCat = "/usr/bin/cat",
        pathMkfifo = "/usr/bin/mkfifo",
        pathPkill = "/usr/bin/pkill",
        terminalKind = "integrated",
        args = {},
      }

      dap.configurations.zsh = { config }
    end,
  },
}
