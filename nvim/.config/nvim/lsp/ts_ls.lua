local vue_typescript_plugin =
	vim.fn.expand(vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server")

return {
	cmd = { "typescript-language-server", "--stdio" },
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vue_typescript_plugin,
				languages = { "vue" },
			},
		},
	},
	filetypes = {
		"vue",
	},
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
}
