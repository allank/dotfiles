return {
	-- Agentic AI coding assistant
	{
		"carlos-algms/agentic.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			provider = "gemini-acp",
		},
		keys = {
			{ "<leader>aa", function() require("agentic").toggle() end, desc = "Toggle Agentic Chat" },
			{ "<leader>as", function() require("agentic").add_selection() end, mode = "v", desc = "Add selection to Agentic" },
			{ "<leader>af", function() require("agentic").add_file() end, desc = "Add file to Agentic" },
			{ "<leader>an", function() require("agentic").new_session() end, desc = "New Agentic session" },
		},
	},
}
