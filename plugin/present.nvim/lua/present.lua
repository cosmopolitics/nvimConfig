local M = {}

M.setup = function()
  -- nothing
end

local function make_floating_window(opts) 
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- buf position
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf( false, true )
  end


  --window options
  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded"
  }

  local win = vim.api.nvim_open_win( buf, true, win_config )

  return { buf = buf, win = win }
end

---@class present.Slides
---@fields slides string[]: the slides of a file

---@params lines string[]
---@return present.Slides
local parse_slides = function(lines)
  local slides = { slides = {} }
  local current_slide = {}

  local separator = "^#"
  for _, line in ipairs(lines) do
    print(line, "find:", line:find(separator), "|")
    if line:find(separator) then
      if #current_slide > 0 then
        table.insert(slides.slides, current_slide)
      end

      current_slide = {}
    end

    table.insert(current_slide, line)
  end
  table.insert(slides.slides, current_slide)

  return slides
end

M.start_presentation = function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local parsed = parse_slides(lines)
  local float = make_floating_window()

  vim.api.nvim_buf_set_lines()
end

--vim.print( parse_slides {
--  "# hello",
--  "this is something else",
--  "# world",
--  "thing is another thing",
--})

return M
