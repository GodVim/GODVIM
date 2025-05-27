return {

  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    opts = {},
  },
  {
    lazy = true,
    "williamboman/mason-lspconfig",
  --   version = "^1.0.0" 
  },
--  {
--    "nvim-java/nvim-java",
--    ft = "java",
--    dependencies = {
--      {
--        "nvim-java/nvim-java-core",
--        url = "https://github.com/Kabil777/nvim-java-core.git",
--        branch = "fix/mason-api-update",
--      },
--    },
--  },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "zeioth/garbage-day.nvim",
      {
        "mason-org/mason.nvim",
--         version = "^1.0.0",
--        opts = {
--          registries = {
--            'github:nvim-java/mason-registry@2024-12-24-graceful-raft',
--            'github:mason-org/mason-registry@2025-05-10-new-sprout',
--          },
--        },
      },

    },
    opts = {
        -- options for vim.diagnostic.config()
        ---@type vim.diagnostic.Opts
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
            -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
            -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
            -- prefix = "icons",
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
              [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
              [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
            },
          },
        },
      }
    config = function()
      local mason = require("mason")
      local lspconfig = require("lspconfig")

      mason.setup()

      local servers = {
        "lua_ls",
        "ruff",
        "jsonls",

                "yamlls",
        "pyright",
        "marksman",
      }


      require("mason-lspconfig").setup({
        ensure_installed = servers,
      })

      
      -- diagnostics signs
      if vim.fn.has("nvim-0.10.0") == 0 then
        if type(opts.diagnostics.signs) ~= "boolean" then
          for severity, icon in pairs(opts.diagnostics.signs.text) do
            local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
            name = "DiagnosticSign" .. name
            vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
          end
        end
      end

      if vim.fn.has("nvim-0.10") == 1 then
        -- inlay hints
        if opts.inlay_hints.enabled then
          LazyVim.lsp.on_supports_method("textDocument/inlayHint", function(client, buffer)
            if
              vim.api.nvim_buf_is_valid(buffer)
              and vim.bo[buffer].buftype == ""
              and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
            then
              vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
            end
          end)
        end

        -- code lens
        if opts.codelens.enabled and vim.lsp.codelens then
          LazyVim.lsp.on_supports_method("textDocument/codeLens", function(client, buffer)
            vim.lsp.codelens.refresh()
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
              buffer = buffer,
              callback = vim.lsp.codelens.refresh,
            })
          end)
        end
      end

      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
          or function(diagnostic)
            local icons = LazyVim.config.icons.diagnostics
            for d, icon in pairs(icons) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                return icon
              end
            end
          end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))


--      require("java").setup({
--        jdk = {
--          auto_install = false,
--        },
--      })

--      require("lspconfig").jdtls.setup({
--        handlers = {
          -- By assigning an empty function, you can remove the notifications
          -- printed to the cmd
--          ["$/progress"] = function(_, result, ctx) end,
--        },
--      })

      lspconfig.lua_ls.setup({})
      lspconfig.jsonls.setup({})
      lspconfig.ruff.setup({})
      lspconfig.yamlls.setup({})
      lspconfig.pyright.setup({})
      lspconfig.marksman.setup({})
    end,
  }
}

