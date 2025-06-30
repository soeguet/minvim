return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {
            "lua_ls",
            "rust_analyzer",
            "pyright",
            "ts_ls",
            "gopls",
            "jdtls"
        },
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
            jdtls = {
                cmd = { "jdtls" },
                root_dir = function(fname)
                    return require('lspconfig.util').root_pattern('.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle')(
                        fname) or vim.fn.getcwd()
                end,
            },
        },
    },
    dependencies = {
        {
            "mason-org/mason.nvim",
            opts = {
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            }
        },
        { "neovim/nvim-lspconfig" },
        { "saghen/blink.cmp" },
    },
    config = function(_, opts)

        print('alarm111')
        require("mason-lspconfig").setup(opts)



        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                local buffer_options = { buffer = args.buf }

                -- LSP Keybindings nur wenn Client die Methode unterstützt
                if client:supports_method('textDocument/declaration') then
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, buffer_options)
                end

                if client:supports_method('textDocument/definition') then
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, buffer_options)
                end

                if client:supports_method('textDocument/hover') then
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, buffer_options)
                end

                if client:supports_method('textDocument/implementation') then
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, buffer_options)
                end

                if client:supports_method('textDocument/signatureHelp') then
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, buffer_options)
                    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, buffer_options)
                end

                if client:supports_method('textDocument/typeDefinition') then
                    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, buffer_options)
                end

                if client:supports_method('textDocument/rename') then
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, buffer_options)
                end

                if client:supports_method('textDocument/codeAction') then
                    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, buffer_options)
                end

                if client:supports_method('textDocument/references') then
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, buffer_options)
                end

                if client:supports_method('textDocument/documentSymbol') then
                    vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol, buffer_options)
                end

                if client:supports_method('workspace/symbol') then
                    vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, buffer_options)
                end

                -- Formatierung
                if client:supports_method('textDocument/formatting') then
                    vim.keymap.set('n', '<leader>ff', function()
                        vim.lsp.buf.format { async = true }
                    end, buffer_options)

                    -- Auto-Format beim Speichern (optional)
                    -- vim.api.nvim_create_autocmd('BufWritePre', {
                    --     group = vim.api.nvim_create_augroup('LspFormatting', { clear = false }),
                    --     buffer = args.buf,
                    --     callback = function()
                    --         vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                    --     end,
                    -- })
                end

                if client:supports_method('textDocument/rangeFormatting') then
                    vim.keymap.set('v', '<leader>ff', function()
                        vim.lsp.buf.format { async = true }
                    end, buffer_options)
                end

                -- Workspace-Funktionen
                vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, buffer_options)
                vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, buffer_options)
                vim.keymap.set('n', '<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, buffer_options)

                -- Document Highlighting (wenn unterstützt)
                if client:supports_method('textDocument/documentHighlight') then
                    vim.keymap.set('n', '<leader>h', vim.lsp.buf.document_highlight, buffer_options)
                    vim.keymap.set('n', '<leader>H', vim.lsp.buf.clear_references, buffer_options)

                    -- Auto-highlight beim Cursor stillstand
                    vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        group = 'lsp_document_highlight',
                        buffer = args.buf,
                        callback = vim.lsp.buf.document_highlight,
                    })
                    vim.api.nvim_create_autocmd('CursorMoved', {
                        group = 'lsp_document_highlight',
                        buffer = args.buf,
                        callback = vim.lsp.buf.clear_references,
                    })
                end

                -- Inlay Hints (wenn unterstützt)
                if client:supports_method('textDocument/inlayHint') then
                    vim.keymap.set('n', '<leader>ih', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                    end, buffer_options)
                end

                -- Completion aktivieren (wenn unterstützt)
                -- if client:supports_method('textDocument/completion') then
                --     vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
                -- end
            end,
        })

        -- Diagnostic Keybindings (global, nicht client-spezifisch)
        vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Open Diagnostic Float' })
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Set Diagnostic List' })

        -- Springe zum ersten/letzten Diagnostic im Buffer
        vm.keymap.set('n', '[D', function() vim.diagnostic.goto_prev({ count = math.huge }) end)
        vim.keymap.set('n', ']D', function() vim.diagnostic.goto_next({ count = math.huge }) end)

        print('alarm')


        local lspconfig = require('lspconfig')
        for server, config in pairs(opts.servers) do

            if server == "jdtls" then
                return true
            end

            config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
            lspconfig[server].setup(config)
        end

        -- Diagnostic Konfiguration
        -- vim.diagnostic.config({
        --     virtual_text = true,
        --     signs = true,
        --     underline = true,
        --     update_in_insert = false,
        --     severity_sort = true,
        --     float = {
        --         border = 'rounded',
        --         source = 'always',
        --         header = '',
        --         prefix = '',
        --     },
        -- })

        -- Diagnostic Signs
        -- local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
        -- for type, icon in pairs(signs) do
        --     local hl = "DiagnosticSign" .. type
        --     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        -- end
    end
}
