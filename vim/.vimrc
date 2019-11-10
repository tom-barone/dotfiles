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

Plug 'ericbn/vim-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'scrooloose/nerdtree'
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'

Plug 'scrooloose/nerdcommenter'
Plug 'heavenshell/vim-jsdoc'

Plug 'w0rp/ale'

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

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

Plug 'Valloric/YouCompleteMe'

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

call plug#end()

""""""""""""
"  REMAPS  "
""""""""""""
inoremap jk <esc>
vnoremap jk <esc>
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

map <Leader>mk :make<cr>
map <Leader>mc :make clean<cr>
map <Leader>fo :cw 15<Enter>
map <Leader>fq :ccl<Enter>
map <Leader>rr @

map <Leader>du :diffupdate<cr>

nnoremap <Leader>z <C-w>z

"nnoremap <Leader>gt :ALEGoToDefinition<cr>
"nnoremap <Leader>gr :ALEFindReferences<cr>
nnoremap <Leader>gt :YcmCompleter GoTo<cr>
nnoremap <Leader>gr :YcmCompleter GoToReferences<cr>

nnoremap <Leader>go :YcmCompleter OrganizeImports<cr>
nnoremap <silent> K :YcmCompleter GetDoc<CR>

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

set incsearch
set nohlsearch

" Disable python 2 support
let g:loaded_python_provider = 1

" set Jenkinsfile to load as a groovy file
au BufNewFile,BufRead Jenkinsfile setf groovy

"" Theming
set t_Co=256
colorscheme solarized
set background=dark

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

""" set foldsettings for sh files
augroup fold_sh
  autocmd!
  autocmd FileType sh 
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

"" Ultisnips
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="tabdo"

let g:UltiSnipsSnippetsDir = '/home/tomb/.vim/custom-snips'
let g:UltiSnipsSnippetDirectories = ['/home/tomb/.vim/custom-snips', 'UltiSnips']

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

"" vim-prettier
"let g:prettier#autoformat = 0
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

"let g:prettier#config#print_width = 80
"let g:prettier#config#tab_width = 2
"let g:prettier#config#use_tabs = 'false'
"let g:prettier#config#semi = 'true'
"let g:prettier#config#single_quote = 'false'
"let g:prettier#config#bracket_spacing = 'true'
"let g:prettier#config#jsx_bracket_same_line = 'false'
"let g:prettier#config#arrow_parens = 'avoid'
"let g:prettier#config#trailing_comma = 'none'
"let g:prettier#config#parser = 'babylon'


"" YouCompleteMe
"let g:ycm_show_diagnostics_ui = 0

" Semantic triggers for css/less/sass files
let g:ycm_semantic_triggers = {
    \   'css': [ 're!^', 're!^\s+', ': ' ],
    \   'scss': [ 're!^', 're!^\s+', ': ' ],
    \   'less': [ 're!^', 're!^\s+', ': ' ],
    \ }

" Turn off confirmation on load
let g:ycm_confirm_extra_conf = 0

"" Ack
let g:ackprg = 'ag --vimgrep'

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

let g:ale_fixers_aliases = {'jsx': ['css', 'javascript']}
let g:ale_fixers = { 
            \'jsx': ['prettier'], 
            \'tsx': ['prettier'], 
            \'typescript': ['prettier'], 
            \'less' : ['prettier'], 
            \'scss' : ['prettier'], 
            \'python': ['yapf'], 
            \'json': ['fixjson'], 
            \'sql': ['pgformatter'], 
            \'svg': ['xmllint'],
            \'markdown': ['prettier'],
            \'go': ['gofmt'] 
            \}
let g:ale_linter_aliases = {'jsx': ['css', 'javascript', 'tsx', 'typescript']}
let g:ale_linters = {
            \'jsx': ['eslint'], 
            \'tsx': ['eslint'], 
            \'typescript': ['eslint'], 
            \'less' : [''], 
            \'python': ['prospector']
            \}
let g:ale_linters_explicit = 1

"let g:ale_xml_xmllint_options = '--c14n'        
let g:ale_javascript_eslint_executable = 'yarn' 
let g:ale_javascript_eslint_options = 'eslint'        
let g:ale_javascript_eslint_use_global = 1

let g:ale_python_yapf_options = '--style pep8'
"let g:ale_virtualenv_dir_names = ['/home/tomb/.local/share/virtualenvs/.vim-lrMxc1SW/']
let g:ale_virtualenv_dir_names = []

"" Signify
let g:signify_vcs_list = [ 'git' ]

"" Scratch
let g:scratch_insert_autohide = 0

"" FZF
let g:fzf_buffers_jump = 1

"" Sessions
" Turn off branch suggestions
let g:session_name_suggestion_function = 0
