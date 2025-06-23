return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function()
        -- require("which-key").show({ global = false })
        -- Show hydra mode for changing windows
        require("which-key").show({
            keys = "<c-w>",
            loop = true, -- this will keep the popup open until you hit <esc>
        })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
