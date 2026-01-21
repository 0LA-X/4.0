require("nvchad.options")

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

local o = vim.opt
-- add yours here!
o.termguicolors = true -- Enable true color support
o.guicursor = "i-n-c-sm:block-blinkwait700-blinkon400-blinkoff250"

-- o.number = true         -- Show absolute line number
o.relativenumber = true -- Show relative numbers

-- CursorLine
-- o.cursorline = true
-- o.cursorlineopt ='both' -- to enable cursorline!
-- vim.cmd([[
--   highlight CursorLine ctermbg=DarkGrey guibg=#2a2a2a
--   highlight CursorLineNr ctermbg=DarkGrey guibg=#2a2a2a
-- ]])
