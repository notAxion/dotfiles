vim.cmd([[
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching
set ignorecase              " case insensitive
set mouse=v                 " middle-click paste with
" set hlsearch                " highlight search
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set relativenumber          " shows nummbers relative to the current line
set wildmode=longest,list   " get bash-like tab completions
set cc=100                 " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.
set splitright              " vertical split to the right
set splitbelow              " normal split to below

let mapleader= " "

" move line or visually selected block - alt+j/k
" inoremap ∆ <Esc>:m .+1<CR>==gi
" inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

" move split panes to left/bottom/top/right
nnoremap ˙ <C-W>H
nnoremap ∆ <C-W>J
nnoremap ˚ <C-W>K
nnoremap ¬ <C-W>L

" move between panes to left/bottom/top/right
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader>sv :source $MYVIMRC<CR>

" move horizontally
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

" find and move cursor in the middle
nnoremap n nzzzv
nnoremap N Nzzzv

" best remap by primeagen
xnoremap <leader>p "_dP
xnoremap <leader>d "_d

]])
