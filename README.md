# kamaizen-nvim

Neovim plugin to integrate the [KamaiZen Language Server](https://github.com/IbrahimShahzad/KamaiZen) and tree-sitter grammar for Kamailio configuration files.

## Installation

with [lazy.nvim](https://github.com/folke/lazy.nvim):
```lua
    {
      'IbrahimShahzad/kamaizen.nvim',
      dependencies = {
        { 'IbrahimShahzad/KamaiZen', build = 'go build' },
      },
      opts = {
        settings = {
          kamaizen = {
            enableDeprecatedCommentHint = false, -- to enable hints for '#' comments
            -- update path to a kamailio source folder if the config is in a different
            -- directory
            KamailioSourcePath = vim.fn.getcwd(),
            loglevel = 3,
          },
        },
      },
    }
```

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.
