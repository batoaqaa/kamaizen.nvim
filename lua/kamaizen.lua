local M = {}

M.setup = function()
	local cmd = { "KamaiZen" }

	local client = vim.lsp.start_client({
		cmd = cmd,
		name = "KamaiZen",
	})

	if not client then
		vim.notify("KamaiZen failed to connect")
		return
	end

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "kamailio",
		callback = function()
			vim.lsp.buf_attach_client(0, client)
		end,
	})
end

return M
