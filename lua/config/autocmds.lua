-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_user_command("ShellcheckFix", function()
  if vim.bo.filetype ~= "sh" then
    vim.notify("Not a shell script", vim.log.levels.WARN)
    return
  end

  vim.cmd("write")

  local file = vim.api.nvim_buf_get_name(0)
  local dir = vim.fn.fnamemodify(file, ":h")
  local name = vim.fn.fnamemodify(file, ":t")

  local result = vim.system({ "shellcheck", "--format=diff", name }, { cwd = dir, text = true }):wait()

  if result.code == 2 or result.code == 3 then
    vim.notify(result.stderr, vim.log.levels.ERROR)
    return
  end

  if result.stdout == "" then
    vim.notify("No automatic fixes available")
    return
  end

  local patch = vim
    .system({ "patch", "-p1", "--batch", "--forward" }, { cwd = dir, stdin = result.stdout, text = true })
    :wait()

  if patch.code ~= 0 then
    vim.notify(patch.stderr, vim.log.levels.ERROR)
    return
  end

  vim.cmd("edit!")
  vim.notify("ShellCheck fixes applied")
end, {})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("AutoChmodShebang", { clear = true }),
  callback = function(args)
    local first_line = vim.api.nvim_buf_get_lines(args.buf, 0, 1, false)[1]
    if first_line and first_line:match("^#!") then
      local file = vim.api.nvim_buf_get_name(args.buf)
      local stat = vim.uv.fs_stat(file)
      if stat and (stat.mode % 512) ~= 484 then -- skip if already 0744
        -- Add execute bits (0111 = 73 in decimal) to existing permissions
        vim.uv.fs_chmod(file, 484)
      end
    end
  end,
})
