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
" Search all git ignored files and binary files with Rga (Control - Shift - F)
noremap ♠ <Cmd>Rga<Enter>
vmap ♠ "gy<space>FF
nmap <expr> <leader>FF ":Rga<Enter>".escape(getreg("g"), ' ')

" Mappings for plugins
nmap <Leader>tt <Cmd>NvimTreeToggle <Enter>
nmap <Leader>tf <Cmd>NvimTreeFindFile! <Enter>
nmap <Leader>pc <Cmd>source $MYVIMRC <Bar> PlugClean <Enter>
nmap <Leader>pi <Cmd>source $MYVIMRC <Bar> PlugInstall <Enter>
nmap <Leader>pr <Cmd>Format <Enter>
nmap <Leader>po <Cmd>OrganiseImports <Enter>
nmap <Leader>gy <Cmd>Goyo <Enter>
nmap <C-t> <Cmd>Files<Enter>
nnoremap <C-w>o :MaximizerToggle<CR>

nmap <C-g><C-f> <Cmd>GFiles?<Enter>
nmap <C-g><C-b> <Cmd>Buffers<Enter>
nnoremap <leader>ge <Cmd>Trouble diagnostics focus=false filter.buf=0<cr>
nnoremap <leader>gE <Cmd>Trouble diagnostics<cr>
nnoremap <leader>gr <Cmd>Trouble lsp_references<cr>

" Git commands
" Show history of current file
nnoremap <leader>gh <Cmd>0Gclog<cr>
vnoremap <leader>gh :Gclog<cr>
nnoremap <leader>gst <Cmd>vert Git<Enter><Cmd>vertical resize 31<Enter>

nnoremap [d <Cmd>lua vim.diagnostic.goto_prev()<Enter>
nnoremap ]d <Cmd>lua vim.diagnostic.goto_next()<Enter>

" Copilot
imap <C-s> <Plug>(copilot-accept-line)
imap <silent><script><expr> <C-d> copilot#Accept("\<CR>")
" ignore default tab map
let g:copilot_no_tab_map = v:true
imap <C-j> <Plug>(copilot-next)
imap <C-k> <Plug>(copilot-previous)
nnoremap <leader>cd <Cmd>Copilot disable<CR>
nnoremap <leader>ce <Cmd>Copilot enable<CR>

" Open URL under cursor
" Loads netrw on demand since we disable netrw normally for nvim-tree.lua
" https://github.com/nvim-tree/nvim-tree.lua/issues/47
nnoremap gx :call <sid>open_url()<CR>
function! s:open_url() abort
  unlet! g:loaded_netrw
  unlet! g:loaded_netrwPlugin
  runtime! plugin/netrwPlugin.vim
  return netrw#BrowseX(expand('<cfile>'), netrw#CheckIfRemote())
endfunction

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
