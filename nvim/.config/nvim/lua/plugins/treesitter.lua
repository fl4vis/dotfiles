return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        { "nvim-treesitter/nvim-treesitter-context" },
    },
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            modules = {},
            auto_install = false,
            ignore_install = {},
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "go",
                "javascript",
                "html",
                "php",
                "php_only",
                "css",
                "blade",
                "sql",
                "yaml",
                "json",
                "jsdoc",
                "phpdoc",
            },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
