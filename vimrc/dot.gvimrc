" dot.gvimrc
source preference.vim
source guipref.vim
source $VIMRUNTIME/mswin.vim

set guifont=Ubuntu\ Mono\ 11
set guioptions-=m

" FuzzyFinder mappings
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

" Taglist settings
let tlist_r_settings = 'r;f:function'
let tlist_groovy_settings = 'groovy;p:package;c:class;i:inteface;f:function;v:variable'
let Tlist_Show_One_File = 1
let Tlist_WinWidth = 40
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1

colorscheme railscasts
hi ColorColumn guibg=grey18

cd /bin