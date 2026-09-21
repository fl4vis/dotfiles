return {
	-- Manage/Install LSP's in our system
	"williamboman/mason.nvim",
	config = function()
		require("mason").setup()
	end,
}
