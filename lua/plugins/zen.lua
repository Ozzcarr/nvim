return {
    "folke/zen-mode.nvim",
    opts = {
        width = 120,
    },
    config = function()
        vim.keymap.set("n", "<leader>z", ":ZenMode<cr>", { desc = "Open Zen Mode" })
    end
}
