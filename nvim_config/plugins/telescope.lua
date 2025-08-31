return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    return require("astronvim.utils").extend_tbl(opts, {
      defaults = {
        file_ignore_patterns = {
          ".git/*",
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          -- no_ignore = true, -- show dir ignored by .gitignore
        },
      },
    })
  end,
}
