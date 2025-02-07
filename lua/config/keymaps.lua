local map = vim.keymap.set

-- Set leader key
vim.g.mapleader = " "

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Pasting
map("x", "<leader>p", '"_dP', { desc = "Paste without removing copied text" })

-- Lazy
map("n", "<leader>l", ":Lazy<cr>", { desc = "Lazy" })

-- Buffers
map("n", "<leader>n", ":bn<cr>", { desc = "Next buffer" })
map("n", "<leader>p", ":bp<cr>", { desc = "Previous buffer" })
map("n", "<leader>x", function()
    vim.api.nvim_command("bp|sp|bn|bd")
end, { desc = "Delete buffer" })

-- Quit
map("n", "<leader><Esc>", "<cmd>qa<cr>", { desc = "Quit All" })

-- Yank to clipboard
map("n", "<leader>y", [["+yy]], { desc = "Yank to clipboard" })
map("v", "<leader>y", [["+y]], { desc = "Yank to clipboard" })
map("n", "<leader>Y", function()
    local current_line = vim.fn.line(".")
    local current_col = vim.fn.col(".")
    vim.cmd('normal! ggVG"+y')
    vim.fn.cursor(current_line, current_col)
end, { desc = "Yank all to clipboard" })

-- Window Splitting Keymaps
map("n", "<leader>v", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
map("n", "<leader>h", "<cmd>split<cr>", { desc = "Horizontal Split" })
