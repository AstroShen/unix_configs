return {
	"jay-babu/mason-nvim-dap.nvim",
	opts = function(_, opts)
		opts.ensure_installed = { "python", "cpp" }
		local dap = require("dap")
		local home_dir = vim.fn.expand("~")
		dap.adapters.lldb = {
			type = "executable",
			command = home_dir .. "/.local/share/nvim/mason/bin/codelldb", -- adjust as needed, must be absolute path
			name = "LLDB",
		}
		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = home_dir .. "/absolute/path/to/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
		}
		dap.configurations.cpp = {
			{
				name = "lldb",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
			{
				name = "cppdbg",
				type = "cppdbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
			},
		}
		-- dap.configurations.c = dap.configurations.cpp
	end,
}
