# KamaiZen-nvim

Neovim plugin to integrate the [KamaiZen Language Server](https://github.com/IbrahimShahzad/KamaiZen) for Kamailio configuration files.

## Installation

Use [mason.nvim](https://github.com/williamboman/mason.nvim) to install KamaiZen:

```lua
return {
  'IbrahimShahzad/kamaizen.nvim',
  dependencies = { 'neovim/nvim-lspconfig' },
  ft = 'cfg',
  init = function()
    local k = require('lspconfig').kamaizen
    k.setup {
      cmd = { 'KamaiZen' },
      root_dir = function()
        return vim.loop.cwd()
      end,
      settings = {
        kamaizen = {
          logLevel = 'info',
          kamailioSourcePath = '/home/usr/path/kamailio/', -- Path to Kamailio source code
        },
      },
    }
  end,
}
```
