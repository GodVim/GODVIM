-- lazy.nvim example for mini.statusline with Rose Pine, no M.helpers
return {
  {
    'echasnovski/mini.statusline',
    version = false,

    config = function()
      local M = require('mini.statusline')

      -- Rosé Pine 'main' palette (hex codes from rosepinetheme.com/palette/ingredients/)
      local RP = {
        base = '#191724',
        surface = '#1f1d2e',
        overlay = '#26233a',
        muted = '#6e6a86',
        subtle = '#908caa',
        text = '#e0def4',
        love = '#eb6f92',
        gold = '#f6c177',
        rose = '#ebbcba',
        pine = '#31748f',
        foam = '#9ccfd8',
        iris = '#c4a7e7',
        highlight_low = '#21202e',
        highlight_med = '#403d52',
        highlight_high = '#524f67',

        -- Mappings for easier replacement
        bg = '#191724',    -- base
        fg = '#e0def4',    -- text
        line_bg = '#1f1d2e', -- surface
        fg_green = '#31748f', -- pine
        yellow = '#f6c177',   -- gold
        cyan = '#9ccfd8',     -- foam
        darkblue = '#31748f', -- pine
        green = '#31748f',    -- pine
        orange = '#f6c177',   -- gold
        purple = '#c4a7e7',   -- iris
        magenta = '#eb6f92',  -- love
        gray = '#6e6a86',     -- muted
        blue = '#9ccfd8',     -- foam
        red = '#eb6f92'       -- love
      }

      -- === Custom Statusline Components (replacing M.helpers) ===

      -- Helper for applying highlights (similar to M.helpers.attr)
      local apply_hl = function(text, fg, bg, bold)
          local hl_group = ('MiniStatuslineCustom%s%s%s'):format(fg, bg, bold and 'Bold' or '')
          vim.cmd(string.format('highlight %s guifg=%s guibg=%s %s', hl_group, fg, bg, bold and 'gui=bold' or ''))
          return string.format('%%#%s#%s', hl_group, text)
      end

      -- 1. ViMode
      local get_vim_mode = function()
        local mode = vim.fn.mode()
        local mode_colors = {
          n = RP.love, i = RP.pine, v = RP.iris, [' '] = RP.iris, V = RP.iris,
          c = RP.love, no = RP.love, s = RP.gold, S = RP.gold, [' '] = RP.gold,
          ic = RP.yellow, R = RP.iris, Rv = RP.iris, cv = RP.love, ce = RP.love,
          r = RP.foam, rm = RP.foam, ['r?'] = RP.foam, ['!'] = RP.love, t = RP.love
        }
        local color = mode_colors[mode] or RP.text
        return apply_hl('  ', color, RP.line_bg, true)
      end

      -- 2. FileIcon and FileName
      local get_file_info = function()
        local filename = vim.fn.expand('%:t')
        if filename == '' then
          return '' -- No file in current buffer
        end

        local file_icon = ''
        local icon_color = RP.foam
        if pcall(require, 'nvim-web-devicons') then
            local devicons = require('nvim-web-devicons')
            local icon, color = devicons.get_icon_by_filetype(vim.bo.filetype, { default = true })
            if icon then
                file_icon = icon .. ' '
                icon_color = color or RP.foam
            end
        end

        local filename_text = vim.fn.fnamemodify(vim.fn.bufname(), ':t')
        if vim.bo.modified then
            filename_text = filename_text .. ' +'
        end

        local icon_part = apply_hl(file_icon, icon_color, RP.line_bg)
        local name_part = apply_hl(filename_text, RP.iris, RP.line_bg, true)

        return icon_part .. name_part
      end

      -- 3. LSP Diagnostics
      local get_lsp_diagnostics = function()
        local diag = vim.diagnostic.get(0)
        local errors = 0
        local warns = 0

        for _, d in ipairs(diag) do
          if d.severity == vim.diagnostic.severity.ERROR then
            errors = errors + 1
          elseif d.severity == vim.diagnostic.severity.WARN then
            warns = warns + 1
          end
        end

        local parts = {}
        if errors > 0 then
          table.insert(parts, apply_hl(' ' .. errors, RP.love, RP.line_bg))
        end
        if warns > 0 then
          table.insert(parts, apply_hl(' ' .. warns, RP.gold, RP.line_bg))
        end

        return table.concat(parts, ' ')
      end

      -- 4. LSP Client
      local get_lsp_client = function()
        local clients = vim.lsp.buf_get_clients(0)
        if #clients == 0 then
          return ''
        end
        local client_names = {}
        for _, client in ipairs(clients) do
          table.insert(client_names, client.name)
        end
        return apply_hl('  ' .. table.concat(client_names, ', '), RP.foam, RP.line_bg)
      end

      -- 5. Git Information
      local get_git_info = function()
        local branch = vim.fn.systemlist('git rev-parse --abbrev-ref HEAD 2>/dev/null')[1]
        if not branch or branch == '' then
            return '' -- Not a git repo
        end

        local diff_add = tonumber(vim.fn.systemlist('git diff --numstat --cached | awk \'{print $1}\'')[1] or '0')
        local diff_mod = tonumber(vim.fn.systemlist('git diff --numstat --cached | awk \'{print $2}\'')[1] or '0')
        local diff_del = tonumber(vim.fn.systemlist('git diff --numstat --cached | awk \'{print $3}\'')[1] or '0')

        local parts = {}
        table.insert(parts, apply_hl(' ' .. branch, RP.rose, RP.line_bg, true))

        if diff_add > 0 then
          table.insert(parts, apply_hl(' ' .. diff_add, RP.pine, RP.line_bg))
        end
        if diff_mod > 0 then
          table.insert(parts, apply_hl('柳 ' .. diff_mod, RP.gold, RP.line_bg))
        end
        if diff_del > 0 then
          table.insert(parts, apply_hl(' ' .. diff_del, RP.love, RP.line_bg))
        end

        return table.concat(parts, ' ')
      end

      -- 6. Line and Column Info
      local get_line_col_info = function()
        local line = vim.fn.line('.')
        local col = vim.fn.col('.')
        local total_lines = vim.fn.line('$')
        local percent = math.floor((line / total_lines) * 100)
        return apply_hl(string.format(' %d:%d %d%% ', line, col, percent), RP.text, RP.line_bg)
      end

      -- 7. File Size (simple)
      local get_file_size = function()
          local filesize = vim.fn.getfsize(vim.fn.bufname())
          if filesize > 0 then
              local size_mb = filesize / (1024 * 1024)
              if size_mb >= 1 then
                  return apply_hl(string.format(' %.1fMB ', size_mb), RP.text, RP.line_bg)
              else
                  local size_kb = filesize / 1024
                  return apply_hl(string.format(' %dKB ', size_kb), RP.text, RP.line_bg)
              end
          end
          return ''
      end

      -- ==== Mini.statusline setup ====
      M.setup({
        -- Each element in 'content' is a function that returns a formatted string
        -- These functions will be called on each statusline redraw.
        content = {
          -- Left section
          function() return apply_hl(' ', RP.foam, RP.line_bg) end, -- FirstElement (padding)
          get_vim_mode,
          get_file_info,
          get_lsp_diagnostics,
          get_lsp_client,

          -- Spacer to push right elements to the right
          function() return M.sections.fill() end, -- This is still a helper to fill space

          -- Right section
          get_git_info,
          get_file_size,
          get_line_col_info,
        },
        -- Content for inactive windows
        inactive = {
          function()
            local filename = vim.fn.expand('%:t')
            if filename == '' then
              return ''
            end
            return apply_hl(' ' .. filename .. ' ', RP.subtle, RP.surface)
          end,
        },
      })

      -- Set cmdheight to 0 to make the statusline global if you desire
      vim.opt.laststatus = 3
      vim.opt.cmdheight = 0

      -- Define default highlight groups for mini.statusline (can be overridden by apply_hl)
      vim.cmd(string.format('highlight MiniStatuslineModeNormal guifg=%s guibg=%s', RP.love, RP.line_bg))
      vim.cmd(string.format('highlight MiniStatuslineModeInsert guifg=%s guibg=%s', RP.pine, RP.line_bg))
      vim.cmd(string.format('highlight MiniStatuslineModeVisual guifg=%s guibg=%s', RP.iris, RP.line_bg))
      vim.cmd(string.format('highlight MiniStatuslineModeReplace guifg=%s guibg=%s', RP.rose, RP.line_bg))
      vim.cmd(string.format('highlight MiniStatuslineModeCmdline guifg=%s guibg=%s', RP.love, RP.line_bg))
      vim.cmd(string.format('highlight MiniStatuslineDevinfo guifg=%s guibg=%s', RP.rose, RP.line_bg))
      vim.cmd(string.format('highlight MiniStatuslineFilename guifg=%s guibg=%s', RP.iris, RP.line_bg))
      vim.cmd(string.format('highlight MiniStatuslineFileinfo guifg=%s guibg=%s', RP.text, RP.line_bg))
      vim.cmd(string.format('highlight MiniStatuslineInactive guifg=%s guibg=%s', RP.subtle, RP.surface))
      vim.cmd(string.format('highlight MiniStatuslineDiagnosticError guifg=%s guibg=%s', RP.love, RP.line_bg))
      vim.cmd(string.format('highlight MiniStatuslineDiagnosticWarn guifg=%s guibg=%s', RP.gold, RP.line_bg))
      vim.cmd(string.format('highlight MiniStatuslineLspClient guifg=%s guibg=%s', RP.foam, RP.line_bg))
      vim.cmd(string.format('highlight MiniStatuslineGitBranch guifg=%s guibg=%s', RP.rose, RP.line_bg))
      vim.cmd(string.format('highlight MiniStatuslineDiffAdd guifg=%s guibg=%s', RP.pine, RP.line_bg))
      vim.cmd(string.format('highlight MiniStatuslineDiffChange guifg=%s guibg=%s', RP.gold, RP.line_bg))
      vim.cmd(string.format('highlight MiniStatuslineDiffDelete guifg=%s guibg=%s', RP.love, RP.line_bg))

    end,
  },
}
