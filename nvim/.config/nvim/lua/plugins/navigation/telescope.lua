local icons = {
	Namespace = " ",
	Package = " ",
	String = "󰀬 ",
	Number = "󰎠 ",
	Boolean = "◩ ",
	Array = "󰅪 ",
	Object = "󰅩 ",
	Key = "󰌋 ",
	Null = "󰟢 ",
	Text = "󰉿 ",
	Method = "󰊕 ",
	Function = "󰊕 ",
	Constructor = " ",
	Field = "󰜢 ",
	Variable = "󰀫 ",
	Class = " ",
	Interface = " ",
	Module = "󰕳 ",
	Property = "󰜢 ",
	Unit = "󰑭 ",
	Value = "󰎠 ",
	Enum = " ",
	Keyword = "󰌋 ",
	Snippet = " ",
	Color = "󰏘 ",
	File = "󰈙 ",
	Reference = "󰈇 ",
	Folder = "󰉋 ",
	EnumMember = " ",
	Constant = "󰏿 ",
	Struct = "󰙅 ",
	Event = " ",
	Operator = "󰆕 ",
	TypeParameter = "",
}

---@param picker TelescopeSymbolPicker
---@param opts? table
local function lsp_icons(picker, opts)
	local make_entry = require("telescope.make_entry")

	opts = opts or {}

	local gen = make_entry.gen_from_lsp_symbols(opts)

	opts.entry_maker = function(entry)
		local e = gen(entry)
		if not e then
			return nil
		end

		local original_display = e.display

		e.display = function(et)
			local display, highlights

			if type(original_display) == "function" then
				display, highlights = original_display(et)
			else
				display = original_display
			end

			local icon = icons[entry.kind] or "?"

			return icon .. " " .. tostring(display), highlights
		end

		return e
	end

	picker(opts)
end

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
				pickers = {
					lsp_document_symbols = {
						default_text = "", -- or symbols, initial_mode, etc.
					},
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

			-----------
			-- LSP
			-----------
			vim.keymap.set("n", "<leader>lD", builtin.diagnostics, { desc = "Diagnostics all Buffers" })

			vim.keymap.set("n", "<leader>li", function()
				builtin.lsp_implementations({
					jump_type = "never",
				})
			end, { desc = "Implementations" })

			vim.keymap.set("n", "<leader>lt", builtin.lsp_definitions, { desc = "Definition" })
			vim.keymap.set("n", "<leader>lT", builtin.lsp_type_definitions, { desc = "Type" })

			vim.keymap.set("n", "<leader>lo", builtin.lsp_incoming_calls, { desc = "Incoming Calls (who calls this)" })
			vim.keymap.set("n", "<leader>lO", builtin.lsp_outgoing_calls, { desc = "Outgoing Calls (what this calls)" })

			vim.keymap.set("n", "<leader>lr", builtin.lsp_references, { desc = "References" })

			-- Use lsp icons
			vim.keymap.set("n", "<leader>ls", function()
				lsp_icons(builtin.lsp_document_symbols, {
					path_display = { "hidden" },
					on_complete = {
						function(picker)
							if picker:_get_prompt() == "A" then
								picker:set_prompt("")
							end
						end,
					},
				})
			end, { desc = "Document Symbols" })

			vim.keymap.set("n", "<leader>ly", function()
				lsp_icons(builtin.lsp_workspace_symbols)
			end, { desc = "Workspace Symbols" })

			vim.keymap.set("n", "<leader>lY", function()
				lsp_icons(builtin.lsp_dynamic_workspace_symbols)
			end, { desc = "Dynamic Workspace Symbols" })

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
