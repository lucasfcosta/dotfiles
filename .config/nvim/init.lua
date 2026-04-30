-- Keep init.lua tiny: just import well-named Lua modules.
-- This makes your config composable and fast to reason about.

-- Core editor options (numbers, tabs, splits, etc.)
require("config.options")

-- Keybindings for navigation and common actions
require("config.keymaps")

-- Small quality-of-life automation
require("config.autocmds")

-- Plugin manager bootstrap + plugin specifications
require("config.plugins")
