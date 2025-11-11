return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = function()
        local header = "Neovim" -- Simple fallback

        -- Try to get random ASCII art
        local ok, ascii = pcall(require, "ascii")
        if ok then
            local art = ascii.get_random_global()
            if art then
                -- Handle table return
                if type(art) == "table" then
                    header = table.concat(art, "\n")
                elseif type(art) == "string" then
                    header = art
                end
            end
        end

        return {
            bigfile = { enabled = false },
            dashboard = {
                preset = {
                    pick = nil,
                    header = header,
                },
                sections = {
                    { section = "header" },
                },
            },
            explorer = { enabled = false },
            indent = { enabled = false },
            input = { enabled = false },
            notifier = {
                enabled = false,
                timeout = 3000,
            },
            picker = { enabled = false },
            quickfile = { enabled = false },
            scope = { enabled = false },
            scroll = { enabled = false },
            statuscolumn = { enabled = false },
            words = { enabled = false },
            styles = {
                notification = {},
            },
        }
    end,
}
