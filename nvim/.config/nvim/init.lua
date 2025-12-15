-- Packages
vim.pack.add {
	-- Theme
	{ src = "https://github.com/catppuccin/nvim" },
	-- Treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	-- Telescope
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/BurntSushi/ripgrep" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	-- NvimTree
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	-- LSP
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	-- Completion
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-path" },
	-- Copilot
	{ src = "https://github.com/github/copilot.vim" },
	-- Tmux navigation
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
}

-- Search case
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Tabs
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Line number
vim.opt.number = true
vim.opt.relativenumber = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Keybinds
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>hc", ":checkhealth ", { noremap = true, silent = false, desc = "Prefill :checkhealth" })
vim.keymap.set("n", "<C-S-k>", ":normal gcc<CR>", { desc = "Toggle line comment" })

-- Theme
require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	transparent_background = true,
	integrations = {
		treesitter = true,
		lsp = true,
	},
})
vim.cmd("colorscheme catppuccin")

-- LSP
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"lua_ls",
		"stylua",
		"pyright",
		"ts_ls",
		"eslint",
	}
})

vim.lsp.config["lua_ls"] = {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }, -- Fixes “Undefined global "vim"”
			},
		},
	}
}

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { silent = true })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { silent = true })

-- Treesitter
require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "python", "typescript", "markdown", "markdown_inline" },
	sync_install = false,
	highlight = {
		enable = true,
	},
})

-- Telescope
require("telescope").setup({
	defaults = {
		path_display = { "truncate" }
	}
})

local builtin = require('telescope.builtin')
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope find git files. Respects .gitignore" })
vim.keymap.set('n', '<leader>lg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


-- NvimTree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()
vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

-- Autocomplete
local cmp = require("cmp")
cmp.setup({
	mapping = {
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
	},
})

-- Diagnostics
vim.diagnostic.config({
	virtual_text = true,
})

-- Copilot
vim.keymap.set("n", "<leader>cd", ":Copilot disable<CR>", { desc = "Disable Copilot" })
vim.keymap.set("n", "<leader>ce", ":Copilot enable<CR>", { desc = "Enable Copilot" })

