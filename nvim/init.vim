" Installation instructions:
"
"   1. Install vim-plug: curl -fLo ~/dotfiles/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   2. :PlugInstall
"

scriptencoding utf-8
set encoding=utf-8

"----------------------------------------------------------------------
" pyenv
"----------------------------------------------------------------------
if has("unix")
    if has('mac')
        let g:python_host_prog = '/Users/alexlee/.pyenv/versions/neovim2/bin/python'
        let g:python3_host_prog = '/Users/alexlee/.pyenv/versions/neovim3/bin/python'
        let g:python3_host_skip_check=1
    else
        let g:python_host_prog = '/home/alex/.pyenv/versions/neovim2/bin/python'
        let g:python3_host_prog = '/home/alex/.pyenv/versions/neovim3/bin/python'
        let g:python3_host_skip_check=1
    endif
endif
"" Setup python3 environment
"let g:python3_host_prog='/usr/local/bin/python3'
"let g:python3_host_skip_check=1

"----------------------------------------------------------------------
" Plugins
"----------------------------------------------------------------------
call plug#begin('~/dotfiles/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
"Plug 'gcmt/taboo.vim'
"Plug 'mhinz/vim-startify'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'

" New
"Plug 'vim-pandoc/vim-pandoc', { 'for': [ 'pandoc', 'markdown' ] }
"Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': [ 'pandoc', 'markdown' ] }
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'lervag/vimtex'
" Async autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Python autocompletion
Plug 'zchee/deoplete-jedi', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet'
Plug 'jiangmiao/auto-pairs'
Plug 'Shougo/neosnippet-snippets'
" Just to add the python go-to-definition and similar features, autocompletion
" from this plugin is disabled
Plug 'davidhalter/jedi-vim'
"Plug 'w0rp/ale'
call plug#end()

"----------------------------------------------------------------------
" Basic Options
"----------------------------------------------------------------------
let mapleader=";"         " The <leader> key
set autoread              " Reload files that have not been modified
set backspace=2           " Makes backspace not behave all retarded-like
set colorcolumn=80        " Highlight 80 character limit
set hidden                " Allow buffers to be backgrounded without being saved
set laststatus=2          " Always show the status bar
set list                  " Show invisible characters
set listchars=tab:›\ ,eol:¬,trail:⋅ "Set the characters for the invisibles
set number
set ruler                 " Show the line number and column in the status bar
set t_Co=256              " Use 256 colors
set cursorline            " hightlight the line the cursor is on
set scrolloff=999         " Keep the cursor centered in the screen
set showmatch             " Highlight matching braces
set showmode              " Show the current mode on the open buffer
set splitbelow            " Splits show up below by default
set splitright            " Splits go to the right by default
set title                 " Set the title for gvim
set visualbell            " Use a visual bell to notify us

" Customize session options. Namely, I don't want to save hidden and
" unloaded buffers or empty windows.
set sessionoptions="curdir,folds,help,options,tabpages,winsize"

if !has("win32")
    set showbreak=↪       " The character to put to show a line has been wrapped
end

syntax on                 " Enable filetype detection by syntax
"
" Home path
if has("nvim")
    " Neovim
    let g:vim_home_path = "~/dotfiles/nvim"
"elseif has("win32")
"    " We're on Windows.
"    let g:vim_home_path = "~/vimfiles"
"else
"    " We're on some POSIX system, hopefully.
"    let g:vim_home_path = "~/.vim"
endif

" Backup settings
execute "set directory=" . g:vim_home_path . "/swap"
execute "set backupdir=" . g:vim_home_path . "/backup"
execute "set undodir=" . g:vim_home_path . "/undo"
set backup
set undofile
set writebackup

" Search settings
set hlsearch   " Highlight results
set ignorecase " Ignore casing of searches
set incsearch  " Start showing results as you type
set smartcase  " Be smart about case sensitivity when searching

" Tab settings
set expandtab     " Expand tabs to the proper type and size
set tabstop=4     " Tabs width in spaces
set softtabstop=4 " Soft tab width in spaces
set shiftwidth=4  " Amount of spaces when shifting

" Tab completion settings
set wildmode=list:longest     " Wildcard matches show a list, matching the longest first
set wildignore+=.git,.hg,.svn " Ignore version control repos
set wildignore+=*.pyc         " Ignore Python compiled files
set wildignore+=*.swp         " Ignore vim backups

" GUI settings
if has("gui_running") || has("nvim")
    colorscheme apprentice
    set guioptions=cegmt

    if has("win32")
        set guifont=Inconsolata:h11
    else
        set guifont=Inconsolata\ for\ Powerline:h14
    endif

    if exists("&fuopt")
        set fuopt+=maxhorz
    endif
endif

"----------------------------------------------------------------------
" Key Mappings
"----------------------------------------------------------------------
" Remap a key sequence in insert mode to kick me out to normal
" mode. This makes it so this key sequence can never be typed
" again in insert mode, so it has to be unique.
" inoremap jj <esc>
" inoremap jJ <esc>
" inoremap Jj <esc>
" inoremap JJ <esc>
" inoremap jk <esc>
" inoremap jK <esc>
" inoremap Jk <esc>
" inoremap JK <esc>

" Make j/k visual down and up instead of whole lines. This makes word
" wrapping a lot more pleasent.
map j gj
map k gk

" cd to the directory containing the file in the buffer. Both the local
" and global flavors.
" nmap <leader>cd :cd %:h<CR>
" nmap <leader>lcd :lcd %:h<CR>

" Shortcut to edit the vimrc
if has("nvim")
    nmap <silent> <leader>vimrc :e ~/dotfiles/nvim/init.vim<CR>
else
    nmap <silent> <leader>vimrc :e ~/.vimrc<CR>
endif

" Shortcut to edit the snippets
nmap <silent> <leader>snipt :e ~/dotfiles/nvim/snippets/tex.snip<CR>

" Make navigating around splits easier
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l
" if has('nvim')
"   " We have to do this to fix a bug with Neovim on OS X where C-h
"   " is sent as backspace for some reason.
"   nnoremap <BS> <C-W>h
" endif

" Navigating tabs easier
" map <D-S-{> :tabprevious
" map <D-S-}> :tabprevious

" Shortcut to yanking to the system clipboard
" map <leader>y "*y
" map <leader>p "*p

" Get rid of search highlights
noremap <silent><leader>/ :nohlsearch<cr>

" Command to write as root if we dont' have permission
" cmap w!! %!sudo tee > /dev/null %
"
" " Expand in command mode to the path of the currently open file
" cnoremap %% <C-R>=expand('%:h').'/'<CR>
"
" " Buffer management
" nnoremap <leader>d   :bd<cr>
"
" " Terminal mode
" if has("nvim")
"     tnoremap <esc> <C-\><C-n>
"     tnoremap jj <C-\><C-n>
"     tnoremap jJ <C-\><C-n>
"     tnoremap Jj <C-\><C-n>
"     tnoremap JJ <C-\><C-n>
"     tnoremap jk <C-\><C-n>
"     tnoremap jK <C-\><C-n>
"     tnoremap Jk <C-\><C-n>
"     tnoremap JK <C-\><C-n>
"     nnoremap <Leader>c :terminal <CR>
" endif
"
" " Tabs
" map <C-t> :tabnew<CR>
" map <C-c> :tabclose<CR>
" map <C-[> :tabprevious<CR>
" map <C-]> :tabnext<CR>
"
" " CtrlP
" nnoremap <leader>t :CtrlP<cr>
" nnoremap <leader>b :CtrlPBuffer<cr>
" nnoremap <leader>l :CtrlPLine<cr>

"----------------------------------------------------------------------
" Autocommands
"----------------------------------------------------------------------
" Clear whitespace at the end of lines automatically
autocmd BufWritePre * :%s/\s\+$//e

" Don't fold anything.
autocmd BufWinEnter * set foldlevel=999999

" Reload Powerline when we read a Puppet file. This works around
" some weird bogus bug.
autocmd BufNewFile,BufRead *.pp call Pl#Load()"

"----------------------------------------------------------------------
" Plugins
"----------------------------------------------------------------------

" [vimtex]
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0
let g:vimtex_quickfix_open_on_warning=0
let g:vimtex_compiler_progname='nvr'
augroup latexsettings
    autocmd FileType tex set spell
augroup END

" [jiangmiao/auto-pairs]
let g:AutoPairsMapCR=0

" [davidhalter/jedi-vim]
let g:jedi#completions_enabled=0
let g:jedi#force_py_version=3

" [Shougo/neosnippet]
let g:neosnippet#disable_runtime_snippets={ '_' : 1 }
let g:neosnippet#snippets_directory='~/dotfiles/nvim/snippets'
let g:neosnippet#enable_snipmate_compatibility=1

" [Shougo/deoplete]
smap <silent><expr><tab> neosnippet#jumpable() ? "\<plug>(neosnippet_jump)"      : "\<tab>"
imap <silent><expr><tab> pumvisible()          ? "\<c-n>"                        : (neosnippet#jumpable()   ? "\<plug>(neosnippet_jump)"   : "\<tab>")
imap <silent><expr><cr>  !pumvisible()         ? "\<cr>\<plug>AutoPairsReturn"   : (neosnippet#expandable() ? "\<plug>(neosnippet_expand)" : deoplete#mappings#close_popup())
imap <silent><expr><esc> pumvisible()          ? deoplete#mappings#close_popup() : "\<esc>"
imap <silent><expr><bs>  deoplete#mappings#smart_close_popup()."\<bs>"
let g:deoplete#enable_at_startup=1
let g:deoplete#auto_completion_start_length=1
let g:deoplete#enable_camel_case=1
let g:deoplete#max_list=100
" let g:deoplete#ignore_sources={}
" let g:deoplete#ignore_sources._=['buffer']

set t_ZH=[3m
set t_ZR=[23m
