-- This makes firenvim have a larger font in the UI
vim.cmd([[
function! OnUIEnter(event)
	let l:ui = nvim_get_chan_info(a:event.chan)
	if has_key(l:ui, 'client') && has_key(l:ui.client, 'name')
		if l:ui.client.name ==# 'Firenvim'
			set guifont=Iosevka:h18
		endif
	endif
endfunction

augroup FireNvim
autocmd UIEnter * call OnUIEnter(deepcopy(v:event))
augroup END
]])
