# KamaiZen-nvim

Neovim plugin to integrate the KamaiZen LSP server for Kamailio configuration files.

## Installation

Use your favorite Neovim plugin manager to install this plugin. Here's an example using `mason`:

```lua
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'kamaizen' },
})

local lspconfig = require('lspconfig')

lspconfig.kamaizen.setup({
  cmd = { 'KamaiZen' },
  filetypes = { 'kamailio_cfg' },
})
```
