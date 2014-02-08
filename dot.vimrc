set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

colorscheme railscasts

set noerrorbells visualbell t_vb=
set expandtab
set cursorline
set autoindent
set backspace=2
set display+=lastline

set ruler
" set colorcolumn=80
set laststatus=2
set relativenumber
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

nmap <C-n> <ESC>:cn<CR>
nmap <C-p> <ESC>:cp<CR>

syntax on
filetype on
filetype indent on
filetype plugin on

autocmd FileType groovy setlocal shiftwidth=4 softtabstop=4
autocmd FileType html setlocal shiftwidth=2 softtabstop=2
autocmd FileType java setlocal shiftwidth=4 softtabstop=4
autocmd FileType python setlocal tabstop=8 shiftwidth=4 softtabstop=4
autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2
autocmd FileType R setlocal shiftwidth=2 softtabstop=2
autocmd FileType scala setlocal shiftwidth=2 softtabstop=2
autocmd BufRead,BufNewFile *.gradle set filetype=groovy
autocmd BufRead,BufNewFile *.erb set filetype=ruby
autocmd BufRead,BufNewFile *.cql set syntax=cql

hi ColorColumn ctermbg=grey
" hi CursorLine cterm=none ctermbg=grey

let g:acp_behaviorKeywordCommand = "\<C-p>"
let g:acp_completeoptPreview = 1

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

