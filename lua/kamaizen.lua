vim.api.nvim_create_autocmd("FileType", {
	pattern = "cfg",
	callback = function()
		require("kamaizen").setup({})
	end,
})
