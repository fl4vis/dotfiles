-- help [vim.lsp.buf, vim.diagnostic, lsp-config, lspconfig-all]
-- checkhealt vim.lsp , lsp

vim.lsp.enable({
    "lua_ls",
    "intelephense",
    "ts_ls",
    "gopls",
    "tailwindcss",
    "html",
    "emmet",
    "clangd",
    "sqls",
    "pyright",
    "rust_analyzer",
})

-- Keybindings
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Actions" })
        vim.keymap.set("n", "<leader>ls", vim.lsp.buf.document_symbol, { desc = "Document Symbol" })

        vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show Diagnostic Float" })
        vim.keymap.set("n", "<leader>lk", vim.diagnostic.setqflist, { desc = "Show Diagnostic List" })

        vim.keymap.set("n", "<leader>li", vim.lsp.buf.type_definition, { desc = "Show Type Definition" })

        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Builint LSP formmatter" })
    end,
})

-- Diagnostics
local severity = vim.diagnostic.severity
vim.diagnostic.config({
    virtual_lines = {
        current_line = true,
    },
    signs = {
        text = {
            [severity.ERROR] = " ",
            [severity.WARN] = " ",
            [severity.HINT] = "󰠠 ",
            [severity.INFO] = " ",
        },
    },
})
