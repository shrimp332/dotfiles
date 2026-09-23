vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

-- tabs
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.number = true
opt.relativenumber = true

-- Alt + jk move lines
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("i", "<A-j>", "<ESC>:m .+1<CR>==gi", { desc = "Move line down" })
vim.keymap.set("i", "<A-k>", "<ESC>:m .-2<CR>==gi", { desc = "Move line up" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })

vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "exit terminal insert mode" })

vim.diagnostic.config({ virtual_text = false })

-- clipboard + over ssh
vim.g.clipboard = {
    name = "OSC 52",
    copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
        ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
        ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
}
opt.clipboard = "unnamedplus"

local gh = function(x)
    return "https://github.com/" .. x
end

-- color scheme
vim.pack.add({
    gh "folke/tokyonight.nvim",
})
require("tokyonight").setup({
    style = "night",
    transparent = true,
})
vim.cmd.colorscheme("tokyonight")

-- navigation
vim.pack.add({
    gh "stevearc/oil.nvim",
    gh "nvim-tree/nvim-web-devicons",
})

require("oil").setup({
    view_options = { show_hidden = true },
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.pack.add({
    gh "nvim-telescope/telescope.nvim",
    gh "nvim-lua/plenary.nvim",
    gh "nvim-telescope/telescope-ui-select.nvim",
})
require("telescope").setup({})
require("telescope").load_extension("ui-select")
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })

-- lsp, completions
vim.pack.add({
    {
        src = gh "saghen/blink.cmp",
        version = "v1",
    },
    gh "rafamadriz/friendly-snippets",
    gh "folke/trouble.nvim",
    gh "mason-org/mason.nvim",
    gh "mason-org/mason-lspconfig.nvim",
    gh "neovim/nvim-lspconfig",
})
require("blink.cmp").setup({
    keymap = { preset = "default" },

    appearance = {
        nerd_font_variant = "mono",
    },

    completion = { documentation = { auto_show = true } },

    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },

    signature = {
        enabled = true,
        window = {
            show_documentation = true,
        },
    },
})
require("mason").setup()
require("mason-lspconfig").setup()

require("trouble").setup()

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })

vim.opt.signcolumn = "yes"

vim.keymap.set({ "n", "x" }, "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>")
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
vim.keymap.set({ "n", "x" }, "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>")
vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")

-- server configs
vim.lsp.config("emmet_language_server", {
    filetypes = {
        "astro",
        "css",
        "eruby",
        "html",
        "htmlangular",
        "htmldjango",
        "javascriptreact",
        "less",
        "pug",
        "sass",
        "scss",
        "svelte",
        "templ",
        "typescriptreact",
        "vue",
        "php",
    },
})
vim.lsp.config("pylsp", {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    maxLineLength = 999,
                },
                mccabe = {
                    enabled = false,
                },
                pyflakes = { enabled = false },
            },
        },
    },
})
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})


-- treesitter
vim.pack.add({ gh "nvim-treesitter/nvim-treesitter" })
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

-- sugar
vim.pack.add({
    gh "lukas-reineke/indent-blankline.nvim",
    gh "windwp/nvim-autopairs",
})
require("ibl").setup({ scope = { enabled = false } })
require("nvim-autopairs").setup()

-- vim.pack.add({ gh "github/copilot.vim" })

-- latex
vim.pack.add({ gh "lervag/vimtex" })
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_latexmk = {
    aux_dir = "tmp",
    out_dir = "tmp",
}
vim.g.vimtex_compiler_latexmk_engines = { _ = "-xelatex" }

-- Notes
vim.opt.spelllang = "en_au"
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "tex" },
    callback = function()
        vim.opt_local.spell = true
    end
})
