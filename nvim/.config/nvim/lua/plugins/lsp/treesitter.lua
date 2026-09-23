-- The new nvim-treesitter compiles parsers locally and depends on the tree-sitter CLI
-- https://github.com/tree-sitter/tree-sitter/releases
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-context" },
	},
	main = "nvim-treesitter",
	init = function()
		-- Enable highlighting + indentation per filetype
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		-- Replace ensure_installed: install missing parsers on startup
		local ensureInstalled = {
			"c",
			"lua",
			"vim",
			"vimdoc",
			"go",
			"javascript",
			"typescript",
			"tsx",
			"vue",
			"html",
			"php",
			"css",
			"blade",
			"sql",
			"yaml",
			"json",
			"jsdoc",
			"phpdoc",
			"java",
			"xml",
		}

		-- Callback that diffs against already-installed parsers
		-- so it doesn't reinstall everything on every startup
		local alreadyInstalled = require("nvim-treesitter.config").get_installed()
		local parsersToInstall = vim.iter(ensureInstalled)
			:filter(function(parser)
				return not vim.tbl_contains(alreadyInstalled, parser)
			end)
			:totable()

		if #parsersToInstall > 0 then
			require("nvim-treesitter").install(parsersToInstall)
		end
	end,
}
