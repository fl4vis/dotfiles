require("vim._core.ui2").enable({})

require("config.options")
require("config.lazy")

require("lazy").setup({
	spec = {
		{ import = "plugins" },
		{ import = "plugins.themes" },
		{ import = "plugins.navigation" },
		{ import = "plugins.lsp" },
		{ import = "plugins.debug" },
	},
})

require("config.lsp")

-- :packadd nvim.undotree
-- :packadd nvim-difftool
