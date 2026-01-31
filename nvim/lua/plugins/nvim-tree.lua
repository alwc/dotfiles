vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  update_focused_file = {
    enable = true,
    update_root = true,
  },
})

-- Auto-find file when switching buffers (if tree is open)
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.filetype ~= "NvimTree" then
      local api = require("nvim-tree.api")
      if api.tree.is_visible() then
        api.tree.find_file({ open = false, focus = false })
      end
    end
  end,
})
