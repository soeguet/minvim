M = {}

-- The command that starts the language server
-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
local function custom_cwd()
    local parent_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':h')
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    local cwd = {

        -- 💀
        '/usr/lib/jvm/java-21-openjdk-amd64/bin/java',

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',

        -- 💀
        '-jar',
        '/home/soeguet/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.7.0.v20250331-1702.jar',
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
        -- Must point to the                                                     Change this to
        -- eclipse.jdt.ls installation                                           the actual version

        -- 💀
        '-configuration',
        '/home/soeguet/.local/share/nvim/mason/packages/jdtls/config_linux',
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
        -- Must point to the                      Change to one of `linux`, `win` or `mac`
        -- eclipse.jdt.ls installation            Depending on your system.

        -- 💀
        -- See `data directory configuration` section in the README
        -- CAVE: darf nicht gleich = projektpfad sein sonst 'non-projekt file' fehler
        '-data',
        parent_dir .. '/workspaces/' .. project_name
    }

    return cwd
end

-- Language server `initializationOptions`
-- You need to extend the `bundles` with paths to jar files
-- if you want to use additional eclipse.jdt.ls plugins.
--
-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
--
-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
local function custom_init_options()
    local init_opts = {
        bundles = {},
        extendedClientCapabilities = {
            actionableNotificationSupported = true,
            actionableRuntimeNotificationSupport = true,
            advancedExtractRefactoringSupport = true,
            advancedGenerateAccessorsSupport = true,
            advancedIntroduceParameterRefactoringSupport = true,
            advancedOrganizeImportsSupport = true,
            classFileContentsSupport = true,
            generateConstructorsPromptSupported = true,    -- Typo korrigiert
            generateDelegateMethodsPromptSupported = true, -- Typo korrigiert
            generateToStringPromptSupported = true,        -- Typo korrigiert
            gradleChecksumWrapperPromptSupported = true,   -- Typo korrigiert
            hashCodeEqualsPromptSupported = true,          -- Typo korrigiert
            moveRefactoringSupport = true,
            onCompletionItemSelectedCommand = true,
            overrideMethodsPromptSupported = true, -- Typo korrigiert
            shouldLanguageServerExitOnShutdown = true,
            resolveAdditionalTextEditsSupport = true,
            -- Wichtig für Constructor/Override
            implementMethodsSupported = true,
            generateConstructorsSupported = true,
            generateAccessorsSupported = true,
        },
    }

    return init_opts
end

-- Here you can configure eclipse.jdt.ls specific settings
-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
-- for a list of options
local function java_settings()
    local java_opts = {
        java = {
            format = {
                enabled = false,
            },
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
                -- runtimes = {
                --     {
                --         name = "JavaSE-21",
                --         path = "C:\\Users\\Osman.Soeguet\\.jdks\\azul-21.0.6",
                --         default = true,
                --     },
                -- },
            },
            import = {
                exclusions = {},
                gradle = {
                    enabled = true,
                    annotationProcessing = {
                        enabled = true,
                    },
                    offline = {
                        enabled = false,
                    },
                    wrapper = {
                        enabled = true,
                    },
                },
                maven = { enabled = true },
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            inlayHints = {
                parameterNames = {
                    enabled = "all",
                },
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            signatureHelp = {
                enabled = true,
                description = {
                    enabled = true,
                },
            },
            completion = {
                enabled = true,      -- Wieder aktiviert, aber reduziert
                chain = {
                    enabled = false, -- Deaktiviert für Stabilität
                },
                guessMethodArguments = false,
                maxResults = 20, -- Reduziert
                overwrite = false,
                filteredTypes = {
                    "com.sun.*",
                    "sun.*",
                    "jdk.*",
                    "org.graalvm.*",
                    "io.micrometer.shaded.*",
                },
            },
            rename = { enabled = true },
            saveActions = { organizeImports = true },
            selectionRange = { enabled = true },
            symbols = { includeSourceMethodDeclarations = true },
            typeHierarchy = {
                lazyLoad = false,
            },
            trace = { server = "off" },
            codeGeneration = {
                hashCodeEquals = {
                    useInstanceof = false,
                    useJava7Objects = false,
                },
                insertionLocation = "afterCursor",
                generateComments = true,
                toString = {
                    codeStyle = "STRING_CONCATENATION",
                    limitElements = 0,
                    listArrayContents = true,
                    skipNullValues = false,
                    template = "${object.className} [${member.name()}=${member.value}, ${otherMembers}]",
                },
                useBlocks = true,
            },
            edit = {
                validateAllOpenBuffersOnChanges = false,
            },
            contentProvider = { preferred = "fernflower" },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
        },
    }

    vim.notify('java_opts loaded')
    return java_opts
end

local function enhanced_capabilities()
    local capabilities = require('cmp_nvim_lsp').default_capabilities() --nvim-cmp
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = { 'documentation', 'detail', 'additionalTextEdits' }
    }
    capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
    capabilities.textDocument.hover = {
        dynamicRegistration = true,
        contentFormat = { "markdown", "plaintext" }
    }
    -- Code Action Capabilities aktivieren
    capabilities.textDocument.codeAction = {
        dynamicRegistration = true,
        codeActionLiteralSupport = {
            codeActionKind = {
                valueSet = {
                    'quickfix',
                    'refactor',
                    'refactor.extract',
                    'refactor.inline',
                    'refactor.rewrite',
                    'source.organizeImports',
                    'source.generate',
                    'source.generate.constructor',
                    'source.generate.accessors',
                    'source.generate.toString',
                    'source.generate.hashCodeEquals',
                    'source.generate.overrideMethods',
                    'source.generate.implementMethods',
                }
            }
        },
        resolveSupport = {
            properties = { 'edit' }
        }
    }

    vim.notify('capabilities loaded')
    return capabilities
end

function M:setup()
    local config = {
        settings = java_settings(),
        init_options = custom_init_options(),
        capabilities = enhanced_capabilities(),
        cmd = custom_cwd(),

        -- 💀
        -- This is the default if not provided, you can remove it. Or adjust as needed.
        -- One dedicated LSP server & client will be started per unique root_dir
        -- root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }),
        root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml" }),
    }

    require('jdtls').start_or_attach(config)
    vim.notify('jdtls loaded up!')
end

return M
