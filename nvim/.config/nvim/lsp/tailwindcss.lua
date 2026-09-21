---@brief
--- https://github.com/tailwindlabs/tailwindcss-intellisense
---
--- Tailwind CSS Language Server can be installed via npm:
---
--- npm install -g @tailwindcss/language-server
---
--- To manually set the config file or CSS entry-point, see:
--- https://github.com/tailwindlabs/tailwindcss-intellisense#tailwindcssexperimentalconfigfile

---@type vim.lsp.Config
return {
	cmd = function(dispatchers, config)
		local cmd = "tailwindcss-language-server"
		if (config or {}).root_dir then
			local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules/.bin", cmd)
			if vim.fn.executable(local_cmd) == 1 then
				cmd = local_cmd
			end
		end
		return vim.lsp.rpc.start({ cmd, "--stdio" }, dispatchers)
	end,
	-- filetypes copied and adjusted from tailwindcss-intellisense
	filetypes = {
		-- html
		"aspnetcorerazor",
		"astro",
		"astro-markdown",
		"blade",
		"clojure",
		"django-html",
		"htmldjango",
		"edge",
		"eelixir", -- vim ft
		"elixir",
		"ejs",
		"erb",
		"eruby", -- vim ft
		"gohtml",
		"gohtmltmpl",
		"haml",
		"handlebars",
		"hbs",
		"html",
		"htmlangular",
		"html-eex",
		"heex",
		"jade",
		"leaf",
		"liquid",
		"markdown",
		"mdx",
		"mustache",
		"njk",
		"nunjucks",
		"php",
		"razor",
		"slim",
		"twig",
		-- css
		"css",
		"less",
		"postcss",
		"sass",
		"scss",
		"stylus",
		"sugarss",
		-- js
		"javascript",
		"javascriptreact",
		"reason",
		"rescript",
		"typescript",
		"typescriptreact",
		-- mixed
		"vue",
		"svelte",
		"templ",
	},
	capabilities = {
		workspace = {
			didChangeWatchedFiles = {
				dynamicRegistration = true,
			},
		},
	},
	---@type lspconfig.settings.tailwindcss
	settings = {
		tailwindCSS = {
			validate = true,
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidScreen = "error",
				invalidVariant = "error",
				invalidConfigPath = "error",
				invalidTailwindDirective = "error",
				recommendedVariantOrder = "warning",
			},
			classAttributes = {
				"class",
				"className",
				"class:list",
				"classList",
				"ngClass",
			},
			includeLanguages = {
				eelixir = "html-eex",
				elixir = "phoenix-heex",
				eruby = "erb",
				heex = "phoenix-heex",
				htmlangular = "html",
				templ = "html",
			},
		},
	},
	before_init = function(_, config)
		config.settings = vim.tbl_deep_extend("keep", config.settings, {
			editor = { tabSize = vim.lsp.util.get_effective_tabstop() },
		})
	end,
	workspace_required = true,
	root_dir = function(bufnr, on_dir)
		local root_files = {
			-- Generic
			"tailwind.config.js",
			"tailwind.config.cjs",
			"tailwind.config.mjs",
			"tailwind.config.ts",
			"postcss.config.js",
			"postcss.config.cjs",
			"postcss.config.mjs",
			"postcss.config.ts",
			-- Django
			"theme/static_src/tailwind.config.js",
			"theme/static_src/tailwind.config.cjs",
			"theme/static_src/tailwind.config.mjs",
			"theme/static_src/tailwind.config.ts",
			"theme/static_src/postcss.config.js",
			-- Fallback for tailwind v4, where tailwind.config.* is not required anymore
			".git",
		}

		local fname = vim.api.nvim_buf_get_name(bufnr)

		-- If a package.json up the tree lists tailwindcss as a dependency,
		-- treat it as a root marker too.
		local pkg_json = vim.fs.find("package.json", { path = fname, upward = true })[1]
		if pkg_json then
			local ok, content = pcall(function()
				return vim.json.decode(table.concat(vim.fn.readfile(pkg_json), "\n"))
			end)
			if ok and content then
				local deps = content.dependencies or {}
				local dev_deps = content.devDependencies or {}
				if deps.tailwindcss or dev_deps.tailwindcss then
					table.insert(root_files, "package.json")
				end
			end
		end

		-- If Gemfile.lock or mix.lock mentions tailwind, treat them as root markers too.
		for _, lockfile in ipairs({ "Gemfile.lock", "mix.lock" }) do
			local lock_path = vim.fs.find(lockfile, { path = fname, upward = true })[1]
			if lock_path then
				local lines = vim.fn.readfile(lock_path)
				for _, line in ipairs(lines) do
					if line:lower():find("tailwind") then
						table.insert(root_files, lockfile)
						break
					end
				end
			end
		end

		on_dir(vim.fs.dirname(vim.fs.find(root_files, { path = fname, upward = true })[1]))
	end,
}
