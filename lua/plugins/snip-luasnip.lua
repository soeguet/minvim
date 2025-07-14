return {
    'L3MON4D3/LuaSnip',

    dependencies = {
        { 'rafamadriz/friendly-snippets' }
    },
    version = 'v2.*',
    build = "make install_jsregexp",

    config = function()
        local ok
        -- the required files are handling the add_snippets part
        -- require('luasnip.loaders.from_vscode').lazy_load()

        -- load snippets from path/of/your/nvim/config/my-cool-snippets
        require("luasnip.loaders.from_vscode").lazy_load()

        ok, _ = pcall(require, 'snippets.all-snippets')
        ok, _ = pcall(require, 'snippets.python-snippets')
        -- ok, _ = pcall(require, 'snippets.java-snippets')
        -- ok, _ = pcall(require, 'snippets.lua-snippets')
        -- ok, _ = pcall(require, 'snippets.snippets')
        -- ok, _ = pcall(require, 'snippets.typescript-snippets')
        -- ok, _ = pcall(require, 'snippets.typescriptreact-snippets')
        if not ok then
            print('could not load all snippets')
        end

        local ls = require('luasnip')

        local function reload_package(package_name)
            for module_name, _ in pairs(package.loaded) do
                if string.find(module_name, '^' .. package_name) then
                    package.loaded[module_name] = nil
                    require(module_name)
                    print('test')
                end
            end
        end

        local function refresh_snippets()
            ls.cleanup()
            reload_package('snippets')
            print('test2')
        end

        local set = vim.keymap.set

        local mode = { 'i', 's' }
        local normal = { 'n' }

        set(normal, ',r', refresh_snippets)
    end,
}
