-- Shorthand fn and opts obj to define silent, non-recursive mappings
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Disable arrow keys in normal, insert, and visual modes
-- This encourages the use of hjkl for movement and improves muscle memory

-- Normal mode
map("n", "<Up>",    "<nop>", opts)
map("n", "<Down>",  "<nop>", opts)
map("n", "<Left>",  "<nop>", opts)
map("n", "<Right>", "<nop>", opts)

-- Insert mode
map("i", "<Up>",    "<nop>", opts)
map("i", "<Down>",  "<nop>", opts)
map("i", "<Left>",  "<nop>", opts)
map("i", "<Right>", "<nop>", opts)

-- Visual mode
map("v", "<Up>",    "<nop>", opts)
map("v", "<Down>",  "<nop>", opts)
map("v", "<Left>",  "<nop>", opts)
map("v", "<Right>", "<nop>", opts)

-- Navigate through quickfix more quickly
map("n", "<leader>qn", "<cmd>cnext<CR>", { desc = "Quickfix next" })
map("n", "<leader>qp", "<cmd>cprev<CR>", { desc = "Quickfix prev" })
