return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			telescope.setup({
				defaults = {
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							width = 0.87,
							height = 0.80,
							preview_width = 0.55,
						},
						prompt_position = "top",
					},
					sorting_strategy = "ascending",
					prompt_prefix = "   ",
					selection_caret = " ",
					path_display = { "filename_first" },
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})

			telescope.load_extension("ui-select")
			telescope.load_extension("fzf")

			-- Files / search
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
			vim.keymap.set("n", "<leader>fh", function()
				builtin.find_files({ hidden = true, no_ignore = true })
			end, { desc = "Find Hidden Files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
			vim.keymap.set("n", "<leader>fr", builtin.registers, { desc = "Registers" })
			vim.keymap.set("n", "<leader>fj", builtin.jumplist, { desc = "Jump List" })

			-- LSP
			vim.keymap.set("n", "<leader>ld", builtin.diagnostics, { desc = "Diagnostics all open buffers" })
			vim.keymap.set("n", "<leader>la", function()
				vim.lsp.buf.code_action()
			end, { desc = "Code Action" })
			vim.keymap.set("n", "<leader>lr", builtin.lsp_references, { desc = "References" })
			vim.keymap.set(
				"n",
				"<leader>ls",
				builtin.lsp_dynamic_workspace_symbols,
				{ desc = "Dynamic Workspace Symbols" }
			)

			local function workspace_symbols_with_icons(opts)
				opts = opts or {}
				local make_entry = require("telescope.make_entry")
				local gen = make_entry.gen_from_lsp_symbols(opts)

				local icons = {
					File = "󰈙",
					Module = "",
					Namespace = "󰌗",
					Package = "",
					Class = "󰌗",
					Method = "󰆧",
					Property = "",
					Field = "",
					Constructor = "",
					Enum = "",
					Interface = "",
					Function = "󰊕",
					Variable = "󰀫",
					Constant = "󰏿",
					String = "󰀬",
					Number = "󰎠",
					Boolean = "◩",
					Array = "󰅪",
					Object = "󰅩",
					Key = "󰌋",
					Null = "󰟢",
					EnumMember = "",
					Struct = "󰙅",
					Event = "",
					Operator = "󰆕",
					TypeParameter = "󰊄",
				}

				opts.entry_maker = function(entry)
					local e = gen(entry)
					if not e then
						return e
					end

					local icon = icons[entry.kind] or "?"
					local orig = e.display

					e.display = function(et)
						local disp, hl
						if type(orig) == "function" then
							disp, hl = orig(et)
						else
							disp = orig
						end
						return icon .. " " .. tostring(disp), hl
					end

					return e
				end

				require("telescope.builtin").lsp_workspace_symbols(opts)
			end

			vim.keymap.set("n", "<leader>ly", workspace_symbols_with_icons, { desc = "Workspace Symbols" })

			-- ASCII art finder
			vim.keymap.set("n", "<leader>fa", function()
				require("telescope").extensions.ascii.ascii()
			end, { desc = "Find ASCII art" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
}
