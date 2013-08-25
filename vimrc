set nocompatible               " get rid of Vi compatibility mode 
set encoding=utf-8

"-------------------------------------------------------------------------------
" Vundle Settings
"-------------------------------------------------------------------------------

filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'Lokaltog/vim-powerline'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-eunuch'
Bundle 'kien/ctrlp.vim'
Bundle 'godlygeek/tabular'
Bundle 'Valloric/YouCompleteMe'
Bundle 'mattn/emmet-vim'

" python
Bundle 'klen/python-mode'

" javascript
"Better JS color scheme
"Provide syntax and indent plugins
"TextMate's snippets features
Bundle 'jelera/vim-javascript-syntax'
Bundle 'pangloss/vim-javascript'
Bundle 'Raimondi/delimitMate'
Bundle 'othree/javascript-libraries-syntax.vim'

" colortheme
Bundle 'altercation/vim-colors-solarized'

filetype plugin indent on     " required!

"-------------------------------------------------------------------------------
" Basic Options
"-------------------------------------------------------------------------------

syntax on                               " for syntax highlighting
let mapleader=";"                       " use ";" as the <leader> key
set colorcolumn=80                      " hightlight 80 character limit
set hidden                              " allow buffers to be backgrounded wihtout being safe
set t_Co=256                            " use 256 colors
set nu                                  " for displaying line numbers
set cursorline                          " hightlight the line the cursor is on
set scrolloff=10                        " for displaying at least 10 lines below the cursor
set relativenumber                      " show relative line numbers

" Text fomatting
set nowrap                              " don't wrap text
set showmatch                           " highlight matching braces
set matchtime=3                         " how many tenths of a second to wait before showing matching braces
set list                                " show inivisble characters
set listchars=tab:›\ ,eol:¬,trail:⋅     " set the characters for the inivisbles
set backspace=2                         " allow backspace over everything in insert mode

" Search settings
set nohlsearch                          " don't continue to highlight searched phrases
set incsearch                           " show matches while typing
set ignorecase                          " make searches case-insensitive
set smartcase                           " be smart about case sensitivity when searching

" Tab settings
set expandtab                           " use spaces instead of tabs
set tabstop=4                           " tab spacing
set shiftwidth=4                        " indent/outdent by 4 columns
set softtabstop=4                       " soft tab width in spaces
set shiftround                          " alwyas indent/outdent to the nearest tabstop 
set smartindent                         " does the right thing (mostly) in programs
set autoindent                          " auto-indent

" Color scheme
syntax enable
set background=dark
colorscheme solarized

"-------------------------------------------------------------------------------
" Key Mappings
"-------------------------------------------------------------------------------

"iabbrev </ </<C-X><C-O>

" move by rows rather than lines
nnoremap j gj
nnoremap k gk

"-------------------------------------------------------------------------------
" Filetype Options
"-------------------------------------------------------------------------------

" X?HTML & XML
autocmd FileType html,xhtml,xml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" CSS
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

" JavaScript
autocmd FileType javascript setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

"-------------------------------------------------------------------------------
" Plugin Settings
"-------------------------------------------------------------------------------

" CtrlP
let g:ctrlp_max_files = 10000

" EasyMotion
let g:EasyMotion_leader_ley = '<leader><leader>'

" YouCompleteMe
let g:ycm_min_num_identifier_candidate_chars = 2

" vim-javascript
"let javascript_enable_domhtmlcss=1

" Syntastic
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_enable_signs = 1  " Show sidebar signs.
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2  " Close error window automatically when there are no errors.
let g:syntastic_mode_map = { 'mode': 'active',
                            \'active_filetypes': [],
                            \'passive_filetypes': ['html'] }
" let g:syntastic_python_checkers = ['flake8']
" let g:syntastic_python_flake8_args =
" '--ignore="E501,E302,E261,E701,E241,E126,E127,E128W801"'
let g:synastic_javascript_checkers = ['jshint']

" Powerline settings
set laststatus=2   " Always show the statusline

" make Esc happen without waiting for timeoutlen
" fixes Powerline delay
augroup FastEscape
  autocmd!
  au InsertEnter * set timeoutlen=0
  au InsertLeave * set timeoutlen=1000
augroup END

" delimitMate
let delimitMate_expand_cr = 1

" javascript-libraries-synthax
let g:used_javascript_libs = 'jquery,angularjs'
