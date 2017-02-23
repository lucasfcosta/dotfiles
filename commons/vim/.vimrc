"""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""

set encoding=utf-8  " The encoding displayed.
set fileencoding=utf-8  " The encoding written to file.
syntax on " Enable syntax highlight

" Set to auto read when a file is changed from the outside
" set autoread

set nocompatible              " be iMproved, required
filetype off                  " required

"""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins List
"""""""""""""""""""""""""""""""""""""""""""""""

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The NERD tree
Plugin 'scrooloose/nerdtree'

" ctrlp.vim
Plugin 'kien/ctrlp.vim'

" colorschemes
Plugin 'chriskempson/base16-vim'

" MOAR COLORSCHEMES
Plugin 'flazz/vim-colorschemes'

" fugitive
Plugin 'tpope/vim-fugitive'

" vim-airline
Plugin 'bling/vim-airline'

" vim-airline-themes
Plugin 'vim-airline/vim-airline-themes'

 " syntastic
 " Plugin 'scrooloose/syntastic'

" identLine
Plugin 'Yggdroot/indentLine'

" syntax highlight for JS (ES6)
Plugin 'othree/yajs.vim'

" JS Syntax/Indent related Plugin (required for JSX highlight)
Plugin 'pangloss/vim-javascript'

" syntax highlight for JSX
" Disabled because it messes up comments in normal JS files
" Bundle 'mxw/vim-jsx'

" .editorconfig
Plugin 'editorconfig/editorconfig-vim'

" emmet
Plugin 'mattn/emmet-vim'

" automatic insertion of matching pairs (for `(`, `[`, etc...)
Plugin 'jiangmiao/auto-pairs'

" surround
Plugin 'tpope/vim-surround'

" dev icons for files
Plugin 'ryanoasis/vim-devicons'

" vim-go
Plugin 'fatih/vim-go'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
" Put your non-Plugin stuff after this line



"""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Related Configs
"""""""""""""""""""""""""""""""""""""""""""""""

" Open NERDTree automatically when vim starts up
" autocmd vimenter * NERDTree
" NERDTree
let NERDTreeShowHidden=1
map <silent> <C-n> :NERDTreeToggle<CR>

" close NERDTree after a file is opened
let g:NERDTreeQuitOnOpen=1

" vim-airline
let g:airline_powerline_fonts=1
let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#enabled=1
set guifont=Meslo\ LG\ S\ Regular\ for\ Powerline:h20

" syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" 
" let g:syntastic_javascript_checkers = ['jshint']
" let g:syntastic_json_checkers = ['jsonlint']

" enable emmet for JSX
let g:user_emmet_jsx = 1

" ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard'] " only show files that are not ignored by git

" enable syntax highlight for JSX on .js files
let g:jsx_ext_required = 0

" indentLine
let g:indentLine_enabled = 1
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_color_term = 239
let g:indentLine_char = '¦'
let g:indentLine_leadingSpaceChar = '⋅'



"""""""""""""""""""""""""""""""""""""""""""""""
" => Filetype Related Configs
"""""""""""""""""""""""""""""""""""""""""""""""

" vim thinks that json is javascript
au BufRead,BufNewFile *.json set filetype=json

" display handlebars templates as html
au BufNewFile,BufRead *.handlebars set filetype=html



"""""""""""""""""""""""""""""""""""""""""""""""
" => Visual Related Configs
"""""""""""""""""""""""""""""""""""""""""""""""

" molokai
colorscheme bubblegum
let g:molokai_original = 1
let g:rehash256 = 1

" maintain terminal background
hi Normal ctermbg=none

" background and theme
set background=dark

" long lines as just one line (have to scroll horizontally)
set nowrap

" 256 colors
set t_Co=256

" line numbers
set relativenumber
set number

" show the status line all the time
set laststatus=2

" toggle invisible characters
set invlist
set list
set listchars=tab:¦\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
highlight SpecialKey ctermbg=none guifg=darkgray" make the highlighting of tabs less annoying
hi NonText ctermfg=7 guifg=darkgray



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

" toggle paste mode with F2
set pastetoggle=<F2>

" swapfiles location
set backupdir=/tmp//
set directory=/tmp//

" make backspace work like most other apps
set backspace=2 

" stop comments auto indentation
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o



"""""""""""""""""""""""""""""""""""""""""""""""
" => Indentation
"""""""""""""""""""""""""""""""""""""""""""""""

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set ai "Auto indent
set si "Smart indent
