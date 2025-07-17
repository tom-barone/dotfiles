" Search visual selection on C-f and open RG if in normal
noremap <C-f> <Cmd>Rg<Enter>
vmap <C-f> "fy<space>ff
nmap <expr> <leader>ff ":Rg<Enter>".escape(getreg("f"), ' ')
" Search all git ignored files and binary files with Rga (Control - Shift - F)
noremap ♠ <Cmd>Rga<Enter>
vmap ♠ "gy<space>FF
nmap <expr> <leader>FF ":Rga<Enter>".escape(getreg("g"), ' ')

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
