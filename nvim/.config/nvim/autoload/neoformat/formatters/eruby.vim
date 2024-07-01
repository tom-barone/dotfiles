" TODO: replace with Conform
"
"function! neoformat#formatters#eruby#enabled() abort
"    return ['htmlbeautifier', 'erbformatter']
"endfunction

"function! neoformat#formatters#eruby#htmlbeautifier() abort
"    return {
"        \ 'exe': 'htmlbeautifier',
"        \ 'stdin': 1
"        \ }
"endfunction

"function! neoformat#formatters#eruby#erbformatter() abort
"    return {
"        \ 'exe': 'erb-format',
"        \ 'args': ['--stdin'],
"        \ 'stdin': 1
"        \ }
"endfunction
