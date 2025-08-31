-- Set up autocommands
local create_autocmd = vim.api.nvim_create_autocmd

Au_group = {
  cpp = vim.api.nvim_create_augroup("cpp_group", { clear = true }),
  python = vim.api.nvim_create_augroup("python_group", { clear = true }),
  general = vim.api.nvim_create_augroup("general", { clear = true }),
  makePrg = vim.api.nvim_create_augroup("makePrg", { clear = true }),
}

local definitions = {
  {
    "BufEnter",
    {
      pattern = "*.cpp",
      command = "setlocal makeprg=g++\\ -std=c++20\\ -g\\ -Wall\\ %:p\\ -o\\ %:p:r",
      group = Au_group.makePrg,
      desc = "make cpp programs",
    },
  },
  {
    "FileType",
    {
      pattern = "cpp",
      command = "set tabstop=4 shiftwidth=4 expandtab",
      group = Au_group.cpp,
      desc = "cpp tab set to 4",
    },
  },
  {
    "BufEnter",
    {
      pattern = { "*.py", "*.sh", "*.csh", "*.pl", "*.lua" },
      command = "setlocal makeprg=%:p",
      group = Au_group.makePrg,
      desc = "run scripts programs",
    },
  },
  {
    "BufEnter",
    {
      pattern = { "*.lua", "*.vim" },
      command = "nnoremap <buffer> <leader>m :update<cr>:source %<cr>",
      group = Au_group.makePrg,
      desc = "run vim/lua scripts",
    },
  },
  {
    "BufReadPost",
    {
      command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]],
      group = Au_group.general,
      desc = "Restore the cursor position when opening a file",
    },
  },
  {
    "QuickFixCmdPost",
    {
      pattern = "[^l]*",
      nested = true,
      command = "botright copen",
      group = Au_group.general,
      desc = "automatically open quickfix window",
    },
  },
  {
    "QuickFixCmdPost",
    {
      pattern = "l*",
      nested = true,
      command = "lwindow",
      group = Au_group.general,
      desc = "automatically open quickfix window",
    },
  },
  {
    "BufWritePost",
    {
      pattern = { "*.py", "*.pl", "*.csh", "*.tcsh", "*.sh" },
      callback = function()
        local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, true)[1]
        if string.match(first_line, "^#!") then vim.api.nvim_command "silent !chmod +x <afile>" end
      end,
      group = Au_group.general,
      desc = "add execution rights to script files such as *sh, *.py, etc after :w",
    },
  },
  {
    "TextYankPost",
    {
      pattern = "*",
      callback = function() vim.highlight.on_yank { timeout = 500 } end,
      group = Au_group.general,
      desc = "highlight yanks",
    },
  },
  {
    "CursorHold",
    {
      pattern = "*",
      command = "lua vim.diagnostic.open_float(nil, {focus = false})",
      group = Au_group.general,
      desc = "show diagnostic",
    },
  },
  {
    "BufWritePre",
    {
      pattern = "*",
      command = 'call mkdir(expand("<afile>:p:h"), "p")',
      group = Au_group.general,
      desc = "create non-exist directory when saving files",
    },
  },
  {
    { "FocusGained", "BufEnter" },
    {
      pattern = "*",
      command = "silent! checktime",
      group = Au_group.general,
      desc = "auto reload changed buffers",
    },
  },
  {
    "User",
    {
      pattern = "AsyncRunStop",
      callback = function()
        if vim.g["asyncrun_status"] == "failure" then
          vim.cmd [[bot copen]]
        else
          vim.notify('Command "' .. vim.g["asyncrun_cmd"] .. '" run successfully.')
        end
      end,
      group = Au_group.general,
      desc = "show async job run result.",
    },
  },
}

for _, entry in ipairs(definitions) do
  local event = entry[1]
  local opts = entry[2]
  if type(opts.group) == "string" and opts.group ~= "" then
    local exists, _ = pcall(vim.api.nvim_get_autocmds, { group = opts.group })
    if not exists then vim.api.nvim_create_augroup(opts.group, {}) end
  end
  vim.api.nvim_create_autocmd(event, opts)
end
