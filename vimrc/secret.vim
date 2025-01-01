"------------------------------------------------------------
" Vim configuration file for encrypting and decrypting secrets
" 
" To use this file, add the following line to your .vimrc:
" source /path/to/secret.vim
"
" To encrypt a line, add the {SECRET} prefix and use the leader key followed by 'ce'
" To decrypt a line, use the leader key followed by 'cd'
" To add the {SECRET} prefix to a line, use the leader key followed by 'ca'
" To remove the {SECRET} prefix from a line, use the leader key followed by 'cr'
" To clear the stored password, use the 'ClearPassword' command
"
"------------------------------------------------------------

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
        let password1 = inputsecret('Enter encryption password: ')
        if empty(password1)
            echo "Password cannot be empty"
            return ''
        endif
        
        let password2 = inputsecret('Confirm encryption password: ')
        if password1 != password2
            echo "Passwords do not match!"
            return ''
        endif
        
        let s:stored_password = password1
    endif
    return s:stored_password
endfunction

function! EncryptLines() range
    let password = s:GetPassword()
    if empty(password)
        redraw
        echo "Encryption cancelled"
        return
    endif

    " Process each line in the selection
    for line_num in range(a:firstline, a:lastline)
        let line = getline(line_num)
        " Skip if line is labeled
        if line !~ '^{SECRET}'
            continue
        endif
        let plaintext = substitute(line, '^{SECRET}', '', '')
        let encrypted = system('echo ' . shellescape(plaintext) . ' | openssl enc -aes-256-cbc -pbkdf2 -a -salt -pass pass:' . shellescape(password))
        let cleaned = substitute(encrypted, '[[:cntrl:]]', '', 'g')
        let cleaned = substitute(cleaned, '\r', '', 'g')
        let cleaned = substitute(cleaned, '\n\+$', '', '')
        " Add {AES} prefix
        let cleaned = '{AES}' . cleaned
        call setline(line_num, cleaned)
    endfor
endfunction

function! DecryptLines() range
    let password = s:GetPassword()
    if empty(password)
        redraw
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
        let cleaned = '{SECRET}' . decrypted
        call setline(line_num, substitute(cleaned, '\n\+$', '', ''))
    endfor
endfunction

function! AddSecretPrefix() range
    " Process each line in the selection
    for line_num in range(a:firstline, a:lastline)
        let line = getline(line_num)
        " Skip if line already has prefix
        if line =~ '^{SECRET}'
            continue
        endif
        " Add prefix
        call setline(line_num, '{SECRET}' . line)
    endfor
endfunction

function! RemoveSecretPrefix() range
    " Process each line in the selection
    for line_num in range(a:firstline, a:lastline)
        let line = getline(line_num)
        " Only remove prefix if it exists
        if line =~ '^{SECRET}'
            " Remove prefix using substitute
            let cleaned = substitute(line, '^{SECRET}', '', '')
            call setline(line_num, cleaned)
        endif
    endfor
endfunction

function! ClearStoredPassword()
    let s:stored_password = ''
    echo "Stored password cleared"
endfunction

" Map to commands with range support
command! -range EncryptLines <line1>,<line2>call EncryptLines()
command! -range DecryptLines <line1>,<line2>call DecryptLines()
command! -range AddSecret <line1>,<line2>call AddSecretPrefix()
command! -range RemoveSecret <line1>,<line2>call RemoveSecretPrefix()
command! ClearPassword call ClearStoredPassword()

" Set space as leader - must be before other mappings
let mapleader=" "
let maplocalleader=" "

" Key mappings for normal and visual mode
nnoremap <leader>ce :EncryptLines<CR>
nnoremap <leader>cd :DecryptLines<CR>
vnoremap <leader>ce :EncryptLines<CR>
vnoremap <leader>cd :DecryptLines<CR>
nnoremap <leader>ca :AddSecret<CR>
nnoremap <leader>cr :RemoveSecret<CR>
vnoremap <leader>ca :AddSecret<CR>
vnoremap <leader>cr :RemoveSecret<CR>