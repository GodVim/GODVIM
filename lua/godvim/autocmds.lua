
local autocmd = vim.api.nvim_create_autocmd
local cmd = vim.api.nvim_create_user_command
vim.deprecate = function() end

function run_cmd(cmd, show_error)
  -- Split cmd string into a list, if needed.
  if type(cmd) == "string" then
    cmd = vim.split(cmd, " ")
  end

  -- If windows, and prepend cmd.exe
  if vim.fn.has("win32") == 1 then
    cmd = vim.list_extend({ "cmd.exe", "/C" }, cmd)
  end

  -- Execute cmd and store result (output or error message)
  local result = vim.fn.system(cmd)
  local success = vim.api.nvim_get_vvar("shell_error") == 0

  -- If the command failed and show_error is true or not provided, print error.
  if not success and (show_error == nil or show_error) then
    vim.api.nvim_echo({{
      ("Error running command %s\nError message:\n%s"):format(
        table.concat(cmd, " "), -- Convert the cmd back to string.
        result                  -- Show the error result
      )}}, true, { err = true }
    )
  end

  -- strip out terminal escape sequences and control characters.
  local cleaned_result = result:gsub("[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", "")

  -- Return the cleaned result if the command succeeded, or nil if it failed
  return (success and cleaned_result) or nil
end

function trigger_event(event, is_urgent)
  -- define behavior
  local function trigger()
    local is_user_event = string.match(event, "^User ") ~= nil
    if is_user_event then
      event = event:gsub("^User ", "")
      vim.api.nvim_exec_autocmds("User", { pattern = event, modeline = false })
    else
      vim.api.nvim_exec_autocmds(event, { modeline = false })
    end
end
end

-- STOLEN FROM NORMALNVIM
autocmd({ "BufReadPost", "BufNewFile", "BufWritePost" }, {
  desc = "Nvim user events for file detection (BaseFile and BaseGitFile)",
  callback = function(args)
    local empty_buffer = vim.fn.resolve(vim.fn.expand "%") == ""
    local greeter = vim.api.nvim_get_option_value("filetype", { buf = args.buf }) == "alpha"
    local git_repo = vim.fn.executable("git") == 1 and run_cmd(
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
