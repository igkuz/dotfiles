return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  keys = {
    {
      "<leader>e",
      function()
        local uv = vim.uv or vim.loop
        require("neo-tree.command").execute({ toggle = true, dir = uv.cwd() })
      end,
      desc = "Toggle file explorer",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
        filtered_items = {
          hide_dotfiles = false,
        },
      },
      window = {
        width = 32,
        mappings = {
          -- Use <Tab> to expand/collapse so it doesn't collide with your <Space> leader
          ["<Tab>"] = "toggle_node",
        },
      },
    })
  end,
}
