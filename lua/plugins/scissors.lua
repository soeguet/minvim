return {
  "chrisgrieser/nvim-scissors",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "L3MON4D3/LuaSnip",
  },
  opts = {
    snippetDir = vim.fn.stdpath("config") .. "/lua/snippets",
  },
  config = function(_, opts)
    require("scissors").setup(opts)
    require("luasnip.loaders.from_vscode").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
    })
  end,
}
