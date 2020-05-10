let g:wiki_root='~/Dropbox/wiki'
let g:wiki_zotero_root='~/Dropbox/references'
let g:wiki_template_title_month='# %(year) %(month-name)'
let g:wiki_template_title_week='# %(year) week %(week)'
let g:wiki_filetypes=['md']
" let g:wiki_filetypes=['wiki', 'md']
let g:wiki_link_extension = '.md'
let g:wiki_date_exe='gdate'

" Add date
nmap <silent> <leader>date a<C-R>=strftime(" %a %d %b %Y %I:%M:%S %p %Z")<CR><ESC>

" From:
" - https://www.reddit.com/r/vim/comments/2hxxxy/how_to_autoupdate_time_stamp_field_in_a_file/
" - https://gist.github.com/jelera/7838011
autocmd! BufWritePre *.md :call s:timestamp()
" to update timestamp when saving if its in the first 20 lines of a file
function! s:timestamp()
    let pat = '\(\(Last\)\?\s*\([Cc]hanged\?\|[Mm]odified\|[Uu]pdated\?\)\s*:\s*\).*'
    let rep = '\1' . strftime("%a %d %b %Y %I:%M:%S %p %Z")
    call s:subst(1, 20, pat, rep)
endfunction
" subst taken from timestamp.vim
" {{{ subst( start, end, pat, rep): substitute on range start - end.
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
" }}}