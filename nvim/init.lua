-- vim.opt.relativenumber = true
vim.opt.winborder = "rounded"
vim.opt.termguicolors = true
vim.opt.number = true

vim.opt.expandtab = true
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
setKey("n", "<leader>bl", ":Gitsigns blame_line<CR>")
setKey("n", "]h", ":Gitsigns next_hunk<CR>")
setKey("n", "[h", ":Gitsigns prev_hunk<CR>")
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
    "basedpyright",
    "lemminx",
    "roslyn",
    "lua_ls",
    "clangd",
    "vue_ls",
    "cssls",
    "gopls",
    "jdtls",
    "ts_ls",
    "html",
    "zls"
})

setKey("n", "F", vim.lsp.buf.format)

setKey("n", "[e", function()
    vim.diagnostic.jump({ count = -1, float = true, wrap = true, severity = vim.diagnostic.severity.ERROR })
end)
setKey("n", "]e", function()
    vim.diagnostic.jump({ count = 1, float = true, wrap = true, severity = vim.diagnostic.severity.ERROR })
end)

-- packages
vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.completion",      name = "mini-cmp" },
    { src = "https://github.com/nvim-mini/mini.icons",           name = "mini-icons" },
    { src = "https://github.com/OXY2DEV/markview.nvim",          name = "markview" },
    { src = "https://github.com/lewis6991/gitsigns.nvim",        name = "gitsigns" },
    { src = "https://github.com/nvim-lualine/lualine.nvim",      name = "lualine" },
    { src = "https://github.com/navarasu/onedark.nvim",          name = "onedark" },
    { src = "https://github.com/github/copilot.vim",             name = "copilot" },
    { src = "https://github.com/ibhagwan/fzf-lua",               name = "fzf-lua" },
    { src = "https://github.com/mason-org/mason.nvim",           name = "mason" },
    { src = "https://github.com/stevearc/oil.nvim",              name = "oil" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/seblyng/roslyn.nvim" },
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

require("mini.completion").setup()
require("mini.icons").setup()

local ts = require("nvim-treesitter")
ts.install({
    'dockerfile',
    'javascript',
    'typescript',
    'c_sharp',
    'arduino',
    'python',
    'razor',
    'java',
    'html',
    'css',
    'xml',
    'lua',
    'zig',
    'cpp',
    "vue",
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

require("lualine").setup({})
