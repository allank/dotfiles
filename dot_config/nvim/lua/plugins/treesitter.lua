return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			local langs = { "lua", "markdown", "markdown_inline", "python", "go", "bash", "vimdoc", "query" }
			require("nvim-treesitter").setup()
			require("nvim-treesitter").install(langs)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "lua", "markdown", "python", "go", "bash", "help" },
				callback = function() vim.treesitter.start() end,
			})
		end,
	},
}
