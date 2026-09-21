return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	config = function()
		require("lualine").setup({
			options = {
				theme = "catppuccin-nvim",
			},
			sections = {
				lualine_a = {
					"mode",
				},
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						"filetype",
						separator = "|",
					},
					{
						"filesize",
						icon = "󰈙",
						separator = " 󰿟 ",
					},
				},
				lualine_x = {
					"location",
				},
				lualine_y = { "progress" },
				lualine_z = { "searchcount", "selectioncount" },
			},
			-- Top of editor
			tabline = {
				lualine_a = {
					{
						"tabs",
						mode = 0,
						component_separators = { left = "", right = "" },
						section_separators = { left = "", right = "" },
						padding = 0,
						tabs_color = {
							active = "lualine_a_normal",
							inactive = "lualine_c_inactive",
						},
						symbols = {
							modified = "", -- Text to show when the file is modified.
						},
					},
				},
				-- Gap between tabs and buffers
				lualine_b = {
					{

						function()
							local hour = tonumber(os.date("%H"))

							if hour < 6 then
								return "  " -- night
							elseif hour < 12 then
								return " 󱃾 " -- morning
							elseif hour < 18 then
								return "   " -- afternoon
							elseif hour < 24 then
								return "  " -- afternoon
							else
								return "   " -- evening
							end
						end,
						padding = 0,
						separator = { left = "", right = "" },
					},
				},
				lualine_c = {
					{
						"buffers",
						show_filename_only = true, -- Shows shortened relative path when set to false.
						hide_filename_extension = false, -- Hide filename extension when set to true.
						show_modified_status = true, -- Shows indicator when the buffer is modified.

						mode = 4,
						-- 0: Shows buffer name
						-- 1: Shows buffer index
						-- 2: Shows buffer name + buffer index
						-- 3: Shows buffer number
						-- 4: Shows buffer name + buffer number

						symbols = {
							modified = " ●",
							alternate_file = "",
							directory = "",
						},

						buffers_color = {
							active = "lualine_a_normal",
							inactive = "lualine_c_normal",
						},

						max_length = vim.o.columns,
					},
				}, -- Tabline with tabs component
			},
		})
	end,
}
