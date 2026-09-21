return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			integrations = {
				blink_cmp = true,
				native_lsp = {
					enabled = true,
				},
			},
		})
		vim.cmd.colorscheme("catppuccin-macchiato")
	end,
}
