-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- [ 21/03/25 ] https://stackoverflow.com/a/15124717/27002740.
-- Then, I got Claude to translate it to LazyVim for me: https://claude.ai/share/183aa120-afbc-452e-871e-6d5409ae882c.
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost", "BufNewFile" }, {
  callback = function()
    local full_path = vim.fn.expand("%")
    local filename = vim.fn.fnamemodify(full_path, ":t")
    if filename ~= "" then
      vim.fn.system("tmux rename-window " .. filename)
    end
  end,
})
