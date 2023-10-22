function! neoformat#formatters#eruby#enabled() abort
    return ['htmlbeautifier']
endfunction

function! neoformat#formatters#eruby#htmlbeautifier() abort
    return {
        \ 'exe': 'htmlbeautifier',
        \ 'stdin': 1
        \ }
endfunction
