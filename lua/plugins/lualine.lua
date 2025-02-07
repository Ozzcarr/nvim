return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "f-person/git-blame.nvim" },
    config = function()
        local git_blame = require("gitblame")
        vim.g.gitblame_display_virtual_text = 0

        local cached_branch = nil
        local function get_git_branch()
            -- Check if the branch is already cached and return it
            if cached_branch then
                return cached_branch
            end

            -- Detect if running on Windows
            local is_windows = package.config:sub(1, 1) == "\\"
            local cmd = is_windows and "git rev-parse --abbrev-ref HEAD 2>nul"
                or "git rev-parse --abbrev-ref HEAD 2>/dev/null"

            -- Run command safely
            local handle = io.popen(cmd)
            if not handle then
                cached_branch = "No Branch"
                return cached_branch
            end

            local branch = handle:read("*a") or ""
            handle:close()

            branch = branch:gsub("%s+", "") -- Trim whitespace (newlines, spaces)
            cached_branch = branch ~= "" and branch or "No Branch"

            return cached_branch
        end

        -- Reset cache when changing directories
        vim.cmd([[autocmd DirChanged * lua cached_branch = nil]])

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
