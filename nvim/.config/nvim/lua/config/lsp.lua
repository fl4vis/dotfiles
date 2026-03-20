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

        vim.keymap.set("n", "<leader>lt", function()
            for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
                client.server_capabilities.documentFormattingProvider = false
            end
        end, { desc = "Disable LSP Formatter" })
    end,
})

-- Formatting
vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
    callback = function()
        vim.lsp.buf.format({ async = false })
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

-- ECS (PHP)
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.php",
    callback = function()
        local filepath = vim.fn.expand("%:p")
        local root = vim.fn.finddir("vendor/bin", ".;")

        if root ~= "" then
            local ecs_path = vim.fn.fnamemodify(root, ":h:h") .. "/vendor/bin/ecs"

            if vim.fn.filereadable(ecs_path) == 1 then
                vim.fn.system(
                    string.format(
                        "cd %s && %s check --fix --no-progress-bar %s",
                        vim.fn.shellescape(vim.fn.fnamemodify(root, ":h:h")),
                        vim.fn.shellescape(ecs_path),
                        vim.fn.shellescape(filepath)
                    )
                )

                -- Reload the buffer to show the changes
                vim.cmd("checktime")
            end
        end
    end,
    group = vim.api.nvim_create_augroup("ECSFormat", { clear = true }),
})
