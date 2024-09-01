local M = {}

local config = require("kamaizen.config")

function M.setup(user_config)
	config.setup(user_config)

	local lsp_config = {
		name = "KamaiZen",
		cmd = { "KamaiZen" },
		filetypes = { "kamailio" },
		root_dir = vim.loop.cwd,
		settings = {
			kamaizen = config.config,
		},
		handlers = {
			["workspace/configuration"] = function(_, _, params)
				return { config.config }
			end,
		},
	}

	local client = vim.lsp.start_client(lsp_config)

	if not client then
		vim.notify("KamaiZen LSP failed to start")
		return
	end

	vim.api.nvim_create_autocmd("FileType", {
		pattern = lsp_config.filetypes,
		callback = function()
			vim.lsp.buf_attach_client(0, client)
		end,
	})
end

return M
