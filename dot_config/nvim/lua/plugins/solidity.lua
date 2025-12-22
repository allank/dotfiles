-- Minimal Solidity support without the problematic LSP
-- Only treesitter for syntax highlighting (formatter is in formatting.lua)
return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = { "solidity" },
		},
	},
}
