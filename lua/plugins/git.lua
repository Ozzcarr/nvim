return {
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        },
    },
    {
        "sindrets/diffview.nvim",
        keys = {
            {
                "<leader>gd",
                function()
                    local lib = require("diffview.lib")
                    local view = lib.get_current_view()
                    if view then
                        vim.cmd("DiffviewClose")
                    else
                        vim.cmd("DiffviewOpen")
                    end
                end,
                desc = "Toggle Git Diff",
            },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },
}
