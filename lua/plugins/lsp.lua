return {
    {
        "williamboman/mason.nvim",
        config = function()
            vim.keymap.set("n", "<leader>m", ":Mason<cr>", { desc = "Open Mason" })
            require("mason").setup({
                PATH = "prepend",
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                    "pyright",
                    "clangd",
                },
                automatic_installation = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        init = function()
            vim.opt.signcolumn = "yes" -- Reserve a space to the left to prevent shifting of layout
            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics,
                {
                    virtual_text = false,
                    signs = true,
                    update_in_insert = false,
                    underline = true,
                }
            )

            vim.keymap.set("n", "<leader>e", ":lua vim.diagnostic.open_float()<cr>", { desc = "Show line diagnostics" })
        end,
        config = function()
            -- Add capabilities
            local lsp_defaults = require("lspconfig").util.default_config
            lsp_defaults.capabilities =
                vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

            -- Set keymaps
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
                    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                    vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
                    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                end,
            })

            -- Change flex to lex to make treesitter syntax highlight correctly
            vim.api.nvim_exec(
                [[
                  augroup FileTypeFlex
                    autocmd!
                    autocmd BufRead,BufNewFile *.flex setfiletype lex
                  augroup END
                ]],
                false
            )

            -- Setup languages
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({})
            lspconfig.pyright.setup({})
            lspconfig.clangd.setup({})
            lspconfig.ts_ls.setup({
                on_attach = function(client, _)
                    -- Disable tsserver's formatting capability
                    client.server_capabilities.documentFormattingProvider = false
                end,
            })
        end,
    },
}
