source ~/.vim/preference.vim

colorscheme railscasts
nmap <C-n> <ESC>:cn<CR>
nmap <C-p> <ESC>:cp<CR>

hi ColorColumn ctermbg=grey
let g:acp_behaviorKeywordCommand = "\<C-p>"
let g:acp_completeoptPreview = 1

" Use Vim's internal diff engine.
set diffexpr= diffopt+=internal
