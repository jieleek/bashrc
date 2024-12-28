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

""""""""""""""""""""""""""""""""""
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


let s:stored_password = ''

function! s:GetPassword()
    if empty(s:stored_password)
        let s:stored_password = inputsecret('Enter encryption password: ')
    endif
    return s:stored_password
endfunction

function! EncryptLines() range
    let password = s:GetPassword()
    if empty(password)
        echo "Encryption cancelled"
        return
    endif

    " Process each line in the selection
    for line_num in range(a:firstline, a:lastline)
        let line = getline(line_num)
        " Skip if line is already encrypted
        if line =~ '^{AES}'
            continue
        endif
        let encrypted = system('echo ' . shellescape(line) . ' | openssl enc -aes-256-cbc -pbkdf2 -a -salt -pass pass:' . shellescape(password))
        " Add {AES} prefix and remove trailing newline
        let encrypted = '{AES}' . substitute(encrypted, '\n\+$', '', '')
        call setline(line_num, encrypted)
    endfor
endfunction

function! DecryptLines() range
    let password = s:GetPassword()
    if empty(password)
        echo "Decryption cancelled"
        return
    endif

    " Process each line in the selection
    for line_num in range(a:firstline, a:lastline)
        let line = getline(line_num)
        " Only decrypt lines starting with {AES}
        if line !~ '^{AES}'
            continue
        endif
        " Remove {AES} prefix before decryption
        let encrypted = substitute(line, '^{AES}', '', '')
        let decrypted = system('echo ' . shellescape(encrypted) . ' | openssl enc -aes-256-cbc -pbkdf2 -a -d -salt -pass pass:' . shellescape(password))
        call setline(line_num, substitute(decrypted, '\n\+$', '', ''))
    endfor
endfunction

function! ClearStoredPassword()
    let s:stored_password = ''
    echo "Stored password cleared"
endfunction

" Map to commands with range support
command! -range EncryptLines <line1>,<line2>call EncryptLines()
command! -range DecryptLines <line1>,<line2>call DecryptLines()
command! ClearPassword call ClearStoredPassword()

" Set space as leader - must be before other mappings
let mapleader=" "
let maplocalleader=" "

" Key mappings for normal and visual mode
nnoremap <leader>enc :EncryptLines<CR>
nnoremap <leader>dec :DecryptLines<CR>
vnoremap <leader>enc :EncryptLines<CR>
vnoremap <leader>dec :DecryptLines<CR>
