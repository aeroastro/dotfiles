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
set fdm=indent

set laststatus=2
set wildmenu

set hlsearch
set incsearch
set showmatch " parentheses

set backspace=indent,eol,start " Allow backspace in insert mode
set ttyfast " Optimize for fast terminal connections

set mouse=a
set ruler
set scrolloff=3

" show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list

" ----- File Detection ----- "
" this could be merged into extended editorconfig. Does it exist?
 augroup FileTypeDetect
   autocmd BufRead,BufNewFile *.schema setfiletype ruby
 augroup END

" ----- Binary Editing Mode ----- "
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END

" Initialization
autocmd vimenter * if !argc() | NERDTree | endif
