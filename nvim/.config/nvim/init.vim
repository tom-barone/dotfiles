" Neovim settings
" Vim code here

" Install vim-plug if it doesn't exist
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')

" Good plugins source
" https://github.com/rockerBOO/awesome-neovim/blob/main/README.md
"

Plug 'airblade/vim-gitgutter'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'folke/trouble.nvim'
Plug 'github/copilot.vim'
Plug 'godlygeek/tabular'
Plug 'gpanders/editorconfig.nvim'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kosayoda/nvim-lightbulb'
Plug 'mfussenegger/nvim-lint'
Plug 'nathangrigg/vim-beancount'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'ojroques/nvim-hardline'
Plug 'preservim/nerdcommenter'
Plug 'rafamadriz/friendly-snippets'
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'weilbith/nvim-code-action-menu'

"
"Plug 'antoinemadec/FixCursorHold.nvim'
"Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
"Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
"Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
"Plug 'scrooloose/nerdtree'
"Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-rails'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'dense-analysis/ale'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }"
"Plug 'junegunn/fzf.vim'
"Plug 'ap/vim-css-color'
"Plug 'cespare/vim-toml'
"Plug 'vim-test/vim-test'
"Plug 'aymericbeaumet/vim-symlink'
"Plug 'editorconfig/editorconfig-vim'
"Plug 'hrsh7th/cmp-nvim-lsp'
"Plug 'hrsh7th/cmp-buffer'
"Plug 'hrsh7th/cmp-path'
"Plug 'hrsh7th/cmp-cmdline'
"Plug 'hrsh7th/nvim-cmp'
"Plug 'nvim-lua/plenary.nvim'
"Plug 'nvim-telescope/telescope.nvim'
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'kyazdani42/nvim-web-devicons'
"Plug 'quangnguyen30192/cmp-nvim-ultisnips'

call plug#end()

"""""""""""""
""  REMAPS  "
"""""""""""""
"inoremap jk <esc>
"tnoremap jk <C-\><C-n>
"noremap j gj
"noremap k gk
"nnoremap <C-S> :w<Enter>
"inoremap <C-s> <Esc>:w<Enter>li

"" Scroll by 3 rows at a time
"nnoremap <C-e> 3<C-e>
"nnoremap <C-y> 3<C-y>
"map <D-i> <A-i>

"nnoremap <C-X> :Bdelete<CR>
"nnoremap <C-Q> :q<CR>

"" Auto close
"inoremap (; (<CR>);<C-c>O
"inoremap (, (<CR>),<C-c>O
"inoremap {; {<CR>};<C-c>O
"inoremap {, {<CR>},<C-c>O
"inoremap [; [<CR>];<C-c>O
"inoremap [, [<CR>],<C-c>O

"" Disabled EX mode
":map Q <Nop>


"" Search for selected text, forwards or backwards.
"vnoremap <silent> * :<C-U>
  "\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  "\gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  "\escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  "\gVzv:call setreg('"', old_reg, old_regtype)<CR>
"vnoremap <silent> # :<C-U>
  "\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  "\gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  "\escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  "\gVzv:call setreg('"', old_reg, old_regtype)<CR>

""""""""""""""
""  LEADERS  "
""""""""""""""
"let mapleader = "\<Space>"
"nmap <Leader>v :source $MYVIMRC <Enter>
"nmap <Leader>V :tabedit ~/.vimrc
"nmap <Leader>L :tabedit ~/.config/nvim/lua/init.lua
"nmap <Leader>s :w<Enter>
"nmap <Leader>Q :qa!

"nmap <Leader>tt :NERDTreeToggle <Enter>
"nmap <Leader>tf :NERDTreeFind <Enter>
"map <Leader>cc <plug>NERDCommenterComment
"map <Leader>cu <plug>NERDCommenterUncomment


"" Beancount shortcuts
"nnoremap <Leader>be :!PYTHONPATH=. poetry run bean-extract import.py ~/Downloads > temp.beancount<cr><cr>

"nnoremap <C-t> <Cmd>Telescope find_files find_command=rg,--hidden,--glob,!.git/*,--files<Enter>
"nnoremap <leader>fb <Cmd>Telescope buffers<cr>
"nnoremap <leader>lg <Cmd>Telescope live_grep<cr>
"nnoremap <leader>gs <Cmd>Telescope git_status<cr>

"nnoremap <leader>xx <Cmd>TroubleToggle<cr>
"nnoremap <leader>xw <Cmd>TroubleToggle workspace_diagnostics<cr>
"nnoremap <leader>xd <Cmd>TroubleToggle document_diagnostics<cr>

"nmap <Leader>pr <Cmd>Neoformat<Enter>


"""""""""""""""""""""""
""  GENERAL SETTINGS  "
"""""""""""""""""""""""
""" Basic editor options
"" Numbers in the margin
"set number
"" Show existing tab with 4 spaces width
"set tabstop=4
"" When indenting with '>', use 4 spaces width
"set shiftwidth=4
"" On pressing tab, insert 4 spaces
"set expandtab
"" Treat dash seperated words as vim words
"set iskeyword-=-
"" Highlight the current line that the cursor is on
"set cursorline

"set completeopt=menu,menuone,noselect

""" Vim specific options
"" Hide buffers with unsaved changes
"set hidden
"" Sync the system clipboard with the unnamed register
"set clipboard^=unnamed,unnamedplus
"" Open new split panes to the right and the bottom
"set splitright
"set splitbelow
"" Allow modelines
"set modeline
"" Open menu for completion
"set wildmenu
"" Show the typed vim commands in status bar
"set showcmd
"" Modify file instead of saving new one - fixes webpack-dev-server watching
"set backupcopy=yes
"" Cycle through completions with tab
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" Open all javascript folds on buffer open
"au BufRead *.js normal zR
"" enable mouse in all modes - makes things work well with tmux
"set mouse=a
"" Always show the tab bar
"set showtabline=2
"" Always show the sign column for things like git gutter
"set signcolumn=yes

"set incsearch
"set nohlsearch

"" Set python3 path
"let g:python3_host_prog = '~/.virtualenvs/nvim/bin/python3'

"" Disable python 2 support
"let g:loaded_python_provider = 1

"" Disable perl support
"let g:loaded_perl_provider = 0

""" set Jenkinsfile to load as a groovy file
""au BufNewFile,BufRead Jenkinsfile setf groovy

""" set geojson to load as json
""au BufNewFile,BufRead *geojson setf json

""if &diff
    ""set noreadonly
""endif

""" Theming

"if exists('+termguicolors')
  ""let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  ""let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  "set termguicolors
"endif

"set background=dark
"autocmd vimenter * ++nested colorscheme solarized8

""highlight DiffAdd    ctermfg=NONE ctermbg=22
""highlight DiffDelete ctermfg=NONE ctermbg=52
""highlight DiffChange ctermfg=NONE ctermbg=23
""highlight DiffText   ctermfg=NONE ctermbg=23

"let g:airline_powerline_fonts = 1
"let g:airline_theme='minimalist'

"""" Autofolding .vimrc, bashrc
""""" defines a foldlevel for each line of code
""" see http://vimcasts.org/episodes/writing-a-custom-fold-expression/
""" use cstr to specify the type of comment character
""function! FileFolds(lnum,cstr)
  ""let s:thisline = getline(a:lnum)
  """if match(s:thisline, '^"" ') >= 0
  ""if match(s:thisline, printf('^%s%s ',a:cstr,a:cstr)) >= 0
    ""return '>2'
  ""endif
  """if match(s:thisline, '^""" ') >= 0
  ""if match(s:thisline, printf('^%s%s%s ',a:cstr,a:cstr,a:cstr)) >= 0
    ""return '>3'
  ""endif
  ""let s:two_following_lines = 0
  ""if line(a:lnum) + 2 <= line('$')
    ""let s:line_1_after = getline(a:lnum+1)
    ""let s:line_2_after = getline(a:lnum+2)
    ""let s:two_following_lines = 1
  ""endif
  ""if !s:two_following_lines
      ""return '='
    ""endif
  ""else
    """if (match(s:thisline, '^"""""') >= 0) &&
       """\ (match(s:line_1_after, '^"  ') >= 0) &&
       """\ (match(s:line_2_after, '^""""') >= 0)
    ""if (match(s:thisline, printf('^%s%s%s%s%s',a:cstr,a:cstr,a:cstr,a:cstr,a:cstr)) >= 0) &&
       ""\ (match(s:line_1_after, printf('^%s  ',a:cstr)) >= 0) &&
       ""\ (match(s:line_2_after, printf('^%s%s%s%s',a:cstr,a:cstr,a:cstr,a:cstr)) >= 0)
      ""return '>1'
    ""else
      ""return '='
    ""endif
  ""endif
""endfunction

""""" defines a foldtext
""function! FoldText()
  """ handle special case of normal comment first
  ""let s:info = '('.string(v:foldend-v:foldstart).' l)'
  ""if v:foldlevel == 1
    ""let s:line = ' ??? '.getline(v:foldstart+1)[3:-2]
  ""elseif v:foldlevel == 2
    ""let s:line = '   ???  '.getline(v:foldstart)[3:]
  ""elseif v:foldlevel == 3
    ""let s:line = '     ??? '.getline(v:foldstart)[4:]
  ""endif
  ""if strwidth(s:line) > 80 - len(s:info) - 3
    ""return s:line[:79-len(s:info)-3+len(s:line)-strwidth(s:line)].'...'.s:info
  ""else
    ""return s:line.repeat(' ', 80 - strwidth(s:line) - len(s:info)).s:info
  ""endif
""endfunction


""""" set foldsettings for vim files
""augroup fold_vimrc
  ""autocmd!
  ""autocmd FileType vim
                   ""\ setlocal foldmethod=expr |
                   ""\ setlocal foldexpr=FileFolds(v:lnum,'\"') |
                   ""\ setlocal foldtext=FoldText() |
     """              \ set foldcolumn=2 foldminlines=2
""augroup END

""""" set foldsettings for sh and zsh files
""augroup fold_sh
  ""autocmd!
  ""autocmd FileType sh,zsh
                   ""\ setlocal foldmethod=expr |
                   ""\ setlocal foldexpr=FileFolds(v:lnum,'#') |
                   ""\ setlocal foldtext=FoldText() |
     """              \ set foldcolumn=2 foldminlines=2
""augroup END

"""" Deleting inactive buffers
""function! DeleteInactiveBufs()
    """From tabpagebuflist() help, get a list of all buffers in all tabs
    ""let tablist = []
    ""for i in range(tabpagenr('$'))
        ""call extend(tablist, tabpagebuflist(i + 1))
    ""endfor

    """Below originally inspired by Hara Krishna Dara and Keith Roberts
    """http://tech.groups.yahoo.com/group/vim/message/56425
    ""let nWipeouts = 0
    ""for i in range(1, bufnr('$'))
        ""if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        """bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            ""silent exec 'bwipeout' i
            ""let nWipeouts = nWipeouts + 1
        ""endif
    ""endfor
    ""echomsg nWipeouts . ' buffer(s) wiped out'
""endfunction
""command! DeleteInactiveBuffers :call DeleteInactiveBufs()

""" quickfix buffers
""nnoremap <expr> t (&buftype is# "quickfix" ? "<C-W><CR><C-W>T" : "t")
""nnoremap <expr> i (&buftype is# "quickfix" ? "<C-W><CR><C-W>K" : "i")
""nnoremap <expr> s (&buftype is# "quickfix" ? "<C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t" : "s")

""""""""""""""""""""""
""  PLUGIN SETTINGS  "
""""""""""""""""""""""



""" NeoFormat
""let g:neoformat_ruby_rubocop = {
  ""\ 'exe': 'rubocop',
  ""\ 'args': ['--auto-correct-all', '--stdin', '"%:p"', '2>/dev/null', '|', 'sed "1,/^====================$/d"'],
  ""\ 'stdin': 1,
  ""\ 'stderr': 1
  ""\ }

"let g:neoformat_enabled_eruby = ['prettier']
"let g:neoformat_enabled_javascript = ['prettier']
"let g:neoformat_enabled_python = ['black']
"let g:neoformat_enabled_ruby = ['prettier', 'rubocop']
"let g:neoformat_enabled_yaml = ['prettier']
"" Enable basic formatting
"let g:neoformat_basic_format_trim = 1
"" Run all configured formatters
"let g:neoformat_run_all_formatters = 1
"let g:neoformat_try_node_exe = 1
"" See verbose error messages
""let g:neoformat_verbose = 1


""" NERDtree
"let NERDTreeIgnore = ['\.aux$', '\.bbl$', '\.blg$', '\.ilg$', '\.idx$', '\.gz$','\.ind$', '\.lof$', '\.log$', '\.lot$', '\.out$', '\.latexmain$', '\.toc$']
"let NERDTreeShowHidden=1
"let g:NERDTreeMouseMode = 3

""" NERDCommenter
"let g:NERDCreateDefaultMappings = 0

""" Ultisnips
"let g:UltiSnipsExpandTrigger="<c-k>"
"let g:UltiSnipsJumpForwardTrigger="<c-k>"
"let g:UltiSnipsJumpBackwardTrigger="<c-b>"
"let g:UltiSnipsEditSplit="tabdo"

"let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/plugged/vim-react-html-snippets', $HOME.'/.vim/plugged/vim-react-snippets', $HOME.'/.vim/plugged/vim-snippets', $HOME.'/.vim/custom-snips']




""" ALE

""let g:ale_disable_lsp = 1

""function! FormatERuby(buffer) abort
    ""return {
    ""\   'command': 'htmlbeautifier'
    ""\}
""endfunction

""execute ale#fix#registry#Add('htmlbeautifier', 'FormatERuby', ['eruby'], 'htmlbeautifier for eruby')

""let g:ale_fixers = {
            ""\'eruby': ['htmlbeautifier'],
            ""\'go': ['gofmt'],
            ""\'json': ['prettier'],
            ""\'javascript': ['prettier'],
            ""\'less' : ['prettier'],
            ""\'markdown': ['prettier'],
            ""\'python': ['yapf'],
            ""\'ruby' : ['rubocop', 'prettier'],
            ""\'scss' : ['prettier'],
            ""\'sh' : ['shfmt'],
            ""\'sql': ['pgformatter'],
            ""\'svg': ['xmllint'],
            ""\'tsx': ['prettier'],
            ""\'typescript': ['prettier'],
            ""\'yaml': ['prettier']
            ""\}
""let g:ale_linters = {
            ""\'javascript': ['eslint'],
            ""\'less' : [''],
            ""\'python': ['prospector'],
            ""\'ruby' : ['rubocop'],
            ""\'sh' : ['shellcheck'],
            ""\'tsx': ['eslint', 'tsserver'],
            ""\'typescript': ['eslint', 'tsserver'],
            ""\'yaml': ['yamllint']
            ""\}
""let g:ale_linters_explicit = 1
""let g:ale_javascript_eslint_executable = 'eslint'
""let g:ale_python_yapf_options = '--style pep8'
""let g:ale_yaml_yamllint_options = '-d relaxed'
""let g:ale_virtualenv_dir_names = []

""" Signify
"let g:signify_vcs_list = [ 'git' ]

""" Scratch
"let g:scratch_insert_autohide = 0
"let g:scratch_height = 2

""" FZF
""let g:fzf_buffers_jump = 1


""" Sessions
"" Turn off branch suggestions
"let g:session_name_suggestion_function = 0

""" vim-latex
"set grepprg=grep\ -nH\ $*
"let g:tex_flavor='latex'
"imap <D-b> <Plug>Tex_MathBF
"imap <D-c> <Plug>Tex_MathCal
"imap <D-l> <Plug>Tex_LeftRight
"imap <D-i> <Plug>Tex_InsertItemOnThisLine

"" F5 environment mappings
"map <D-I> <F5>
"imap <D-I> <F5>
"map <D-O> <S-F5>
"imap <D-O> <S-F5>

"" F7 command mappings
"map <D-J> <F7>
"imap <D-J> <F7>
"map <D-K> <S-F7>
"imap <D-K> <S-F7>

""http://stackoverflow.com/questions/12650528/viewing-pdfs-with-vim-latex-suite-start-preview-shell-returned-127
"let g:tex_flavor='latex'
"let g:Tex_DefaultTargetFormat='pdf'
"let g:Tex_MultipleCompileFormats='pdf,bibtex,pdf'
"let g:Tex_TreatMacViewerAsUNIX = 1
"let g:Tex_ExecuteUNIXViewerInForeground = 1
"let g:Tex_ViewRule_ps = 'open -a Skim'
"let g:Tex_ViewRule_pdf = 'open -a Skim'
""let g:Tex_UseMakefile = 1

""" Goyo
"" Turn off branch suggestions
"autocmd! User GoyoEnter set linebreak
"autocmd! User GoyoLeave set nolinebreak
"let g:goyo_width=100

""" markdown-preview
"" Don't close the window when changing to a different buffer
"let g:mkdp_auto_close = 0

""" vim-test
"nmap <silent> t<C-n> :TestNearest<CR>
"nmap <silent> t<C-f> :TestFile<CR>
"nmap <silent> t<C-s> :TestSuite<CR>
"nmap <silent> t<C-l> :TestLast<CR>
"nmap <silent> t<C-g> :TestVisit<CR>
"let test#strategy = "neovim"

""" coc.nvim

""let g:coc_global_extensions = [
      ""\'coc-snippets',
      ""\'coc-solargraph',
      ""\'coc-pyright',
      ""\'coc-yaml'
      ""\]

""" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
""" delays and poor user experience.
""set updatetime=300

""" Don't pass messages to |ins-completion-menu|.
""set shortmess+=c

""" Always show the signcolumn, otherwise it would shift the text each time
""" diagnostics appear/become resolved.
""if has("nvim-0.5.0") || has("patch-8.1.1564")
  """ Recently vim can merge signcolumn and number column into one
  ""set signcolumn=number
""else
  ""set signcolumn=yes
""endif

""" Use tab for trigger completion with characters ahead and navigate.
""" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
""" other plugin before putting this into your config.
""inoremap <silent><expr> <TAB>
      ""\ pumvisible() ? "\<C-n>" :
      ""\ <SID>check_back_space() ? "\<TAB>" :
      ""\ coc#refresh()
""inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
""function! s:check_back_space() abort
  ""let col = col('.') - 1
  ""return !col || getline('.')[col - 1]  =~# '\s'
""endfunction

""" Make <CR> auto-select the first completion item and notify coc.nvim to
""" format on enter, <cr> could be remapped by other vim plugin
""inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              ""\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

""" GoTo code navigation.
""nmap <silent> <leader>gd <Plug>(coc-definition)
""nmap <silent> <leader>gy <Plug>(coc-type-definition)
""nmap <silent> <leader>gi <Plug>(coc-implementation)
""nmap <silent> <leader>gr <Plug>(coc-references)

""" Use K to show documentation in preview window.
""nnoremap <silent> K :call <SID>show_documentation()<CR>

""function! s:show_documentation()
  ""if (index(['vim','help'], &filetype) >= 0)
    ""execute 'h '.expand('<cword>')
  ""elseif (coc#rpc#ready())
    ""call CocActionAsync('doHover')
  ""else
    ""execute '!' . &keywordprg . " " . expand('<cword>')
  ""endif
""endfunction

""" Highlight the symbol and its references when holding the cursor.
""autocmd CursorHold * silent call CocActionAsync('highlight')

""" Symbol renaming.
""nmap <leader>rn <Plug>(coc-rename)

""augroup mygroup
  ""autocmd!
  """ Setup formatexpr specified filetype(s).
  ""autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  """ Update signature help on jump placeholder.
  ""autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
""augroup end

"""" Applying codeAction to the selected region.
"""" Example: `<leader>aap` for current paragraph
"""xmap <leader>a  <Plug>(coc-codeaction-selected)
"""nmap <leader>a  <Plug>(coc-codeaction-selected)

""" Remap keys for applying codeAction to the current buffer.
""nmap <leader>ac  <Plug>(coc-codeaction)
""" Apply AutoFix to problem on the current line.
""nmap <leader>qf  <Plug>(coc-fix-current)

""" Use CTRL-S for selections ranges.
""" Requires 'textDocument/selectionRange' support of language server.
"""nmap <silent> <C-s> <Plug>(coc-range-select)
"""xmap <silent> <C-s> <Plug>(coc-range-select)

""" Add `:Format` command to format current buffer & organise imports
""command! -nargs=0 Format :call CocAction('format') "| :call CocAction('runCommand', 'editor.action.organizeImport')

""" Add `:Fold` command to fold current buffer.
"""command! -nargs=? Fold :call     CocAction('fold', <f-args>)

""" Add `:OR` command for organize imports of the current buffer.
"""command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

""" Add (Neo)Vim's native statusline support.
""" NOTE: Please see `:h coc-status` for integrations with external plugins that
""" provide custom statusline: lightline.vim, vim-airline.
""set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

""" Mappings for CoCList
""" Show all diagnostics.
""nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
""" Manage extensions.
"""nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
""" Show commands.
""" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
""" Find symbol of current document.
""" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
""" Search workspace symbols.
""" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
""" Do default action for next item.
""" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
""" Do default action for previous item.
""" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
""" Resume latest coc list.
""" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


