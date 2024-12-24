local state = {
  floating = {
    buf = 0,
    win = -1,
  }
}

local function make_floating_window(opts) 
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- buf position
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = vim.api.nvim_create_buf(false, true) -- no file, scratch buffer

  --window options
  local winConfig = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded"
  }

  local win = vim.api.nvim_open_win(buf, true, winConfig)

  return { buf = buf, win = win }
end

state.floating = make_floating_window()
