-- Set <Space> as leader early so further mappings and plugins read it correctly
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Show absolute line numbers and relative ones for quick motions
vim.opt.number = true
vim.opt.relativenumber = true

-- Convert tabs to spaces and keep common 4-space indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Real hackers don't need a mouse :)
vim.opt.mouse = nil

-- Share system clipboard with Neovim
vim.opt.clipboard = "unnamedplus"

-- Case-insensitive search unless pattern contains capitals
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Improve UI responsiveness for LSP and diagnostics
-- This setting controls how long Neovim waits before triggering updates
-- after you stop typing.
vim.opt.updatetime = 500

-- Always keep 8 lines visible above/below the cursor
-- This helps with scrolling and context awareness
vim.opt.scrolloff = 8

-- Always show the sign column so layout doesn’t shift
vim.opt.signcolumn = "yes"
