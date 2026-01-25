-- nvim-tree configuration
local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
    return
end

-- disable netrw (vim's built-in file explorer)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

nvim_tree.setup({
    view = {
        width = 30,
    },
    renderer = {
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = false,  -- disable git icons for speed
            },
        },
    },
    filters = {
        dotfiles = false,
    },
    git = {
        enable = false,  -- disable git integration for speed
    },
    filesystem_watchers = {
        enable = false,  -- disable file watching for speed
    },
})

-- keybindings
vim.keymap.set('n', '<leader>w', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fw', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })
