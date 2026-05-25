return {
  -- LSP Config
  { "neovim/nvim-lspconfig" },
  -- Mason for managing servers
  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim" },
  -- Completion Plugins
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip", -- optional, but recommended for snippets
      "saadparwaiz1/cmp_luasnip", -- optional, for LuaSnip integration
    },
  },
  -- Optional: LSP status UI
  --  { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
}

