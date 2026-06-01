" Make sure to not search within the filename, just search the content of the
" file. This is done by using --nth=4.. and --delimiter=: to ignore the first
" three fields (filename, line number, column number) in the fzf preview.
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --hidden --smart-case -- ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': ['--delimiter', ':', '--nth', '4..']}), <bang>0)
command! -bang -nargs=* Rga call fzf#vim#grep("rg --column --line-number --no-heading --color=always -uuu --smart-case -- ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': ['--delimiter', ':', '--nth', '4..']}), <bang>0)


" Make the style of the floating fzf match the neovim floating windows
let g:fzf_colors =
\ { 'bg':          ['bg', 'NormalFloat'],
  \ 'gutter':      ['bg', 'NormalFloat'] }
