return {
	"LunarVim/bigfile.nvim",
	event = "BufReadPre", -- this ensures it kicks in before the file is read
  opts = {
    filesize = 2, -- MiB threshold
		pattern = { "*" },
  }
}
