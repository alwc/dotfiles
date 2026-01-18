" Markdown syntax highlighting for vim-markdown (uses html* groups)
" Match gruvbox9 colors

if &background ==# 'dark'
    " Headers - green for H1/H2, yellow for H3-H6 (matching gruvbox markdownH* groups)
    hi htmlH1 guifg=#b8bb26 gui=bold ctermfg=142 cterm=bold
    hi htmlH2 guifg=#b8bb26 gui=bold ctermfg=142 cterm=bold
    hi htmlH3 guifg=#fabd2f gui=bold ctermfg=214 cterm=bold
    hi htmlH4 guifg=#fabd2f gui=bold ctermfg=214 cterm=bold
    hi htmlH5 guifg=#fabd2f ctermfg=214
    hi htmlH6 guifg=#fabd2f ctermfg=214

    " Heading delimiter (the # symbols)
    hi mkdHeading guifg=#fe8019 ctermfg=208

    " Links
    hi mkdLink guifg=#83a598 gui=underline ctermfg=109 cterm=underline
    hi mkdURL guifg=#d3869b ctermfg=175
    hi mkdInlineURL guifg=#d3869b gui=underline ctermfg=175 cterm=underline

    " Code
    hi mkdCode guifg=#8ec07c ctermfg=107
    hi mkdCodeDelimiter guifg=#8ec07c ctermfg=107
    hi mkdCodeStart guifg=#8ec07c ctermfg=107
    hi mkdCodeEnd guifg=#8ec07c ctermfg=107

    " Lists
    hi mkdListItem guifg=#83a598 ctermfg=109

    " Blockquotes
    hi mkdBlockquote guifg=#928374 gui=italic ctermfg=102 cterm=italic

    " Rules (---)
    hi mkdRule guifg=#928374 ctermfg=102
else
    " Light background
    hi htmlH1 guifg=#79740e gui=bold ctermfg=100 cterm=bold
    hi htmlH2 guifg=#79740e gui=bold ctermfg=100 cterm=bold
    hi htmlH3 guifg=#b57614 gui=bold ctermfg=172 cterm=bold
    hi htmlH4 guifg=#b57614 gui=bold ctermfg=172 cterm=bold
    hi htmlH5 guifg=#b57614 ctermfg=172
    hi htmlH6 guifg=#b57614 ctermfg=172

    hi mkdHeading guifg=#af3a03 ctermfg=124

    hi mkdLink guifg=#076678 gui=underline ctermfg=24 cterm=underline
    hi mkdURL guifg=#8f3f71 ctermfg=126
    hi mkdInlineURL guifg=#8f3f71 gui=underline ctermfg=126 cterm=underline

    hi mkdCode guifg=#427b58 ctermfg=29
    hi mkdCodeDelimiter guifg=#427b58 ctermfg=29
    hi mkdCodeStart guifg=#427b58 ctermfg=29
    hi mkdCodeEnd guifg=#427b58 ctermfg=29

    hi mkdListItem guifg=#076678 ctermfg=24

    hi mkdBlockquote guifg=#928374 gui=italic ctermfg=102 cterm=italic

    hi mkdRule guifg=#928374 ctermfg=102
endif
