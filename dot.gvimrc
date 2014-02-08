set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set guifont=Ubuntu\ Mono\ 11
set noerrorbells visualbell t_vb=
set columns=132
set lines=35
set expandtab
set cursorline
set autoindent
set display+=lastline
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions+=e

set linespace=9
set ruler
set colorcolumn=80
set laststatus=2
set relativenumber
set ignorecase
set infercase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

nmap ff <ESC>:FufFile **/<CR>
nmap fb <ESC>:FufBuffer<CR>
nmap fl <ESC>:FufLine<CR>
nmap fq <ESC>:FufQuickfix<CR>
nmap fc <ESC>:FufChangeList<CR>
nmap fj <ESC>:FufJumpList<CR>
nmap ft <ESC>:FufTag<CR>
nmap fe <ESC>:Explore<CR>
nmap <C-n> <ESC>:cn<CR>
nmap <C-p> <ESC>:cp<CR>
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|class|png|orig|gz|gif|sw[po])$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|(^|[/\\])(target|build|bin)($|[/\\])'
let g:fuf_dir_exclude = '\v(^|[/\\])\.(hg|git|bzr)($|[/\\])|[/\\])(target|build|bin)($|[/\\])'

" taglist for R
let tlist_r_settings = 'r;f:function'
let tlist_groovy_settings = 'groovy;p:package;c:class;i:inteface;f:function;v:variable'
let Tlist_Show_One_File = 1
let Tlist_WinWidth = 40
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1

syntax on
filetype on
filetype indent on
filetype plugin on

autocmd FileType groovy setlocal shiftwidth=4 softtabstop=4
autocmd FileType html setlocal shiftwidth=2 softtabstop=2
autocmd FileType java setlocal shiftwidth=4 softtabstop=4
autocmd FileType python setlocal tabstop=8 shiftwidth=4 softtabstop=4
autocmd FileType R setlocal shiftwidth=2 softtabstop=2
autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2
autocmd FileType scala setlocal shiftwidth=2 softtabstop=2

autocmd BufRead,BufNewFile *.gradle set filetype=groovy
autocmd BufRead,BufNewFile *.erb set filetype=ruby
autocmd BufRead,BufNewFile *.cql set filetype=cql

colorscheme railscasts
hi ColorColumn guibg=grey18

cd /bin
