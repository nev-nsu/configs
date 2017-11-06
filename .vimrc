" Vundle
" ======
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" All of your Plugins must be added before the following line

Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'vim-syntastic/syntastic'
Plugin 'sheerun/vim-polyglot'
Plugin 'auto-pairs-gentle'

Plugin 'kien/ctrlp.vim'

call vundle#end()            " required
filetype plugin indent on    " required

" MAIN
" ====

set exrc
set secure
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set autoindent
set smartindent
set showmatch
set ignorecase
set hls
set wildmenu
set wildmode=full
set splitright
set backspace=2
set clipboard=unnamedplus
set mouse=a                             
syntax on
set number
set cursorline
au VimEnter * hi CursorLine cterm=NONE ctermbg=236 ctermfg=NONE
colorscheme default

" Pligins
" =======

" LATEX
filetype plugin on
set shellslash
set grepprg=grep\ -nH\ $*
filetype indent on
let g:tex_flavor='latex'
let g:AutoPairsUseInsertedCount = 1


" Tabs and NERDTree

let NERDTreeMapOpenInTab='<ENTER>'
let g:nerdtree_tabs_open_on_console_startup=2
let g:nerdtree_tabs_autofind=1

"hi TabLine      ctermfg=White  ctermbg=34  cterm=NONE
"hi TabLineFill  ctermfg=White  ctermbg=34  cterm=NONE
"hi TabLineSel   ctermfg=White  ctermbg=25  cterm=NONE

" Syntastic

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_quiet_messages = { "level" : "warnings" }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Airline

let g:airline_powerline_fonts = 1
let g:airline_theme='dark_minimal'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled= 1
let g:airline_extensions = ['tabline', 'syntastic']
set ttimeoutlen=10
let g:airline#extensions#tabline#buffer_min_count=2
au VimEnter * set laststatus=1
" Keymap
" ======

nmap <C-N> :NERDTreeTabsToggle<CR>

nnoremap <A-Up> :m-2<CR>
nnoremap <A-Down> :m+<CR>
inoremap <A-Up> <Esc>:m-2<CR>
inoremap <A-Down> <Esc>:m+<CR>

nnoremap <Space> <C-D>

