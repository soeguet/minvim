return {
    'nvim-telescope/telescope.nvim',
    --tag = '0.1.8',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { '<leader>sf',       '<cmd>Telescope find_files<cr>',             desc = 'Find Files' },
        { '<c-p>',            '<cmd>Telescope find_files<cr>',             desc = 'Find Files' },
        { '<leader>sg',       '<cmd>Telescope live_grep<cr>',              desc = 'Live Grep' },
        { '<leader>sr',       '<cmd>Telescope resume<cr>',                 desc = 'Resume' },
        { '<leader>sb',       '<cmd>Telescope buffers<cr>',                desc = 'Buffers' },
        { '<leader><leader>', '<cmd>Telescope buffers<cr>',                desc = 'Buffers' },
        { '<leader>sh',       '<cmd>Telescope help_tags<cr>',              desc = 'Help Tags' },
        { '<leader>sc',       '<cmd>Telescope commands<cr>',               desc = 'Commands' },
        { '<leader>ss',       '<cmd>Telescope lsp_document_symbols<cr>',   desc = 'LSP Document Symbols' },
        { '<leader>sd',       '<cmd>Telescope diagnostics<cr>',            desc = 'Diagnostics' },
        { '<leader>so',       '<cmd>Telescope oldfiles only_cwd=true<cr>', desc = 'Old Files' },
        { '<leader>st',       '<cmd>Telescope live_grep<cr>',              desc = 'Live Grep' },
        { '<leader>sw',       '<cmd>Telescope grep_string<cr>',            desc = 'Grep String' },
    },
    config = function()
        require('telescope').setup({
            defaults = {
                path_display = function(opts, path)
                    local tail = require("telescope.utils").path_tail(path)
                    return string.format("%s ___ %s", tail, path)
                end,
                file_ignore_patterns = {
                    'node_modules',
                    '%.pdf',
                    '.git/',
                    '.cache',
                    '.next',
                    'dist',
                    'build',
                    'vendor',
                    '__pycache__',
                    'yarn%.lock', -- Lua pattern für yarn.lock
                    'package%-lock%.json',
                    'target',
                },
                preview = {
                    treesitter = true,     -- Aktiviert Treesitter für Syntax-Highlighting
                    highlight_limit = 256, -- Limit für große Dateien
                },
            },
            pickers = {
                find_files = {
                    preview = {
                        treesitter = true,
                    },
                },
            },
        })
    end,
}
