return {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
        local jdtls = require("jdtls")
        local jdtls_utils = require("jdtls.setup")

        local root_dir = jdtls_utils.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
        if not root_dir then
            return
        end

        -- Standard LSP capabilities mit minimalen Completion-Features
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.workspace.configuration = true
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities.textDocument.completion.completionItem.resolveSupport = {
            properties = { "documentation", "detail" } -- Nur basics, keine additionalTextEdits
        }
        -- Code Action Capabilities aktivieren
        capabilities.textDocument.codeAction = {
            dynamicRegistration = true,
            codeActionLiteralSupport = {
                codeActionKind = {
                    valueSet = {
                        "quickfix",
                        "refactor",
                        "refactor.extract",
                        "refactor.inline",
                        "refactor.rewrite",
                        "source.organizeImports",
                        "source.generate",
                        "source.generate.constructor",
                        "source.generate.accessors",
                        "source.generate.toString",
                        "source.generate.hashCodeEquals",
                        "source.generate.overrideMethods",
                        "source.generate.implementMethods",
                    }
                }
            },
            resolveSupport = {
                properties = { "edit" }
            }
        }

        jdtls.start_or_attach({
            cmd = {
                "env", "JAVA_HOME=C:\\Users\\Osman.Soeguet\\.jdks\\azul-21.0.6", "jdtls",
                "--add-modules=ALL-SYSTEM",
                "--add-opens", "java.base/java.util=ALL-UNNAMED",
                "--add-opens", "java.base/java.lang=ALL-UNNAMED"
            },
            root_dir = root_dir,
            capabilities = capabilities, -- Verwende Standard-Capabilities

            init_options = {
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
            },

            settings = {
                java = {
                    format = {
                        enabled = false,
                    },
                    eclipse = {
                        downloadSources = true,
                    },
                    configuration = {
                        updateBuildConfiguration = "interactive",
                        runtimes = {
                            {
                                name = "JavaSE-21",
                                path = "C:\\Users\\Osman.Soeguet\\.jdks\\azul-21.0.6",
                                default = true,
                            },
                        },
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
                            "java.awt.*",
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
            },

            on_attach = function(client, bufnr)
                local opts = { buffer = bufnr }

                -- Standard LSP Keybindings
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

                -- JDTLS-spezifische Keybindings
                vim.keymap.set('n', '<leader>jo', function() jdtls.organize_imports() end, opts)
                vim.keymap.set('n', '<leader>jv', function() jdtls.extract_variable() end, opts)
                vim.keymap.set('n', '<leader>jc', function() jdtls.extract_constant() end, opts)
                vim.keymap.set('v', '<leader>jm', function() jdtls.extract_method() end, opts)
                vim.keymap.set('n', '<leader>jt', function() jdtls.test_class() end, opts)
                vim.keymap.set('n', '<leader>jn', function() jdtls.test_nearest_method() end, opts)

                -- Spezifische Code Actions für häufige Anwendungsfälle
                vim.keymap.set('n', '<leader>jgc', function()
                    vim.lsp.buf.code_action({
                        filter = function(action)
                            return action.kind and action.kind:match("source.generate.constructor")
                        end,
                        apply = true
                    })
                end, { desc = "Generate Constructor", buffer = bufnr })

                vim.keymap.set('n', '<leader>jgs', function()
                    vim.lsp.buf.code_action({
                        filter = function(action)
                            return action.kind and action.kind:match("source.generate.accessors")
                        end,
                        apply = true
                    })
                end, { desc = "Generate Getter/Setter", buffer = bufnr })

                vim.keymap.set('n', '<leader>jgi', function()
                    vim.lsp.buf.code_action({
                        filter = function(action)
                            return action.kind and
                                (action.kind:match("source.generate.implementMethods") or action.kind:match("source.override"))
                        end,
                        apply = true
                    })
                end, { desc = "Implement/Override Methods", buffer = bufnr })

                print("JDTLS attached to buffer " .. bufnr)
            end,
        })
    end,
}
