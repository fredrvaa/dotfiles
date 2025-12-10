-- Packages
vim.pack.add{
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/catppuccin/nvim' },
-- Completion
  { src = 'https://github.com/hrsh7th/nvim-cmp' },
  { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
  { src = 'https://github.com/hrsh7th/cmp-buffer' },
  { src = 'https://github.com/hrsh7th/cmp-path' },
}

-- Tabs
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Line number
vim.opt.number = true
vim.opt.relativenumber = true

-- Clipboard
vim.opt.clipboard = 'unnamedplus'

-- Keybinds
vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>hc', ':checkhealth ', { noremap = true, silent = false, desc = 'Prefill :checkhealth' })

-- Theme
require('catppuccin').setup({
  flavour = 'mocha', -- latte, frappe, macchiato, mocha
  integrations = {
    treesitter = true,
    lsp = true,
  },
})
vim.cmd('colorscheme catppuccin')

-- LSP
vim.lsp.config['lua_ls'] = {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }, -- Fixes “Undefined global 'vim'”
      },
    },
  }
}

vim.lsp.enable({'pyright', 'lua_ls', 'tsserver'})

-- Treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'lua', 'python', 'typescript', 'markdown', 'markdown_inline' },
  sync_install = false,
  highlight = {
    enable = true,
  },
}

-- Autocomplete
local cmp = require('cmp')
cmp.setup({
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
  },
})

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true,
})
