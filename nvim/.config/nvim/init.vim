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

"Plug 'ActivityWatch/aw-watcher-vim', IsWSL() ? {} : { 'on': [] } " https://github.com/junegunn/vim-plug/wiki/tips#conditional-activation
Plug 'NoahTheDuke/vim-just'
Plug 'Shougo/context_filetype.vim'
Plug 'airblade/vim-gitgutter'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'antosha417/nvim-lsp-file-operations', 
Plug 'ap/vim-css-color'
Plug 'evanleck/vim-svelte'
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
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
Plug 'jparise/vim-graphql'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'kosayoda/nvim-lightbulb'
Plug 'mfussenegger/nvim-lint'
Plug 'moll/vim-bbye'
Plug 'nathangrigg/vim-beancount'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'preservim/nerdcommenter'
Plug 'rafamadriz/friendly-snippets'
Plug 'stevearc/conform.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug '~/opt/fzf'

call plug#end()

" Snapshots, because updating everything broke some stuff on my work laptop
silent! let g:plugs['bufferline.nvim'].commit = '99337f63f0a3c3ab9519f3d1da7618ca4f91cffe'
silent! let g:plugs['cmp-buffer'].commit = '3022dbc9166796b644a841a02de8dd1cc1d311fa'
silent! let g:plugs['cmp-cmdline'].commit = 'd250c63aa13ead745e3a40f61fdd3470efde3923'
silent! let g:plugs['cmp-nvim-lsp'].commit = '39e2eda76828d88b773cc27a3f61d2ad782c922d'
silent! let g:plugs['cmp-nvim-lsp-signature-help'].commit = '031e6ba70b0ad5eee49fd2120ff7a2e325b17fa7'
silent! let g:plugs['cmp-path'].commit = '91ff86cd9c29299a64f968ebb45846c485725f23'
silent! let g:plugs['cmp-vsnip'].commit = '989a8a73c44e926199bfd05fa7a516d51f2d2752'
silent! let g:plugs['conform.nvim'].commit = 'cd75be867f2331b22905f47d28c0c270a69466aa'
silent! let g:plugs['context_filetype.vim'].commit = '7ff5b43fc8d5b274aa19ade5af11e9fa57577ed6'
silent! let g:plugs['copilot.vim'].commit = '1dcaf72099b436b5832d6117d9cd7a4a098a8d77'
silent! let g:plugs['editorconfig.nvim'].commit = '5b9e303e1d6f7abfe616ce4cc8d3fffc554790bf'
silent! let g:plugs['friendly-snippets'].commit = '700c4a25caacbb4648c9a27972c2fe203948e0c2'
silent! let g:plugs['fzf-lua'].commit = '993fce4991b28064eb3f34146c51ee85ca808135'
silent! let g:plugs['fzf.vim'].commit = '279e1ec068f526e985ee7e3f62a71f083bbe0196'
silent! let g:plugs['goyo.vim'].commit = 'fa0263d456dd43f5926484d1c4c7022dfcb21ba9'
silent! let g:plugs['lsp-colors.nvim'].commit = '2bbe7541747fd339bdd8923fc45631a09bb4f1e5'
silent! let g:plugs['lualine.nvim'].commit = '0a5a66803c7407767b799067986b4dc3036e1983'
silent! let g:plugs['markdown-preview.nvim'].commit = 'a923f5fc5ba36a3b17e289dc35dc17f66d0548ee'
silent! let g:plugs['nerdcommenter'].commit = '7bb1f72e802a80e37bdda5f6906c69b5a93de1eb'
silent! let g:plugs['nvim-cmp'].commit = 'b356f2c80cb6c5bae2a65d7f9c82dd5c3fdd6038'
silent! let g:plugs['nvim-lightbulb'].commit = '8f00b89dd1b1dbde16872bee5fbcee2e58c9b8e9'
silent! let g:plugs['nvim-lint'].commit = '941fa1220a61797a51f3af9ec6b7d74c8c7367ce'
silent! let g:plugs['nvim-lsp-file-operations'].commit = '9744b738183a5adca0f916527922078a965515ed'
silent! let g:plugs['nvim-lspconfig'].commit = '92166b89ab4b3d60f24e58170cac53b7141fd032'
silent! let g:plugs['nvim-tree.lua'].commit = '610a1c189bdb2b9b936169b2ea9d1838f971fa2b'
silent! let g:plugs['nvim-treesitter'].commit = '9ebc589329083522f9594f408fc2652090b41139'
silent! let g:plugs['nvim-web-devicons'].commit = 'c0cfc1738361b5da1cd0a962dd6f774cc444f856'
silent! let g:plugs['plenary.nvim'].commit = '2d9b06177a975543726ce5c73fca176cedbffe9d'
silent! let g:plugs['tabular'].commit = '339091ac4dd1f17e225fe7d57b48aff55f99b23a'
silent! let g:plugs['tokyonight.nvim'].commit = 'e4df5bb11d5dd419994c87e81e667847f0389c7e'
silent! let g:plugs['trouble.nvim'].commit = 'fbcf55f2cf3e4bd9350ae7d33081d46286f3393c'
silent! let g:plugs['vim-bbye'].commit = '25ef93ac5a87526111f43e5110675032dbcacf56'
silent! let g:plugs['vim-beancount'].commit = '25bcbc773554b5798d253a1a5fa5de158792f95e'
silent! let g:plugs['vim-css-color'].commit = '950e80352b325ff26d3b0faf95b29e301c200f7d'
silent! let g:plugs['vim-doge'].commit = '188351964c8b2540a69c1d2648b3c6e7877a016f'
silent! let g:plugs['vim-fugitive'].commit = '4f59455d2388e113bd510e85b310d15b9228ca0d'
silent! let g:plugs['vim-gitgutter'].commit = 'e801371917e52805a4ceb1e93f55ed1fba712f82'
silent! let g:plugs['vim-graphql'].commit = 'c1d6af3b93ec135e7e2fc182d4cae6cd0d9e20b1'
silent! let g:plugs['vim-just'].commit = '152d4f62e16140183d6b4500b689f6bf851a6029'
silent! let g:plugs['vim-obsession'].commit = 'fe9d3e1a9a50171e7d316a52e1e56d868e4c1fe5'
silent! let g:plugs['vim-rails'].commit = 'd3954dfe3946c9330dc91b4fbf79ccacb2c626c0'
silent! let g:plugs['vim-repeat'].commit = '24afe922e6a05891756ecf331f39a1f6743d3d5a'
silent! let g:plugs['vim-rhubarb'].commit = 'ee69335de176d9325267b0fd2597a22901d927b1'
silent! let g:plugs['vim-surround'].commit = '3d188ed2113431cf8dac77be61b842acb64433d9'
silent! let g:plugs['vim-svelte'].commit = '0e93ec53c3667753237282926fec626785622c1c'
silent! let g:plugs['vim-unimpaired'].commit = '6d44a6dc2ec34607c41ec78acf81657248580bf1'
silent! let g:plugs['vim-vsnip'].commit = '02a8e79295c9733434aab4e0e2b8c4b7cea9f3a9'
silent! let g:plugs['vim-vsnip-integ'].commit = '1914e72cf3de70df7f5dde476cd299aba2440aef'
