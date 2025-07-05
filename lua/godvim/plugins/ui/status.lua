-- lazy.nvim example
return {
  {
    'echasnovski/mini.statusline', -- This is the correct repository for mini.statusline
    branch = 'main', -- Or a specific tag like 'v0.12.0' for stability
    config = function()
      local M = require('mini.statusline')
      local H = M.helpers
      -- Assuming you have Catppuccin loaded globally or access to its palette
      local catppuccin = require('catppuccin')
      local C = catppuccin.get_palette 'mocha'

      -- Helper to get mode color (similar to Galaxyline's logic)
      local get_mode_highlight = function()
        local mode_colors = {
          n = C.red,
          i = C.green,
          v = C.blue,
          [' '] = C.blue,
          V = C.blue,
          c = C.red,
          no = C.red,
          s = C.peach,
          S = C.peach,
          [' '] = C.peach,
          ic = C.yellow,
          R = C.purple,
          Rv = C.purple,
          cv = C.red,
          ce = C.red,
          r = C.teal,
          rm = C.teal,
          ['r?'] = C.teal,
          ['!'] = C.red,
          t = C.red
        }
        return mode_colors[vim.fn.mode()] or C.text
      end

      -- Helper to get file icon color
      local get_file_icon_color = function()
        return C.blue -- Default color for this example
      end

      -- Define Left section groups
      local left_groups = {
        -- FirstElement (just a space for padding/color block)
        H.group({
          H.section.raw(' ', { H.attr.fg(C.blue), H.attr.bg(C.mantle) })
        }),
        -- ViMode
        H.group({
          H.section.raw(
            '  ',
            { H.attr.fg(get_mode_highlight()), H.attr.bg(C.mantle), H.attr.bold() }
          )
        }),
        -- FileIcon & FileName
        H.group({
          H.section.file_icon({
            { H.attr.fg(get_file_icon_color()), H.attr.bg(C.mantle) }
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
            { H.attr.fg(C.purple), H.attr.bg(C.mantle), H.attr.bold() }
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
                  { H.attr.fg(C.red), H.attr.bg(C.mantle) }
                ))
              end
              if diagnostics.warn ~= 0 then
                table.insert(parts, H.section.raw(
                  diagnostics.warn_icon .. diagnostics.warn,
                  { H.attr.fg(C.yellow), H.attr.bg(C.mantle) }
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
            { H.attr.fg(C.sky), H.attr.bg(C.mantle) }
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
            { H.attr.fg(C.peach), H.attr.bg(C.mantle), H.attr.bold() }
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
                table.insert(parts, H.section.raw(diff.add_icon .. diff.add, { H.attr.fg(C.green), H.attr.bg(C.mantle) }))
              end
              if diff.change ~= 0 then
                table.insert(parts, H.section.raw(diff.change_icon .. diff.change, { H.attr.fg(C.yellow), H.attr.bg(C.mantle) }))
              end
              if diff.delete ~= 0 then
                table.insert(parts, H.section.raw(diff.delete_icon .. diff.delete, { H.attr.fg(C.red), H.attr.bg(C.mantle) }))
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
            { H.attr.fg(C.text), H.attr.bg(C.mantle) }
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
              { H.attr.fg(C.overlay0), H.attr.bg(C.mantle) } -- Faded colors for inactive
            })
          })
        },
      })

      -- Set cmdheight to 0 to make the statusline global if you desire
      vim.opt.laststatus = 3
      vim.opt.cmdheight = 0

      -- Define highlight groups for mini.statusline if you want more granular control
      vim.cmd(string.format('highlight MiniStatuslineModeNormal guifg=%s guibg=%s', C.red, C.mantle))
      vim.cmd(string.format('highlight MiniStatuslineModeInsert guifg=%s guibg=%s', C.green, C.mantle))
      vim.cmd(string.format('highlight MiniStatuslineDevinfo guifg=%s guibg=%s', C.peach, C.mantle))
      vim.cmd(string.format('highlight MiniStatuslineFilename guifg=%s guibg=%s', C.purple, C.mantle))
      vim.cmd(string.format('highlight MiniStatuslineFileinfo guifg=%s guibg=%s', C.text, C.mantle))
      vim.cmd(string.format('highlight MiniStatuslineInactive guifg=%s guibg=%s', C.overlay0, C.mantle))
    end,
  },
}
