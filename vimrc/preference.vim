" Common settings for all environments
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim

" Basic settings
set noerrorbells visualbell t_vb=
set expandtab autoindent cursorline number ruler laststatus=2
set display+=lastline

" Search settings
set ignorecase smartcase gdefault incsearch showmatch hlsearch

" File handling
syntax on
filetype plugin indent on

" Do not persist buffer contents, history, backups, or undo files.
set noswapfile nobackup nowritebackup viminfo= noundofile

" Replace this configuration's autocommands when the file is reloaded.
augroup DotVimPreferences
    autocmd!
    autocmd FileType groovy,java setlocal shiftwidth=4 softtabstop=4
    autocmd FileType html,ruby,R,scala setlocal shiftwidth=2 softtabstop=2
    autocmd FileType python setlocal tabstop=8 shiftwidth=4 softtabstop=4

    " Custom file associations
    autocmd BufRead,BufNewFile *.gradle setlocal filetype=groovy
    autocmd BufRead,BufNewFile *.erb setlocal filetype=ruby

    " Suppress the external file-change prompt.
    autocmd FileChangedShell * :
augroup END

let g:dot_vim_preferences_loaded = 1
