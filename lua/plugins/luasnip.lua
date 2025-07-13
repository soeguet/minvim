return {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = "make install_jsregexp",

    config = function()
        local ok
        -- the required files are handling the add_snippets part
        require('luasnip.loaders.from_vscode').lazy_load()
        ok, _ = pcall(require, 'snippets.all-snippets')
        ok, _ = pcall(require, 'snippets.java-snippets')
        ok, _ = pcall(require, 'snippets.lua-snippets')
        ok, _ = pcall(require, 'snippets.snippets')
        ok, _ = pcall(require, 'snippets.typescript-snippets')
        ok, _ = pcall(require, 'snippets.typescriptreact-snippets')
        if not ok then
            print('could not load all snippets')
        end
    end,
}
