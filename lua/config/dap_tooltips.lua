local M = {}

local actions = {
  'Start / Continue',
  'Step Into (F7)',
  'Step Over (F8)',
  'Step Out (Shift-F8)',
  'Step Back',
  'Run Last',
  'Stop (Shift-F2)',
  'Disconnect',
}

local timer
local tooltip_buf
local tooltip_win
local pending_action
local original_mousemoveevent

local function close_tooltip()
  local win = tooltip_win
  tooltip_win = nil
  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
  end
end

local function hovered_action(pos)
  if not pos or pos.winid == 0 or not vim.api.nvim_win_is_valid(pos.winid) then
    return nil
  end

  local winbar = vim.wo[pos.winid].winbar
  if not winbar:find('v:lua._dapui.step_over', 1, true) then
    return nil
  end

  local info = vim.fn.getwininfo(pos.winid)[1]
  if not info or info.winbar ~= 1 or pos.screenrow ~= info.winrow then
    return nil
  end

  -- nvim-dap-ui renders each control as two spaces followed by one icon.
  local column = pos.screencol - info.wincol + 1
  local index = math.ceil(column / 3)
  if column < 1 or column > #actions * 3 then
    return nil
  end

  if index == 1 then
    local session = package.loaded.dap and require('dap').session()
    if session and not session.stopped_thread_id then
      return 'Pause'
    end
  end
  return actions[index]
end

local function show_tooltip(label, pos)
  if not tooltip_buf or not vim.api.nvim_buf_is_valid(tooltip_buf) then
    tooltip_buf = vim.api.nvim_create_buf(false, true)
  end
  vim.api.nvim_buf_set_lines(tooltip_buf, 0, -1, false, { label })

  close_tooltip()
  tooltip_win = vim.api.nvim_open_win(tooltip_buf, false, {
    relative = 'editor',
    row = math.max(0, math.min(pos.screenrow, vim.o.lines - 3)),
    col = math.max(0, math.min(pos.screencol - 1, vim.o.columns - vim.fn.strdisplaywidth(label) - 3)),
    width = vim.fn.strdisplaywidth(label),
    height = 1,
    border = 'rounded',
    style = 'minimal',
    focusable = false,
    mouse = false,
    zindex = 100,
  })
end

local function on_mouse_move()
  local pos = vim.fn.getmousepos()
  local label = hovered_action(pos)
  if label == pending_action and tooltip_win and vim.api.nvim_win_is_valid(tooltip_win) then
    return
  end

  timer:stop()
  close_tooltip()
  pending_action = label
  if not label then
    return
  end

  timer:start(350, 0, vim.schedule_wrap(function()
    if hovered_action(vim.fn.getmousepos()) == label then
      show_tooltip(label, vim.fn.getmousepos())
    end
  end))
end

local function refresh_mouse_tracking()
  local toolbar_visible = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.wo[win].winbar:find('v:lua._dapui.step_over', 1, true) then
      toolbar_visible = true
      break
    end
  end

  vim.o.mousemoveevent = original_mousemoveevent or toolbar_visible
  if not toolbar_visible then
    timer:stop()
    pending_action = nil
    close_tooltip()
  end
end

function M.setup()
  if timer then return end
  timer = vim.uv.new_timer()
  original_mousemoveevent = vim.o.mousemoveevent
  vim.keymap.set('n', '<MouseMove>', on_mouse_move, { silent = true, desc = 'Debug toolbar tooltip' })
  local group = vim.api.nvim_create_augroup('DapTooltipMouse', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufWinLeave', 'WinEnter', 'WinClosed' }, {
    group = group,
    callback = function() vim.schedule(refresh_mouse_tracking) end,
  })
  vim.schedule(refresh_mouse_tracking)
end

M.hovered_action = hovered_action
M.refresh_mouse_tracking = refresh_mouse_tracking
return M
