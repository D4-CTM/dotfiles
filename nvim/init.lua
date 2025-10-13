vim.opt.relativenumber = true
vim.opt.winborder = "rounded"
vim.opt.termguicolors = true
vim.opt.number = true

vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.o.wrap = false

vim.g.mapleader = " "

-- remaps
local setKey = vim.keymap.set
setKey("n", "<leader>w", ":write<CR>")
setKey("n", "<leader>q", ":quit<CR>")
setKey("n", "<leader>gb", ":Oil<CR>")
setKey("n", "<leader>ff", ":FzfLua files<CR>")
setKey("n", "<leader>fg", ":FzfLua live_grep<CR>")
setKey("v", "J", ":m '>+1<CR>gv=gv")
setKey("v", "K", ":m '<-2<CR>gv=gv")
setKey("n", "r", ":redo<CR>")
setKey({ "n", "v" }, "Y", [["+y]])

vim.keymap.set("n", "<leader>lg", function()
	local fzf = require("fzf-lua")

	vim.ui.input({ prompt = "Input file pattern: " }, function(input)
		if input == nil or input == "" then
			vim.notify("File extension was empty", "error")
			return
		end

		fzf.live_grep({
			rg_opts = string.format("--glob %s", input)
		})
	end)
end)

-- lsp

vim.lsp.enable({
	"arduino_language_server",
	"omnisharp",
	"lemminx",
	"lua_ls",
	"clangd",
	"cssls",
	"gopls",
	"jdtls",
	"ts_ls",
	"html",
	"zls"
})

setKey("n", "F", vim.lsp.buf.format)
setKey("n", "<leader>e", vim.diagnostic.open_float)
setKey("n", "<leader>gd", vim.lsp.buf.definition)
setKey("n", "?", vim.lsp.buf.hover)
setKey("n", "<d", function()
	vim.diagnostic.jump({ count = -1, float = true, wrap = true })
end)
setKey("n", ">d", function()
	vim.diagnostic.jump({ count = 1, float = true, wrap = true })
end)

-- packages
vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", name = "treesitter" },
	{ src = "https://github.com/OXY2DEV/markview.nvim",           name = "markview" },
	{ src = "https://github.com/Saghen/blink.cmp",                name = "blink-cmp" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim",       name = "lualine" },
	{ src = "https://github.com/ibhagwan/fzf-lua",                name = "fzf-lua" },
	{ src = "https://github.com/navarasu/onedark.nvim",           name = "onedark" },
	{ src = "https://github.com/mason-org/mason.nvim",            name = "mason" },
	{ src = "https://github.com/stevearc/oil.nvim",               name = "oil" },
})


require("mason").setup()
require("oil").setup()
require("markview").setup({
	lazy = false
})
local blink = require("blink.cmp")
blink.setup({
	fuzzy = {
		implementation = "prefer_rust",
		prebuilt_binaries = {
			force_version = "1.*"
		}
	},
	keymap = {
		['<Tab>'] = {
			function()
				if blink.is_visible() then
					blink.select_and_accept()
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", true)
				end
			end,
			mode = { 'i' },
		}
	},
})

require("nvim-treesitter.configs").setup({
	sync_install = false,
	ensure_installed = {
		"lua",
		"zig",
	},
	highlight = { enable = true },
	indent = { enable = true },
	auto_install = true,
	ignore_install = {},
	modules = {},
})

local onedark = require("onedark")
onedark.setup({
	style = "deep",
	transparent = true,
	code_style = {
		keywords = "bold",
		functions = "bold",
	},
	highlights = {
		["@variable"] = { fg = "$red" },
	},
})
onedark.load()

require("lualine").setup({
	options = {
		theme = "onedark",
	},
})
