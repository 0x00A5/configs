return {
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			require('nvim-tree').setup()
			-- quick toggle
			vim.keymap.set('n', '<leader>nt', '<cmd>NvimTreeToggle<cr>')
		end
	},
	{
		'christoomey/vim-tmux-navigator',
		lazy = false,
	},
	-- main color scheme
	{
		'catppuccin/nvim', 
		name = 'catppuccin', 
		lazy = false, -- load at start
		priority = 1000, -- load first
		config = function()
			require("catppuccin").setup({
				auto_integrations = true,
			})
			vim.cmd([[colorscheme catppuccin-mocha]])
			vim.o.background = 'dark'
			-- Make comments more prominent -- they are important.
			local bools = vim.api.nvim_get_hl(0, { name = 'Boolean' })
			vim.api.nvim_set_hl(0, 'Comment', bools)
			-- Make it clearly visible which argument we're at.
			local marked = vim.api.nvim_get_hl(0, { name = 'PMenu' })
			vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true })
		end
	},
	{
		'nvim-lualine/lualine.nvim',
		lazy = false, -- also load at start since it's UI
		dependencies = {
			'nvim-tree/nvim-web-devicons',
		},
		config = function()
			-- no need to also show mode in cmd line when we have bar
			vim.o.showmode = false

			local function lsp_status()
				local clients = vim.lsp.get_clients({ bufnr = 0 })
				if #clients == 0 then
					return ''
				end

				local msg = vim.lsp.status()
				if msg ~= nil and msg ~= '' then
					-- Escape statusline control chars from LSP progress text.
					return msg:gsub('%%', '%%%%')
				end

				local names = {}
				for _, client in ipairs(clients) do
					table.insert(names, client.name)
				end
				return table.concat(names, ',')
			end

			require('lualine').setup({
				options = {
					theme = 'catppuccin-mocha',
					globalstatus = true,
					component_separators = { left = '|', right = '|' },
					section_separators = { left = '', right = '' },
				},
				sections = {
					lualine_a = { 'mode' },
					lualine_b = { 'branch' },
					lualine_c = {
						{
							'filename',
							path = 1,
						},
						{
							'diagnostics',
						},
					},
					lualine_x = {
							'encoding',
							'filetype',
							{
								lsp_status,
							},
						},
					lualine_y = { 'progress' },
					lualine_z = { 'location' },
				},
			})

			vim.api.nvim_create_autocmd({ 'LspAttach', 'LspDetach', 'LspProgress', 'DiagnosticChanged', 'BufEnter' }, {
				callback = function()
					require('lualine').refresh()
				end,
			})
		end
	},
	{
		'andymass/vim-matchup',
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end
	}
}
