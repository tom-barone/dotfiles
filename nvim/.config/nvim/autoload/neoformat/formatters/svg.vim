function! neoformat#formatters#svg#enabled() abort
    return ['prettier']
endfunction

function! neoformat#formatters#svg#prettier() abort
    return {
        \ 'exe': 'prettier',
        \ 'args': ['--stdin-filepath', '"%:p"', '--parser', 'html'],
        \ 'stdin': 1,
        \ 'try_node_exe': 1,
        \ }
endfunction
