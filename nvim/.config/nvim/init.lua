require("config.options")
require("config.lazy")

require("lazy").setup({
    spec = {
        { import = "plugins" },
        { import = "plugins.themes" },
        { import = "plugins.debug" },
    },
})

require("config.lsp")
require("config.ui")
