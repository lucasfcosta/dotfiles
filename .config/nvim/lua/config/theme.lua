-- Shared theme management logic

local M = {}

-- Read current theme from state file
function M.read_theme()
  local theme_state_file = vim.fn.expand("~/.config/theme-mode")
  local f = io.open(theme_state_file, "r")

  if not f then
    return "dark"
  end

  local theme = f:read("*all") or "dark"
  f:close()

  return theme:gsub("^%s*(.-)%s*$", "%1")
end

-- Apply theme to Neovim
function M.apply_theme(theme)
  if theme == "dark" then
    vim.opt.background = "dark"
    vim.cmd.colorscheme("tokyonight-moon")
  else
    vim.opt.background = "light"
    vim.cmd.colorscheme("catppuccin-latte")
  end
end

return M
