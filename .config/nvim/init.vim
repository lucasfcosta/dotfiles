"""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""

set encoding=utf-8          " The encoding displayed
set fileencoding=utf-8      " The encoding written to file
syntax on                   " Enable syntax highlight
set ttyfast                 " Faster redrawing
set lazyredraw              " Only redraw when necessary
set cursorline              " Find the current line quickly.



"""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins List
"""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin()

" catpuccin colorscheme
Plug 'catppuccin/nvim', {'as': 'catppuccin'}

" file-tree explorer
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'

" .editorconfig (can this use native LSP? - check)
Plug 'editorconfig/editorconfig-vim'

" emmet
Plug 'mattn/emmet-vim'

" LSP support (see :help lsp)
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

" Auto-complete for LSP
Plug 'hrsh7th/nvim-cmp'

" LSP source for the auto-complete
Plug 'hrsh7th/cmp-nvim-lsp'

" Allows auto-complete within the buffer
Plug 'hrsh7th/cmp-buffer'

" Allows auto-complete for filesystem paths
Plug 'hrsh7th/cmp-path'

" Allows auto-complete for vim (LUA) configs
Plug 'hrsh7th/cmp-nvim-lua'

" Snippet engine to allow for expansions
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Extra LSP sources (I use it for prettier)
" plenary is a dep for null-ls (and telescope)
Plug 'nvim-lua/plenary.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'

" File finder
Plug 'nvim-telescope/telescope.nvim'

" Make telescope faster by adding native FZF sorter
" https://github.com/nvim-telescope/telescope-fzf-native.nvim/issues/23#issuecomment-1174097943
Plug 'lucasfcosta/telescope-fzf-native.nvim', { 'do': 'make' }

" Enable live-grep capabilities on Telescope
Plug 'BurntSushi/ripgrep'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Related Configs
"""""""""""""""""""""""""""""""""""""""""""""""

" NvimTree
map <silent> <C-n> :NvimTreeToggle<CR>

lua << EOF
require("nvim-tree").setup {
    actions = {
        open_file = {
            quit_on_open = true,
        }
    }
}
EOF

" make FZF respect gitignore if `ag` is installed
if (executable('ag'))
    let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
endif

" make emmet behave well with JSX in JS and TS files
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\  'typescript' : {
\      'extends' : 'tsx',
\  },
\}



"""""""""""""""""""""""""""""""""""""""""""""""
" => Native Visual Related Configs
"""""""""""""""""""""""""""""""""""""""""""""""

" 256 colors
set t_Co=256

" long lines as just one line (have to scroll horizontally)
set nowrap

" line numbers
set relativenumber
set number

" show the status line all the time
set laststatus=2

" toggle invisible characters
set list
set listchars=tab:¦\ ,eol:¬,trail:⋅,extends:❯,precedes:❮

" disable scrollbars (real hackers don't use scrollbars)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" More space for displaying for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns (an extra column for err/warnings)
set signcolumn=yes

" show max width as 80 spaces
set colorcolumn=80


"""""""""""""""""""""""""""""""""""""""""""""""
" => Theming comings
"""""""""""""""""""""""""""""""""""""""""""""""

lua << EOF
local catppuccin = require("catppuccin")

-- configure it
catppuccin.setup {
    integrations = {
        treesitter = false,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = "italic",
                hints = "italic",
                warnings = "italic",
                information = "italic",
            },
            underlines = {
                errors = "underline",
                hints = "underline",
                warnings = "underline",
                information = "underline",
            },
        },
        cmp = true,
        gitsigns = true,
        telescope = true,
        nvimtree = {
            enabled = true,
            show_root = true,
            transparent_panel = false,
        },
        indent_blankline = {
            enabled = false,
            colored_indent_levels = false,
        },
        dashboard = false,
        neogit = false,
        bufferline = false,
        markdown = true,
        lightspeed = false,
        ts_rainbow = false,
        hop = false,
        notify = false,
        telekasten = false,
        symbols_outline = false,
    }
}
EOF

" set colorscheme
let g:catppuccin_flavour = "frappe" " latte, frappe, macchiato, mocha
colorscheme catppuccin


"""""""""""""""""""""""""""""""""""""""""""""""
" => General Key Mappings
"""""""""""""""""""""""""""""""""""""""""""""""

" map leaderkey to space (for namespacing user-land commands)
let mapleader=" "

" dont use arrowkeys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" really, just dont
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>
inoremap <Left>  <NOP>
inoremap <Right> <NOP>

" copy and paste to/from vIM and the clipboard
nnoremap <C-y> +y
vnoremap <C-y> +y
nnoremap <C-p> +P
vnoremap <C-p> +P

" access system clipboard
set clipboard=unnamed

" swapfiles location
set backupdir=/tmp//
set directory=/tmp//


"""""""""""""""""""""""""""""""""""""""""""""""
" => File finder (Telescope)
"""""""""""""""""""""""""""""""""""""""""""""""

lua << EOF
local telescope = require('telescope')
telescope.setup {
  extensions = {
    fzf = {}
  }
}
telescope.load_extension('fzf')
EOF

" map Telescope to ctrl+p
nnoremap <C-P> <cmd>Telescope live_grep hidden=true<cr>


"""""""""""""""""""""""""""""""""""""""""""""""
" => Indentation
"""""""""""""""""""""""""""""""""""""""""""""""

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
" :help smarttab
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Auto indent
" Copy the indentation from the previous line when starting a new line
set ai

" Smart indent
" Automatically inserts one extra level of indentation in some cases, and works for C-like files
set si

" search as I type
set incsearch

" scroll 8 rows before I reach bottom
set scrolloff=8



"""""""""""""""""""""""""""""""""""""""""""""""
" => LSP-related configs
"""""""""""""""""""""""""""""""""""""""""""""""

" When to trigger completion on insert mode (see :help completeopt)
set completeopt=menu,menuone

lua << EOF
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>xx', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>lk', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<leader>lj', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)

  -- If there's a formatter available, use it on save
  if client.server_capabilities.documentFormattingProvider then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end
end

-- Setup nvim-cmp for auto-completion.
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            buffer = "[Buffer]",
            path = "[Path]",
            nvim_lua = "[NVIM LUA]",
          })[entry.source.name]
          return vim_item
      end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'nvim_lua' },
  })
})

local capabilities = require('cmp_nvim_lsp')
  .update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- Setup server configs
language_servers = {
    'tsserver', 'html', 'cssls', 'marksman', 'dockerls', 'yamlls', 'eslint',
    'rust_analyzer', 'jsonls', 'sumneko_lua', 'gopls', 'terraformls', 'vimls'
}

-- Automatically install and configure each of the servers listed below
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.setup({
    automatic_installation = true,
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

for i, ls in ipairs(language_servers) do
    local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
    }

    if ls == "tsserver" then
        -- Disable auto-formatting for TSServer only so I can use prettier
        -- (unless I use <leader>fm)
        local tsserver_opts = {
            on_attach = function(client, bufnr)
                client.resolved_capabilities.document_formatting = false -- Valid for nvim <= 0.7
                client.server_capabilities.documentFormattingProvider = false  -- Valid for nvim >= 0.8
                vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
                on_attach(client, bufnr)
            end,
        }
        opts = vim.tbl_deep_extend("keep", tsserver_opts, opts)
    end

    require('lspconfig')[ls].setup(opts)
end


-- Prettier LSP
null_ls = require('null-ls');
null_ls.setup({
    sources = { null_ls.builtins.formatting.prettier },
    on_attach = on_attach
})

-- Configurations for diagnostics
local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
    virtual_text = false,
    signs = { active = signs },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    }
}

vim.diagnostic.config(config)

-- Auto diagnostics on hover
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

-- Change border of signature help info
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

EOF

" let g:coc_global_extensions = [
" \ 'coc-emoji', 'coc-eslint', 'coc-prettier',
" \ 'coc-tsserver', 'coc-tslint-plugin', 'coc-css',
" \ 'coc-json', 'coc-rls', 'coc-yaml', 'coc-rust-analyzer'
" \ ]

" Function to trim whitespace
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" Automatically call a few functions when saving files
augroup lucasfcosta
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
    " automatically format files on save
    "autocmd BufWrite * :call CocAction('format')
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""
" => Utils (a.k.a. mess I can't categorize)
"""""""""""""""""""""""""""""""""""""""""""""""
