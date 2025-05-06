return {
	{
		"mfussenegger/nvim-dap",

		dependencies = {
			"igorlfs/nvim-dap-view",
			{
				"williamboman/mason.nvim",
				opts = { ensure_installed = { "java-debug-adapter", "java-test" } },
			},
		},

    -- stylua: ignore
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
      { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    },

		config = function()
			local dap = require("dap")
			dap.configurations.java = {
				{
					type = "java",
					request = "attach",
					name = "Debug (Attach) - Remote",
					hostName = "127.0.0.1",
					port = 5005,
				},
			}
		end,
	},

	-- fancy UI for the debugger
	{
		"igorlfs/nvim-dap-view",
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dap-view").toggle({ }) end, desc = "Dap UI" },
    },
		config = function(_, opts)
			local dap, dv = require("dap"), require("dap-view")
			dap.listeners.before.attach["dap-view-config"] = function()
				dv.open()
			end
			dap.listeners.before.launch["dap-view-config"] = function()
				dv.open()
			end
			dap.listeners.before.event_terminated["dap-view-config"] = function()
				dv.close()
			end
			dap.listeners.before.event_exited["dap-view-config"] = function()
				dv.close()
			end
		end,
	},
}
