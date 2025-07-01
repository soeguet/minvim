return {
    'nvim-telescope/telescope.nvim',
    --tag = '0.1.8',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
        { '<c-p>', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
        { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live Grep' },
        { '<leader>fr', '<cmd>Telescope resume<cr>', desc = 'Resume' },
        { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
        { '<leader><leader>', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
        { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help Tags' },
        { '<leader>fc', '<cmd>Telescope commands<cr>', desc = 'Commands' },
    },
    opts={}
}
