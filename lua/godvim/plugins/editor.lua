return {
    {
        "folke/snacks.nvim",
        event = "User FilePost",
        ---@type snacks.Config
        opts = {
            indent = {enabled = true},
            input = {enabled = true}
        }
    },
    {
        "folke/snacks.nvim",
        event = "UiEnter",
        ---@type snacks.Config
        opts = {
            picker = {enabled = true}
        }
    },
    {
        "LunarVim/breadcrumbs.nvim",
        opts = {
            lsp = {
                auto_attach = true
            }
        },
        event = "BufReadPre",
        dependencies = {
            "SmiteshP/nvim-navic",
        }
    },
    
}
