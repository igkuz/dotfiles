# Neovim Config Guide

This repository lives at `~/.config/nvim` and is driven by `lazy.nvim`. The files are intentionally small so you can glance at them when you forget how things connect.

## Load Order

`init.lua` executes modules in this order:

1. `config.options` – core `vim.opt` tweaks.
2. `config.keymaps` – global mappings that do not depend on plugins.
3. `config.lazy` – bootstraps `lazy.nvim`, sets `mapleader = " "` and `maplocalleader = "\\"`, and loads everything under `lua/plugins`.
4. `config.lsp` – Mason/LSP wiring and shared `on_attach` keybindings for diagnostics, definitions, formatting, etc.
5. `config.cmp` – completion UI setup (`nvim-cmp` + `LuaSnip`).
6. `set` – final odds and ends (disables unused language providers).

Neovim sources each module only once per session, so the order above is effectively the startup pipeline.

## Config Modules

- `lua/config/options.lua`: cursorline, relative numbers, 2-space indent, Treesitter fold expr (on 0.10+), smooth scrolling, and custom fill characters.
- `lua/config/keymaps.lua`: window navigation on `<C-h/j/k/l>` and a visual-mode `<leader>p` paste that keeps the unnamed register intact.
- `lua/config/lsp.lua`: bootstraps Mason (`ensure_installed = { "lua_ls", "pyright", "ts_ls" }`), defines shared `capabilities` from `cmp-nvim-lsp`, and an `on_attach` helper that sets all LSP mappings buffer-locally (`gd`, `gD`, `<leader>rn`, `<leader>e`, `[d`, `]d`, `<leader>f`, Telescope-based references/symbols, etc.). Server-specific bits:
  - `ts_ls`: gets the shared `on_attach`/`capabilities`.
  - `lua_ls`: same settings plus diagnostics tweak so `vim` is treated as a known global and third-party workspace checks are disabled.
- `lua/config/cmp.lua`: `nvim-cmp` wiring with `<C-n>` to trigger completion, Tab/Shift-Tab to cycle through items or jump through `LuaSnip`, and `<CR>` to confirm.
- `lua/set.lua`: disables unused providers (`python3`, `ruby`, `perl`, `node`) to speed up startup.

## Plugin Layout

Lazy reads `lua/plugins/init.lua`, which re-exports smaller plugin specs:

- `plugins/colorscheme.lua`: installs `catppuccin` (Mocha flavour) and loads it first so other plugins inherit the palette.
- `plugins/telescope.lua`: `nvim-telescope/telescope.nvim` with `<leader>ff`, `<leader>fg`, `<leader>fb`, `<leader>fh`.
- `plugins/treesitter.lua`: `nvim-treesitter` with `:TSUpdate` auto-run plus a startup install list for the languages you edit most; each `FileType` buffer starts Treesitter highlighting/indent when a parser is available.
- `plugins/git.lua`: lazy-loads `vim-fugitive` on first use (`event = "VeryLazy"`).
- `plugins/lsp.lua`: collects the infrastructure bits (`nvim-lspconfig`, `mason.nvim`, `mason-lspconfig.nvim`, `nvim-cmp` and companions). Mason installs binaries; `config.lsp` handles startup/attachment logic.

`lazy-lock.json` pins plugin commit hashes so reinstalls stay reproducible.

## Tips & Reminders

- Leader key is **Space**. Examples: `<leader>e` shows line diagnostics via `vim.diagnostic.open_float`; `<leader>rn` renames; `<leader>ff` starts Telescope file search.
- Use `<C-o>` / `<C-i>` to move backward/forward in the jump list after `gD`, `gd`, etc.
- To inspect LSP mappings or see where something was last defined, `:verbose nmap <lhs>` prints the source file/line.
- `:Mason` shows which language servers and tools are installed; `:LspInfo` confirms which clients are attached to the current buffer.

Feel free to append per-language tweaks under `lua/config` (sourced via `init.lua`) or drop one-off plugin specs into `lua/plugins/*.lua` and import them through `plugins/init.lua`.
