autocmd VimEnter * language en_US.utf8

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The NERD tree
Plugin 'scrooloose/nerdtree'

" ctrlp.vim
Plugin 'kien/ctrlp.vim'

" Go vim
Plugin 'fatih/vim-go'

" colorschemes
Plugin 'chriskempson/base16-vim'

" fugitive
Plugin 'tpope/vim-fugitive'

" vim-airline
Plugin 'bling/vim-airline'

" syntastic
Plugin 'scrooloose/syntastic'

" vim-clojure-highlight
Plugin 'guns/vim-clojure-highlight'

" identLine
Plugin 'Yggdroot/indentLine'

" syntax highlight for JS (ES6)
Plugin 'othree/yajs.vim'

" JS Syntax/Indent related Plugin (required for JSX highlight)
Plugin 'pangloss/vim-javascript'

" syntax highlight for JSX
Bundle 'mxw/vim-jsx'

" .editorconfig
Plugin 'editorconfig/editorconfig-vim'

" emmet
Plugin 'mattn/emmet-vim'

" automatic insertion of matching pairs (for `(`, `[`, etc...)
Plugin 'jiangmiao/auto-pairs'

" surround
Plugin 'tpope/vim-surround'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
" Put your non-Plugin stuff after this line

" Open NERDTree automatically when vim starts up
" autocmd vimenter * NERDTree
" NERDTree
let NERDTreeShowHidden=1
map <silent> <C-n> :NERDTreeToggle<CR>

" close NERDTree after a file is opened
let g:NERDTreeQuitOnOpen=1

" vim-airline
let g:airline_powerline_fonts=1
let g:airline_theme='molokai'
let g:airline#extensions#tabline#enabled=1
set guifont=Meslo\ LG\ S\ Regular\ for\ Powerline:h20

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_json_checkers = ['jsonlint']
let g:syntastic_go_checkers = [] " vim-go does that for me

" enable emmet for JSX
let g:user_emmet_jsx = 1

" ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard'] " only show files that are not ignored by git

" vim-go
let g:go_fmt_command = "goimports"

" enable syntax highlight for JSX on .js files
let g:jsx_ext_required = 0

" vim thinks that json is javascript
au BufRead,BufNewFile *.json set filetype=json

" display handlebars templates as html
au BufNewFile,BufRead *.handlebars set filetype=html

" identLine
let g:indentLine_enabled = 1
" let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_color_term = 239
let g:indentLine_char = '¦'
" let g:indentLine_leadingSpaceChar = '⋅'

" molokai
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1

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

" 4 spaces
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

" long lines as just one line (have to scroll horizontally)
set nowrap

" 256 colors
set t_Co=256

" line numbers
set number

" access system clipboard
set clipboard=unnamedplus

" toggle paste mode with F2
set pastetoggle=<F2>

" show the status line all the time
set laststatus=2

" toggle invisible characters
set invlist
set list
set listchars=tab:¦\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
highlight SpecialKey ctermbg=none guifg=darkgray" make the highlighting of tabs less annoying
hi NonText ctermfg=7 guifg=darkgray

" swapfiles location
set backupdir=/tmp//
set directory=/tmp//

" maintain terminal background
hi Normal ctermbg=none

" background and theme
set background=dark
