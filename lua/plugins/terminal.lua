return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    opts = {
        open_mapping = [[<C-n>]],
        direction = "float",
        persist_mode = true,
        shell = vim.fn.has('win32') == 1 and 'pwsh' or nil,  -- Use PowerShell on Windows
    },
}
