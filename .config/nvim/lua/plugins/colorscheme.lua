return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,  -- Ensures colorscheme loads first
    config = function()
      -- You can set up Catppuccin options here if you want, or leave empty for defaults
      require("catppuccin").setup({
				  flavour = "mocha", -- "latte", "frappe", "macchiato", "mocha"
					-- transparent_background = true,
					integrations = {
            cmp=true,
						treesitter = true,
						telescope = true,
					},
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}

