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
