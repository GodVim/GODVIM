return {
  "Exafunction/windsurf.nvim",
  event = "User FilePost",
  lazy = true,
  build = ":Codeium Auth",
  opts = {
    enable_cmp_source = true,
    virtual_text = {
      enabled = false,
      key_bindings = {
        next = "<M-]>",
        prev = "<M-[>",
      },
    },
  },
}
