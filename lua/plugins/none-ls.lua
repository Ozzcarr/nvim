return {
    {
        "jay-babu/mason-null-ls.nvim",
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = {
                    -- Lua
                    "stylua",

                    -- Javascript
                    "prettier",

                    -- Python
                    "isort",
                    "black",

                    -- C / C++
                    "clang-format",
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
                    null_ls.builtins.formatting.stylua.with({
                        extra_args = { "--indent-type", "Spaces", "--indent-width", "4" },
                    }),

                    -- Javascript
                    null_ls.builtins.formatting.prettier.with({
                        extra_args = { "--print-width", "120" },
                    }),

                    -- Python
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.formatting.black.with({
                        extra_args = { "--line-length", "120" },
                    }),

                    -- C / C++
                    null_ls.builtins.formatting.clang_format.with({
                        extra_args = { "--indent-width", "4", "--line-length", "120" },
                    }),
                },
            })
        end,
    },
}
