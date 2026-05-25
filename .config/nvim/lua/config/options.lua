local opt = vim.opt

opt.cursorline = true       -- highlihgts the current line (and number)
opt.expandtab = true        -- use spaces, not tabs
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.number = true						-- Print line numbers
opt.relativenumber = true		-- Relative line numbers
opt.ruler = true
opt.shiftwidth = 2					-- An autoindent (with <<) is two spaces
opt.smartindent = true      -- I forgot what it does, copied from vimrc
opt.tabstop = 2 						-- Number of spaces tabs count for
opt.termguicolors = true    -- True color support
opt.wrap = false 						-- Disable line wrap

local markdown_group = vim.api.nvim_create_augroup("markdown-options", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = markdown_group,
  pattern = "markdown",
  callback = function()
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.wo.breakindent = true
  end,
})

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
  -- opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
  -- opt.foldmethod = "expr"
  -- opt.foldtext = ""
else
  opt.foldmethod = "indent"
  opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
end
