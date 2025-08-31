-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    [";"] = { ":", desc = "enter command mode" },
    ["qw"] = { "<C-w>q", desc = "close window" },
    ["<leader>w"] = { ":update<cr>", desc = "update file" },
    ["]c"] = { ":cnext<cr>", desc = "next quickfix item" },
    ["[c"] = { ":cprevious<cr>", desc = "previous quickfix item" },
    ["L"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["H"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    ["<leader>q"] = { ":bot copen<cr>", desc = "open/goto quickfix" },
    ["<leader>s"] = { ":ClangdSwitchSourceHeader<cr>", desc = "siwtch source and header file" },
    ["<leader>m"] = { ":AsyncRun -program=make<cr>", desc = "Run make program async" },
    ["<leader>M"] = { ":AsyncRun -program=make && %:p:r<cr>", desc = "Run make program and execute async" },
    ["gh"] = { ":help <c-r><c-w><cr>", desc = "help word under cursor" },
    ["<c-'>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
  },
  i = {
    ["<c-e>"] = { "<end>", desc = "move to last of the line in insert mode" },
    ["<c-l>"] = { "<right>", desc = "move to next position in insert mode" },
  },
  t = {
    ["<c-'>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
  },
}
