return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
        require("lualine").setup({
            options = {
                theme = "catppuccin",
            },
            sections = {
                lualine_a = {
                    "mode",
                },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            -- Top of editor
            tabline = {
                lualine_a = {
                    "tabs",
                },
                lualine_c = {
                    {
                        "buffers",
                        show_filename_only = true, -- Shows shortened relative path when set to false.
                        hide_filename_extension = false, -- Hide filename extension when set to true.
                        show_modified_status = true, -- Shows indicator when the buffer is modified.

                        mode = 4,      -- 0: Shows buffer name
                        -- 1: Shows buffer index
                        -- 2: Shows buffer name + buffer index
                        -- 3: Shows buffer number
                        -- 4: Shows buffer name + buffer number

                        max_length = vim.o.columns * 2 / 3,
                    },
                }, -- Tabline with tabs component
            },
        })
    end,
}
