local servers = {
    "gopls",
    "lua_ls",
    "vtsls",
    "jdtls",
    "pyright",
    "dockerls",
    "docker_compose_language_service"
}

local capabilities = require('blink.cmp').get_lsp_capabilities()

for _, server in ipairs(servers) do
    if server ~= "jdtls" then  -- jdtls ausschließen falls nötig
        vim.lsp.config(server, {
            capabilities = capabilities
        })
    end
end

vim.lsp.enable(servers)
