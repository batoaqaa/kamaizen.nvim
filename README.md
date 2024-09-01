# KamaiZen-nvim

Neovim plugin to integrate the [KamaiZen Language Server](https://github.com/IbrahimShahzad/KamaiZen) for Kamailio configuration files.

## Installation

### Basic Installation (recommended)

1. Clone this repo abd Install the KamaiZen Language Server by running the following script:

```bash
chmod +x install.sh
./install.sh
```

2. This should install and export PATH to the bashrc file. If you are using a different shell, you can manually add the following line to your shell configuration file:

```bash
export PATH=$PATH:$HOME/.local/bin
```

3. In Neovim, start the language server by running for the cfg file-type by adding the following:

```lua
local client = vim.lsp.start_client {
  cmd = { 'KamaiZen' },
  name = 'KamaiZen',
  settings = {
    kamaizen = {
      logLevel = 1,
      kamailioSourcePath = '/home/ibrahim/work/kamailio/', -- Path to Kamailio source code
    },
  },
}

if not client then
  vim.notify('Failed to start LSP client', vim.log.levels.ERROR)
  return
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'kamailio_cfg',
  callback = function()
    vim.lsp.buf_attach_client(0, client)
  end,
})
```

### With mason 

THIS STILL NEEDS TO BE TESTED

> **Note:** KamaiZen requires the Kamailio source code to be present on the system. The path to the source code must be provided in the KamaiZen configuration.
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
