return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require "configs.lspconfig"
        end,
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black", "isort" },
                json = { "prettier" },
                yaml = { "prettier" },
                terraform = { "terraform-ls" },
                markdown = { "markdown_oxide" },
            },
        },
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "stylua",
                "prettier",
                "pyright",
                "black",
                "isort",
                "flake8",
                "terraform-ls",
                "markdown_oxide",
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "vim",
                "lua",
                "vimdoc",
                "python",
                "terraform",
                "markdown",
            },
        },
    },
}
