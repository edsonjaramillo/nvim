return {
    "smoka7/hop.nvim",
    opts = {
        multi_windows = true,
        keys = "htnsueoaidgcrlypmbkjxv",
        uppercase_labels = true
    },
    keys = {
        {
            "<leader>fj",
            function()
                require("hop").hint_words()
            end,
            mode = { "n", "x", "o" }
        }
    }
}
