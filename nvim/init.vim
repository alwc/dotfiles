scriptencoding utf-8
set encoding=utf-8

"-----------------------------------------------------------------------------
" uv Python configuration
"-----------------------------------------------------------------------------
if has("unix")
    let g:python_host_prog = $HOME.'/neovim2/bin/python'
    let g:python3_host_prog = $HOME.'/neovim3/bin/python'
    let g:python3_host_skip_check=1
endif

"-----------------------------------------------------------------------------
" vim-pLug
"-----------------------------------------------------------------------------
" Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" TODO: Remove after done reading VimL Primer
set runtimepath+=~/Dropbox/tutorials/vim/benjamin.klein-viml_primer/mpc/

call plug#begin('~/.config/nvim/plugged')

" Plug 'plasticboy/vim-markdown'
" "Plug 'mhinz/vim-startify'
" "Plug 'vim-pandoc/vim-pandoc', { 'for': [ 'pandoc', 'markdown' ] }
" "Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': [ 'pandoc', 'markdown' ] }
" Disabled because of the chdir problem: https://github.com/vim-pandoc/vim-pandoc/issues/272
" Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'jiangmiao/auto-pairs'
Plug 'kshenoy/vim-signature'

if has('mac')
    " A lightweight version of vimwiki
    Plug 'lervag/wiki.vim'
    " Manage text based lists
    Plug 'lervag/lists.vim'

    " If fzf has already been installed via Homebrew, use the existing fzf
    " Otherwise, install fzf. The `--all` flag makes fzf accessible outside of vim
    if isdirectory("/usr/local/opt/fzf")
      Plug '/usr/local/opt/fzf'
    else
      Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    endif
else
    " Fuzzy search
    Plug '/home/linuxbrew/.linuxbrew/opt/fzf'
endif
Plug 'junegunn/fzf.vim'
" Adds file type icons to Vim plugins
Plug 'ryanoasis/vim-devicons'
" A light and configurable statusline/tabline plugin
Plug 'itchyny/lightline.vim'
" Few utilities for pretty tabs
Plug 'gcmt/taboo.vim'
" Vim sugar for the UNIX shell commands
Plug 'tpope/vim-eunuch'
" Git wrapper
Plug 'tpope/vim-fugitive'
" Comment stuff out
Plug 'tpope/vim-commentary'
" Autosave session
Plug 'tpope/vim-obsession'
" For editing LaTeX files
Plug 'lervag/vimtex', { 'for': ['latex', 'tex'] }
" Run Async Shell Commands in Neovim
Plug 'skywind3000/asyncrun.vim'
" Git commit browser
Plug 'junegunn/gv.vim'
" Create a sidebar that shows the contents of the registers.
Plug 'junegunn/vim-peekaboo'
" Generate proper code documentation skeletons with a single keypress
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
" Jsonnet filetype plugin
Plug 'google/vim-jsonnet'
" Collection of language packs
Plug 'sheerun/vim-polyglot'
" Manage your c-tags files
Plug 'ludovicchabant/vim-gutentags'
" Manage your g-tags files
Plug 'skywind3000/gutentags_plus'
" Viewer & Finder for LSP symbols and tags
Plug 'liuchengxu/vista.vim'
" Intellisense engine with full LSP support as VSCode
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Preview markdown on your browser with synchronised scrolling
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Check syntax asynchronously and fix files
" Plug 'dense-analysis/ale'

call plug#end()

"-----------------------------------------------------------------------------
" Basic Options
"-----------------------------------------------------------------------------
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
set updatetime=300        " reduce vim-gitgutter's updatetime
let &t_ut=''              " Fix background color problem when using kitty

" Customize session options. Namely, I don't want to save hidden and
" unloaded buffers or empty windows.
set sessionoptions="curdir,folds,help,options,tabpages,winsize"

if !has("win32")
    set showbreak=↪       " The character to put to show a line has been wrapped
end

syntax on                 " Enable filetype detection by syntax
"
" Home path
let g:vim_home_path = "~/dotfiles/nvim"

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

" Color settings
set background=dark
colorscheme gruvbox9
let g:gruvbox_plugin_hi_groups = 1

"-----------------------------------------------------------------------------
" Key Mappings
"-----------------------------------------------------------------------------
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
nmap <silent> <leader>vimrc :e ~/dotfiles/nvim/init.vim<CR>

" Shortcut to edit the snippets
" nmap <silent> <leader>snipt :e ~/dotfiles/nvim/snippets/tex.snip<CR>

" Make navigating around splits easier
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
if has('nvim')
  " We have to do this to fix a bug with Neovim on OS X where C-h
  " is sent as backspace for some reason.
  nnoremap <BS> <C-W>h
endif

" Shortcut to yanking to the system clipboard
map <leader>y "*y
map <leader>p "*p

" Get rid of search highlights
noremap <silent><leader>/ :nohlsearch<CR>

" Command to write as root if we dont' have permission
" cmap w!! %!sudo tee > /dev/null %
"
" " Expand in command mode to the path of the currently open file
" cnoremap %% <C-R>=expand('%:h').'/'<CR>
"
" " Buffer management
" nnoremap <leader>d   :bd<CR>

" vim's built-in tabs navigation
if has('mac')
    map <M-1> 1gt
    map <M-2> 2gt
    map <M-3> 3gt
    map <M-4> 4gt
    map <M-5> 5gt
    map <M-6> 6gt
    map <M-7> 7gt
    map <M-8> 8gt
    map <M-9> 9gt
    map <M-0> :tablast<CR>
    " map <M-t> :tabnew<CR>
    map <M-c> :tabclose<CR>
    map <M-[> :tabprevious<CR>
    map <M-]> :tabnext<CR>
else
    map <A-1> 1gt
    map <A-2> 2gt
    map <A-3> 3gt
    map <A-4> 4gt
    map <A-5> 5gt
    map <A-6> 6gt
    map <A-7> 7gt
    map <A-8> 8gt
    map <A-9> 9gt
    map <A-0> :tablast<CR>
    " map <A-t> :tabnew<CR>
    map <A-c> :tabclose<CR>
    map <A-[> :tabprevious<CR>
    map <A-]> :tabnext<CR>
endif

"-----------------------------------------------------------------------------
" Autocommands
"-----------------------------------------------------------------------------
" Clear whitespace at the end of lines automatically
autocmd BufWritePre * :%s/\s\+$//e

" Don't fold anything.
autocmd BufWinEnter * set foldlevel=999999

" Reload stale-but-unmodified buffers whenever we gain focus
" https://stackoverflow.com/questions/1272007/refresh-all-files-in-buffer-from-disk-in-vim
autocmd FocusGained * checktime

"-----------------------------------------------------------------------------
" Plugins
"-----------------------------------------------------------------------------

" [lervag/vimtex]
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0
let g:vimtex_quickfix_open_on_warning=0
let g:vimtex_compiler_progname='nvr'
augroup latexsettings
    autocmd FileType tex set spell
augroup END

" [jiangmiao/auto-pairs] =====================================================
" let g:AutoPairsMapCR=0

" ['kshenoy/vim-signature'] ==================================================
nmap <silent> <leader>m :SignatureToggle<CR>

" [skywind3000/asyncrun.vim] =================================================
" Give async capabilities to vim-fugitive
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
