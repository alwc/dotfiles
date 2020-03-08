let g:lightline = {
    \ 'colorscheme': 'gruvbox9',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'readonly', 'filename', 'modified' ],
    \             [ 'cocstatus' ] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'filetype' ] ]
    \ },
    \ 'component': {
    \   'lineinfo': ' %3l:%-2v',
    \ },
    \ 'component_function': {
    \   'readonly': 'LightlineReadonly',
    \   'fugitive': 'LightlineFugitive',
    \   'cocstatus': 'coc#status'
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' }
    \ }

function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction

function! LightlineFugitive()
    if exists('*FugitiveHead')
        let branch = FugitiveHead()
        "return branch !=# '' ? '  '.branch : ''
        return branch !=# '' ? '  '.branch : ''
    endif
    return ''
endfunction

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
