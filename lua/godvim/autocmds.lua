
local autocmd = vim.api.nvim_create_autocmd
local cmd = vim.api.nvim_create_user_command
vim.deprecate = function() end

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



-- Write all buffers
cmd("WriteAllBuffers", function()
  vim.cmd("wa")
end, { desc = "Write all changed buffers" })

-- Close all notifications
cmd("CloseNotifications", function()
  require("notify").dismiss({ pending = true, silent = true })
end, { desc = "Dismiss all notifications" })


autocmd("User", {
  pattern = "MiniFilesActionRename",
  callback = function(event)
    Snacks.rename.on_rename_file(event.data.from, event.data.to)
  end,
})


vim.api.nvim_create_augroup("FileEnterOnDoubleEvent", { clear = true })

vim.g.ui_entered_flag = false

local function trigger_file_enter_event(buffer)
  if vim.api.nvim_buf_is_valid(buffer) and
     vim.api.nvim_buf_is_loaded(buffer) and
     vim.bo[buffer].buftype == '' and -- Ensure it's a normal file buffer
     vim.api.nvim_buf_get_name(buffer) ~= '' then -- Ensure it has a file name
    vim.api.nvim_exec_autocmds("User", { pattern = "FileEnter", buffer = buffer })

    vim.b[buffer].buf_read_post_flag = nil
  end
end

vim.api.nvim_create_autocmd("BufReadPost", {
  group = "FileEnterOnDoubleEvent",
  callback = function(args)
    local buffer = args.buf
    local bufname = vim.api.nvim_buf_get_name(buffer)
    local buftype = vim.bo[buffer].buftype

    if buftype == '' and bufname ~= '' then
      vim.b[buffer].buf_read_post_flag = true

      if vim.g.ui_entered_flag then
        trigger_file_enter_event(buffer)
      end
    end
  end,
})

-- 2. Autocommand for UiEnter event
-- This fires when the Neovim UI is ready.
vim.api.nvim_create_autocmd("UiEnter", {
  group = "FileEnterOnDoubleEvent",
  callback = function()
    -- Set the global flag to indicate that UiEnter has fired.

    for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buffer) and
         vim.b[buffer] and
         vim.b[buffer].buf_read_post_flag and
         vim.bo[buffer].buftype == '' and
         vim.api.nvim_buf_get_name(buffer) ~= '' then
        trigger_file_enter_event(buffer)
      end
    end
  end,
})
