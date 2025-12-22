return {
	-- Extend mason to ensure tools are installed
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"gopls",
				"goimports",
				"pyright",
				"ruff",
				"stylua",
				"isort",
				-- NOTE: solidity-ls removed due to constant "No results found for select" issue
			},
		},
	},
}