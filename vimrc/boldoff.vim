function! s:BoldOff()
	let hid = 1
	while 1
		let hln = synIDattr(hid, 'name')
		if !hlexists(hln) | break | endif
		if hid == synIDtrans(hid) && synIDattr(hid, 'bold')
			let atr = ['underline', 'undercurl', 'reverse', 'inverse', 'italic', 'standout']
			call filter(atr, 'synIDattr(hid, v:val)')
			let gui = empty(atr) ? 'NONE' : join(atr, ',')
			exec 'highlight ' . hln . ' gui=' . gui
		endif
		let hid += 1
	endwhile
endfunction

command! BoldOff call s:BoldOff()

