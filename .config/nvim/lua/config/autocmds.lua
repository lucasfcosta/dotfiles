-- Create small helpers for augroup/autocmd
local aug = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

-- Group UI related events for cleanliness
local ui = aug("UI", { clear = true })

-- Trim trailing whitespace on save (quietly)
au("BufWritePre", {
  group = ui,
  pattern = "*",
  command = ":%s/\\s\\+$//e",
})

-- Auto-adjust split sizes when Vim window is resized
-- This is very helpful when redimensioning tmux panes
au("VimResized", {
  group = ui,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Auto-reload colorscheme when theme file changes
local theme_helper = require("config.theme")
local last_theme = nil

local function check_theme()
  local theme = theme_helper.read_theme()

  if theme ~= last_theme then
    last_theme = theme
    pcall(function()
      theme_helper.apply_theme(theme)
    end)
  end
end

-- Check theme on these events
au({ "FocusGained", "BufEnter" }, {
  group = ui,
  callback = check_theme,
})

-- Also check theme periodically (every 1 second)
local timer = vim.loop.new_timer()
timer:start(1000, 1000, vim.schedule_wrap(check_theme))
