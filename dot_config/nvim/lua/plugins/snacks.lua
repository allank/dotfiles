return {
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				enabled = true,
				-- Suppress "No results found for select" notifications
				sources = {
					select = {
						-- Don't show notification when no results
						on_show = function(picker)
							if picker:empty() then
								picker:close()
								return false
							end
						end,
					},
				},
			},
		},
		keys = {
			-- File operations (matching original Telescope bindings)
			{ "<leader>sf", function() Snacks.picker.files() end, desc = "[S]earch [F]iles" },
			{ "<leader>sb", function() Snacks.picker.explorer() end, desc = "[S]earch by [B]rowsing" },
			{ "<leader><leader>", function() Snacks.picker.buffers() end, desc = "Find existing buffers" },

			-- Search operations
			{ "<leader>/", function() Snacks.picker.lines() end, desc = "[/] Fuzzily search in current buffer" },
			{ "<leader>s/", function() Snacks.picker.grep_buffers() end, desc = "[S]earch [/] in Open Files" },
			{ "<leader>sg", function() Snacks.picker.grep() end, desc = "[S]earch by [G]rep" },
			{ "<leader>sw", function() Snacks.picker.grep_word() end, desc = "[S]earch current [W]ord" },
			{ "<leader>ss", function() Snacks.picker.pickers() end, desc = "[S]earch [S]elect Picker" },
			{ "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "[S]earch [D]iagnostics" },
			{ "<leader>sr", function() Snacks.picker.resume() end, desc = "[S]earch [R]esume" },
			{ "<leader>s.", function() Snacks.picker.recent() end, desc = "[S]earch Recent Files" },
			{ "<leader>sh", function() Snacks.picker.help() end, desc = "[S]earch [H]elp" },
			{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "[S]earch [K]eymaps" },
			{ "<leader>sn", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "[S]earch [N]eovim files" },

			-- LSP pickers (replacing Telescope LSP pickers)
			{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
			{ "gr", function() Snacks.picker.lsp_references() end, desc = "Goto References" },
			{ "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
			{ "<leader>D", function() Snacks.picker.lsp_type_definitions() end, desc = "Type Definition" },
			{ "<leader>ds", function() Snacks.picker.lsp_symbols() end, desc = "Document Symbols" },
			{ "<leader>ws", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace Symbols" },
		},
	},
}
