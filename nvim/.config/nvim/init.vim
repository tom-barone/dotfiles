" Neovim settings
" Vim code here

" Install vim-plug if it doesn't exist
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Function to test if we're on ubuntu WSL
function! IsWSL()
	if has("unix")
		if filereadable("/proc/version")
			let lines = readfile("/proc/version")
			if lines[0] =~ "microsoft"
				return 1
			endif
		endif
	endif
  return 0
endfunction

" Leader key
" This needs to be set before plugins are loaded becuase they
" sometimes setup mappings based on it. (e.g. NerdCommenter)
let mapleader = " "

call plug#begin(stdpath('data') . '/plugged')

" Good plugins source
" https://github.com/rockerBOO/awesome-neovim/blob/main/README.md
"

" TODO: Update stuff  from https://www.lazyvim.org/news
" Use blink.cmp
" https://github.com/danymat/neogen

" To delete
"Plug 'hrsh7th/cmp-buffer'
"Plug 'hrsh7th/cmp-cmdline'
"Plug 'hrsh7th/cmp-nvim-lsp'
"Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
"Plug 'hrsh7th/cmp-path'
"Plug 'hrsh7th/cmp-vsnip'
"Plug 'hrsh7th/nvim-cmp'
"Plug 'hrsh7th/vim-vsnip'
"Plug 'hrsh7th/vim-vsnip-integ'
"Plug 'nvim-neotest/nvim-nio'
"Plug 'tpope/vim-obsession'
"Plug 'tpope/vim-rails'
"Plug 'ap/vim-css-color'  " https://github.com/ap/vim-css-color
"Plug 'evanleck/vim-svelte'  " https://github.com/evanleck/vim-svelte
"Plug 'folke/lsp-colors.nvim'  " https://github.com/folke/lsp-colors.nvim
"Plug 'godlygeek/tabular'  " https://github.com/godlygeek/tabular
"Plug 'jparise/vim-graphql'  " https://github.com/jparise/vim-graphql
"Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }  " https://github.com/kkoomen/vim-doge
"Plug 'kosayoda/nvim-lightbulb'  " https://github.com/kosayoda/nvim-lightbulb
"Plug 'mfussenegger/nvim-dap'  " https://github.com/mfussenegger/nvim-dap
"Plug 'rcarriga/nvim-dap-ui'  " https://github.com/rcarriga/nvim-dap-ui
"Plug 'vim-test/vim-test'  " https://github.com/vim-test/vim-test
"Plug 'szw/vim-maximizer'  " https://github.com/szw/vim-maximizer
"Plug 'junegunn/fzf.vim'  " https://github.com/junegunn/fzf.vim

" Might not need
"Plug 'NoahTheDuke/vim-just'  " https://github.com/NoahTheDuke/vim-just
"Plug 'Shougo/context_filetype.vim' " https://github.com/Shougo/context_filetype.vim

Plug 'airblade/vim-gitgutter'  " https://github.com/airblade/vim-gitgutter
Plug 'akinsho/bufferline.nvim'  " https://github.com/akinsho/bufferline.nvim
Plug 'antosha417/nvim-lsp-file-operations' " https://github.com/antosha417/nvim-lsp-file-operations
Plug 'editorconfig/editorconfig-vim'  " https://github.com/editorconfig/editorconfig-vim
Plug 'folke/tokyonight.nvim' " https://github.com/folke/tokyonight.nvim
Plug 'folke/trouble.nvim'  " https://github.com/folke/trouble.nvim
Plug 'github/copilot.vim'  " https://github.com/github/copilot.vim
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  }  " https://github.com/iamcco/markdown-preview.nvim
Plug 'ibhagwan/fzf-lua'  " https://github.com/ibhagwan/fzf-lua
Plug 'junegunn/fzf.vim'  " https://github.com/junegunn/fzf.vim
Plug 'junegunn/goyo.vim'  " https://github.com/junegunn/goyo.vim
Plug 'lervag/vimtex'  " https://github.com/lervag/vimtex
Plug 'lifepillar/vim-cheat40' " https://github.com/lifepillar/vim-cheat40
Plug 'mfussenegger/nvim-lint'  " https://github.com/mfussenegger/nvim-lint
Plug 'moll/vim-bbye'  " https://github.com/moll/vim-bbye
Plug 'nathangrigg/vim-beancount'  " https://github.com/nathangrigg/vim-beancount
Plug 'neovim/nvim-lspconfig'  " https://github.com/neovim/nvim-lspconfig
Plug 'nvim-lua/plenary.nvim'  " https://github.com/nvim-lua/plenary.nvim
Plug 'nvim-lualine/lualine.nvim'  " https://github.com/nvim-lualine/lualine.nvim
Plug 'nvim-tree/nvim-tree.lua'  " https://github.com/nvim-tree/nvim-tree.lua
Plug 'nvim-tree/nvim-web-devicons'  " https://github.com/nvim-tree/nvim-web-devicons
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " https://github.com/nvim-treesitter/nvim-treesitter
Plug 'preservim/nerdcommenter'  " https://github.com/preservim/nerdcommenter
Plug 'rafamadriz/friendly-snippets'  " https://github.com/rafamadriz/friendly-snippets
Plug 'stevearc/conform.nvim'  " https://github.com/stevearc/conform.nvim
Plug 'tpope/vim-fugitive'  " https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-repeat'  " https://github.com/tpope/vim-repeat
Plug 'tpope/vim-rhubarb'  " https://github.com/tpope/vim-rhubarb
Plug 'tpope/vim-surround'  " https://github.com/tpope/vim-surround
Plug 'tpope/vim-unimpaired'  " https://github.com/tpope/vim-unimpaired
Plug 'Saghen/blink.cmp', { 'do': 'cargo build --release' } " https://github.com/Saghen/blink.cmp
Plug '~/opt/fzf' " https://github.com/junegunn/fzf, already installed in ~/opt/fzf

call plug#end()

" Snapshots to keep plugin versions fixed
silent! let g:plugs['blink.cmp'].commit = '3545f6dce83baacbedfb5dd8d1230cd0492fd1d7'
silent! let g:plugs['bufferline.nvim'].commit = '655133c3b4c3e5e05ec549b9f8cc2894ac6f51b3'
silent! let g:plugs['conform.nvim'].commit = '973f3cb73887d510321653044791d7937c7ec0fa'
silent! let g:plugs['copilot.vim'].commit = '12995dffe10282b29b8335650bf3e7457f4870e7'
silent! let g:plugs['editorconfig-vim'].commit = '6a58b7c11f79c0e1d0f20533b3f42f2a11490cf8'
silent! let g:plugs['friendly-snippets'].commit = '572f5660cf05f8cd8834e096d7b4c921ba18e175'
silent! let g:plugs['fzf-lua'].commit = 'e297fea843bd703b162894e880d2ba90b1fe9dae'
silent! let g:plugs['fzf.vim'].commit = '3725f364ccd25b85a91970720ba9bc2931861910'
silent! let g:plugs['goyo.vim'].commit = 'fa0263d456dd43f5926484d1c4c7022dfcb21ba9'
silent! let g:plugs['lualine.nvim'].commit = 'a94fc68960665e54408fe37dcf573193c4ce82c9'
silent! let g:plugs['markdown-preview.nvim'].commit = 'a923f5fc5ba36a3b17e289dc35dc17f66d0548ee'
silent! let g:plugs['nerdcommenter'].commit = '02a3b6455fa07b61b9440a78732f1e9b7876c991'
silent! let g:plugs['nvim-lint'].commit = '3c5e34c24834a67b1cb37600ab7663eefd2b0390'
silent! let g:plugs['nvim-lsp-file-operations'].commit = '9744b738183a5adca0f916527922078a965515ed'
silent! let g:plugs['nvim-lspconfig'].commit = 'dbfd8da6206b4ab0e2fe9b72a538f82e2b410102'
silent! let g:plugs['nvim-tree.lua'].commit = 'b0b49552c9462900a882fe772993b01d780445fe'
silent! let g:plugs['nvim-treesitter'].commit = '42fc28ba918343ebfd5565147a42a26580579482'
silent! let g:plugs['nvim-web-devicons'].commit = '0422a19d9aa3aad2c7e5cca167e5407b13407a9d'
silent! let g:plugs['plenary.nvim'].commit = '857c5ac632080dba10aae49dba902ce3abf91b35'
silent! let g:plugs['tokyonight.nvim'].commit = '057ef5d260c1931f1dffd0f052c685dcd14100a3'
silent! let g:plugs['trouble.nvim'].commit = '85bedb7eb7fa331a2ccbecb9202d8abba64d37b3'
silent! let g:plugs['vim-bbye'].commit = '25ef93ac5a87526111f43e5110675032dbcacf56'
silent! let g:plugs['vim-beancount'].commit = '589a4f06f3b2fd7cd2356c2ef1dafadf6b7a97cf'
silent! let g:plugs['vim-cheat40'].commit = '6b02ec9ab47215141bccc48b5387c0099c18fca0'
silent! let g:plugs['vim-fugitive'].commit = '61b51c09b7c9ce04e821f6cf76ea4f6f903e3cf4'
silent! let g:plugs['vim-gitgutter'].commit = '85ca3a087204e3a32cb2faa5d9d0451524e08720'
silent! let g:plugs['vim-repeat'].commit = '65846025c15494983dafe5e3b46c8f88ab2e9635'
silent! let g:plugs['vim-rhubarb'].commit = '5496d7c94581c4c9ad7430357449bb57fc59f501'
silent! let g:plugs['vim-surround'].commit = '3d188ed2113431cf8dac77be61b842acb64433d9'
silent! let g:plugs['vim-unimpaired'].commit = '6d44a6dc2ec34607c41ec78acf81657248580bf1'
silent! let g:plugs['vimtex'].commit = '7f2633027c8f496a85284de0c11aa32f1e07e049'
