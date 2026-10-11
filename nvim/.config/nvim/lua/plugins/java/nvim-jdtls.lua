return {
	{
		"mfussenegger/nvim-jdtls",
		url = "https://codeberg.org/mfussenegger/nvim-jdtls",
		ft = "java",

		config = function()
			local jdtls = require("jdtls")

			local home = os.getenv("HOME")
			local mason = vim.fn.stdpath("data") .. "/mason/packages"

			-- JDTLS installed by Mason.
			local jdtls_path = mason .. "/jdtls"

			-- Find the project root.
			local root_dir = jdtls.setup.find_root({
				"mvnw",
				"gradlew",
				"pom.xml",
				"build.gradle",
				"build.gradle.kts",
				".git",
			})

			if not root_dir then
				return
			end

			-- Find Lombok installed by Maven.
			local lombok_jars =
				vim.fn.glob(home .. "/.m2/repository/org/projectlombok/lombok/*/lombok-*.jar", false, true)

			table.sort(lombok_jars)

			local lombok_path = lombok_jars[#lombok_jars]

			if not lombok_path then
				vim.notify("Lombok jar not found in ~/.m2/repository/org/projectlombok/lombok", vim.log.levels.ERROR)
				return
			end

			-- One workspace per project.
			local project_name = vim.fn.fnamemodify(root_dir, ":t")

			local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name

			-- JDTLS launcher installed by Mason.
			local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

			if launcher == "" then
				vim.notify("JDTLS launcher not found", vim.log.levels.ERROR)
				return
			end

			-- Used to silence JDTLS status/progress messages.
			local noop = function() end

			local config = {
				cmd = {
					"java",

					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dosgi.checkConfiguration=true",

					"-Xms1G",
					"-Xmx2G",

					-- Lombok must be loaded into the JVM running JDTLS.
					"-javaagent:" .. lombok_path,

					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",

					"-jar",
					launcher,

					"-configuration",
					jdtls_path .. "/config_linux",

					"-data",
					workspace_dir,
				},

				root_dir = root_dir,

				-- Hide the "Starting Java Language Server", "ServiceReady", etc. messages.
				handlers = {
					["language/status"] = noop,
					["language/progressReport"] = noop,
					["$/progress"] = noop,
				},

				settings = {
					java = {
						eclipse = {
							downloadSources = true,
						},

						configuration = {
							updateBuildConfiguration = "interactive",
						},

						maven = {
							downloadSources = true,
						},

						implementationsCodeLens = {
							enabled = true,
						},

						referencesCodeLens = {
							enabled = true,
						},

						signatureHelp = {
							enabled = true,
						},
					},
				},

				init_options = {
					bundles = {},
				},
			}

			local function attach_jdtls()
				jdtls.start_or_attach(config)
			end

			-- Lazy.nvim runs config() only once when the plugin loads.
			-- Register a FileType autocmd to attach JDTLS to every Java buffer.
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "java",
				callback = attach_jdtls,
			})

			-- Attach to the first Java buffer too.
			if vim.bo.filetype == "java" then
				attach_jdtls()
			end
		end,
	},
}
