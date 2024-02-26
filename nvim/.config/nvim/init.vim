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

call plug#begin(stdpath('data') . '/plugged')

" Good plugins source
" https://github.com/rockerBOO/awesome-neovim/blob/main/README.md
"

Plug 'ActivityWatch/aw-watcher-vim', IsWSL() ? {} : { 'on': [] } " https://github.com/junegunn/vim-plug/wiki/tips#conditional-activation
Plug 'NoahTheDuke/vim-just'
Plug 'airblade/vim-gitgutter'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'folke/trouble.nvim'
Plug 'github/copilot.vim'
Plug 'godlygeek/tabular'
Plug 'gpanders/editorconfig.nvim'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  }
Plug 'jparise/vim-graphql'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'kosayoda/nvim-lightbulb'
Plug 'mfussenegger/nvim-lint'
Plug 'moll/vim-bbye'
Plug 'nathangrigg/vim-beancount'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ojroques/nvim-hardline'
Plug 'preservim/nerdcommenter'
Plug 'rafamadriz/friendly-snippets'
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'weilbith/nvim-code-action-menu'
Plug '~/opt/fzf'

call plug#end()

" Snapshots, because updating everything broke some stuff on my work laptop
silent! let g:plugs['FixCursorHold.nvim'].commit = '1900f89dc17c603eec29960f57c00bd9ae696495'
silent! let g:plugs['aw-watcher-vim'].commit = '4ba86d05a940574000c33f280fd7f6eccc284331'
silent! let g:plugs['bufferline.nvim'].commit = '028a87933d99f8bb88f2f70a4def3ff9574f3594'
silent! let g:plugs['cmp-buffer'].commit = '3022dbc9166796b644a841a02de8dd1cc1d311fa'
silent! let g:plugs['cmp-cmdline'].commit = '8ee981b4a91f536f52add291594e89fb6645e451'
silent! let g:plugs['cmp-nvim-lsp'].commit = '44b16d11215dce86f253ce0c30949813c0a90765'
silent! let g:plugs['cmp-nvim-lsp-signature-help'].commit = '3d8912ebeb56e5ae08ef0906e3a54de1c66b92f1'
silent! let g:plugs['cmp-path'].commit = '91ff86cd9c29299a64f968ebb45846c485725f23'
silent! let g:plugs['cmp-vsnip'].commit = '1ae05c6c867d9ad44bce811056e861e0d5c531cb'
silent! let g:plugs['copilot.vim'].commit = '309b3c803d1862d5e84c7c9c5749ae04010123b8'
silent! let g:plugs['editorconfig.nvim'].commit = '2af880947129f1ab776b732a4eecb92528472ef5'
silent! let g:plugs['friendly-snippets'].commit = '1a6a02350568d6830bcfa167c72f9b6e75e454ae'
silent! let g:plugs['fzf.vim'].commit = '9ceac718026fd39498d95ff04fa04d3e40c465d7'
silent! let g:plugs['goyo.vim'].commit = 'fa0263d456dd43f5926484d1c4c7022dfcb21ba9'
silent! let g:plugs['lsp-colors.nvim'].commit = '2bbe7541747fd339bdd8923fc45631a09bb4f1e5'
silent! let g:plugs['markdown-preview.nvim'].commit = '02cc3874738bc0f86e4b91f09b8a0ac88aef8e96'
silent! let g:plugs['neoformat'].commit = 'afbc055587e88554b1fd11408cfab859d0cd40d3'
silent! let g:plugs['nerdcommenter'].commit = '98cc4a2d64ca67cccbf5b5cf47c682ebadaaff58'
silent! let g:plugs['nvim-cmp'].commit = '8a9e8a89eec87f86b6245d77f313a040a94081c1'
silent! let g:plugs['nvim-code-action-menu'].commit = 'e4399dbaf6eabff998d3d5f1cbcd8d9933710027'
silent! let g:plugs['nvim-hardline'].commit = '81f8dafc1abfdd836f8b13abc903b0b82ca67c7b'
silent! let g:plugs['nvim-lightbulb'].commit = '56b9ce31ec9d09d560fe8787c0920f76bc208297'
silent! let g:plugs['nvim-lint'].commit = '9e3b261583a39b47facfefd181a233bfd68b9af0'
silent! let g:plugs['nvim-lspconfig'].commit = 'dd11ba7b3c8f82d51b6d4dd7d68fce2d78bf78a0'
silent! let g:plugs['nvim-tree.lua'].commit = '273c1700eb68c27dce4e518efafc8144fd7ce4ab'
silent! let g:plugs['nvim-treesitter'].commit = '7b04e8b67eec7d92daadf9f0717dd272ddfc81a3'
silent! let g:plugs['nvim-web-devicons'].commit = 'efbfed0567ef4bfac3ce630524a0f6c8451c5534'
silent! let g:plugs['tabular'].commit = '339091ac4dd1f17e225fe7d57b48aff55f99b23a'
silent! let g:plugs['tokyonight.nvim'].commit = '62b4e89ea1766baa3b5343ca77d62c817f5f48d0'
silent! let g:plugs['trouble.nvim'].commit = '897542f90050c3230856bc6e45de58b94c700bbf'
silent! let g:plugs['vim-bbye'].commit = '25ef93ac5a87526111f43e5110675032dbcacf56'
silent! let g:plugs['vim-beancount'].commit = '2f970a0c826275f7d07fa145ba9a35c15b15232d'
silent! let g:plugs['vim-doge'].commit = '8b23c0cb5e882d42efbbc19ae58c3cc4a8c6844c'
silent! let g:plugs['vim-fugitive'].commit = '23b9b9b2a3b88bdefee8dfd1126efb91e34e1a57'
silent! let g:plugs['vim-gitgutter'].commit = '400a12081f188f3fb639f8f962456764f39c6ff1'
silent! let g:plugs['vim-graphql'].commit = '996749a7d69a3709768fa8c4d259f79b5fd9bdb1'
silent! let g:plugs['vim-just'].commit = '60fb16e889fc241d172d51c0f43c8dd70384209e'
silent! let g:plugs['vim-obsession'].commit = '7d39576149d17bde3c096fd57e3a2cdae65deaf5'
silent! let g:plugs['vim-rails'].commit = '1ad9663ce31e8c08134849d04184cda94bb42aba'
silent! let g:plugs['vim-repeat'].commit = '24afe922e6a05891756ecf331f39a1f6743d3d5a'
silent! let g:plugs['vim-surround'].commit = '3d188ed2113431cf8dac77be61b842acb64433d9'
silent! let g:plugs['vim-unimpaired'].commit = '6d44a6dc2ec34607c41ec78acf81657248580bf1'
silent! let g:plugs['vim-vsnip'].commit = '6f873418c4dc601d8ad019a5906eddff5088de9b'
silent! let g:plugs['vim-vsnip-integ'].commit = '1cf89903f12777b90dd79eb4b3d7fbc0b9a254a1'
