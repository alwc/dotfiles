" Pandoc syntax highlighting customizations for gruvbox
" These colors match the markdown highlight groups in gruvbox9

if &background ==# 'dark'
    " Headers - green/yellow bold
    hi pandocAtxHeader guifg=#b8bb26 gui=bold ctermfg=142 cterm=bold
    hi pandocAtxStart guifg=#fe8019 ctermfg=208
    hi pandocSetexHeader guifg=#b8bb26 gui=bold ctermfg=142 cterm=bold

    " Links - purple URL, grey text with underline
    hi pandocReferenceURL guifg=#d3869b gui=underline ctermfg=175 cterm=underline
    hi pandocReferenceLabel guifg=#83a598 ctermfg=109
    hi pandocReferenceDefinitionAddress guifg=#d3869b gui=underline ctermfg=175 cterm=underline
    hi pandocReferenceDefinitionLabel guifg=#83a598 ctermfg=109
    hi pandocAutomaticLink guifg=#d3869b gui=underline ctermfg=175 cterm=underline
    hi pandocLinkTip guifg=#b8bb26 ctermfg=142

    " Code - aqua
    hi pandocNoFormatted guifg=#8ec07c ctermfg=107
    hi pandocDelimitedCodeBlock guifg=#8ec07c ctermfg=107
    hi pandocCodePre guifg=#8ec07c ctermfg=107

    " Tables - orange delimiters
    hi pandocTableDelims guifg=#fe8019 ctermfg=208
    hi pandocPipeTableDelims guifg=#fe8019 ctermfg=208
    hi pandocGridTableDelims guifg=#fe8019 ctermfg=208
    hi pandocSimpleTableDelims guifg=#fe8019 ctermfg=208
    hi pandocTableHeaderWord guifg=#fabd2f gui=bold ctermfg=214 cterm=bold

    " Lists - grey markers
    hi pandocListItemBullet guifg=#928374 ctermfg=102
    hi pandocUListItemBullet guifg=#928374 ctermfg=102

    " Block quotes - grey italic
    hi pandocBlockQuote guifg=#928374 gui=italic ctermfg=102 cterm=italic
    hi pandocBlockQuoteMark guifg=#fe8019 ctermfg=208

    " Footnotes - blue
    hi pandocFootnoteID guifg=#83a598 ctermfg=109
    hi pandocFootnoteDef guifg=#928374 ctermfg=102

    " Citations
    hi pandocCiteKey guifg=#83a598 ctermfg=109

    " Operators
    hi pandocOperator guifg=#fe8019 ctermfg=208
else
    " Light background variants
    hi pandocAtxHeader guifg=#79740e gui=bold ctermfg=100 cterm=bold
    hi pandocAtxStart guifg=#af3a03 ctermfg=124
    hi pandocSetexHeader guifg=#79740e gui=bold ctermfg=100 cterm=bold

    hi pandocReferenceURL guifg=#8f3f71 gui=underline ctermfg=126 cterm=underline
    hi pandocReferenceLabel guifg=#076678 ctermfg=24
    hi pandocReferenceDefinitionAddress guifg=#8f3f71 gui=underline ctermfg=126 cterm=underline
    hi pandocReferenceDefinitionLabel guifg=#076678 ctermfg=24
    hi pandocAutomaticLink guifg=#8f3f71 gui=underline ctermfg=126 cterm=underline
    hi pandocLinkTip guifg=#79740e ctermfg=100

    hi pandocNoFormatted guifg=#427b58 ctermfg=29
    hi pandocDelimitedCodeBlock guifg=#427b58 ctermfg=29
    hi pandocCodePre guifg=#427b58 ctermfg=29

    hi pandocTableDelims guifg=#af3a03 ctermfg=124
    hi pandocPipeTableDelims guifg=#af3a03 ctermfg=124
    hi pandocGridTableDelims guifg=#af3a03 ctermfg=124
    hi pandocSimpleTableDelims guifg=#af3a03 ctermfg=124
    hi pandocTableHeaderWord guifg=#b57614 gui=bold ctermfg=172 cterm=bold

    hi pandocListItemBullet guifg=#928374 ctermfg=102
    hi pandocUListItemBullet guifg=#928374 ctermfg=102

    hi pandocBlockQuote guifg=#928374 gui=italic ctermfg=102 cterm=italic
    hi pandocBlockQuoteMark guifg=#af3a03 ctermfg=124

    hi pandocFootnoteID guifg=#076678 ctermfg=24
    hi pandocFootnoteDef guifg=#928374 ctermfg=102

    hi pandocCiteKey guifg=#076678 ctermfg=24

    hi pandocOperator guifg=#af3a03 ctermfg=124
endif
