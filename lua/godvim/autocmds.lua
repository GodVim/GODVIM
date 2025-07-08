
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

local function trigger_file_enter_event(bufnr)
  if vim.api.nvim_buf_is_valid(bufnr) and
     vim.api.nvim_buf_is_loaded(bufnr) and
     vim.bo[bufnr].buftype == '' and
     vim.api.nvim_buf_get_name(bufnr) ~= '' then
    vim.api.nvim_exec_autocmds("User", { pattern = "FileEnter", buffer = bufnr })

    vim.b[bufnr].buf_read_post_flag = nil
  end
end

vim.api.nvim_create_autocmd("User", {
  group = "FileEnterOnDoubleEvent",
  pattern = "FileEnter",
  callback = function(args)
    local bufnr = args.buf
    local bufname = vim.api.nvim_buf_get_name(bufnr)
  end,
  })
