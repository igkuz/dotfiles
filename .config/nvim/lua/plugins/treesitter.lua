return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ok, treesitter = pcall(require, "nvim-treesitter")
    if not ok or type(treesitter.setup) ~= "function" or type(treesitter.install) ~= "function" then
      vim.schedule(function()
        vim.notify("nvim-treesitter needs to be updated. Run :Lazy sync.", vim.log.levels.WARN)
      end)
      return
    end

    local languages = {
      "bash",
      "c",
      "css",
      "go",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "ruby",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    }

    treesitter.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })
    treesitter.install(languages)

    local group = vim.api.nvim_create_augroup("user-treesitter", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      callback = function(args)
        if vim.bo[args.buf].buftype ~= "" then
          return
        end

        local ok_start = pcall(vim.treesitter.start, args.buf)
        if ok_start then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
