local M = {}

M.setup = function()
end

local function make_floating_window(opts)
  opts = opts or {}
  local width = opts.width or vim.o.columns
  local height = opts.height or vim.o.lines

  -- buf position
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  --
  --window options
  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = { " ", " ", " ", " ", " ", " ", " ", " ", }
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

---@class present.Slides
---@fields slides present.Slide[]: the slides of a file

---@class present.Slide
---@field title string
---@field body string

---@params lines string[]
---@return present.Slides
local parse_slides = function(lines)
  local slides = { slides = {} }
  local current_slide = {
    title = "",
    body = {}
  }

  local separator = "^#"
  for _, line in ipairs(lines) do
    if line:find(separator) then
      if #current_slide.title > 0 then
        table.insert(slides.slides, current_slide)
      end

      current_slide = {
        title = line,
        body = {}
      }
    else
      table.insert(current_slide.body, line)
    end
  end
  table.insert(slides.slides, current_slide)

  return slides
end


M.start_presentation = function(opts)
  opts = opts or {}
  opts.bufnr = opts.bufnr or 0
  local lines = vim.api.nvim_buf_get_lines(opts.bufnr, 0, -1, false)
  local parsed = parse_slides(lines)

  ---@type vim.api.keyset.win_config[]
  local width = vim.o.columns
  local height = vim.o.lines

  local windows = {
    header = {
      relative = "editor",
      width = width,
      height = 1,
      style = "minimal",
      col = 1,
      row = 1,
    },
    body = {
      relative = "editor",
      width = width,
      height = height - 1,
      border = { " ", " ", " ", " ", " ", " ", " ", " ", },
    },
  }

  local float = make_floating_window()

  local display_content = function(current_slide)
    vim.api.nvim_buf_set_lines(float.buf, 0, -1, false, parsed.slides[current_slide].body)
  end
  local display_title = function(current_slide)
    vim.api.nvim_buf_set_lines(float.buf, 0, -1, false, parsed.slides[current_slide].title)
  end

  local current_slide = 1
  vim.keymap.set("n", 'n', function()
    current_slide = math.min(current_slide + 1, #parsed.slides)
    display_content(current_slide)
  end, { buffer = float.buf })

  vim.keymap.set("n", 'p', function()
    current_slide = math.max(current_slide - 1, 1)
    display_content(current_slide)
  end, { buffer = float.buf })

  vim.keymap.set('n', 'q', function()
    vim.api.nvim_win_close(float.win, true)
  end, { buffer = float.buf })

  local restore = {
    cmdheight = {
      original = vim.o.cmdheight,
      present = 0
    }
  }

  for option, config in pairs(restore) do
    vim.opt[option] = config.present
  end

  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = float.buf,
    callback = function()
      for option, config in pairs(restore) do
        vim.opt[option] = config.restore
      end
    end
  })

  display_content(current_slide)
end

return M
