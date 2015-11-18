set nocompatible               " get rid of Vi compatibility mode
filetype off                   " required!
set encoding=utf-8

"-------------------------------------------------------------------------------
" Vundle Settings
"-------------------------------------------------------------------------------


if has('win32') || has('win64')
    " Windows settings
    set rtp+=~/vimfiles/bundle/vundle
    call vundle#begin('$HOME/vimfiles/bundle')
else
    " Usual settings
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
endif

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" My Plugins here:
"
" original repos on github
Plugin 'Lokaltog/vim-powerline'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-eunuch'
Plugin 'kien/ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'Valloric/YouCompleteMe'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-markdown'
Plugin 'mikewest/vimroom'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vim-pandoc/vim-pantondoc'
Plugin 'chase/vim-ansible-yaml'

" golang
Plugin 'fatih/vim-go'

" python
Plugin 'klen/python-mode'

" javascript
"Better JS color scheme
"Provide syntax and indent plugins
"TextMate's snippets features
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'Raimondi/delimitMate'
Plugin 'othree/javascript-libraries-syntax.vim'

" colortheme
Plugin 'altercation/vim-colors-solarized'

" tmux
Plugin 'benmills/vimux'

" latex
Plugin 'LaTeX-Box-Team/LaTeX-Box'

call vundle#end()
filetype plugin indent on     " required!

"-------------------------------------------------------------------------------
" OS Settings
"-------------------------------------------------------------------------------

if has("gui_running")
    colorscheme solarized
    set guioptions=egmt

    if has("gui_gtk2")
        set guifont=Inconsolata\ 12
    elseif has("gui_win32") || has("gui_win32s")
        set guifont=Consolas:h11:cANSI
    endif
endif

"-------------------------------------------------------------------------------
" Basic Options
"-------------------------------------------------------------------------------

" General settings
syntax on                               " for syntax highlighting
let mapleader=";"                       " use ";" as the <leader> key
set colorcolumn=80                      " hightlight 80 character limit
set hidden                              " allow buffers to be backgrounded wihtout being save
set t_Co=256                            " use 256 colors
set number                              " for displaying line numbers
set cursorline                          " hightlight the line the cursor is on
set scrolloff=999                       " for displaying at least 10 lines below the cursor
set relativenumber                      " show relative line numbers
set clipboard=unnamed                   " yank and paste with system clipboard
set wildmenu                            " show a navigable menu for tab completion
set wildmode=longest,list,full          " wildcard matches completion
set nofoldenable                        " temporarily disables folding (restore with zc)

" Text fomatting
" set nowrap                              " don't wrap text
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

" move by rows rather than lines
nnoremap j gj
nnoremap k gk

" vimux"
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vq :VimuxCloseRunner<CR>
map <Leader>vx :VimuxInterruptRunner<CR>

"-------------------------------------------------------------------------------
" Filetype Options
"-------------------------------------------------------------------------------

autocmd FileType html,xhtml,xml setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascript setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType go setlocal listchars=tab:\ \  noexpandtab
autocmd FileType go setlocal nolist noexpandtab
augroup latexsettings
    autocmd FileType tex set spell
augroup END

"-------------------------------------------------------------------------------
" Plugin Settings
"-------------------------------------------------------------------------------

" netrw
let g:netrw_liststyle=3                 "use tree-mode as default view
let g:netrw_browse_split=4              "open file in previous buffer
let g:netrw_preview=1                   "preview window shown in vertical split
let g:netrw_winsize=20                  "netrw takes up 20% of screen space

" CtrlP
let g:ctrlp_max_files = 10000

" EasyMotion
let g:EasyMotion_leader_ley = '<leader><leader>'

" YouCompleteMe
set completeopt-=preview
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_add_preview_to_completeopt = 0
"let g:ycm_autoclose_preview_window_after_completion = 1

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
"
" LatexBox options
let g:LatexBox_latexmk_async=1
" let g:LatexBox_latexmk_options = "-pvc"
