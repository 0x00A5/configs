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
		"wincent/base16-nvim",
		lazy = false, -- load at start
		priority = 1000, -- load first
		config = function()
			vim.cmd([[colorscheme gruvbox-material-dark-hard]])
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
		'itchyny/lightline.vim',
		lazy = false, -- also load at start since it's UI
		config = function()
			-- no need to also show mode in cmd line when we have bar
			vim.o.showmode = false
			vim.g.lightline = {
				colorscheme = 'darcula',
				active = {
					left = {
						{ 'mode', 'paste' },
						{ 'readonly', 'filename', 'modified' }
					},
					right = {
						{ 'lineinfo' },
						{ 'percent' },
						{ 'fileencoding', 'filetype' },
						{ 'lspstatus' },
					},
				},
				component_function = {
					filename = 'LightlineFilename',
					lspstatus = 'LspStatus',
				},
			}
			function LightlineFilenameInLua(opts)
				if vim.fn.expand('%:t') == '' then
					return '[No Name]'
				else
					return vim.fn.getreg('%')
				end
			end
			-- get lsp statusline
			function LspStatusInLua()
				if #vim.lsp.buf_get_clients() > 0 then
					return require('lsp-status').status()
				else
					return ''
				end
			end
			-- https://github.com/itchyny/lightline.vim/issues/657
			vim.api.nvim_exec(
				[[
				function! g:LspStatus()
					return v:lua.LspStatusInLua()
				endfunction
				]],
				true
			)
			vim.api.nvim_exec(
				[[
				function! g:LightlineFilename()
					return v:lua.LightlineFilenameInLua()
				endfunction
				]],
				true
			)
		end
	},
	{
		'andymass/vim-matchup',
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end
	},
}
