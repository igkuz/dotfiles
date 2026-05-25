-- lua/config/lsp.lua

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "jsonls", "lua_ls", "marksman", "pyright", "ts_ls" }, -- Add servers you want
  automatic_enable = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then desc = "LSP: " .. desc end
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("gd", vim.lsp.buf.definition, "Goto Definition")
  nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
  nmap("gi", vim.lsp.buf.implementation, "Goto Implementation")
  nmap("gr", require("telescope.builtin").lsp_references, "Goto References")
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
  nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
  nmap("<leader>ld", vim.diagnostic.open_float, "Show Line Diagnostics")
  nmap("[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
  nmap("]d", vim.diagnostic.goto_next, "Next Diagnostic")
  nmap("<leader>f", function() vim.lsp.buf.format { async = true } end, "Format Buffer")
end

vim.lsp.config("ts_ls", {
  on_attach = on_attach,
  capabilities = capabilities
})

vim.lsp.config("pyright", {
  on_attach = on_attach,
  capabilities = capabilities
})

vim.lsp.config("jsonls", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    json = {
      validate = { enable = true },
    },
  },
})

vim.lsp.config("marksman", {
  on_attach = on_attach,
  capabilities = capabilities
})

vim.lsp.config("lua_ls", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
    },
  },
})


-- lspconfig.ts_ls.setup({
--   capabilities = capabilities,
  -- on_attach = on_attach,
-- })

-- Copilot LSP for NES (Next Edit Suggestions)
-- Install server first: :MasonInstall copilot-language-server
-- Then sign in: :LspCopilotSignIn
vim.lsp.enable("copilot")
