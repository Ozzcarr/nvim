return {
    "folke/zen-mode.nvim",
    opts = {
        window = {
            width = 130,
        },
    },
    config = function(_, opts)
        require("zen-mode").setup(opts)
        vim.keymap.set("n", "<leader>z", ":ZenMode<cr>", { desc = "Open Zen Mode" })
    end,
}
