set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=74                   " set an 80 column border for good coding style
set relativenumber
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim

inoremap jh <Esc>

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'loctvl842/monokai-pro.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'm4xshen/autoclose.nvim'
call plug#end()

let g:coc_global_extensions = ['coc-ccls']
source ~/.config/nvim/coc-example-config.vim

lua << EOF
require("monokai-pro").setup({
    filter = "spectrum",
})
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "cpp", "vim", "lua", "rust"},
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    },
}
require('lualine').setup()
require("autoclose").setup()
EOF

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
colorscheme monokai-pro
