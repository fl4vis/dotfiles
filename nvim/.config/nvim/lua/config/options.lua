-- Control<C-x>
-- Shift <S-x>
-- Alt/Meta<M-x> or <A-x>

vim.g.mapleader = " "

vim.g.netrw_banner = 0

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.inccommand = "split"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.laststatus = 3

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.clipboard:append("unnamedplus")
vim.opt.isfname:append("@-@")
vim.opt.scrolloff = 8

vim.opt.colorcolumn = "0"
vim.opt.signcolumn = "yes"

vim.o.cmdheight = 0
vim.opt.termguicolors = true

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.hl.on_yank()
	end,
})

--  Keymaps to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands

-- Window
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Buffer
vim.keymap.set("n", "<leader>c", ":bdelete<CR>", { desc = "Close Buffer" })

-- Tab
vim.keymap.set("n", "]t", ":tabnext<CR>", { desc = "Next Tab" })
vim.keymap.set("n", "[t", ":tabprevious<CR>", { desc = "Previous Tab" })
vim.keymap.set("n", "<leader>tn", ":tab sbuffer<CR>", { desc = "New Tab from Buffer" })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close Tab" })
vim.keymap.set("n", "<leader>t<", ":tabmove -1<CR>", { desc = "Move Tab -1" })
vim.keymap.set("n", "<leader>t>", ":tabmove +1<CR>", { desc = "Move Tab +1" })

vim.keymap.set("n", "<A-k>", "<C-W>+", { desc = "Resize +" })

-- Rounded Hover Signature
vim.o.winborder = "rounded"
