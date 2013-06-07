" Setting for Program
set fileencodings=utf8,iso-2022-jp,cp932,euc-jp
set backspace=indent,eol,start

" Using NeoBundle
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim.bundle.')) " 上のifの中？[TBD]

" Plugins
NeoBundle 'petdance/vim-perl'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/neocomplcache'

filetype plugin indent on

" For US Keyboards
noremap ; :
noremap : ;

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
