local format_settings = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
}

return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        -- Setup
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
            },
            format_on_save = format_settings,
        })

        -- Keybindings
        vim.keymap.set({ "n", "v" }, "<leader>pr", function()
            conform.format(format_settings)
        end, { desc = "Format file or range (in visual mode)" })

        -- Automatically format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                require("conform").format({ bufnr = args.buf })
            end,
        })
    end,
}
