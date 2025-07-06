-- This configuration sets up the 'alpha-nvim' start screen.
-- 'alpha-nvim' is a faster and more lightweight alternative to dashboard-nvim
-- for creating highly customizable Neovim start screens.

return {
  "goolord/alpha-nvim",
  -- 'alpha-nvim' is typically not lazy-loaded because it serves as the initial
  -- screen when Neovim starts or when all buffers are closed.
  -- Setting lazy = false is essential for a start screen plugin to function correctly.
  lazy = false,
  -- The 'config' function is executed when the plugin is loaded.
  config = function()
    -- Require the main 'alpha' module.
    local alpha = require("alpha")
    -- Require the 'dashboard' theme for 'alpha'. This theme provides a
    -- structured layout similar to a dashboard, allowing us to customize its sections.
    local dashboard = require("alpha.themes.dashboard")

    -- Define the ASCII logo for the header.
    -- The logo is split into a table of strings, where each string is a line.
    -- The original 'string.rep("\n", 8)' for top padding is handled by alpha's
    -- layout system, so it's removed from the logo string itself.
    local logo = [[
███╗    ██╗███████╗ ██████╗ ██╗    ██╗██╗███╗    ███╗
████╗   ██║██╔════╝██╔═══██╗██║    ██║██║████╗ ████║
██╔██╗  ██║█████╗  ██║    ██║██║    ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║    ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
    ]]

    -- Assign the logo to the header section of the dashboard theme.
    -- 'vim.split(logo, "\n")' converts the multi-line string into a table of lines.
    dashboard.section.header.val = vim.split(logo, "\n")

    -- Define the buttons for the center section.
    -- These are the same actions and descriptions as in your original dashboard-nvim config.
    local buttons_raw = {
      { action = "FzfLua files", desc = " Find File", icon = " ", key = "f" },
      { action = "ene | startinsert", desc = " New File", icon = " ", key = "n" },
      { action = "FzfLua oldfiles", desc = " Recent Files", icon = " ", key = "r" },
      { action = "Leet", desc = " Leetcode", icon = " ", key = "c" },
      { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
      { action = "qa", desc = " Quit", icon = " ", key = "q" },
    }

    -- Process the raw buttons to fit 'alpha-nvim's button structure.
    -- 'alpha-nvim' buttons typically use 'text', 'action', and 'shortcut'.
    -- The original padding logic is applied to maintain similar visual alignment.
    local mapped_buttons = {}
    for _, button in ipairs(buttons_raw) do
      -- The description part is padded to a length of 43 characters,
      -- similar to the original dashboard-nvim configuration.
      local full_desc = button.desc
      local padded_desc = full_desc .. string.rep(" ", math.max(0, 43 - #full_desc))
      -- The final text combines the icon and the padded description.
      local text = button.icon .. padded_desc

      table.insert(mapped_buttons, {
        text = text,              -- The display text for the button.
        action = button.action,   -- The Neovim command or function to execute.
        shortcut = button.key,    -- The keybinding for the button.
        -- 'alpha-nvim's dashboard theme automatically formats the shortcut,
        -- so a separate 'key_format' is generally not needed here.
      })
    end
    -- Assign the processed buttons to the buttons section of the dashboard theme.
    dashboard.section.buttons.val = mapped_buttons

    -- Define the footer section.
    -- This function dynamically generates the footer content, showing Lazy.nvim statistics.
    dashboard.section.footer.val = function()
      -- Ensure 'lazy.nvim' is loaded before trying to get its stats.
      if package.loaded["lazy"] then
        local stats = require("lazy").stats()
        -- Calculate startup time in milliseconds, rounded to two decimal places.
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        -- Return a table containing the footer line.
        return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
      else
        -- Fallback if lazy.nvim is not loaded or stats are unavailable.
        return { "⚡ Neovim loaded. (Lazy stats unavailable)" }
      -- You can also add more details or a different message if lazy is not loaded
      end
    end

    -- Explicitly set the theme to "dashboard" within the dashboard.config.
    -- This ensures the dashboard theme's default layout and styling are applied.
    dashboard.config.theme = "dashboard"

    -- Set up an autocommand to show alpha-nvim when a 'lazy' buffer is closed.
    -- This replicates the behavior from your original dashboard-nvim setup.
    vim.api.nvim_create_autocmd("BufWinLeave", {
      pattern = "lazy", -- Trigger when leaving a buffer with filetype 'lazy'
      callback = function()
        -- Check if there are no other open buffers.
        -- This prevents alpha from appearing unnecessarily if you're just switching windows.
        if #vim.api.nvim_list_bufs(false) == 1 then -- Only the alpha buffer itself might be left
          vim.schedule(function()
            alpha.start() -- Start alpha-nvim
          end)
        end
      end,
    })

    -- Finally, set up 'alpha-nvim' with the configured dashboard theme.
    -- By passing 'dashboard.config', we use the layout and default settings
    -- provided by the dashboard theme, while our custom sections override its defaults.
    alpha.setup(dashboard.config)
  end,
}
