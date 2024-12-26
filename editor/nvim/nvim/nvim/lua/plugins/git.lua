return {
	{
		"airblade/vim-gitgutter",
		config = function()
			require('vim-gitgutter').setup()
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
