return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function() require("conform").format({ async = true, lsp_format = "never" }) end,
				mode = { "n", "v" },
				desc = "[C]ode [F]ormat",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "ruff_format" },
				go = { "goimports", "gofmt" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "never",
			},
		},
	},
}
