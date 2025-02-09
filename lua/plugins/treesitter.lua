return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup()
            vim.keymap.set("n", "<leader>gc", function()
                require("treesitter-context").go_to_context(vim.v.count1)
            end, { silent = true })
        end,
    },
}
