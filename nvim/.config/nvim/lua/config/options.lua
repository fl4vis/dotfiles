-- Control<C-x> 
-- Shift <S-x>
-- Alt/Meta<M-x> or <A-x>

vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.wrap = false


-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands

-- Window
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })


-- Buffer
vim.keymap.set("n", "]b", ":bnext<CR>", {desc = "Next Buffer"})
vim.keymap.set("n", "[b", ":bprev<CR>", {desc = "Previous Buffer"})
vim.keymap.set("n", "<leader>c", ":bdelete<CR>", {desc = "Close Buffer"})

-- Tab
vim.keymap.set("n", "]t", ":tabnext<CR>", {desc = "Next Tab"})
vim.keymap.set("n", "[t", ":tabprevious<CR>", {desc = "Previous Tab"})

vim.keymap.set("n", "<A-k>", "<C-W>+", { desc = "Resize +" })

-- Rounded Hover Signature
vim.o.winborder = 'rounded'
