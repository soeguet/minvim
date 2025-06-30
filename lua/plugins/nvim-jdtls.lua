return {
    "mfussenegger/nvim-jdtls",
    enabled = false,
    ft = { "java" },
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig", -- Often needed for LSP utilities
    },
    config = function()
        local jdtls = require("jdtls")

        -- Get jdtls installation path from Mason
        local mason_registry = require("mason-registry")
        if not mason_registry.is_installed("jdtls") then
            vim.notify("jdtls is not installed via Mason", vim.log.levels.ERROR)
            return
        end

        local jdtls_pkg = mason_registry.get_package("jdtls")
        local jdtls_path = jdtls_pkg:get_install_path()

        -- Find project root
        local root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
        if not root_dir then
            vim.notify("No Java project root found", vim.log.levels.WARN)
            return
        end

        -- Create workspace directory
        local workspace_dir = vim.fn.fnamemodify(root_dir, ":p:h:t")
        local workspace_path = vim.fn.stdpath("data") .. "/workspace/" .. workspace_dir

        -- Ensure workspace directory exists
        vim.fn.mkdir(workspace_path, "p")

        -- Detect OS for configuration path
        local config_dir = "config_linux"
        if vim.fn.has("mac") == 1 then
            config_dir = "config_mac"
        elseif vim.fn.has("win32") == 1 then
            config_dir = "config_win"
        end

        -- Find the launcher jar
        local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
        if launcher_jar == "" then
            vim.notify("Could not find jdtls launcher jar", vim.log.levels.ERROR)
            return
        end

        local config = {
            cmd = {
                "java",
                "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                "-Dosgi.bundles.defaultStartLevel=4",
                "-Declipse.product=org.eclipse.jdt.ls.core.product",
                "-Dlog.protocol=true",
                "-Dlog.level=ALL",
                "-Xmx1g",
                "--add-modules=ALL-SYSTEM",
                "--add-opens", "java.base/java.util=ALL-UNNAMED",
                "--add-opens", "java.base/java.lang=ALL-UNNAMED",
                "-jar", launcher_jar,
                "-configuration", jdtls_path .. "/" .. config_dir,
                "-data", workspace_path,
            },
            root_dir = root_dir,
            settings = {
                java = {
                    eclipse = {
                        downloadSources = true,
                    },
                    configuration = {
                        updateBuildConfiguration = "interactive",
                    },
                    maven = {
                        downloadSources = true,
                    },
                    implementationsCodeLens = {
                        enabled = true,
                    },
                    referencesCodeLens = {
                        enabled = true,
                    },
                    references = {
                        includeDecompiledSources = true,
                    },
                    format = {
                        enabled = true,
                        settings = {
                            url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
                            profile = "GoogleStyle",
                        },
                    },
                },
                signatureHelp = { enabled = true },
                completion = {
                    favoriteStaticMembers = {
                        "org.hamcrest.MatcherAssert.assertThat",
                        "org.hamcrest.Matchers.*",
                        "org.hamcrest.CoreMatchers.*",
                        "org.junit.jupiter.api.Assertions.*",
                        "java.util.Objects.requireNonNull",
                        "java.util.Objects.requireNonNullElse",
                        "org.mockito.Mockito.*",
                    },
                },
                contentProvider = { preferred = "fernflower" },
                extendedClientCapabilities = jdtls.extendedClientCapabilities,
                sources = {
                    organizeImports = {
                        starThreshold = 9999,
                        staticStarThreshold = 9999,
                    },
                },
                codeGeneration = {
                    toString = {
                        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                    },
                    useBlocks = true,
                },
            },
            -- Initialize the language server
            init_options = {
                bundles = {},
            },
            -- capabilities intentionally omitted for blink.cmp
        }

        -- Start or attach to jdtls
        jdtls.start_or_attach(config)

        -- Optional: Set up keymaps for Java-specific functionality
        local opts = { noremap = true, silent = true, buffer = true }
        vim.keymap.set('n', '<leader>co', jdtls.organize_imports, opts)
        vim.keymap.set('n', '<leader>crv', jdtls.extract_variable, opts)
        vim.keymap.set('n', '<leader>crc', jdtls.extract_constant, opts)
        vim.keymap.set('v', '<leader>crm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], opts)
        vim.keymap.set('n', '<leader>crm', jdtls.extract_method, opts)
    end,
}
