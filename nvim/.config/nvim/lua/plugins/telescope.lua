return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
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

            -- ASCII art finder
            vim.keymap.set("n", "<leader>fa", function()
                require("telescope").extensions.ascii.ascii()
            end, { desc = "Find ASCII art" })
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({
                            -- even more opts
                        }),

                        -- pseudo code / specification for writing custom displays, like the one
                        -- for "codeactions"
                        -- specific_opts = {
                        --   [kind] = {
                        --     make_indexed = function(items) -> indexed_items, width,
                        --     make_displayer = function(widths) -> displayer
                        --     make_display = function(displayer) -> function(e)
                        --     make_ordinal = function(e) -> string
                        --   },
                        --   -- for example to disable the custom builtin "codeactions" display
                        --      do the following
                        --   codeactions = false,
                        -- }
                    },
                },
            })
            -- To get ui-select loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require("telescope").load_extension("ui-select")
        end,
    },
}
