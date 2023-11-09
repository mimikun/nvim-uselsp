-- TODO: setting
local cmds = {
    -- neovim/nvim-lspconfig
    "LspInfo",
    "LspRestart",
    "LspStart",
    "LspStop",
    -- williamboman/mason.nvim
    "Mason",
    "MasonUpdate",
    "MasonInstall",
    "MasonUninstall",
    "MasonUninstallAll",
    "MasonLog",
    -- williamboman/mason-lspconfig.nvim
    "LspInstall",
    "LspUninstall",
    -- hrsh7th/nvim-cmp
    "CmpStatus",
}

return {
    -- base
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    --event = "BufRead",
    --cmd = cmds,
    dependencies = {
        -- lsp
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
        -- cmp
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        -- LSP configs
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        mason.setup({})
        mason_lspconfig.setup_handlers({
            function(server)
                local opt = {
                    capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
                }
                lspconfig[server].setup(opt)
            end,
        })

        -- CMP configs
        local cmp = require("cmp")
        cmp.setup({
            snippet = {},
            sources = {
                { name = "nvim_lsp" },
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-l>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            experimental = {
                ghost_text = true,
            },
        })
    end,
    --cond = false,
}

-- refs:
-- https://zenn.dev/botamotch/articles/21073d78bc68bf
