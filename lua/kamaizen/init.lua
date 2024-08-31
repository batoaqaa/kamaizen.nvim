local config = require("kamaizen.config")

local M = {}

function M.setup(user_config)
	-- Apply user configuration
	config.setup(user_config)

	-- Start the LSP client using the configuration
	local client = vim.lsp.start_client(config.config)

	if not client then
		vim.notify("KamaiZen LSP failed to start")
		return
	end

	-- Auto-attach the LSP to the appropriate file types
	vim.api.nvim_create_autocmd("FileType", {
		pattern = config.config.filetypes,
		callback = function()
			vim.lsp.buf_attach_client(0, client)
		end,
	})
end

return M
