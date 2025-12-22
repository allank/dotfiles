-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- =============================================================================
-- DEBUG: LSP Response Debugging
-- See: https://github.com/folke/snacks.nvim/discussions/2264
-- Remove this entire section after debugging is complete
-- =============================================================================

-- Enable verbose LSP tracing
vim.lsp.set_log_level("debug")

-- Wrap the code action handler to see what's being passed
vim.schedule(function()
	local orig_code_action_handler = vim.lsp.handlers["textDocument/codeAction"]
	vim.lsp.handlers["textDocument/codeAction"] = function(err, result, ctx, config)
		local log_file = vim.fn.stdpath("cache") .. "/lsp_code_action_debug.log"
		local f = io.open(log_file, "a")
		if f then
			f:write(os.date("%Y-%m-%d %H:%M:%S") .. "\n")
			f:write("Client: " .. (ctx.client_id and vim.lsp.get_client_by_id(ctx.client_id).name or "unknown") .. "\n")
			f:write("Error: " .. vim.inspect(err or "nil") .. "\n")
			f:write("Result: " .. vim.inspect(result or "nil") .. "\n")
			f:write("---\n\n")
			f:close()
		end
		-- Also show in Neovim for immediate visibility
		if result and #result == 0 then
			vim.notify(
				"[DEBUG] Empty code actions from: " .. (ctx.client_id and vim.lsp.get_client_by_id(ctx.client_id).name or "unknown"),
				vim.log.levels.WARN
			)
		end
		if orig_code_action_handler then
			return orig_code_action_handler(err, result, ctx, config)
		end
	end

	-- Also wrap vim.ui.select to see what's calling it
	local orig_select = vim.ui.select
	vim.ui.select = function(items, opts, on_choice)
		local log_file = vim.fn.stdpath("cache") .. "/vim_ui_select_debug.log"
		local f = io.open(log_file, "a")
		if f then
			f:write(os.date("%Y-%m-%d %H:%M:%S") .. "\n")
			f:write("Items count: " .. (items and #items or "nil") .. "\n")
			f:write("Opts: " .. vim.inspect(opts or {}) .. "\n")
			if not items or #items == 0 then
				f:write("STACKTRACE:\n" .. debug.traceback() .. "\n")
			end
			f:write("---\n\n")
			f:close()
		end
		return orig_select(items, opts, on_choice)
	end
end)
-- =============================================================================
-- END DEBUG
-- =============================================================================