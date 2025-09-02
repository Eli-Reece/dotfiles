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
set cc=80                   " set an 80 column border for good coding style
set relativenumber
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set nomodeline

inoremap jh <Esc>

" Open LeetCode UI
nnoremap <leader>lo :Leet list<CR>
" Show current problem
nnoremap <leader>ld :Leet desc<CR>
" Run code
nnoremap <leader>lr :Leet run<CR>
" Submit code
nnoremap <leader>ls :Leet submit<CR>
" Change Language
nnoremap <leader>ll :Leet lang<CR>

call plug#begin()
Plug 'loctvl842/monokai-pro.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'm4xshen/autoclose.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'          " Completion engine
Plug 'hrsh7th/cmp-nvim-lsp'      " LSP source for nvim-cmp
Plug 'hrsh7th/cmp-buffer'        " Buffer source
Plug 'hrsh7th/cmp-path'          " Path source
Plug 'L3MON4D3/LuaSnip'          " Snippet engine
Plug 'saadparwaiz1/cmp_luasnip'  " Snippet source
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'kawre/leetcode.nvim', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'MunifTanjim/nui.nvim'
call plug#end()


lua << EOF
require("leetcode").setup()
print(vim.inspect(require("leetcode.config").user.storage.cache))
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

local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  })
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig').clangd.setup{
    capabilities = capabilities
}
vim.diagnostic.config({
  virtual_text = true,      -- Show diagnostics as virtual text
  signs = true,             -- Show signs in the sign column
  underline = true,         -- Underline the text with issue
  update_in_insert = false, -- Don't update diagnostics in insert mode
  severity_sort = true,     -- Sort diagnostics by severity
  float = {
    border = "rounded",
    source = "always",
  },
})
vim.keymap.set('n', 'gr', vim.lsp.buf.references, {desc = "Go to references"})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {desc = "Go to definition"})
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {desc = "Go to implementation"})
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {desc = "Show documentation"})
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {desc = "Rename symbol"})
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {desc = "Code actions"})
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show diagnostic in floating window" })
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Add diagnostics to location list" })
EOF

colorscheme monokai-pro
