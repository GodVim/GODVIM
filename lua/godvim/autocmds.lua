
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

local function trigger_file_enter_event(bufnr)
  if vim.api.nvim_buf_is_valid(bufnr) and
     vim.api.nvim_buf_is_loaded(bufnr) and
     vim.bo[bufnr].buftype == '' and -- Ensure it's a normal file buffer
     vim.api.nvim_buf_get_name(bufnr) ~= '' then -- Ensure it has a file name
    vim.api.nvim_exec_autocmds("User", { pattern = "FileEnter", bufnr = bufnr })

    vim.b[bufnr].buf_read_post_flag = nil
  end
end

vim.api.nvim_create_autocmd("BufReadPost", {
  group = "FileEnterOnDoubleEvent",
  callback = function(args)
    local bufnr = args.buf
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local buftype = vim.bo[bufnr].buftype

    if buftype == '' and bufname ~= '' then
      vim.b[bufnr].buf_read_post_flag = true

      if vim.g.ui_entered_flag then
        trigger_file_enter_event(bufnr)
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

    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(bufnr) and
         vim.b[bufnr] and
         vim.b[bufnr].buf_read_post_flag and
         vim.bo[bufnr].buftype == '' and
         vim.api.nvim_buf_get_name(bufnr) ~= '' then
        trigger_file_enter_event(bufnr)
      end
    end
  end,
})
