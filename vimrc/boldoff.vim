function! s:BoldOff()
    let hid = 1
    while 1
        let hln = synIDattr(hid, 'name')
        if !hlexists(hln) | break | endif
        if hid == synIDtrans(hid) && (synIDattr(hid, 'bold') || synIDattr(hid, 'bold', 'cterm'))
            let atr = ['underline', 'undercurl', 'reverse', 'inverse', 'italic', 'standout']
            call filter(atr, 'synIDattr(hid, v:val)')
            let gui = empty(atr) ? 'NONE' : join(atr, ',')
            " Set both GUI and terminal attributes
            exec 'highlight ' . hln . ' gui=' . gui . ' cterm=' . gui
        endif
        let hid += 1
    endwhile
endfunction
command! BoldOff call s:BoldOff()
