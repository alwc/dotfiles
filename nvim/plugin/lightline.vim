let g:lightline = {
    \ 'colorscheme': 'gruvbox9',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'readonly', 'filename', 'modified' ],
    \             [ 'cocstatus', 'cocfunction', 'gutentags' ] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'filetype' ] ]
    \ },
    \ 'component': {
    \   'space': ' ',
    \   'lineinfo': ' %3l:%-2v',
    \ },
    \ 'component_function': {
    \   'readonly': 'LightlineReadonly',
    \   'fugitive': 'LightlineFugitive',
    \   'cocstatus': 'coc#status',
    \   'cocfunction': 'CocCurrentFunction',
    \   'gutentags': 'GutentagsStatus',
    \   'filetype': 'MyFiletype',
    \   'fileformat': 'MyFileformat',
    \ },
    \ 'separator': { 'left': '', 'right': ' ' },
    \ 'subseparator': { 'left': '', 'right': '' }
    \ }

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

function! GutentagsStatus()
    return gutentags#statusline()
endfunction

function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction

function! LightlineFugitive()
    if exists('*FugitiveHead')
        let branch = FugitiveHead()
        return branch !=# '' ? '  '.branch : ''
    endif
    return ''
endfunction

function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
