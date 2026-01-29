" vim-markdown (preservim/vim-markdown) configuration

" Don't require .md extension for markdown links
let g:vim_markdown_no_extensions_in_markdown = 1

" Auto-write when following links
let g:vim_markdown_autowrite = 1

" Enable strikethrough with ~~text~~
let g:vim_markdown_strikethrough = 1

" Syntax highlight for fenced code blocks
let g:vim_markdown_fenced_languages = ['bash=sh', 'javascript', 'js=javascript', 'json', 'python', 'py=python', 'ruby', 'sql', 'html', 'css', 'yaml', 'vim']

" Don't conceal code blocks and links (show actual syntax)
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" Disable folding
let g:vim_markdown_folding_disabled = 1

" Enable YAML front matter
let g:vim_markdown_frontmatter = 1

" Open URL under cursor with double Enter
autocmd FileType markdown,pandoc lua vim.keymap.set('n', '<CR><CR>', function() local word = vim.fn.expand('<cWORD>') local url = word:match('https?://[^%s%>%## %)%]]*') if url then vim.ui.open(url) end end, { buffer = true, desc = 'Open URL under cursor' })
