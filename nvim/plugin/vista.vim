let g:vista_fzf_preview = ['right:50%']
let g:vista_sidebar_width = 40
let g:vista#renderer#enable_icon = 1
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
" let g:vista_default_executive = 'coc'
let g:vista_default_executive = 'ctags'
let g:vista_executive_for = {
    \ 'pandoc': 'markdown',
    \ 'markdown': 'toc',
    \ 'javascript': 'coc',
    \ 'javascript.jsx': 'coc',
    \ 'javascriptreact': 'coc',
    \ 'typescriptreact': 'coc',
    \ 'python': 'ctags',
    \ }

nmap <silent> <leader>e :Vista!!<CR>

nnoremap <silent> <space>fc  :Vista finder coc<CR>
nnoremap <silent> <space>ft  :Vista finder ctags<CR>
