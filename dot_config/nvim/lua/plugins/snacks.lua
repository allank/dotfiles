return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			picker = { enabled = true },
		},
		keys = {
			-- File operations
			{ "<leader>sf", function() Snacks.picker.files() end, desc = "[S]earch [F]iles" },
			{ "<leader>sb", function() Snacks.picker.explorer() end, desc = "[S]earch by [B]rowsing" },
			{ "<leader><leader>", function() Snacks.picker.buffers() end, desc = "Find existing buffers" },

			-- Search operations
			{ "<leader>/", function() Snacks.picker.lines() end, desc = "[/] Fuzzily search in current buffer" },
			{ "<leader>s/", function() Snacks.picker.grep_buffers() end, desc = "[S]earch [/] in Open Files" },
			{ "<leader>sg", function() Snacks.picker.grep() end, desc = "[S]earch by [G]rep" },
			{ "<leader>sw", function() Snacks.picker.grep_word() end, desc = "[S]earch current [W]ord" },
			{ "<leader>ss", function() Snacks.picker.pickers() end, desc = "[S]earch [S]elect Picker" },
			{ "<leader>sr", function() Snacks.picker.resume() end, desc = "[S]earch [R]esume" },
			{ "<leader>s.", function() Snacks.picker.recent() end, desc = "[S]earch Recent Files" },
			{ "<leader>sh", function() Snacks.picker.help() end, desc = "[S]earch [H]elp" },
			{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "[S]earch [K]eymaps" },
			{ "<leader>sn", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "[S]earch [N]eovim files" },
		},
	},
}
