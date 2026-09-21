return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				vue = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				go = { "goimports", "gofmt" },
				php = { "easy-coding-standard" },
				blade = { "blade-formatter" },
			},
			format_on_save = {
				-- If formatter isn't available, fallback to lsp
				lsp_fallback = true,
				async = false,
				timeout_ms = 10000,
			},
		})
	end,
}
