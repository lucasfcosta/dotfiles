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

" nord-vim colorscheme
Plug 'arcticicestudio/nord-vim'

" neomake
Plug 'neomake/neomake'

" JavaScript Highlight & Improved Indentation
Plug 'pangloss/vim-javascript'

" Typescript Syntax Highlight
Plug 'leafgarland/typescript-vim'

" rust support
Plug 'rust-lang/rust.vim'

" NERDTree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Async FuzzyFind
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" .editorconfig
Plug 'editorconfig/editorconfig-vim'

" emmet
Plug 'mattn/emmet-vim'

" semantic-based completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" GraphQL Syntax Highlight
Plug 'jparise/vim-graphql'

" linting engine
Plug 'w0rp/ale'

" golang
Plug 'fatih/vim-go'

" go debug
Plug 'sebdah/vim-delve'


call plug#end()



"""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Related Configs
"""""""""""""""""""""""""""""""""""""""""""""""

" Neomake async hooks
call neomake#configure#automake('w')

" Open NERDTree automatically when vim starts up
" autocmd vimenter * NERDTree
" NERDTree
let NERDTreeShowHidden=1
map <silent> <C-n> :NERDTreeToggle<CR>

" close NERDTree after a file is opened
let g:NERDTreeQuitOnOpen=1

" enable highlight for JSDocs
let g:javascript_plugin_jsdoc = 1

" fix files on save
let g:ale_fix_on_save = 1

" lint after 1000ms after changes are made both on insert mode and normal mode
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 1000

" use emojis for errors and warnings
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'

" fixer configurations
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'typescript': ['prettier', 'deno'],
\   'rust': ['rustfmt'],
\   'go': ['gofmt', 'goimports'],
\}

" allow turning off fixers
function! s:fckALEToggle(...)
    let s:fckALEStatus = {}
    let s:fckALEStatus['global'] = get(g:, 'ale_fix_on_save', 0)
    let s:fckALEStatus['buffer'] = get(b:, 'ale_fix_on_save', s:fckALEStatus['global'])
    let s:fckCurrentScope = get(a:, 1, 'global')
    if (s:fckALEStatus[s:fckCurrentScope] == 1)
        let s:fckALEStatus[s:fckCurrentScope]=0
    else
        let s:fckALEStatus[s:fckCurrentScope]=1
    endif
    let g:ale_fix_on_save=s:fckALEStatus['global']
    let b:ale_fix_on_save=s:fckALEStatus['buffer']
endfunction

command! ALEDisableFixers       let g:ale_fix_on_save=0
command! ALEEnableFixers        let g:ale_fix_on_save=1
command! ALEDisableFixersBuffer let b:ale_fix_on_save=0
command! ALEEnableFixersBuffer  let b:ale_fix_on_save=0
command! ALEToggleFixers call functions#fckALEToggle('global')
command! ALEToggleFixersBuffer call functions#fckALEToggle('buffer')

"linters for rust
let g:ale_linters = {
\   'rust': ['rls'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint', 'deno']
\}

autocmd BufReadPost *.rs setlocal filetype=rust
let g:ale_rust_rls_config = {'rust': {'clippy_preference': 'on'}}
let g:ale_rust_rls_toolchain = 'stable'
let g:rustfmt_autosave = 1

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

"enable gopls lang server
let g:go_gopls_enabled = 1
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'


"""""""""""""""""""""""""""""""""""""""""""""""
" => Visual Related Configs
"""""""""""""""""""""""""""""""""""""""""""""""

" 256 colors
set t_Co=256

" set colorscheme
colorscheme nord

" long lines as just one line (have to scroll horizontally)
set nowrap

" line numbers
set relativenumber
set number

" show the status line all the time
set laststatus=2

" toggle invisible characters
set invlist
set list
set listchars=tab:¦\ ,eol:¬,trail:⋅,extends:❯,precedes:❮

" disable scrollbars (real hackers don't use scrollbars)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L



"""""""""""""""""""""""""""""""""""""""""""""""
" => Keymappings
"""""""""""""""""""""""""""""""""""""""""""""""

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

" map fzf to ctrl+p
nnoremap <C-P> :Files<CR>



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

" Auto indent
" Copy the indentation from the previous line when starting a new line
set ai

" Smart indent
" Automatically inserts one extra level of indentation in some cases, and works for C-like files
set si


"""""""""""""""""""""""""""""""""""""""""""""""
" => Auto-completion (CoC.nvim)
"""""""""""""""""""""""""""""""""""""""""""""""

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

let g:coc_global_extensions = [
\ 'coc-emoji', 'coc-eslint', 'coc-prettier', 'coc-deno',
\ 'coc-tsserver', 'coc-tslint', 'coc-tslint-plugin',
\ 'coc-css', 'coc-json', 'coc-rls', 'coc-yaml', 'coc-rust-analyzer'
\ ]

" Use `lj` and `lk` for navigate diagnostics
nmap <silent> <leader>lj <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>lk <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <C-f> <Plug>(coc-refactor)

" Map <c-space> to trigger completion and cycle through it
inoremap <silent><expr> <c-space> coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <c-space>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<c-space>" :
    \ coc#refresh()


" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""
" => Utils (a.k.a. mess I can't categorize)
"""""""""""""""""""""""""""""""""""""""""""""""
