" Enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']

" Config project root markers.
let g:gutentags_project_root = ['.root']

" Generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" Change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1

" To know when Gutentags is generating tags
set statusline+=%{gutentags#statusline()}

" Ignore git related file types for Gutentags
" See https://github.com/ludovicchabant/vim-gutentags/issues/269
let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']
