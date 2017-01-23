"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('~/.vim/dein/')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neocomplete')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('scrooloose/nerdtree')
call dein#add('editorconfig/editorconfig-vim')

call dein#add('jacoborus/tender.vim')
call dein#add('tomasr/molokai')
call dein#add('nanotech/jellybeans.vim')
call dein#add('romainl/Apprentice')

" You can specify revision/branch/tag.
" call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

syntax enable
colorscheme apprentice

" Default Settings
set number

set cindent

set expandtab
set tabstop=4
set shiftwidth=4

set wildmenu
set hlsearch
set showmatch " parentheses

set fdm=indent

set backspace=indent,eol,start
set mouse=a

" Initialization
autocmd vimenter * if !argc() | NERDTree | endif
