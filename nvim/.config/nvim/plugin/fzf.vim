command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --hidden --smart-case -- ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rga call fzf#vim#grep("rg --column --line-number --no-heading --color=always -uuu --smart-case -- ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

" Make the style of the floating fzf match the neovim floating windows
let g:fzf_colors =
\ { 'bg':          ['bg', 'NormalFloat'],
  \ 'gutter':      ['bg', 'NormalFloat'] }
