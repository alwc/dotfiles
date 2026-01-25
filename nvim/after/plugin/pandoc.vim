" Pandoc and memex-related settings (independent of wiki.vim)

" [Auto-update timestamp in memex files]
" From:
" - https://www.reddit.com/r/vim/comments/2hxxxy/how_to_autoupdate_time_stamp_field_in_a_file/
" - https://gist.github.com/jelera/7838011
autocmd! BufWritePre ~/Dropbox/memex/* :call s:timestamp()

" [To update timestamp when saving if its in the first 20 lines of a file]
function! s:timestamp()
    let pat = '\(\(Last\)\?\s*\([Cc]hanged\?\|[Mm]odified\|[Uu]pdated\?\)\s*:\s*\).*'
    let rep = '\1' . strftime("%a %d %b %Y %I:%M:%S %p %Z")
    call s:subst(1, 20, pat, rep)
endfunction

" subst( start, end, pat, rep): substitute on range start - end.
function! s:subst(start, end, pat, rep)
    let lineno = a:start
    while lineno <= a:end
        let curline = getline(lineno)
        if match(curline, a:pat) != -1
            let newline = substitute( curline, a:pat, a:rep, '' )
            if( newline != curline )
                " Only substitute if we made a change
                "silent! undojoin
                keepjumps call setline(lineno, newline)
            endif
        endif
        let lineno = lineno + 1
    endwhile
endfunction

" Use `vim-pandoc-syntax` without `vim-pandoc`
augroup pandoc_syntax
    au!
    " Default: pandoc for all .md files
    au BufNewFile,BufFilePre,BufRead *.md set filetype=pandoc
    " Override: GFM (vim-markdown) for goodnotes folder
    au BufNewFile,BufFilePre,BufRead ~/Dropbox/memex/goodnotes/*.md set filetype=markdown

    " Create frontmatter template for new memex files
    " Modified from: https://github.com/lervag/wiki.vim/issues/46#issuecomment-617158322
    autocmd BufNewFile ~/Dropbox/memex/*.md call SetWikiMarkdownTemplate() | norm G
augroup END

func SetWikiMarkdownTemplate()
    if expand("%:e") == 'md'
        " READ: https://taptoe.wordpress.com/2013/02/06/vim-capitalize-every-first-character-of-every-word-in-a-sentence/
        let filename = tr(tolower("".expand("%:t:r")), "_", " ")
        let title = substitute(filename, '\v^\a|\:\s\a|<%(in>|the>|at>|with>|a>|and>|for>|of>|on>|from>|by>)@!\a', '\U&', "g")

        call setline(1, "---")
        call setline(2, "title: " . title)
        call setline(3, "modified:".strftime(" %a %d %b %Y %I:%M:%S %p %Z"))
        call setline(4, "created: ".strftime(" %a %d %b %Y %I:%M:%S %p %Z"))
        call setline(5, "---")
        call setline(6, "")
    endif
endfunc
