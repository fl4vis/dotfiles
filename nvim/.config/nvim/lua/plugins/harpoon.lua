return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  config = function ()
    require("telescope").load_extension('harpoon')

    local map = vim.keymap.set
    map("n", "<leader>ah", ":lua require('harpoon.mark').add_file()<CR>", {noremap= true, desc = "Harpoon File"})
    map("n", "<leader>ar", ":lua require('harpoon.mark').rm_file()", {noremap= true, desc = "Harpoon Remove File"})
    map("n", "<leader>ad", ":lua require('harpoon.mark').clear_all()<CR>", {noremap= true, desc = "Harpoon Delete All"})
    map("n", "<leader>am", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", {noremap= true, desc = "Harpoon Menu"})
    map("n", "<leader>a]", ":lua require('harpoon.ui').nav_next()<CR>", {noremap = true, desc = "Harpoon Next"})
    map("n", "<leader>a[", ":lua require('harpoon.ui').nav_prev()<CR>", {noremap = true, desc = "Harpoon Prev"})
    map("n", "<leader>at", ":Telescope harpoon marks<CR>", {noremap = true, desc = "Telescope"})

  end
}

