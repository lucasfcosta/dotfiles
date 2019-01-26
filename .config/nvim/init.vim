"""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""

set encoding=utf-8  " The encoding displayed.
set fileencoding=utf-8  " The encoding written to file.
syntax on " Enable syntax highlight



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

" Async execution library needed by tsuquyomi
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" A client to TSSServer so that we can get autocompletion
Plug 'Quramy/tsuquyomi'

" rust support
Plug 'rust-lang/rust.vim'

" NERDTree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" ctrlp.vim
Plug 'kien/ctrlp.vim'

" .editorconfig
Plug 'editorconfig/editorconfig-vim'

" emmet
Plug 'mattn/emmet-vim'

" syntastic
Plug 'vim-syntastic/syntastic'

" OmniCompletion
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }


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

" ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard'] " only show files that are not ignored by git

" syntastic eslint checks
let g:neomake_javascript_enabled_makers=['eslint']" 

" enable highlight for JSDocs
let g:javascript_plugin_jsdoc = 1



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

" show autocomplete suggestions only when typing more than 2 characters
let g:ycm_min_num_of_chars_for_completion = 2

" show at most 20 completion candidates at a time (more than this would be
" ridiculous, you'd press TAB so many times it would be better to simply type
" the entire thing lol)
" this applies only to the semantic-based engine
let g:ycm_max_num_candidates = 20

" this is the same as above, but only for the identifier-based engine
let g:ycm_max_num_identifier_candidates = 10

" blacklist of filetypes in which autocomplete should be disabled
let g:ycm_filetype_blacklist = {
      \ 'tagbar': 1,
      \ 'qf': 1,
      \ 'notes': 1,
      \ 'markdown': 1,
      \ 'unite': 1,
      \ 'text': 1,
      \ 'vimwiki': 1,
      \ 'pandoc': 1,
      \ 'infolog': 1,
      \ 'mail': 1
      \}

" blacklist of filepaths in which autocomplete should be disabled
let g:ycm_filepath_blacklist = {
      \ 'html': 1,
      \ 'jsx': 1,
      \ 'xml': 1,
      \}



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
" => Utils (a.k.a. mess I can't categorize)
"""""""""""""""""""""""""""""""""""""""""""""""

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null
