"
"  .vimrc - Thomas Barone
"
"""""""""""""
"  PLUGINS  "
"""""""""""""

" Install vim-plug if not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rafi/awesome-vim-colorschemes'

Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim'

Plug 'scrooloose/nerdcommenter'
Plug 'heavenshell/vim-jsdoc'

Plug 'dense-analysis/ale'

Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'

Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
            
Plug 'cristianoliveira/vim-react-html-snippets'
Plug 'epilande/vim-react-snippets'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'hail2u/vim-css3-syntax'
Plug 'groenewege/vim-less'

" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'mhinz/vim-signify'
Plug 'moll/vim-bbye'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'

Plug 'mtth/scratch.vim'

Plug 'junegunn/goyo.vim'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

Plug 'nathangrigg/vim-beancount'

Plug 'vim-latex/vim-latex'
Plug 'ron89/thesaurus_query.vim'

Plug 'ap/vim-css-color'
Plug 'cespare/vim-toml'
Plug 'vim-test/vim-test'
Plug 'aymericbeaumet/vim-symlink'
Plug 'editorconfig/editorconfig-vim'

Plug 'tpope/vim-rails'
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}

call plug#end()

""""""""""""
"  REMAPS  "
""""""""""""
inoremap jk <esc>
tnoremap jk <C-\><C-n>
"vnoremap jk <esc>
noremap j gj
noremap k gk
nnoremap <C-S> :w<Enter>
inoremap <C-s> <Esc>:w<Enter>li
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
map <D-i> <A-i>

nnoremap <C-X> :Bdelete<CR>
nnoremap <C-Q> :q<CR>

nnoremap <C-p> :FZF<CR>

" Auto close
inoremap (; (<CR>);<C-c>O
inoremap (, (<CR>),<C-c>O
inoremap {; {<CR>};<C-c>O
inoremap {, {<CR>},<C-c>O
inoremap [; [<CR>];<C-c>O
inoremap [, [<CR>],<C-c>O

" Disabled EX mode
:map Q <Nop>
nnoremap <C-F> "fyiw:Find<Space><C-R>f


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

"""""""""""""
"  LEADERS  "
"""""""""""""
let mapleader = "\<Space>"
nmap <Leader>v :source ~/.vimrc <Enter>
nmap <Leader>V :tabedit ~/.vimrc
nmap <Leader>s :w<Enter>
nmap <Leader>Q :qa!

nmap <Leader>n :set rnu! <Enter>
vnoremap <Leader>n :set rnu! <Enter>
nmap <Leader>tt :NERDTreeToggle <Enter>
nmap <Leader>tf :NERDTreeFind <Enter>
nmap <Leader>fd :silent exec "!nautilus .&" <Enter>
map <Leader>cc <plug>NERDCommenterComment
map <Leader>cu <plug>NERDCommenterUncomment

map <Leader>mk :make<cr>
map <Leader>mc :make clean<cr>
map <Leader>fo :cw 15<Enter>
map <Leader>fq :ccl<Enter>
map <Leader>rr @

map <Leader>du :diffupdate<cr>

nnoremap <Leader>z <C-w>z:lcl<cr>:ccl<cr>

"nnoremap <Leader>gt :ALEGoToDefinition<cr>
"nnoremap <Leader>gr :ALEFindReferences<cr>
"nnoremap <Leader>gt :YcmCompleter GoTo<cr>
"nnoremap <Leader>gr :YcmCompleter GoToReferences<cr>
"nnoremap <Leader>gf :YcmCompleter FixIt<cr>

"nnoremap <Leader>go :YcmCompleter OrganizeImports<cr>
"nnoremap <silent> K :YcmCompleter GetDoc<CR>

nnoremap <Leader>gs :GFiles?<cr>
nnoremap <Leader>bf :Buffers<cr>

nnoremap <Leader>gy :Goyo<cr>

nnoremap <Leader>jd :JsDoc<cr>

nnoremap <Leader>pr :ALEFix<cr>

""""""""""""""""""""""
"  GENERAL SETTINGS  "
""""""""""""""""""""""
"" Basic editor options
" Numbers in the margin
set number
" Show existing tab with 4 spaces width
set tabstop=4
" When indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" Treat dash seperated words as vim words
set iskeyword-=-

"" Vim specific options
" Hide buffers with unsaved changes
set hidden
" Sync the system clipboard with the unnamed register
set clipboard^=unnamed,unnamedplus
" Open new split panes to the right and the bottom
set splitright
set splitbelow
" Allow modelines
set modeline
" Open menu for completion
set wildmenu
" Show the typed vim commands in status bar
set showcmd
" Modify file instead of saving new one - fixes webpack-dev-server watching 
set backupcopy=yes
" Cycle through completions with tab
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" Open all javascript folds on buffer open
au BufRead *.js normal zR
" enable mouse in all modes - makes things work well with tmux
set mouse=a
" Always show the tab bar
set showtabline=2

set incsearch
set nohlsearch

" Set python3 path
let g:python3_host_prog = '~/.virtualenvs/nvim/bin/python3'

" Disable python 2 support
let g:loaded_python_provider = 1

" set Jenkinsfile to load as a groovy file
au BufNewFile,BufRead Jenkinsfile setf groovy

" set geojson to load as json
au BufNewFile,BufRead *geojson setf json

if &diff
    set noreadonly
endif

"" Theming

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" fixes glitch? in colors when using vim with tmux
set background=dark
colorscheme solarized8

highlight DiffAdd    ctermfg=NONE ctermbg=22
highlight DiffDelete ctermfg=NONE ctermbg=52
highlight DiffChange ctermfg=NONE ctermbg=23
highlight DiffText   ctermfg=NONE ctermbg=23

let g:airline_powerline_fonts = 1
let g:airline_theme='minimalist'

"" Autofolding .vimrc, bashrc
""" defines a foldlevel for each line of code
" see http://vimcasts.org/episodes/writing-a-custom-fold-expression/
" use cstr to specify the type of comment character
function! FileFolds(lnum,cstr)
  let s:thisline = getline(a:lnum)
  "if match(s:thisline, '^"" ') >= 0
  if match(s:thisline, printf('^%s%s ',a:cstr,a:cstr)) >= 0
    return '>2'
  endif
  "if match(s:thisline, '^""" ') >= 0
  if match(s:thisline, printf('^%s%s%s ',a:cstr,a:cstr,a:cstr)) >= 0
    return '>3'
  endif
  let s:two_following_lines = 0
  if line(a:lnum) + 2 <= line('$')
    let s:line_1_after = getline(a:lnum+1)
    let s:line_2_after = getline(a:lnum+2)
    let s:two_following_lines = 1
  endif
  if !s:two_following_lines
      return '='
    endif
  else
    "if (match(s:thisline, '^"""""') >= 0) &&
       "\ (match(s:line_1_after, '^"  ') >= 0) &&
       "\ (match(s:line_2_after, '^""""') >= 0)
    if (match(s:thisline, printf('^%s%s%s%s%s',a:cstr,a:cstr,a:cstr,a:cstr,a:cstr)) >= 0) &&
       \ (match(s:line_1_after, printf('^%s  ',a:cstr)) >= 0) &&
       \ (match(s:line_2_after, printf('^%s%s%s%s',a:cstr,a:cstr,a:cstr,a:cstr)) >= 0)
      return '>1'
    else
      return '='
    endif
  endif
endfunction

""" defines a foldtext
function! FoldText()
  " handle special case of normal comment first
  let s:info = '('.string(v:foldend-v:foldstart).' l)'
  if v:foldlevel == 1
    let s:line = ' ◇ '.getline(v:foldstart+1)[3:-2]
  elseif v:foldlevel == 2
    let s:line = '   ●  '.getline(v:foldstart)[3:]
  elseif v:foldlevel == 3
    let s:line = '     ▪ '.getline(v:foldstart)[4:]
  endif
  if strwidth(s:line) > 80 - len(s:info) - 3
    return s:line[:79-len(s:info)-3+len(s:line)-strwidth(s:line)].'...'.s:info
  else
    return s:line.repeat(' ', 80 - strwidth(s:line) - len(s:info)).s:info
  endif
endfunction


""" set foldsettings for vim files
augroup fold_vimrc
  autocmd!
  autocmd FileType vim 
                   \ setlocal foldmethod=expr |
                   \ setlocal foldexpr=FileFolds(v:lnum,'\"') |
                   \ setlocal foldtext=FoldText() |
     "              \ set foldcolumn=2 foldminlines=2
augroup END 

""" set foldsettings for sh and zsh files
augroup fold_sh
  autocmd!
  autocmd FileType sh,zsh
                   \ setlocal foldmethod=expr |
                   \ setlocal foldexpr=FileFolds(v:lnum,'#') |
                   \ setlocal foldtext=FoldText() |
     "              \ set foldcolumn=2 foldminlines=2
augroup END 

"" Deleting inactive buffers
function! DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
command! DeleteInactiveBuffers :call DeleteInactiveBufs()

"" quickfix buffers
nnoremap <expr> t (&buftype is# "quickfix" ? "<C-W><CR><C-W>T" : "t")
nnoremap <expr> i (&buftype is# "quickfix" ? "<C-W><CR><C-W>K" : "i")
nnoremap <expr> s (&buftype is# "quickfix" ? "<C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t" : "s")

"""""""""""""""""""""
"  PLUGIN SETTINGS  "
"""""""""""""""""""""
"" Ctrl-p
let g:ctrlp_arg_map = 1
let g:ctrlp_working_path_mode = 'c'

"" NERDtree
let NERDTreeIgnore = ['\.aux$', '\.bbl$', '\.blg$', '\.ilg$', '\.idx$', '\.gz$','\.ind$', '\.lof$', '\.log$', '\.lot$', '\.out$', '\.latexmain$', '\.toc$']
let NERDTreeShowHidden=1
let g:NERDTreeMouseMode = 3

"" NERDCommenter
let g:NERDCreateDefaultMappings = 0

"" Ultisnips
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="tabdo"

let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/plugged/vim-react-html-snippets', $HOME.'/.vim/plugged/vim-react-snippets', $HOME.'/.vim/plugged/vim-snippets', $HOME.'/.vim/custom-snips']

"" Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_javascript_eslint_exe = 'yarn eslint'
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
""let g:syntastic_debug=3
"let g:syntastic_debug=0
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_javascript_checkers = ['eslint']


"" YouCompleteMe
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0 
let g:ycm_enable_diagnostic_highlighting = 0

let g:ycm_python_binary_path = 'python'

let g:ycm_auto_trigger = 1

" Semantic triggers for css/less/sass files
let g:ycm_semantic_triggers = {
    \   'css': [ 're!^', 're!^\s+', ': ' ],
    \   'scss': [ 're!^', 're!^\s+', ': ' ],
    \   'less': [ 're!^', 're!^\s+', ': ' ],
    \ }

" Turn off confirmation on load
let g:ycm_confirm_extra_conf = 0

" Use YCM for all filetypes
let g:ycm_filetype_blacklist = {}

"" Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"" vim-session
let g:session_autosave = 'no'

"" vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END

"" ALE
" This setting must be set before ALE is loaded.
"let g:ale_completion_enabled = 1
"set completeopt=menu,menuone,preview,noselect,noinsert
"let g:ale_open_list = 1
let g:ale_disable_lsp = 1

function! FormatERuby(buffer) abort
    return {
    \   'command': 'htmlbeautifier'
    \}
endfunction

execute ale#fix#registry#Add('htmlbeautifier', 'FormatERuby', ['eruby'], 'htmlbeautifier for eruby')

let g:ale_fixers = { 
            \'eruby': ['htmlbeautifier'],
            \'go': ['gofmt'],
            \'json': ['prettier'], 
            \'javascript': ['prettier'], 
            \'less' : ['prettier'], 
            \'markdown': ['prettier'],
            \'python': ['yapf'], 
            \'ruby' : ['rubocop', 'prettier'], 
            \'scss' : ['prettier'], 
            \'sh' : ['shfmt'], 
            \'sql': ['pgformatter'], 
            \'svg': ['xmllint'],
            \'tsx': ['prettier'], 
            \'typescript': ['prettier'], 
            \'yaml': ['prettier']
            \}
let g:ale_linters = {
            \'javascript': ['eslint'], 
            \'less' : [''], 
            \'python': ['prospector'],
            \'ruby' : ['rubocop'], 
            \'sh' : ['shellcheck'], 
            \'tsx': ['eslint', 'tsserver'], 
            \'typescript': ['eslint', 'tsserver'], 
            \'yaml': ['yamllint']
            \}
let g:ale_linters_explicit = 1

"let g:ale_xml_xmllint_options = '--c14n'        
"let g:ale_javascript_eslint_executable = 'yarn eslint' 
"let g:ale_tsx_eslint_executable = 'yarn eslint' 

let g:ale_javascript_eslint_executable = 'eslint' 
"let g:ale_javascript_eslint_options = '--config=../eslintrc.js --ignore-path=../eslintignore --ext=.js,.jsx,.ts,.tsx'
"let g:ale_tsx_eslint_options = '--config=../eslintrc.js --ignore-path=../eslintignore --ext=.js,.jsx,.ts,.tsx'
"let g:ale_javascript_eslint_use_global = 1

let g:ale_python_yapf_options = '--style pep8'
"let g:ale_python_prospector_executable = '~/.virtualenvs/nvim/bin/python3 -m prospector'

"let g:ale_python_prospector_options = '-m prospector'
let g:ale_yaml_yamllint_options = '-d relaxed'
"let g:ale_virtualenv_dir_names = ['/home/tomb/.local/share/virtualenvs/.vim-lrMxc1SW/']
let g:ale_virtualenv_dir_names = []

"" Signify
let g:signify_vcs_list = [ 'git' ]

"" Scratch
let g:scratch_insert_autohide = 0

"" FZF
let g:fzf_buffers_jump = 1

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

"" Sessions
" Turn off branch suggestions
let g:session_name_suggestion_function = 0

"" vim-latex
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
imap <D-b> <Plug>Tex_MathBF	
imap <D-c> <Plug>Tex_MathCal
imap <D-l> <Plug>Tex_LeftRight
imap <D-i> <Plug>Tex_InsertItemOnThisLine

" F5 environment mappings
map <D-I> <F5>
imap <D-I> <F5>
map <D-O> <S-F5>
imap <D-O> <S-F5>

" F7 command mappings
map <D-J> <F7>
imap <D-J> <F7>
map <D-K> <S-F7>
imap <D-K> <S-F7>

"http://stackoverflow.com/questions/12650528/viewing-pdfs-with-vim-latex-suite-start-preview-shell-returned-127
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf,bibtex,pdf'
let g:Tex_TreatMacViewerAsUNIX = 1
let g:Tex_ExecuteUNIXViewerInForeground = 1
let g:Tex_ViewRule_ps = 'open -a Skim'
let g:Tex_ViewRule_pdf = 'open -a Skim'
"let g:Tex_UseMakefile = 1

"" Goyo
" Turn off branch suggestions
autocmd! User GoyoEnter set linebreak
autocmd! User GoyoLeave set nolinebreak
let g:goyo_width=100

"" markdown-preview
" Don't close the window when changing to a different buffer
let g:mkdp_auto_close = 0

"" vim-test
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
let test#strategy = "neovim"

"" coc.nvim

let g:coc_global_extensions = [
      \'coc-marketplace',
      \'coc-snippets',
      \'coc-solargraph',
      \'coc-jedi',
      \'coc-sh'
      \]

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


