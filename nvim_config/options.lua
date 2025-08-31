local grepprg = "grep -n "
if vim.fn.executable "rg" == 1 then grepprg = "rg --vimgrep " end

-- set vim options here (vim.<first_key>.<second_key> = value)
return {
  opt = {
    -- set to true or false etc.
    relativenumber = true, -- sets vim.opt.relativenumber
    number = true, -- sets vim.opt.number
    spell = false, -- sets vim.opt.spell
    wrap = false, -- sets vim.opt.wrap
    autoread = true, -- auto reload buffer when changed on disk
    showtabline = 0, -- hide tabline
    fillchars = {
      horiz = "━",
      horizup = "┻",
      horizdown = "┳",
      vert = "┃",
      vertleft = "┫",
      vertright = "┣",
      verthoriz = "╋",
    },
    list = true, -- show whitespace, and linebreak
    listchars = { trail = "·", eol = "\\u21b5" },
    secure = true,
    exrc = true,
    grepprg = grepprg,
  },
  g = {
    mapleader = " ", -- sets vim.g.mapleader
    autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    cmp_enabled = true, -- enable completion at start
    autopairs_enabled = true, -- enable autopairs at start
    diagnostics_enabled = true, -- enable diagnostics at start
    status_diagnostics_enabled = true, -- enable diagnostics in statusline
    icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    ui_notifications_enabled = true, -- disable notifications when toggling UI elements
    heirline_bufferline = false, -- enable new heirline based bufferline (requires :PackerSync after changing)
  },
}
