vim.deprecate = function() end

-- STOLEN FROM NORMALNVIM
autocmd({ "BufReadPost", "BufNewFile", "BufWritePost" }, {
  desc = "Nvim user events for file detection (BaseFile and BaseGitFile)",
  callback = function(args)
    local empty_buffer = vim.fn.resolve(vim.fn.expand "%") == ""
    local greeter = vim.api.nvim_get_option_value("filetype", { buf = args.buf }) == "alpha"
    local git_repo = vim.fn.executable("git") == 1 and utils.run_cmd(
      { "git", "-C", vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand "%"), ":p:h"), "rev-parse" }, false)

    -- For any file exept empty buffer, or the greeter (alpha)
    if not (empty_buffer or greeter) then
      utils.trigger_event("User BaseFile")

      -- Is the buffer part of a git repo?
      if git_repo then
        utils.trigger_event("User BaseGitFile")
      end
    end
  end,
})


autocmd({ "VimEnter" }, {
  desc = "Nvim user event that trigger a few ms after nvim starts",
  callback = function()
    -- If nvim is opened passing a filename, trigger the event inmediatelly.
    if #vim.fn.argv() >= 1 then
      -- In order to avoid visual glitches.
      utils.trigger_event("User BaseDefered", true)
      utils.trigger_event("BufEnter", true) -- also, initialize tabline_buffers.
    else                                    -- Wait some ms before triggering the event.
      vim.defer_fn(function()
        utils.trigger_event("User BaseDefered")
      end, 70)
    end
  end,
})


autocmd("BufWritePre", {
  desc = "Automatically create parent directories if they don't exist when saving a file",
  callback = function(args)
    local buf_is_valid_and_listed = vim.api.nvim_buf_is_valid(args.buf)
        and vim.bo[args.buf].buflisted

    if buf_is_valid_and_listed then
      vim.fn.mkdir(vim.fn.fnamemodify(
        vim.uv.fs_realpath(args.match) or args.match, ":p:h"), "p")
    end
  end,
})

vim.api.nvim_set_hl(0, 'HighlightURL', { underline = true })
autocmd({ "VimEnter", "FileType", "BufEnter", "WinEnter" }, {
  desc = "URL Highlighting",
  callback = function() utils.set_url_effect() end,
})

-- Write all buffers
cmd("WriteAllBuffers", function()
  vim.cmd("wa")
end, { desc = "Write all changed buffers" })

-- Close all notifications
cmd("CloseNotifications", function()
  require("notify").dismiss({ pending = true, silent = true })
end, { desc = "Dismiss all notifications" })
