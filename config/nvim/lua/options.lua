
vim.opt.relativenumber = true
vim.opt.number = true

-- tabs & indentation
vim.opt.tabstop    = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab  = false
vim.opt.autoindent = true
vim.opt.scrolloff = 10

vim.opt.wrap = false

-- search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- highlights the line
vim.opt.cursorline = true

-- term colors
vim.opt.termguicolors = true
vim.opt.background = "dark" -- color schemas will also choose dark mode
vim.opt.signcolumn = "yes"

-- backspace 
vim.opt.backspace = "indent,eol,start"

-- clipboard
vim.opt.clipboard:append("unnamedplus") -- uses system clipboard as default register

-- window splitting
vim.opt.splitright = true -- has the split go to the rightside of my window

vim.opt.swapfile = false

vim.o.mouse = ""
vim.keymap.set("", "<up>", "<nop>", { noremap = true })
vim.keymap.set("", "<down>", "<nop>", { noremap = true })
vim.keymap.set("i", "<up>", "<nop>", { noremap = true })
vim.keymap.set("i", "<down>", "<nop>", { noremap = true })
vim.keymap.set("", "<right>", "<nop>", { noremap = true })
vim.keymap.set("", "<left>", "<nop>", { noremap = true })
vim.keymap.set("i", "<right>", "<nop>", { noremap = true })
vim.keymap.set("i", "<left>", "<nop>", { noremap = true })
vim.opt.mousescroll = "ver:0,hor:0"
