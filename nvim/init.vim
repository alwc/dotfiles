" Installation instructions:
"
"   1. Install vim-plug: curl -fLo ~/dotfiles/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   2. :PlugInstall

scriptencoding utf-8
set encoding=utf-8

"-----------------------------------------------------------------------------
" pyenv
"-----------------------------------------------------------------------------
if has("unix")
    let g:python_host_prog = $HOME.'/.pyenv/versions/neovim2/bin/python'
    let g:python3_host_prog = $HOME.'/.pyenv/versions/neovim3/bin/python'
    let g:python3_host_skip_check=1
endif

"-----------------------------------------------------------------------------
call plug#begin('~/dotfiles/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'plasticboy/vim-markdown'
Plug 'gcmt/taboo.vim'
" "Plug 'mhinz/vim-startify'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
" "Plug 'vim-pandoc/vim-pandoc', { 'for': [ 'pandoc', 'markdown' ] }
" "Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': [ 'pandoc', 'markdown' ] }
" Disabled because of the chdir problem: https://github.com/vim-pandoc/vim-pandoc/issues/272
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'lervag/vimtex', { 'for': ['latex', 'tex'] }
Plug 'skywind3000/asyncrun.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/gv.vim'
if has('mac')
    Plug '/usr/local/opt/fzf'
else
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'jsfaint/gen_tags.vim'
Plug 'kshenoy/vim-signature'
Plug 'google/vim-jsonnet'
Plug 'sheerun/vim-polyglot'

" Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}


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
" set cursorline            " hightlight the line the cursor is on
set scrolloff=999         " Keep the cursor centered in the screen
set showmatch             " Highlight matching braces
set showmode              " Show the current mode on the open buffer
set splitbelow            " Splits show up below by default
set splitright            " Splits go to the right by default
set title                 " Set the title for gvim
set visualbell            " Use a visual bell to notify us
set updatetime=100        " reduce vim-gitgutter's updatetime
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
    " colorscheme gruvbox
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

" Change bright red to grey for colorcolumn
highlight ColorColumn ctermbg=236

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
if has("nvim")
    nmap <silent> <leader>vimrc :e ~/dotfiles/nvim/init.vim<CR>
else
    nmap <silent> <leader>vimrc :e ~/.vimrc<CR>
endif

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

"-----------------------------------------------------------------------------
" Autocommands
"-----------------------------------------------------------------------------
" Clear whitespace at the end of lines automatically
autocmd BufWritePre * :%s/\s\+$//e

" Don't fold anything.
autocmd BufWinEnter * set foldlevel=999999

" Reload Powerline when we read a Puppet file. This works around
" some weird bogus bug.
autocmd BufNewFile,BufRead *.pp call Pl#Load()"

"-----------------------------------------------------------------------------
" Plugins
"-----------------------------------------------------------------------------

" [neoclide/coc.nvim] ========================================================
" Alex: should try out 'coc-snippets', 'coc-pairs', 'coc-eslint',
let g:coc_global_extensions = [
  \ 'coc-git',
  \ 'coc-tsserver',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-python',
  \ ]

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages at the bottom row of Neovim.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
" set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Use C to open user's coc-settings.json
call SetupCommandAbbrs('C', 'CocConfig')

" Add `:isort` command to sort Python's imports
command! -nargs=0 Isort :call CocAction('runCommand', 'python.sortImports')
"
" [gcmt/taboo.vim] + vim's built-in tabs navigation ==========================
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
"map <M-t> :tabnew<CR>
map <M-t> :TabooOpen<Space>
map <M-c> :tabclose<CR>
map <M-[> :tabprevious<CR>
map <M-]> :tabnext<CR>
map <M-m> :TabooRename<Space>

let g:taboo_tab_format = " %N   %f%m "
let g:taboo_renamed_tab_format = " %N   %l%m "

" [vim-airline/vim-airline-themes] ===========================================
" options: 'tomorrow', 'onedark', 'hybrid', 'ayu_mirage', 'angr'
let g:airline_theme='tomorrow'
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep = ''
" let g:airline#extensions#tabline#left_alt_sep = ''

" [lervag/vimtex]
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0
let g:vimtex_quickfix_open_on_warning=0
let g:vimtex_compiler_progname='nvr'
augroup latexsettings
    autocmd FileType tex set spell
augroup END

" [jiangmiao/auto-pairs] =====================================================
let g:AutoPairsMapCR=0

" [davidhalter/jedi-vim]
" let g:jedi#completions_enabled=0
" let g:jedi#force_py_version=3

" [Shougo/neosnippet]
" let g:neosnippet#disable_runtime_snippets={ '_' : 1 }
" let g:neosnippet#snippets_directory='~/dotfiles/nvim/snippets'
" let g:neosnippet#enable_snipmate_compatibility=1

" [Shougo/deoplete]
" smap <silent><expr><tab> neosnippet#jumpable() ? "\<plug>(neosnippet_jump)"      : "\<tab>"
" imap <silent><expr><tab> pumvisible()          ? "\<c-n>"                        : (neosnippet#jumpable()   ? "\<plug>(neosnippet_jump)"   : "\<tab>")
" imap <silent><expr><CR>  !pumvisible()         ? "\<CR>\<plug>AutoPairsReturn"   : (neosnippet#expandable() ? "\<plug>(neosnippet_expand)" : deoplete#close_popup())
" imap <silent><expr><esc> pumvisible()          ? deoplete#close_popup() : "\<esc>"
" imap <silent><expr><bs>  deoplete#smart_close_popup()."\<bs>"
" let g:deoplete#enable_at_startup=1
" let g:deoplete#auto_completion_start_length=1
" let g:deoplete#enable_camel_case=1
" let g:deoplete#max_list=100
" let g:deoplete#sources#jedi#python_path = 'python3'
" let g:deoplete#ignore_sources={}
" let g:deoplete#ignore_sources._=['buffer']

" set t_ZH=[3m
" set t_ZR=[23m

" [dense-analysis/ale]
" let g:ale_linters = {'python': ['flake8'], 'javascript': ['eslint']}

" Only allowed one global window that shows errors
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_enter = 0
" " let g:ale_lint_on_save = 0
" let b:ale_lint_on_save = 1
"
" let g:ale_sign_error = '▓▓'
" let g:ale_sign_warning = '░░'
"
" " Ctrl+j and Ctrl+k to move between errors
" nmap <silent> <C-m> <Plug>(ale_previous_wrap)
" nmap <silent> <C-n> <Plug>(ale_next_wrap)
"
" " Only run linters on-demand
" nmap <silent> <leader>l :ALEToggleBuffer<CR>

" [mhinz/vim-signify] ========================================================
" let g:signify_sign_add='┣'
" let g:signify_sign_delete='◢'
" let g:signify_sign_delete_first_line='◥'
" let g:signify_sign_change='┃'

" " https://github.com/mhinz/vim-signify/issues/174#issuecomment-174005326
" autocmd User Fugitive SignifyRefresh

" [junegunn/fzf.vim] =========================================================
if executable('fzf')
    nnoremap <silent> <C-t> :Files<CR>
    " nnoremap <silent> <leader>f :BLines<CR>
    " nnoremap <silent> <leader>F :Lines<CR>

    " Use ripgrep
    command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)
end

" [majutsushi/tagbar] ========================================================
" let g:targar_compact=1
let g:tagbar_autofocus=1
let g:tagbar_sort=0
let g:tagbar_width=40
let g:tagbar_iconchars = ['▶', '▼']
nmap <silent> <leader>e :TagbarToggle<CR>

" ['jsfaint/gen_tags.vim'] ===================================================
let $GTAGSLIBPATH='/usr/include/'

" ['kshenoy/vim-signature'] ==================================================
nmap <silent> <leader>m :SignatureToggle<CR>

" [skywind3000/asyncrun.vim] =================================================
" Give async capabilities to vim-fugitive
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
