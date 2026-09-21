-- help [vim.lsp.buf, vim.diagnostic, lsp-config, lspconfig-all]
-- checkhealt vim.lsp , lsp

vim.lsp.enable({
	"lua_ls",
	"phpactor",
	"ts_ls",
	"tsc",
	"vue_ls",
	"gopls",
	"tailwindcss",
	"html",
	"emmet",
	"clangd",
	"sqls",
	"pyright",
	"rust_analyzer",
	"bashls",
	"yamlls",
	"terraformls",
	"cssls",
	"jdtls",
	"lemminx",
})

-- Keybindings
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function()
		vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Actions" })
		vim.keymap.set("n", "<leader>ls", vim.lsp.buf.document_symbol, { desc = "Document Symbol" })

		vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show Diagnostic Float" })
		vim.keymap.set("n", "<leader>lk", vim.diagnostic.setqflist, { desc = "Show Diagnostic List" })

		vim.keymap.set("n", "<leader>li", vim.lsp.buf.type_definition, { desc = "Show Type Definition" })

		-- vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Builint LSP formmatter" })
		vim.keymap.set("n", "<leader>lf", function()
			local conform = require("conform")

			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 10000,
			})
		end, { desc = "LSP Formmatter" })

		vim.keymap.set("n", "<leader>lt", function()
			for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
				client.server_capabilities.documentFormattingProvider = false
			end
		end, { desc = "Disable LSP Formatter" })

		vim.keymap.set("n", "<leader>lc", function()
			local enabled = vim.lsp.document_color.is_enabled({ bufnr = 0 })
			vim.lsp.document_color.enable(not enabled, { bufnr = 0 })
		end, { desc = "Toggle document colors" })
	end,
})

-- Diagnostics
local severity = vim.diagnostic.severity
vim.diagnostic.config({
	severity_sort = true,
	update_in_insert = false,
	float = {
		border = "rounded",
		source = "if_many",
	},
	underline = true,
	virtual_text = {
		spacing = 2,
		source = "if_many",
		prefix = "●",
	},
	virtual_lines = {
		current_line = true,
	},
	signs = {
		text = {
			[severity.ERROR] = " ",
			[severity.WARN] = " ",
			[severity.HINT] = "󰠠 ",
			[severity.INFO] = " ",
		},
	},
})
