if executable('fzf')
    nnoremap <silent> <C-t> :Files<CR>
    nnoremap <silent> <C-f> :Commands<CR>
    " nnoremap <silent> <leader>f :BLines<CR>
    " nnoremap <silent> <leader>F :Lines<CR>

    " Use ripgrep
    command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)
end
