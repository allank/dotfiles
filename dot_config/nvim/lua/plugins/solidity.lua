-- Minimal Solidity support without the broken solidity-ls LSP
-- The solidity-ls package has a corrupted WASM module causing constant errors
-- See: https://github.com/folke/snacks.nvim/discussions/2264
-- This provides treesitter syntax highlighting only (formatting is in formatting.lua)
return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = { "solidity" },
		},
	},
}
