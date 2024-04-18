return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre", "BufNewFile" }, -- uncomment for format on save
        -- keys = {
        --     {
        --         "<leader>fm",
        --         function()
        --             require("conform").format {
        --                 async = true,
        --                 timeout_ms = 500,
        --                 lsp_fallback = true,
        --             }
        --         end,
        --         mode = "n,v",
        --         desc = "format buffer",
        --     },
        -- },
        -- opts = {      
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black", "isort" },
                json = { "prettier" },
                yaml = { "prettier" },
            },
            format_on_save = {
                async = false,
                timeout_ms = 500,
                lsp_fallback = true,
            },
        },
}
