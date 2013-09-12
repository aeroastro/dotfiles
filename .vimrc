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
" NeoBundle 'scrooloose/grep_menuitem.vim'
" List subroutines and variables
NeoBundle 'vim-scripts/taglist.vim'
" tags
NeoBundle 'vim-scripts/SrcExpl'
NeoBundle 'vim-scripts/Trinity'
"NeoBundle 'altercation/vim-colors-solarized'

NeoBundle 'thinca/vim-quickrun'

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
set ruler
set laststatus=2
syntax on
set background=dark
" colorscheme solarized
"
"

set wildmenu

"set list
set showmatch
set hlsearch  "HighLight

"---- Foldings -----"
set fdm=indent "Open All by zR

"---- CursorLine ----"
set cursorline
"set cursorcolumn
"highlight CursorLine   cterm=NONE ctermbg=
"highlight CursorColumn cterm=NONE ctermbg=dark
set background=dark

" Vim Tips
:nnoremap <M-Right> :bn<CR>
:nmap <M-Left> :bp<CR>

"------ Like IDE --------"
" F7 to Compile the File
:nmap <F7> :make<CR><CR>
" F5 to Run
:nmap <F5> :QuickRun<CR>


" color
"hi Pmenu ctermbg=7



"------ Perl Specific Area -----"
let g:perl_compiler_force_warnings=0
autocmd FileType perl :compiler perl
autocmd FileType perl :nmap <S-F5> :!perl %

"
" Option to Include Another Files
source ~/.local.vimrc
