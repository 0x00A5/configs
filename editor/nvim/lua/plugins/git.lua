return {
	{
		"mhinz/vim-signify",
		config = function()
			-- hunk mappings
			vim.keymap.set('n', '<leader>hd', '<cmd>SignifyDiff<cr>')
			vim.keymap.set('n', '<leader>hp', '<cmd>SignifyHunkDiff<cr>')
			vim.keymap.set('n', '<leader>hu', '<cmd>SignifyHunkUndo<cr>')
		end
	},
	-- auto-cd to root of git project
	{
		'notjedi/nvim-rooter.lua',
		config = function()
			require('nvim-rooter').setup()
		end
	},
	-- show git blame
	{
		"FabijanZulj/blame.nvim",
		config = function()
			require('blame').setup()
		end,
	},
}
