let g:neoformat_enabled_eruby = ['prettier']
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_lua = ['stylua']
let g:neoformat_enabled_python = ['yapf']
let g:neoformat_enabled_ruby = ['rubocop']
let g:neoformat_enabled_sql = ['sqlformat']
let g:neoformat_enabled_yaml = ['prettier']

" Enable basic formatting
let g:neoformat_basic_format_trim = 1
let g:neoformat_try_formatprg = 1

" Run all configured formatters
let g:neoformat_run_all_formatters = 1

" Look in the current node_modules for things like local prettier installs
let g:neoformat_try_node_exe = 1

" NOTE: See verbose error messages
"let g:neoformat_verbose = 1
