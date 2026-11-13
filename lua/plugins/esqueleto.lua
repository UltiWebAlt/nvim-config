return {
  {
    "cvigilv/esqueleto.nvim",
    lazy = false,
    event = { "BufNewFile", "BufReadPost" },
    opts = {
      -- Directory where your templates are stored
      directories = { vim.fn.stdpath("config") .. "/skeletons" },
      autouse = true,
      wildcards = {
        expand = true,
        lookup = {
          -- Optional custom wildcard if you don't want to use built-in ${gh-user}
          ["author"] = function()
            return "Randall Burgess"
          end,
          ["mdY"] = function()
            return os.date("%-m/%-d/%Y")
          end,
        },
      },

      -- Filetypes or exact filenames that trigger template insertion
      patterns = { "python", "lua", "sh", "zsh", "LICENSE" },

      -- Automatically insert if only one template exists for the pattern
    },
  },
}
