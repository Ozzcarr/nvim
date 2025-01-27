vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

return {
    "rmagatti/auto-session",
    lazy = false,

    opts = {
        auto_create = false,
        show_auto_restore_notif = true,
        suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    },
    keys = {
        { "<leader>ss", ":SessionSearch<cr>" },
        { "<leader>sd", ":Autosession delete<cr>" },
        { "<leader>sa", ":SessionSave<cr>" },
    },
}
