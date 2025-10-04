vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("autoupdate", {}),
	callback = function()
		require("lazy").update({ show = false })
	end,
})
