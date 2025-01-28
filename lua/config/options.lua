-- Line numbers
vim.opt.nu = true             -- Enable line numbers
vim.opt.relativenumber = true -- Set relative line numbers

-- Indent
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.autoindent = true
vim.opt.list = true      -- Show tab characters and trailing whitespace

-- Turn off [No Name] buffer
vim.opt.hidden = false

-- Change symbols
local symbols = { Error = "󰅙", Info = "󰋼", Hint = "󰌵", Warn = "" }

for name, icon in pairs(symbols) do
    local hl = "DiagnosticSign" .. name
    vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

-- Change prefix before diagnostics text
vim.diagnostic.config({
  virtual_text = {
    prefix = '󰅙',
  }
})
