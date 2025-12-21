return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "ruff_format" },
				go = { "goimports", "gofmt" },
				solidity = { "forge_fmt" },
			},
		},
	},
}