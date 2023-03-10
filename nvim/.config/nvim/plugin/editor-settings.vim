" Editor settings

" Don't use perl (from checkhealth)
let g:loaded_perl_provider = 0

" Theme
if (has("termguicolors"))
 set termguicolors
endif
colorscheme tokyonight-night

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
