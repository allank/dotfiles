-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
-- DEBUG: Mock vim.ui.select to find what's calling it with empty items
-- See: https://github.com/folke/snacks.nvim/discussions/2264
-- Remove this after debugging is complete
vim.schedule(function()
	local orig_select = vim.ui.select -- NOTE: Snacks.picker.select
	vim.ui.select = function(items, opts, on_choice) ---@diagnostic disable-line: duplicate-set-field
		if not items or vim.tbl_isempty(items) then
			-- The error will create a stack trace
			error("Force an error")
		end
		return orig_select(items, opts, on_choice)
	end
end)