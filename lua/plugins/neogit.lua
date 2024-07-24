return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",         -- required
        "sindrets/diffview.nvim",        -- optional - Diff integration
        "nvim-telescope/telescope.nvim", -- optional - Telescope integration
    },
    config = function()
        require("neogit").setup {
            kind = 'vsplit',
        }
        vim.keymap.set("n", "<leader>gi", "<cmd>Neogit<CR>", { desc = "Open Neogit" })
    end
}
