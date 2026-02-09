-- vim.opt.relativenumber = true
vim.opt.winborder = "rounded"
vim.opt.termguicolors = true
vim.opt.number = true

vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.o.wrap = false

vim.g.have_nerd_font = true
vim.g.mapleader = " "

-- remaps
local setKey = vim.keymap.set
setKey("n", "<leader>zh", ":Gitsigns reset_hunk<CR>")
setKey("n", "<leader>rh", ":Gitsigns preview_hunk<CR>")
setKey("n", "<leader>vh", ":Gitsigns preview_hunk_inline<CR>")
setKey("n", ">h", ":Gitsigns next_hunk<CR>")
setKey("n", "<h", ":Gitsigns prev_hunk<CR>")
setKey("n", "<leader>w", ":write<CR>")
setKey("n", "<leader>q", ":quit<CR>")
setKey("n", "<leader>gb", ":Oil<CR>")
setKey("n", "<leader>ff", ":FzfLua files<CR>")
setKey("n", "<leader>fs", ":FzfLua git_status<CR>")
setKey("n", "<leader>fg", ":FzfLua live_grep<CR>")
setKey("v", "J", ":m '>+1<CR>gv=gv")
setKey("v", "K", ":m '<-2<CR>gv=gv")
setKey("n", "r", ":redo<CR>")
setKey({ "n", "v" }, "Y", [["+y]])

vim.keymap.set("n", "<leader>lg", function()
	local fzf = require("fzf-lua")

	vim.ui.input({ prompt = "Input file pattern: " }, function(input)
		if input == nil or input == "" then
			vim.notify("File extension was empty", vim.log.levels.ERROR)
			return
		end

		fzf.live_grep({
			rg_opts = string.format("--glob %s", input)
		})
	end)
end)

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
		if lang then
			pcall(vim.treesitter.start)
		end
	end,
})

vim.lsp.enable({
	"arduino_language_server",
	"rust_analyzer",
	"basedpyright",
	"tinymist",
	"lemminx",
	"roslyn",
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
setKey("n", "<leader>d", vim.diagnostic.open_float)
setKey("n", "<leader>gd", vim.lsp.buf.definition)
setKey("n", "?", vim.lsp.buf.hover)

local function jump(_count, _severity)
	if _severity == nil then
		vim.diagnostic.jump({ count = _count, float = true, wrap = true })
		return
	end
	vim.diagnostic.jump({ count = _count, float = true, wrap = true, severity = _severity })
end

setKey("n", "<e", function()
	jump(-1, vim.diagnostic.severity.ERROR)
end)
setKey("n", ">e", function()
	jump(1, vim.diagnostic.severity.ERROR)
end)
setKey("n", "<d", function()
	jump(-1, nil)
end)
setKey("n", ">d", function()
	jump(1, nil)
end)

-- packages
vim.pack.add({
	{ src = "https://github.com/seblyng/roslyn.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/Saghen/blink.cmp",               name = "blink-cmp" },
	{ src = "https://github.com/OXY2DEV/markview.nvim",          name = "markview" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim",        name = "gitsigns" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim",      name = "lualine" },
	{ src = "https://github.com/ibhagwan/fzf-lua",               name = "fzf-lua" },
	{ src = "https://github.com/navarasu/onedark.nvim",          name = "onedark" },
	{ src = "https://github.com/mason-org/mason.nvim",           name = "mason" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim",   name = "typst" },
	{ src = "https://github.com/stevearc/oil.nvim",              name = "oil" },
})
vim.cmd.packadd("nvim-treesitter")

require("mason").setup({
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    }
})
require("oil").setup()
require("gitsigns").setup()
require("markview").setup()

local blink = require("blink.cmp")
blink.setup({
	fuzzy = {
		implementation = "prefer_rust",
		prebuilt_binaries = {
			force_version = "1.*"
		}
	},
	keymap = {
		['<S-tab>'] = {
			function()
				if blink.is_visible() then
					blink.select_and_accept()
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-tab>", true, false, true), "n", true)
				end
			end,
			mode = { 'i' },
		}
	},
})

local ts = require("nvim-treesitter")
ts.install({
	'dockerfile',
	'javascript',
	'typescript',
	'c_sharp',
	'arduino',
	'python',
	'razor',
	'typst',
	'java',
	'html',
	'yaml',
	'rust',
	'css',
	'xml',
	'lua',
	'zig',
	'cpp',
	'go',
	'c'
}):wait()

ts.setup({
	install_dir = vim.fn.stdpath('data') .. '/site',
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
