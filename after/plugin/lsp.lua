local servers = {
    'gopls',
    'lua_ls',
    'vtsls',
    'pyright',
    'dockerls',
    'docker_compose_language_service'
}

local capabilities = require('cmp_nvim_lsp').default_capabilities() --nvim-cmp
local lsp_attach = function(client, buf)
    -- Example maps, set your own with vim.api.nvim_buf_set_keymap(buf, 'n', <lhs>, <rhs>, { desc = <desc> })
    -- or a plugin like which-key.nvim
    -- <lhs>        <rhs>                        <desc>
    -- 'K'          vim.lsp.buf.hover            'Hover Info'
    -- '<leader>qf' vim.diagnostic.setqflist     'Quickfix Diagnostics'
    -- '[d'         vim.diagnostic.goto_prev     'Previous Diagnostic'
    -- ']d'         vim.diagnostic.goto_next     'Next Diagnostic'
    -- '<leader>e'  vim.diagnostic.open_float    'Explain Diagnostic'
    -- '<leader>ca' vim.lsp.buf.code_action      'Code Action'
    -- '<leader>cr' vim.lsp.buf.rename           'Rename Symbol'
    -- '<leader>fs' vim.lsp.buf.document_symbol  'Document Symbols'
    -- '<leader>fS' vim.lsp.buf.workspace_symbol 'Workspace Symbols'
    -- '<leader>gq' vim.lsp.buf.formatting_sync  'Format File'

    vim.api.nvim_buf_set_option(buf, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')
    vim.api.nvim_buf_set_option(buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_option(buf, 'tagfunc', 'v:lua.vim.lsp.tagfunc')
end


-- local capabilities = require('blink.cmp').get_lsp_capabilities()
--
for _, server in ipairs(servers) do
    if server ~= 'jdtls' then
        vim.lsp.config(server, {
            capabilities = capabilities,
            on_attach = lsp_attach,
        })
    end
end

vim.lsp.enable(servers)


vim.api.nvim_create_autocmd('FileType', {
    pattern = 'java',
    callback = function()
        print('java file found')
        -- local ok, jdtls = pcall(require, 'jdtls.jdtls_setup')
        local jdtls = require('jdtls.jdtls_setup')
        jdtls.setup(capabilities)

    end
})
