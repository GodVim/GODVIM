-- lazy.nvim example for mini.statusline with Rose Pine
return {
  {
    'echasnovski/mini.statusline', -- This is the correct repository for mini.statusline
    version = false,
    config = function()
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

        -- Mappings for easier replacement from previous config
        bg = '#191724',    -- base
        fg = '#e0def4',    -- text
        line_bg = '#1f1d2e', -- surface (slightly lighter than base for distinction)
        fg_green = '#31748f', -- pine (closest to a vibrant green for diff adds)
        yellow = '#f6c177',   -- gold
        cyan = '#9ccfd8',     -- foam
        darkblue = '#31748f', -- pine (can be used for some blue elements)
        green = '#31748f',    -- pine
        orange = '#f6c177',   -- gold
        purple = '#c4a7e7',   -- iris
        magenta = '#eb6f92',  -- love (closest for red/magenta like modes)
        gray = '#6e6a86',     -- muted
        blue = '#9ccfd8',     -- foam (common blue for file icon/separator)
        red = '#eb6f92'       -- love
      }


      -- Helper to get mode color
      local get_mode_highlight = function()
        local mode_colors = {
          n = RP.love,      -- Red/Love
          i = RP.pine,      -- Green/Pine
          v = RP.iris,      -- Blue/Iris
          [' '] = RP.iris,
          V = RP.iris,
          c = RP.love,
          no = RP.love,
          s = RP.gold,      -- Peach/Gold
          S = RP.gold,
          [' '] = RP.gold,
          ic = RP.yellow,
          R = RP.iris,      -- Purple/Iris
          Rv = RP.iris,
          cv = RP.love,
          ce = RP.love,
          r = RP.foam,      -- Teal/Foam
          rm = RP.foam,
          ['r?'] = RP.foam,
          ['!'] = RP.love,
          t = RP.love
        }
        return mode_colors[vim.fn.mode()] or RP.text
      end

      -- Helper to get file icon color
      local get_file_icon_color = function()
        -- You can integrate nvim-web-devicons here if desired
        return RP.foam -- Using 'foam' for file icons
      end

      -- Define Left section groups
      local left_groups = {
        -- FirstElement (just a space for padding/color block)
        H.group({
          H.section.raw(' ', { H.attr.fg(RP.foam), H.attr.bg(RP.line_bg) })
        }),
        -- ViMode
        H.group({
          H.section.raw(
            '  ',
            { H.attr.fg(get_mode_highlight()), H.attr.bg(RP.line_bg), H.attr.bold() }
          )
        }),
        -- FileIcon & FileName
        H.group({
          H.section.file_icon({
            { H.attr.fg(get_file_icon_color()), H.attr.bg(RP.line_bg) }
          }),
          H.section.filename({
            trunc_width = 0, -- Don't truncate
            show_modified = false,
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
        -- LSP Diagnostics
        H.group({
          H.section.diagnostics({
            error_icon = ' ',
            warn_icon = ' ',
            info_icon = ' ',
            hint_icon = ' ',
            truncate = false,
            format = function(diagnostics)
              local parts = {}
              if diagnostics.error ~= 0 then
                table.insert(parts, H.section.raw(
                  diagnostics.error_icon .. diagnostics.error,
                  { H.attr.fg(RP.love), H.attr.bg(RP.line_bg) }
                ))
              end
              if diagnostics.warn ~= 0 then
                table.insert(parts, H.section.raw(
                  diagnostics.warn_icon .. diagnostics.warn,
                  { H.attr.fg(RP.gold), H.attr.bg(RP.line_bg) }
                ))
              end
              return table.concat(parts, ' ')
            end
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
        })
      }

      -- Define Right section groups
      local right_groups = {
        -- Git Information
        H.group({
          H.section.git({
            icon = ' ',
            format = function(git)
              if git.has_git then
                return git.icon .. git.branch
              end
              return ''
            end,
            { H.attr.fg(RP.rose), H.attr.bg(RP.line_bg), H.attr.bold() }
          })
        }),
        -- Git Diffs
        H.group({
          H.section.diff({
            add_icon = ' ',
            change_icon = '柳 ',
            delete_icon = ' ',
            format = function(diff)
              local parts = {}
              if diff.add ~= 0 then
                table.insert(parts, H.section.raw(diff.add_icon .. diff.add, { H.attr.fg(RP.pine), H.attr.bg(RP.line_bg) }))
              end
              if diff.change ~= 0 then
                table.insert(parts, H.section.raw(diff.change_icon .. diff.change, { H.attr.fg(RP.gold), H.attr.bg(RP.line_bg) }))
              end
              if diff.delete ~= 0 then
                table.insert(parts, H.section.raw(diff.delete_icon .. diff.delete, { H.attr.fg(RP.love), H.attr.bg(RP.line_bg) }))
              end
              return table.concat(parts, ' ')
            end
          })
        }),
        -- Line and File Information
        H.group({
          H.section.file_info({
            truncate = false,
            format = {
              'size: %s',
              'lines: %s',
              'cols: %s',
              'ln: %l',
              'col: %c',
              'pos: %p%%'
            },
            -- This will apply to all parts within file_info by default
            { H.attr.fg(RP.text), H.attr.bg(RP.line_bg) }
          })
        })
      }

      M.setup({
        -- content should be a table of groups directly
        content = {
          left_groups,
          H.fill(), -- Spacer
          right_groups
        },
        -- Content for inactive windows (optional)
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

      -- Set cmdheight to 0 to make the statusline global if you desire
      vim.opt.laststatus = 3
      vim.opt.cmdheight = 0

      -- Define highlight groups for mini.statusline if you want more granular control
      -- These highlight groups will be defined based on your Rosé Pine palette
      vim.cmd(string.format('highlight MiniStatuslineModeNormal guifg=%s guibg=%s', RP.love, RP.line_bg))
      vim.cmd(string.format('highlight MiniStatuslineModeInsert guifg=%s guibg=%s', RP.pine, RP.line_bg))
      vim.cmd(string.format('highlight MiniStatuslineModeVisual guifg=%s guibg=%s', RP.iris, RP.line_bg))
      vim.cmd(string.format('highlight MiniStatuslineModeReplace guifg=%s guibg=%s', RP.rose, RP.line_bg)) -- Using rose for replace
      vim.cmd(string.format('highlight MiniStatuslineModeCmdline guifg=%s guibg=%s', RP.love, RP.line_bg)) -- Command line
      vim.cmd(string.format('highlight MiniStatuslineDevinfo guifg=%s guibg=%s', RP.rose, RP.line_bg))
      vim.cmd(string.format('highlight MiniStatuslineFilename guifg=%s guibg=%s', RP.iris, RP.line_bg))
      vim.cmd(string.format('highlight MiniStatuslineFileinfo guifg=%s guibg=%s', RP.text, RP.line_bg))
      vim.cmd(string.format('highlight MiniStatuslineInactive guifg=%s guibg=%s', RP.subtle, RP.surface))

      -- Additional highlights for diagnostics (if not handled purely by section.diagnostics)
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
