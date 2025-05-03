return {
  'CRAG666/code_runner.nvim',
  -- name = "code_runner",
  cmd = 'RunCode',
  keys = {
    {
      '<leader>r',
      function()
        require('code_runner').run_code()
      end,
      desc = '[n]tart code',
    },
  },
  opts = {
    mode = 'better_term',
    better_term = {
      number = 2,
    },
    filetype = {
      markdown = function(...)
        local hook = require('code_runner.hooks.preview_pdf')
        require('code_runner.hooks.ui').select({
          Marp = function()
            require('code_runner').run_from_fn(
              'marp --theme-set $MARPT -w -p . &$end'
            )
          end,
          Latex = function()
            hook.run({
              command = 'pandoc',
              args = { '$fileName', '-o', '$tmpFile', '-t pdf' },
              preview_cmd = preview_cmd,
            })
          end,
          Beamer = function()
            hook.run({
              command = 'pandoc',
              args = { '$fileName', '-o', '$tmpFile', '-t beamer' },
              preview_cmd = preview_cmd,
            })
          end,
          Eisvogel = function()
            hook.run({
              command = 'bash',
              args = { './build.sh' },
              preview_cmd = preview_cmd,
              overwrite_output = '.',
            })
          end,
        })
      end,
      javascript = 'node',
      java = 'cd $dir && javac $fileName && java $fileNameWithoutExt',
      kotlin = 'cd $dir && kotlinc-native $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt.kexe',

      cpp = function(...)
        cpp_base = {
          [[cd '$dir' &&]],
          'g++ $fileName -o',
          '/tmp/$fileNameWithoutExt',
        }
        local cpp_exec = {
          '&& /tmp/$fileNameWithoutExt &&',
          'rm /tmp/$fileNameWithoutExt',
        }
        vim.ui.input({ prompt = 'Add more args:' }, function(input)
          cpp_base[4] = input
          vim.print(vim.tbl_extend('force', cpp_base, cpp_exec))
          require('code_runner.commands').run_from_fn(
            vim.list_extend(cpp_base, cpp_exec)
          )
        end)
      end,
      python = "python -u '$dir/$fileName'",
      sh = 'bash',
      typescript = 'deno run',
      typescriptreact = 'yarn dev$end',
      rust = 'cd $dir && rustc $fileName && $dir$fileNameWithoutExt',
    },
    project_path = vim.fn.expand('~/.config/nvim/project_manager.json'),
  },
}
