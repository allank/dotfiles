return {
	-- Extend mason to ensure tools are installed
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"gopls",
				"goimports",
				"pyright",
				"ruff",
				"stylua",
				"isort",
			},
		},
	},
}