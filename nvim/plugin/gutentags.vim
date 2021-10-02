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

" Disable Gutentags by default
"
" References
" - https://github.com/ludovicchabant/vim-gutentags/issues/269
" - https://github.com/yuriteixeira/dotfiles/commit/69b8ea77d7a4c413172f4f04a27a42c51af4cef3
" - https://github.com/ludovicchabant/vim-gutentags/issues/168#issuecomment-466671110
let g:gutentags_enabled = 0
augroup auto_gutentags
  au FileType python,markdown,pandoc,sh,javascript,vim let g:gutentags_enabled = 1
augroup end
