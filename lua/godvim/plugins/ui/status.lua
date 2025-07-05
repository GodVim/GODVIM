-- lazy.nvim configuration for mini.statusline with Rosé Pine
return {
  {
    'echasnovski/mini.statusline',
    verion = false, -- Or a specific tag like 'v0.12.0' for stability and features

    config = function()
      -- Require mini.statusline and its helpers
      local M = require('mini.statusline')
      local H = M.helpers

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

        -- Mappings for easy replacement (based on your previous galaxyline config)
        bg = '#191724',     -- base
        fg = '#e0def4',     -- text
        line_bg = '#1f1d2e', -- surface (for statusline background)
        fg_green = '#31748f', -- pine
        yellow = '#f6c177',   -- gold
        cyan = '#9ccfd8',     -- foam
        darkblue = '#31748f', -- pine
        green = '#31748f',    -- pine
        orange = '#f6c177',   -- gold
        purple = '#c4a7e7',   -- iris
        magenta = '#eb6f92',  -- love (used for modes like Normal, Cmdline)
        gray = '#6e6a86',     -- muted
        blue = '#9ccfd8',     -- foam (used for Visual mode, FileIcon)
        red = '#eb6f92'       -- love (used for errors)
      }

      -- Function to dynamically get mode color
      local get_mode_color = function()
        local mode_colors = {
          n = RP.love,      -- Normal
          i = RP.pine,      -- Insert
          v = RP.iris,      -- Visual
          V = RP.iris,      -- Visual Line
          ['\22'] = RP.iris, -- Visual Block (Ctrl-V)
          c = RP.love,      -- Command-line
          no = RP.love,     -- Normal Operator Pending
          s = RP.gold,      -- Select
          S = RP.gold,      -- Select Line
          ['\19'] = RP.gold, -- Select Block (Ctrl-S)
          R = RP.iris,      -- Replace
          Rv = RP.iris,     -- Virtual Replace
          cv = RP.love,     -- Ex Command-line
          ce = RP.love,     -- Ex Command-line
          r = RP.foam,      -- Prompt
          rm = RP.foam,     -- More Prompt
          ['r?'] = RP.foam, -- Confirm
          ['!'] = RP.love,  -- Shell
          t = RP.love,      -- Terminal
        }
        return mode_colors[vim.fn.mode()] or RP.text
      end

      -- Function to get file icon color (requires nvim-web-devicons)
      local get_file_icon_color = function()
        if pcall(require, 'nvim-web-devicons') then
          local devicons = require('nvim-web-devicons')
          local _, color = devicons.get_icon_color_by_filetype(vim.bo.filetype, { default = true })
          return color or RP.foam
        end
        return RP.foam -- Default if devicons not loaded
      end

      -- Define Left section groups
      local left_groups = {
        -- FirstElement: just a colored block for aesthetic padding
        H.group({
          H.section.raw(' ', { H.attr.fg(RP.blue), H.attr.bg(RP.line_bg) })
        }),

        -- ViMode: dynamically colored mode indicator
        H.group({
          H.section.raw(
            '  ', -- Icon for ViMode
            { H.attr.fg(get_mode_color()), H.attr.bg(RP.line_bg), H.attr.bold() }
          )
        }),

        -- FileIcon & FileName
        H.group({
          H.section.file_icon({
            { H.attr.fg(get_file_icon_color()), H.attr.bg(RP.line_bg) }
          }),
          H.section.filename({
            trunc_width = 0, -- No truncation for filename
            show_modified = true, -- Show '+' if modified
            draw_empty_filename = false,
            format = {
              not_readable = '(%s)',
              not_loaded = '[%s]',
              unnamed = '[No Name]',
              default = '%s'
            },
            { H.attr.fg(RP.iris), H.attr.bg(RP.line_bg), H.attr.bold() }
          })
        }),

        -- LSP Diagnostics (Error)
        H.group({
          H.section.diagnostics({
            error_icon = ' ',
            format = function(diagnostics)
              return diagnostics.error > 0 and diagnostics.error_icon .. diagnostics.error or ''
            end,
            { H.attr.fg(RP.love), H.attr.bg(RP.line_bg) }
          })
        }),

        -- LSP Diagnostics (Warn)
        H.group({
          H.section.diagnostics({
            warn_icon = ' ',
            format = function(diagnostics)
              return diagnostics.warn > 0 and diagnostics.warn_icon .. diagnostics.warn or ''
            end,
            { H.attr.fg(RP.gold), H.attr.bg(RP.line_bg) }
          })
        }),

        -- LSP Client Name
        H.group({
          H.section.lsp_client({
            icon = '  ',
            format = function(lsp_client)
              return lsp_client.name
            end,
            { H.attr.fg(RP.foam), H.attr.bg(RP.line_bg) }
          })
        }),
      }

      -- Define Right section groups
      local right_groups = {
        -- Git Branch and Icon
        H.group({
          H.section.git({
            icon = ' ',
            format = function(git)
              -- Only show if in a Git workspace
              return git.has_git and git.icon .. git.branch or ''
            end,
            { H.attr.fg(RP.rose), H.attr.bg(RP.line_bg), H.attr.bold() }
          })
        }),

        -- Git Diffs (Add)
        H.group({
          H.section.diff({
            add_icon = ' ',
            format = function(diff)
              return diff.add > 0 and diff.add_icon .. diff.add or ''
            end,
            { H.attr.fg(RP.pine), H.attr.bg(RP.line_bg) }
          })
        }),

        -- Git Diffs (Modified)
        H.group({
          H.section.diff({
            change_icon = '柳 ',
            format = function(diff)
              return diff.change > 0 and diff.change_icon .. diff.change or ''
            end,
            { H.attr.fg(RP.gold), H.attr.bg(RP.line_bg) }
          })
        }),

        -- Git Diffs (Removed)
        H.group({
          H.section.diff({
            delete_icon = ' ',
            format = function(diff)
              return diff.delete > 0 and diff.delete_icon .. diff.delete or ''
            end,
            { H.attr.fg(RP.love), H.attr.bg(RP.line_bg) }
          })
        }),

        -- Line and Column Info
        H.group({
          H.section.file_info({
            format = { 'ln:%l', 'col:%c', '%p%%' }, -- Display line, col, and percentage
            delimiter = ' ', -- Space between elements
            { H.attr.fg(RP.fg), H.attr.bg(RP.line_bg) }
          })
        }),

        -- File Size
        H.group({
          H.section.file_info({
            format = { 'size:%s' }, -- Only file size
            condition = function() return vim.fn.getfsize(vim.fn.bufname()) > 0 end, -- Only show if file has size
            { H.attr.fg(RP.fg), H.attr.bg(RP.line_bg) }
          })
        })
      }

      -- ==== Mini.statusline setup ====
      M.setup({
        -- 'content' is a table where each element is a group of sections.
        -- Use H.fill() to push content to the left/right.
        content = {
          left_groups,
          H.fill(), -- This acts as a dynamic spacer
          right_groups
        },
        -- Content for inactive windows
        inactive = {
          H.group({
            H.section.filename({
              draw_empty_filename = false,
              format = { default = '%s' },
              { H.attr.fg(RP.subtle), H.attr.bg(RP.surface) } -- Faded colors for inactive
            })
          })
        },
      })

      -- Set cmdheight to 0 to make the statusline global if desired
      vim.opt.laststatus = 3
      vim.opt.cmdheight = 0

      -- Define specific highlight groups for mini.statusline
      -- These ensure consistency, especially if inline highlighting isn't always used.
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
