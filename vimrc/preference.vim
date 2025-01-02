" Common settings for all environments
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

" Basic settings
set noerrorbells visualbell t_vb=
set expandtab
set cursorline
set autoindent
set display+=lastline
set ruler
set laststatus=2
set relativenumber

" Search settings
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

" File handling
syntax on
filetype on
filetype indent on
filetype plugin on


" Disable swap file
set noswapfile

" Disable backup files
set nobackup
set nowritebackup

" Disable viminfo file
set viminfo=
" Or if you want minimal viminfo without file contents:
" set viminfo='0

" Disable undo files
set noundofile

" File type specific settings
autocmd FileType groovy setlocal shiftwidth=4 softtabstop=4
autocmd FileType html setlocal shiftwidth=2 softtabstop=2
autocmd FileType java setlocal shiftwidth=4 softtabstop=4
autocmd FileType python setlocal tabstop=8 shiftwidth=4 softtabstop=4
autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2
autocmd FileType R setlocal shiftwidth=2 softtabstop=2
autocmd FileType scala setlocal shiftwidth=2 softtabstop=2

" Custom file associations
autocmd BufRead,BufNewFile *.gradle set filetype=groovy
autocmd BufRead,BufNewFile *.erb set filetype=ruby
