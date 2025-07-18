let g:goyo_width=81

function! s:goyo_enter()
	" Disable the nvim-lualine/lualine.nvim plugin
  lua require('lualine').hide()
	set linebreak
endfunction

function! s:goyo_leave()
  lua require('lualine').hide({unhide = true})
	set nolinebreak
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
