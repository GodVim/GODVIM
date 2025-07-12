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
        "folke/flash.nvim",
        event = "User FilePost",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {

            {"/", mode = {"n", "v"}, function()
                    require("flash").toggle()
                end, desc = "Toggle Flash Search"}
        }
    },
    {
        "SmiteshP/nvim-navic",
        opts = {
            lsp = {
                auto_attach = true
            }
        },
        event = "LspAttach",
        dependencies = {
            "LunarVim/breadcrumbs.nvim"
        }
    }
}
