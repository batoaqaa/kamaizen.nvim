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
  cmd = { '/path/to/.local/bin/KamaiZen' }, -- update this path
  name = 'KamaiZen',
  settings = {
    kamaizen = {
      logLevel = 1,
      kamailioSourcePath = '/path/to/kamailio/', -- Path to Kamailio source code
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
