-- set leader key
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

-----------------------------------------------------------------------------
-- Plugins
-----------------------------------------------------------------------------
require("config.lazy")

-----------------------------------------------------------------------------
-- Preferences
-----------------------------------------------------------------------------
--- do not fold
vim.opt.foldenable = false
vim.opt.foldmethod = 'manual'
vim.opt.foldlevelstart = 99

vim.opt.scrolloff = 2

-- do not wrap
vim.opt.wrap = false

vim.opt.signcolumn = 'yes'
vim.opt.hidden = true

-- keep current split top left
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.undofile = true

-- wildmenu
vim.opt.wildmode = 'list:longest'
vim.opt.wildignore = '.hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site'

vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = false

-- ignore case in searches unless uppercases in search item
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- show relative line number
vim.opt.relativenumber = true
-- show absolute current line number
vim.opt.number = true

-- no beeps
vim.opt.vb = true

-- more useful diffs (nvim -d)
--- by ignoring whitespace
vim.opt.diffopt:append('iwhite')
--- and using a smarter algorithm
--- https://vimways.org/2018/the-power-of-diff/
--- https://stackoverflow.com/questions/32365271/whats-the-difference-between-git-diff-patience-and-git-diff-histogram
--- https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
vim.opt.diffopt:append('algorithm:histogram')
vim.opt.diffopt:append('indent-heuristic')

-- show a column at 100 characters as a guide for long lines
vim.opt.colorcolumn = '100'

-- show more hidden characters
-- also, show tabs nicer
vim.opt.listchars = 'tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•'

-- vim.opt.cmdheight = 2
-- vim.opt.cindent = true
-- http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
-- vim.opt.timeoutlen = 300

--" Wrapping options
--set formatoptions=tc " wrap text and comments using textwidth
--set formatoptions+=r " continue comments when pressing ENTER in I mode
--set formatoptions+=q " enable formatting of comments with gq
--set formatoptions+=n " detect lists for formatting
--set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

--" Search
--set incsearch
--set gdefault

--set noshowmode
--set nojoinspaces
--filetype plugin indent on

-----------------------------------------------------------------------------
-- Autocommands
-----------------------------------------------------------------------------
-- highlight yanked text
vim.api.nvim_create_autocmd(
	'TextYankPost',
	{
		pattern = '*',
		command = 'silent! lua vim.highlight.on_yank({ timeout = 500 })'
	}
)
-- jump to last edit position on opening file
vim.api.nvim_create_autocmd(
	'BufReadPost',
	{
		pattern = '*',
		callback = function(ev)
			if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
				-- except for in git commit messages
				-- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
				if not vim.fn.expand('%:p'):find('.git', 1, true) then
					vim.cmd('exe "normal! g\'\\""')
				end
			end
		end
	}
)
-- prevent accidental writes to buffers that shouldn't be edited
vim.api.nvim_create_autocmd('BufRead', { pattern = '*.orig', command = 'set readonly' })
vim.api.nvim_create_autocmd('BufRead', { pattern = '*.pacnew', command = 'set readonly' })
-- leave paste mode when leaving insert mode (if it was on)
vim.api.nvim_create_autocmd('InsertLeave', { pattern = '*', command = 'set nopaste' })

-----------------------------------------------------------------------------
-- Hotkeys
-----------------------------------------------------------------------------
-- quick save
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>')
-- always center search results
vim.keymap.set('n', 'n', 'nzz', { silent = true })
vim.keymap.set('n', 'N', 'Nzz', { silent = true })
vim.keymap.set('n', '*', '*zz', { silent = true })
vim.keymap.set('n', '#', '#zz', { silent = true })
vim.keymap.set('n', 'g*', 'g*zz', { silent = true })
-- "very magic" (less escaping needed) regexes by default
vim.keymap.set('n', '?', '?\\v')
vim.keymap.set('n', '/', '/\\v')
vim.keymap.set('c', '%s/', '%sm/')

