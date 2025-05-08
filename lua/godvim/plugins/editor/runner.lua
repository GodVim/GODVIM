return {
	"CRAG666/code_runner.nvim",
	cmd = "RunCode",
	keys = {
		{
			"<leader>cr",
			function()
				require("code_runner").run_code()
			end,
			desc = "[r]un code",
		},
	},
	opts = {
		mode = "better_term",
		better_term = {
			number = 2,
		},
		filetype = {
			java = "cd $dir && javac $fileName && java $fileNameWithoutExt",

			cpp = function(...)
				cpp_base = {
					[[cd '$dir' &&]],
					"g++ $fileName -o",
					"/tmp/$fileNameWithoutExt",
				}
				local cpp_exec = {
					"&& /tmp/$fileNameWithoutExt &&",
					"rm /tmp/$fileNameWithoutExt",
				}
				vim.ui.input({ prompt = "Add more args:" }, function(input)
					cpp_base[4] = input
					vim.print(vim.tbl_extend("force", cpp_base, cpp_exec))
					require("code_runner.commands").run_from_fn(vim.list_extend(cpp_base, cpp_exec))
				end)
			end,
			python = "python -u '$dir/$fileName'",
			sh = "bash",
		},
	},
}
