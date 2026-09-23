return {
	-- Manage/Install LSP's in our system
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			local mason_tool_installer = require("mason-tool-installer")

			mason_tool_installer.setup({
				ensure_installed = {
					-- formatter
					"prettier",
					"stylua",
					"isort",
					"black",
					"goimports",
					"blade-formatter",
					-- linters
					-- debug
					"java-debug-adapter",
					"java-test",

					"vscode-spring-boot-tools",
				},
			})
		end,
	},
}
