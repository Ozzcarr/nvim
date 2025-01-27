return {
    {
        "jay-babu/mason-null-ls.nvim",
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = {
                    -- Lua
                    "stylua",

                    -- Javascript
                    "eslint_d",
                    "prettier",

                    -- Python
                    -- "isort",
                    "black",
                },
            })
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvimtools/none-ls-extras.nvim",
        },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    -- Lua
                    null_ls.builtins.formatting.stylua,

                    -- Javascript
                    require("none-ls.diagnostics.eslint_d"),
                    null_ls.builtins.formatting.prettier,

                    -- Python
                    -- null_ls.builtins.formatting.isort,
                    null_ls.builtins.formatting.black,
                },
            })
        end,
    },
}
