-- This configuration sets up the 'alpha-nvim' start screen.
-- 'alpha-nvim' is a highly customizable start screen for Neovim.

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
    -- Require the 'dashboard' theme for 'alpha'.
    -- This theme provides a structured layout similar to a dashboard,
    -- allowing us to customize its sections.
    local dashboard = require("alpha.themes.dashboard")

    -- Define the ASCII logo for the header.
    -- The logo is split into a table of strings, where each string is a line.
    local logo = [[
███╗    ██╗███████╗ ██████╗ ██╗    ██╗██╗███╗    ███╗
████╗   ██║██╔════╝██╔═══██╗██║    ██║██║████╗ ████║
██╔██╗  ██║█████╗  ██║    ██║██║    ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║    ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
    ]]

    -- Assign the logo to the header section of the dashboard theme.
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
      end
    end

    -- Explicitly set the theme to "dashboard" within the dashboard.config.
    -- While passing dashboard.config implicitly uses the dashboard theme,
    -- this makes it explicit in the configuration table itself, fulfilling the request.
    dashboard.config.theme = "dashboard"

    -- Finally, set up 'alpha-nvim' with the configured dashboard theme.
    -- By passing 'dashboard.config', we use the layout and default settings
    -- provided by the dashboard theme, while our custom sections override its defaults.
    alpha.setup(dashboard.config)
  end,
}
