set nocompatible
source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim
source $HOME/boldoff.vim
behave mswin


set noerrorbells visualbell t_vb=
set expandtab
set cursorline
set autoindent
set display+=lastline

set linespace=9
set ruler
" set colorcolumn=80
set laststatus=2
set relativenumber
set ignorecase
set infercase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

syntax on
filetype on
filetype indent on
filetype plugin on
colorscheme desert
hi ColorColumn guibg=grey18
