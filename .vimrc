set nocompatible " Say Good Bye to vi

" Using NeoBundle
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/')) " 

" Plugins


" Every Time in Use 
NeoBundle 'petdance/vim-perl'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/neocomplcache'

" Show Directories
NeoBundle 'scrooloose/nerdtree'
" List subroutines and variables
NeoBundle 'vim-scripts/taglist.vim'
" tags
NeoBundle 'vim-scripts/Source-Explorer-srcexpl.vim'
NeoBundle 'vim-scripts/trinity.vim'

filetype plugin indent on


" Start With IDE Mode unless Files specified
autocmd vimenter * if !argc() | NERDTree | endif

" Setting for Program
set fileencodings=utf8,iso-2022-jp,cp932,euc-jp
set backspace=indent,eol,start


" For US Keyboards
" noremap ; :
" noremap : ;

" Input
set autoindent
set smartindent "cindent?
set cindent
set expandtab
set tabstop=4
"set softtabstop=4
set shiftwidth=4


"---- Display -----"
set number
"set ruler
set laststatus=2
syntax on
"set list
set showmatch
set hlsearch  "HighLight

"---- Foldings -----"
set fdm=indent "Open All by zR

"---- CursorLine ----"
set cursorline




" Vim Tips
"
