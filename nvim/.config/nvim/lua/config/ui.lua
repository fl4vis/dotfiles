-- Fix telescope double winborder caused nvim 0.11
vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopeFindPre",
  callback = function()
    vim.opt_local.winborder = "none"
    vim.api.nvim_create_autocmd("WinLeave", {
      once = true,
      callback = function()
        vim.opt_local.winborder = "rounded"
      end,
    })
  end,
})

-- -- Fix harpoon double winborder caused nvim 0.11
local harpoon_ui = require("harpoon.ui")

-- Wrap the original function
local original_toggle = harpoon_ui.toggle_quick_menu

harpoon_ui.toggle_quick_menu = function()
  vim.api.nvim_exec_autocmds("User", { pattern = "HarpoonMenuOpened" })
  original_toggle()
end

vim.api.nvim_create_autocmd("User", {
  pattern = "HarpoonMenuOpened", -- Assuming this event exists or can be simulated
  callback = function()
    vim.opt_local.winborder = "none"
    vim.api.nvim_create_autocmd("WinLeave", {
      once = true,
      callback = function()
        vim.opt_local.winborder = "rounded"
      end
    })
  end
})
