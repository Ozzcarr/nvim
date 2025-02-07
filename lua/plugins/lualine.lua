return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "f-person/git-blame.nvim" },
    config = function()
        local git_blame = require("gitblame")
        vim.g.gitblame_display_virtual_text = 0

        local cached_branch = nil

        local function get_git_branch()
            return cached_branch or "Loading..."
        end

        -- Declare globally to avoid "nil value" errors
        _G.update_git_branch = function()
            local is_windows = package.config:sub(1, 1) == "\\"
            local cmd = is_windows and "git rev-parse --abbrev-ref HEAD 2>NUL"
                or "git rev-parse --abbrev-ref HEAD 2>/dev/null"

            vim.fn.jobstart(cmd, {
                on_stdout = function(_, data)
                    if data and #data > 0 and data[1] ~= "" then
                        cached_branch = data[1]
                    else
                        cached_branch = "No Branch"
                    end
                    -- Force refresh lualine after fetching the branch
                    vim.cmd("redrawstatus")
                end,
                stdout_buffered = true,
            })
        end

        -- Run on startup
        update_git_branch()

        -- Update git branch on change
        vim.cmd([[autocmd DirChanged * lua _G.update_git_branch()]])
        vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
            callback = function()
                -- Only update if inside a Git repo
                if vim.fn.isdirectory(".git") == 1 then
                    update_git_branch()
                end
            end,
        })

        require("lualine").setup({
            options = {
                theme = "nightfly",
            },
            sections = {
                lualine_b = {
                    { get_git_branch, icon = "" },
                },
                lualine_c = {
                    { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
                },
                lualine_x = {
                    "diagnostics",
                    "filetype",
                },
            },
        })
    end,
}
