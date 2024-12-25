return {
	{
		"airblade/vim-gitgutter",
		lazy = false,
	},
	-- auto-cd to root of git project
	{
		'notjedi/nvim-rooter.lua',
		config = function()
			require('nvim-rooter').setup()
		end
	},
}
