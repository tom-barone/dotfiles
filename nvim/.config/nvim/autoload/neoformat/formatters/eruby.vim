function! neoformat#formatters#eruby#enabled() abort
    return ['htmlbeautifier']
endfunction

function! neoformat#formatters#eruby#prettier() abort
    return {
        \ 'exe': 'htmlbeautifier',
        \ 'stdin': 1
        \ }
endfunction
