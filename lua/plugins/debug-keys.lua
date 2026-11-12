return {
  {
    "mfussenegger/nvim-dap",
    opts = function()
      vim.fn.sign_define("DapStopped", {
        text = "▶",
        texthl = "DiagnosticWarn",
        linehl = "DapStoppedLine",
      })
      vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#514400" })
      vim.opt.signcolumn = "yes"
    end,
    keys = {
      {
        "<F8>",
        function()
          require("dap").step_over()
        end,
        desc = "Debug: Step Over",
      },
      {
        "<F7>",
        function()
          require("dap").step_into()
        end,
        desc = "Debug: Step Into",
      },
      {
        "<S-F8>",
        function()
          require("dap").step_out()
        end,
        desc = "Debug: Step Out",
      },
      {
        "<F9>",
        function()
          require("dap").continue()
        end,
        desc = "Debug: Resume",
      },
      {
        "<S-F9>",
        function()
          require("dap").continue()
        end,
        desc = "Debug: Start",
      },
      {
        "<C-F8>",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Debug: Toggle Breakpoint",
      },
      {
        "<A-F9>",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Debug: Run to Cursor",
      },
      {
        "<S-F2>",
        function()
          require("dap").terminate()
        end,
        desc = "Debug: Stop",
      },
      {
        "<A-F8>",
        function()
          require("dapui").eval()
        end,
        desc = "Debug: Evaluate Expression",
        mode = { "n", "v" },
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    init = function()
      require("config.dap_tooltips").setup()
    end,
    opts = {
      layouts = {
        {
          position = "left",
          size = 0.35, -- 35% of terminal width
          elements = {
            { id = "scopes", size = 0.40 },
            { id = "watches", size = 0.30 },
            { id = "stacks", size = 0.20 },
            { id = "breakpoints", size = 0.10 },
          },
        },
        {
          position = "bottom",
          size = 0.35, -- 35% of terminal height
          elements = {
            { id = "repl", size = 0.25 },
            { id = "console", size = 0.75 },
          },
        },
      },

      controls = {
        enabled = true,
        element = "console", -- Move debugger toolbar here
      },
    },
  },
}
