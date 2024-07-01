function! neoformat#formatters#python#enabled() abort
    return ['ruff', 'tidy_imports' ,'isort']
endfunction

function! neoformat#formatters#python#tidy_imports() abort
    return {
        \ 'exe': 'tidy-imports',
        \ 'stdin': 1
        \ }
endfunction

function! neoformat#formatters#python#isort() abort
    return {
                \ 'exe': 'isort',
                \ 'args': ['-', '--quiet',],
                \ 'stdin': 1,
                \ }
endfunction

function! neoformat#formatters#python#ruff() abort
    return {
                \ 'exe': 'ruff',
                \ 'stdin': 1,
                \ 'args': ['format', '-q', '-'],
                \ }
endfunction
