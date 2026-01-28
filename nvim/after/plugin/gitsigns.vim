" [lewis6991/gitsigns.nvim] keymaps
" navigate chunks of current buffer
nmap [h <cmd>Gitsigns prev_hunk<CR>
nmap ]h <cmd>Gitsigns next_hunk<CR>
" show chunk diff at current position
nmap hs <cmd>Gitsigns preview_hunk<CR>
" show blame for current line
nmap hc <cmd>Gitsigns blame_line<CR>
" stage/unstage hunk
nmap hu <cmd>Gitsigns reset_hunk<CR>
nmap ha <cmd>Gitsigns stage_hunk<CR>
" create text object for git chunks
omap ih <cmd>Gitsigns select_hunk<CR>
xmap ih <cmd>Gitsigns select_hunk<CR>
omap ah <cmd>Gitsigns select_hunk<CR>
xmap ah <cmd>Gitsigns select_hunk<CR>
