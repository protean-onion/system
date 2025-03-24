return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.options = vim.tbl_deep_extend("force", opts.options, {
      component_separators = { left = "|", right = "|" },
      section_separators = { left = "", right = "" },
    })
    return opts
  end,
}
