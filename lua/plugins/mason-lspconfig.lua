return {
    "mason-org/mason-lspconfig.nvim",
    version = "^1.0.0",
    opts = {
        ensure_installed = { "lua_ls", "rust_analyzer", "pyright", "ts_ls", "gopls", "jdtls" },
        automatic_enable = true,
        servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            checkThirdParty = false,
                        },
                    },
                },
            },
            pyright = {},
            ts_ls = {},
            gopls = {},
            jdtls = {},
        },
    },
    dependencies = {
        { "saghen/blink.cmp" },
        { "nvim-java/nvim-java" },
        { "mason-org/mason.nvim" },
        { "neovim/nvim-lspconfig" }
    },
    config = function(_, opts)

        require('java').setup()

        local lspconfig = require('lspconfig')
        for server, config in pairs(opts.servers) do
            -- passing config.capabilities to blink.cmp merges with the capabilities in your
            -- `opts[server].capabilities, if you've defined it
            config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
            lspconfig[server].setup(config)
        end

    --     lspconfig.jdtls.setup({
    --         cmd = { "jdtls" },
    --         root_dir = lspconfig.util.root_pattern(".git", "mvnw", "gradlew", "pom.xml", "build.gradle"),
    --         capabilities = require('blink.cmp').get_lsp_capabilities(),
    --         settings = {
    --             java = {
    --
    --                 signatureHelp = { enabled = true },
    --                 contentProvider = { preferred = 'fernflower' },  -- For decompilation
    --                 eclipse = { downloadSources = true },
    --                 maven = { downloadSources = true },
    --                 references = { includeDecompiledSources = true },
    --                 completion = {
    --                     maxResults = 0,  -- No limit
    --                     guessMethodArguments = true
    --                 },
    --                 -- [[ this will help show documentation on hover over constructor ]]
    --                 eclipse = {
    --                     downloadSources = true,
    --                 },
    --                 configuration = {
    --                     updateBuildConfiguration = "interactive",
    --                 },
    --                 import = {
    --                     exclusions = {},
    --                     gradle = {
    --                         enabled = true,
    --                         annotationProcessing = {
    --                             enabled = true,
    --                         },
    --                         offline = {
    --                             enabled = false,
    --                         },
    --                         wrapper = {
    --                             enabled = true,
    --                         },
    --                     },
    --                     maven = { enabled = true },
    --                 },
    --                 maven = {
    --                     downloadSources = true,
    --                 },
    --                 implementationsCodeLens = {
    --                     enabled = true,
    --                 },
    --                 inlayHints = {
    --                     parameterNames = {
    --                         enabled = "all", -- [[ literals, all, none ]]
    --                     },
    --                 },
    --                 referencesCodeLens = {
    --                     enabled = true,
    --                 },
    --                 references = {
    --                     includeDecompiledSources = true,
    --                 },
    --                 signatureHelp = {
    --                     enabled = true,
    --                     description = {
    --                         enabled = true,
    --                     },
    --                 },
    --                 completion = {
    --                     chain = {
    --                         enabled = true,
    --                     },
    --                     enabled = true,
    --                     guessMethodArguments = true,
    --                     importOrder = {},
    --                     matchCase = {},
    --                     maxResults = 50,
    --                     overwrite = true,
    --                     filteredTypes = {
    --                         -- "java.awt.*",
    --                         "com.sun.*",
    --                         "sun.*",
    --                         "jdk.*",
    --                         "org.graalvm.*",
    --                         "io.micrometer.shaded.*",
    --                     },
    --                     favoriteStaticMembers = {
    --                         "org.hamcrest.MatcherAssert.assertThat",
    --                         "org.hamcrest.Matchers.*",
    --                         "org.hamcrest.CoreMatchers.*",
    --                         "org.junit.jupiter.api.Assertions.*",
    --                         "java.util.Objects.requireNonNull",
    --                         "java.util.Objects.requireNonNullElse",
    --                         "org.mockito.Mockito.*",
    --                     },
    --                 },
    --                 rename = { enabled = true },
    --                 saveActions = { organizeImports = true },
    --                 selectionRange = { enabled = true },
    --                 symbols = { includeSourceMethodDeclarations = true },
    --                 typeHierarchy = {
    --                     lazyLoad = false,
    --                 },
    --                 trace = { server = "messages" },
    --                 codeGeneration = {
    --                     hashCodeEquals = {
    --                         useInstanceof = false,
    --                         useJava7Objects = false,
    --                     },
    --                     insertionLocation = "afterCursor",
    --
    --                     generateComments = true,
    --                     toString = {
    --                         codeStyle = "STRING_CONCATENATION",
    --                         limitElements = 0,
    --                         listArrayContents = true,
    --                         skipNullValues = false,
    --                         template = "${object.className} [${member.name()}=${member.value}, ${otherMembers}]",
    --                     },
    --                     useBlocks = true,
    --                 },
    --                 edit = {
    --                     validateAllOpenBuffersOnChanges = true,
    --                 },
    --                 contentProvider = { preferred = "fernflower" },
    --                 -- extendedClientCapabilities = extendedClientCapabilities,
    --                 sources = {
    --                     organizeImports = {
    --                         starThreshold = 9999,
    --                         staticStarThreshold = 9999,
    --                     },
    --                 },
    --                 extendedClientCapabilities = {
    --                     classFileContentsSupport = true,  -- Critical for library documentation
    --                     clientHoverProvider = true,
    --                     clientDocumentSymbolProvider = true,
    --                     advancedOrganizeImportsSupport = true,
    --                     generateToStringPromptSupport = true,
    --                     inferSelectionSupport = {"extractMethod", "extractVariable", "extractConstant"},
    --
    --                     actionableNotificationSupported = true,
    --                     actionableRuntimeNotificationSupport = true,
    --                     advancedExtractRefactoringSupport = true,
    --                     advancedGenerateAccessorsSupport = true,
    --                     advancedIntroduceParameterRefactoringSupport = true,
    --                     -- advancedOrganizeImportsSupport = true,
    --                     -- classFileContentsSupport = true,
    --                     --clientDocumentSymbolProvider = true,
    --                     --clientHoverProvider = true,
    --                     generateConstructorsPromptSupport = true,
    --                     generateDelegateMethodsPromptSupport = true,
    --                     -- generateToStringPromptSupport = true,
    --                     gradleChecksumWrapperPromptSupport = true,
    --                     hashCodeEqualsPromptSupport = true,
    --                     --inferSelectionSupport = true,
    --                     moveRefactoringSupport = true,
    --                     onCompletionItemSelectedCommand = true,
    --                     overrideMethodsPromptSupport = true,
    --                     shouldLanguageServerExitOnShutdown = true,
    --                     resolveAdditionalTextEditsSupport = true,
    --                     --excludedMarkerTypes = {},  -- list of excluded marker types
    --                     --skipProjectConfiguration = true,
    --                     --skipTextEventPropagation = true
    --                 },
    --             },
    --         },
    --     })
    end
}
