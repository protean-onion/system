-- Add this to a new file in your LazyVim custom config folder
-- ~/.config/nvim/lua/plugins/tmux-title.lua

return {
  -- This creates a plugin spec that runs your custom code
  {
    "LazyVim/LazyVim",
    opts = function()
      -- Set terminal title to current filename
      vim.opt.title = true
      vim.opt.titlestring = "%t"

      -- Additional fallback method using autocmd
      vim.api.nvim_create_autocmd({ "BufEnter" }, {
        callback = function()
          local filename = vim.fn.expand("%:t")
          if filename ~= "" then
            vim.fn.system('printf "\\033]2;' .. filename .. '\\033\\\\"')
          end
        end,
      })
    end,
  },
}
