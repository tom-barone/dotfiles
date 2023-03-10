let g:neoformat_enabled_eruby = ['prettier']
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_lua = ['stylua']
let g:neoformat_enabled_python = ['yapf']
" Make rubocop do unsafe auto-corrects
let g:neoformat_ruby_rubocop = {
		\ 'exe': 'rubocop',
		\ 'args': ['--auto-correct-all', '--stdin', '"%:p"', '2>/dev/null', '|', 'sed "1,/^====================$/d"'],
		\ 'stdin': 1,
		\ 'stderr': 1
		\ }
let g:neoformat_enabled_ruby = ['rubocop']
let g:neoformat_enabled_sql = ['sqlformat']
let g:neoformat_enabled_yaml = ['prettier']
let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_rust = ['rustfmt']

" Enable basic formatting
let g:neoformat_basic_format_trim = 1
let g:neoformat_try_formatprg = 1

" Run all configured formatters
let g:neoformat_run_all_formatters = 1

" Look in the current node_modules for things like local prettier installs
let g:neoformat_try_node_exe = 1

" NOTE: See verbose error messages
"let g:neoformat_verbose = 1
