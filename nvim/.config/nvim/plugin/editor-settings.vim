" Editor settings

" Don't use perl (from checkhealth)
let g:loaded_perl_provider = 0

" Theme
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
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
colorscheme tokyonight-night

" Normally, DiagnosticUnnecessary looks like a comment which is annoying to me
hi! link DiagnosticUnnecessary DiagnosticUnderlineHint

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

let g:python3_host_prog=expand("$HOME/.virtualenvs/nvim/bin/python")
