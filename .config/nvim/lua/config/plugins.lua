-- Ensure paste mode is disabled (can interfere with copilot)
vim.opt.paste = false

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Define your plugins concisely
require("lazy").setup({
  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function() vim.cmd.colorscheme("tokyonight") end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        section_separators = '',
        component_separators = '',
        theme = 'auto',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = {
          {
            'filename',
            path = 1,  -- Shows relative path from current working directory
            shorting_target = 0,  -- Don't shorten the path
          }
        },
        lualine_x = {},  -- Remove encoding, filetype, etc.
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            'filename',
            path = 1,
            shorting_target = 0,
          }
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    }
  },

  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        config = function()
          require("window-picker").setup({
            selection_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              bo = {
                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                buftype = { "terminal", "quickfix" },
              },
            },
          })
        end,
      },
    },
    cmd = "Neotree",
    keys = {
      { "<C-n>", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
    },
    opts = {
      event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            require("neo-tree.command").execute({ action = "close" })
          end
        },
      },
      window = {
        mappings = {
          ["<C-v>"] = "open_vsplit",
          ["<C-x>"] = "open_split",
          ["w"] = "open_with_window_picker",
          -- Unbind '/' (to prevent Neo-tree from hijacking it)
          ["/"] = false,
          -- Rebind filter to 'f'
          ["f"] = "fuzzy_finder",
        },
      },
      filesystem = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
      },
    },
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      -- I use mostly <leader>ff to find files and <leader>fg to find a string
      -- but finding buffers with <leader>fb and reading vim's help with 
      -- <leader>fh are also useful.
      { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
      { "<leader>fg", function() require("telescope.builtin").live_grep() end,  desc = "Live grep" },
      { "<leader>fb", function() require("telescope.builtin").buffers() end,    desc = "Buffers" },
      { "<leader>fh", function() require("telescope.builtin").help_tags() end,  desc = "Help tags" },
    },

    -- Without this, I'd have to leave edit mode whenever I want to select one
    -- of the results in Telescope, which is really annoying.
    -- This allows me to use Ctrl+j and Ctrl+k to move up and down the list
    -- of results without leaving insert mode.
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          file_ignore_patterns = { "^%.git/" },
          mappings = {
            i = {
              -- Move selection up/down with Ctrl+j / Ctrl+k
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
      }
    end,
  },

  -- Treesitter for syntax highlighting and code parsing
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = { "lua", "javascript", "typescript" },
      highlight = { enable = true },
    },
  },

  -- LSP & Mason
  { "neovim/nvim-lspconfig", lazy = true },
  {
    "mason-org/mason.nvim",
    cmd = "Mason", config = true,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig", "mason-org/mason.nvim" },
    opts = { ensure_installed = { "lua_ls", "ts_ls" } },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      -- Buffer-local LSP keymaps when a server attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
          end

          -- Hover & "goto"
          map("n", "K",  vim.lsp.buf.hover,           "LSP: Hover docs")
          map("n", "gd", vim.lsp.buf.definition,      "LSP: Goto definition")
          map("n", "gD", vim.lsp.buf.declaration,     "LSP: Goto declaration")
          map("n", "gr", vim.lsp.buf.references,      "LSP: References")
          map("n", "gI", vim.lsp.buf.implementation,  "LSP: Implementations")
          map("n", "gt", vim.lsp.buf.type_definition, "LSP: Type definition")

          -- Actions & rename
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")
          map("n", "<leader>rn", vim.lsp.buf.rename,               "LSP: Rename")

          -- Diagnostics: float + navigation + loclist
          map("n", "<leader>e", function()
            vim.diagnostic.open_float(nil, { focus = false, scope = "cursor", border = "rounded" })
          end, "Diag: Show details (float)")

          -- Navigating diagnostics
          map("n", "<leader>dp", vim.diagnostic.goto_prev, "Diag: Previous")
          map("n", "<leader>dn", vim.diagnostic.goto_next, "Diag: Next")

          -- Adding all diagnostics to the location list is super useful for
          -- quickly jumping to all issues in the current file and fixing them.
          map("n", "<leader>q", vim.diagnostic.setloclist, "Diag: To location list")
        end,
      })
    end,
  },

  -- Copilot core (auth + suggestions)
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
      suggestion = { 
        enabled = true,
        auto_trigger = true,
        debounce = 500,
        keymap = {
          accept = "<Tab>",
        },
      },
      panel = { enabled = false },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },

  -- Completion via nvim-cmp (this is token-based, not AI-based)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        -- Minimal keymaps (just confirm with <CR>)
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),

        -- These are the sources for completion
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
        },
      })
    end,
  },

  -- Auto-detect indent
  { "tpope/vim-sleuth", event = { "BufReadPost", "BufNewFile" } }
}, {
  ui = { border = "rounded" },
})
