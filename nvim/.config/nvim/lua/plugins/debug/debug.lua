return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		require("dapui").setup()
		require("dap-go").setup()

		-- PHP
		dap.adapters.php = {
			type = "executable",
			command = "node",
			args = { "/home/fl4vis/vscode-php-debug/out/phpDebug.js" },
		}

		dap.configurations.php = {
			{
				type = "php",
				request = "launch",
				name = "Listen for Xdebug",
				port = 9003,
			},
		}

		-- DapUi Config
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- Signs Icons
		vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
		)
		vim.fn.sign_define(
			"DapBreakpointRejected",
			{ text = "", texthl = "DapBreakpointRejected", linehl = "", numhl = "" }
		)
		vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })
		vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" })

		-- Keymaps
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
		vim.keymap.set("n", "<leader>dx", dapui.close, { desc = "Close" })
		vim.keymap.set("n", "<leader>dw", function()
			dapui.eval(nil, { enter = true })
		end, { noremap = true, silent = true, desc = "Add word under cursor to Watches" })
		vim.keymap.set("n", "<leader>dq", function()
			dapui.eval()
		end, { noremap = true, silent = true, desc = "Hover/eval a single value" })
	end,
}
