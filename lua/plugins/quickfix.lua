return {
    {
        'kevinhwang91/nvim-bqf',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        ft = 'qf',
        config = function ()
            require('bqf').setup({
                preview = {
                    winblend =  0
                },
            })
        end
    }
}
