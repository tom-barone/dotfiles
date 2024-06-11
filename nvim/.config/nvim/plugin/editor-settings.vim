" Editor settings

" Theme
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
function! s:tweak_colorscheme()
	if (empty($TMUX))
		if (has("nvim"))
			"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
			let $NVIM_TUI_ENABLE_TRUE_COLOR=1
		endif
		"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
		"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
		" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
		if (has("termguicolors"))
			set termguicolors
		endif
	endif
	highlight! link DiagnosticUnnecessary DiagnosticUnderlineHint
  highlight! DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
  highlight! DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
  highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
  highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

  sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
  sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
  sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
  sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
endfunction
autocmd! ColorScheme tokyo-night call s:tweak_colorscheme()
function! s:goyo_leave()
	colorscheme tokyonight-night
endfunction

" Call the function after colorscheme changes
autocmd! User GoyoLeave nested call <SID>goyo_leave()
colorscheme tokyonight-night

" Normally, DiagnosticUnnecessary looks like a comment which is annoying to me

" Sync the system clipboard with the unnamed register
set clipboard^=unnamed,unnamedplus

" Tab width = 2 spaces
set tabstop=2
set noexpandtab
set shiftwidth=2

" Numbers in the margin
set number

" Treat dash seperated words as vim words
set iskeyword-=-

" Always show the sign column
set signcolumn=yes

" Recommended by nvim-mp
set completeopt=menu,menuone,noselect

set cursorline

set foldmethod=syntax

" How long before the swp file is written to disk
" Makes vim-gitgutter much faster
set updatetime=1000

let g:python3_host_prog=expand("$HOME/.virtualenvs/pynvim/bin/python")

" Use the default manpager within vim
" We're using 'bat' as a manpager in the shell but it doesn't work in vim
let $MANPAGER=""

if IsWSL()
	" Fix the clipboard
	let g:clipboard = {
							\   'name': 'WslClipboard',
							\   'copy': {
							\      '+': 'clip.exe',
							\      '*': 'clip.exe',
							\    },
							\   'paste': {
							\      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
							\      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
							\   },
							\   'cache_enabled': 0,
							\ }
endif

au BufReadPost *.env set syntax=sh
au BufReadPost *.env.* set syntax=sh
