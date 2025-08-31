function _G.generate_cpp_source_file()
  local bufnr = vim.api.nvim_get_current_buf()
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, line_count, false)
  local namespace_name = nil
  for _, line in ipairs(lines) do
    local match = string.match(line, "^namespace ([%w:]+)")
    if match then
      namespace_name = match
      break
    end
  end

  local file_dir = vim.fn.expand "%:p:h:t"

  local source_path = nil
  if file_dir == "include" then
    source_path = vim.fn.expand "%:p:h:h" .. "/src/"
  elseif file_dir == "interface" then
    source_path = vim.fn.expand "%:p:h:h" .. "/private/"
  else
    source_path = vim.fn.expand "%:p:h" .. "/"
  end

  if vim.fn.isdirectory(source_path) == 0 then vim.fn.mkdir(source_path) end

  local source_file_path = source_path .. vim.fn.expand "%:t:r" .. ".cpp"

  if vim.fn.filereadable(source_file_path) == 1 then
    print(source_file_path .. " already exists, nothing happens.")
  else
    local source_file, err, code = io.open(source_file_path, "w")
    if source_file then
      source_file:write('#include "' .. vim.fn.expand "%:t" .. '"\n')
      if namespace_name then source_file:write("\nusing namespace " .. namespace_name .. ";") end
      source_file:close()
      print(source_file_path .. " created.")
    else
      print(err)
    end
  end
end

function _G.copy_member_func_implementation()
  local buf = vim.api.nvim_get_current_buf()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local lines = vim.api.nvim_buf_get_lines(buf, 0, row, false)
  local class_name = nil
  for i = row - 1, 1, -1 do
    local match = string.match(lines[i], "class (%w+)") -- note there is notion before class
    if match then
      class_name = match
      break
    end
  end

  local current_line = vim.api.nvim_get_current_line()

  current_line = string.gsub(current_line, "static%f[^%a%d]", "")
  current_line = string.gsub(current_line, "virtual%f[^%a%d]", "")
  current_line = string.gsub(current_line, "override%f[^%a%d]", "")
  current_line = string.gsub(current_line, ";", "")
  local _, return_type, rest = string.match(current_line, "( *)([%w:]+) (.+)")
  current_line = string.format("%s %s::%s {}", return_type, class_name, rest)

  vim.cmd(string.format("let @\"='%s'", current_line))
end

vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader><leader>s",
  ":lua generate_cpp_source_file()<cr>",
  { desc = "create source file in cpp" }
)
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>yy",
  ":lua copy_member_func_implementation()<cr>",
  { desc = "copy class member declaration" }
)
