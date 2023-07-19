"" Remaps
" :help key-notation

inoremap jk <esc>
tnoremap jk <C-\><C-n>
noremap j gj
noremap k gk
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
nnoremap <C-X> :Bdelete<CR>
lmap <C-c> <C-[>  " For command line modes
nnoremap Q <Nop>
nmap <C-Q> :q <Enter>

" Leaders
let mapleader = "\<Space>"
nmap <Leader>Q :qa!
nmap <Leader>v <Cmd>source $MYVIMRC <Enter>
"nmap <expr> <Leader>V ":tabedit " . stdpath('config') . '/lua/init.lua' . " <Bar> vsplit $MYVIMRC"
nmap <Leader>V :tabedit $MYVIMRC
nmap <Leader>s :w<Enter>

" Search visual selection on C-f and open RG if in normal
noremap <C-f> <Cmd>Rg<Enter>
vmap <C-f> "fy<space>ff
nmap <expr> <leader>ff ":Rg<Enter>".escape(getreg("f"), ' ')

" Mappings for plugins
nmap <Leader>tt <Cmd>NvimTreeToggle <Enter>
nmap <Leader>tf <Cmd>NvimTreeFindFile! <Enter>
nmap <Leader>pc <Cmd>source $MYVIMRC <Bar> PlugClean <Enter>
nmap <Leader>pi <Cmd>source $MYVIMRC <Bar> PlugInstall <Enter>
nmap <Leader>pr <Cmd>Neoformat <Enter>
nmap <Leader>po <Cmd>OrganiseImports <Enter>
nmap <C-t> <Cmd>Files<Enter>

nmap <C-g><C-f> <Cmd>GFiles?<Enter>
nmap <C-g><C-b> <Cmd>Buffers<Enter>
nnoremap <leader>ge <Cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>gE <Cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>gr <Cmd>TroubleToggle lsp_references<cr>

nnoremap [d <Cmd>lua vim.diagnostic.goto_prev()<Enter>
nnoremap ]d <Cmd>lua vim.diagnostic.goto_next()<Enter>

" Copilot
imap <silent><script><expr> <C-s> copilot#Accept("\<CR>")
" ignore default tab map
let g:copilot_no_tab_map = v:true
imap <C-j> <Plug>(copilot-next)
imap <C-k> <Plug>(copilot-previous)


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
