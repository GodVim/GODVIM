    return {
        'mfussenegger/nvim-jdtls',
        ft = 'java',
        config = function()
            local jdtls = require('jdtls')

            local config = {
                cmd = { '/usr/bin/jdtls' },
                root_dir = jdtls.setup.find_root({ '.git', 'gradlew', 'mvnw' }),
                settings = {
                    java = {
                        -- Add your Java settings here
                    },
                },
            }

            jdtls.start_or_attach(config)
        end,
    }
