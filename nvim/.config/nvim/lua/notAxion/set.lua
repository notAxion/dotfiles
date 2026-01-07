vim.g.mapleader = " "

-- disable compatibility to old-time vi
-- vim.opt.nocompatible = true

-- case insensitive
vim.opt.ignorecase = true
-- Don't ignore case with capitals
vim.opt.smartcase = true
-- highlight search
vim.opt.hlsearch = false
-- show matching
vim.opt.showmatch = true
-- incremental search
vim.opt.incsearch = true

-- number of columns occupied by a tab
vim.opt.tabstop = 4
-- see multiple spaces as tabstops so <BS> does the right thing
vim.opt.softtabstop = 4
-- width for autoindents
vim.opt.shiftwidth = 4
-- converts tabs to white space
vim.opt.expandtab = false

-- indent a new line the same amount as the line just typed
vim.opt.autoindent = true

-- add border to the hover info
vim.o.winborder = "rounded"

-- add line numbers
vim.opt.number = true
-- shows nummbers relative to the current line
vim.opt.relativenumber = true

-- get bash-like tab completions
vim.opt.wildmode = "longest,full"
vim.opt.wildignorecase = true
-- set an 80 column border for good coding style
vim.opt.cc = "100"
-- highlight current cursorline
vim.opt.cursorline = true

-- allow auto-indenting depending on file type
vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")
vim.cmd("filetype plugin on")

-- enable mouse click
vim.opt.mouse = "a"
-- middle-click paste with
-- vim.opt.mouse = "v"

-- using system clipboard
vim.opt.clipboard = "unnamedplus"
-- Speed up scrolling in Vim
vim.opt.ttyfast = true
-- keeps the cursor this many lines above or below screen
vim.opt.scrolloff = 6
-- always keeps the signcolumn for lsp ig
vim.opt.signcolumn = "yes"

-- enable spell check (may need to download language package)
-- vim.opt.spell
-- disable creating swap file
vim.opt.swapfile = false
-- Directory to store backup files.
-- vim.opt.backupdir=~/.cache/vim
-- disable backup file
vim.opt.backup = false
-- an undofile for undotree for long undos
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- vertical split to the right
vim.opt.splitright = true
-- normal split to below
vim.opt.splitbelow = true
