function! neoformat#formatters#rust#enabled() abort
    return ['rustfmt']
endfunction

function! neoformat#formatters#rust#rustfmt() abort
    return {
        \ 'exe': 'rustfmt',
        \ 'args': ['--edition 2021'],
        \ 'stdin': 1
        \ }
endfunction
