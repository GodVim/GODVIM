-- lazy.nvim
return {
  "folke/noice.nvim",
  event = "CmdlineEnter",
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
  },
  config = function()
  require("noice").setup({
      lsp = {
    progress = {
      enabled = false, -- Disable LSP progress messages
    },
    hover = {
      enabled = false, -- Disable LSP hover
    },
    signature = {
      enabled = false, -- Disable LSP signature help
    },
    message = {
      enabled = false, -- Disable LSP messages
    },
  },
      messages = {
    enabled = false, -- Disable Noice handling of messages
  },
  popupmenu = {
    enabled = false, -- Disable Noice handling of popupmenu
  },
  notify = {
    enabled = false, -- Disable Noice handling of notifications
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})
  end

}
