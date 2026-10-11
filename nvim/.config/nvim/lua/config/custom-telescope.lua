local M = {}

local make_entry = require("telescope.make_entry")

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
function M.lsp_icons(picker, opts)
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

-- Buffer Picker
function M.buffers()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local actions = require("telescope.actions")
	local state = require("telescope.actions.state")
	local conf = require("telescope.config").values

	local buffers = vim.tbl_filter(function(buf)
		return vim.bo[buf].buflisted
	end, vim.api.nvim_list_bufs())

	-- Most recently used first
	table.sort(buffers, function(a, b)
		return vim.fn.getbufinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
	end)

	local entries = {}
	local letters = {}

	for i, buf in ipairs(buffers) do
		if i > 26 then
			break
		end

		local letter = string.char(96 + i)
		local name = vim.api.nvim_buf_get_name(buf)

		if name == "" then
			name = "[No Name]"
		end

		entries[#entries + 1] = {
			bufnr = buf,
			letter = letter,
			name = vim.fn.fnamemodify(name, ":t"),
		}

		letters[letter] = buf
	end

	pickers
		.new({ initial_mode = "normal" }, {
			prompt_title = "Buffers",

			finder = finders.new_table({
				results = entries,
				entry_maker = function(entry)
					return {
						value = entry,
						ordinal = entry.name,
						display = entry.letter .. "  " .. entry.name,
						bufnr = entry.bufnr,
						filename = vim.api.nvim_buf_get_name(entry.bufnr),
					}
				end,
			}),

			sorter = conf.generic_sorter({}),
			previewer = conf.file_previewer({}),

			attach_mappings = function(prompt_bufnr, map)
				local function open(buf)
					actions.close(prompt_bufnr)
					vim.api.nvim_set_current_buf(buf)
				end

				for letter, buf in pairs(letters) do
					map("n", letter, function()
						open(buf)
					end)
				end

				actions.select_default:replace(function()
					local entry = state.get_selected_entry()
					if entry then
						open(entry.value.bufnr)
					end
				end)

				map("i", "<C-n>", actions.move_selection_next)
				map("i", "<C-p>", actions.move_selection_previous)
				map("n", "<C-n>", actions.move_selection_next)
				map("n", "<C-p>", actions.move_selection_previous)
				return true
			end,
		})
		:find()
end

return M
