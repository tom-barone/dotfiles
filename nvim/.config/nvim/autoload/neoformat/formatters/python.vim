" TODO: replace with Conform


"function! neoformat#formatters#python#enabled() abort
"    return ['tidy_imports', 'ruff_fix', 'ruff_format']
"endfunction

"function! neoformat#formatters#python#tidy_imports() abort
"    return {
"        \ 'exe': 'tidy-imports',
"        \ 'args': ['--quiet'],
"        \ 'stdin': 1,
"        \ }
"endfunction

"function! neoformat#formatters#python#isort() abort
"    return {
"                \ 'exe': 'isort',
"                \ 'args': ['-', '--quiet',],
"                \ 'stdin': 1,
"                \ }
"endfunction

"function! neoformat#formatters#python#ruff_fix() abort
"    " Always return a 0 exit code
"    return {
"                \ 'exe': 'ruff',
"                \ 'args': ['check', '--select', 'I', '--fix', '--unsafe-fixes', '--exit-zero', '-'],
"                \ 'stdin': 1,
"                \ }
"endfunction

"function! neoformat#formatters#python#ruff_format() abort
"    return {
"                \ 'exe': 'ruff',
"                \ 'args': ['format', '-q', '-'],
"                \ 'stdin': 1,
"                \ }
"endfunction
