local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

-----------------------------------------------------------------------------
-- Plugins
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- Editor settings
-----------------------------------------------------------------------------

vim.opt.scrolloff = 2
vim.opt.wrap = false
vim.opt.signcolumn = 'yes'
vim.opt.hidden = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.undofile = true
vim.opt.wildmode = 'list:longest'
vim.opt.wildignore = '.hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site'
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- vim.opt.cindent = true
-- http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
-- vim.opt.timeoutlen = 300

vim.g.vim_markdown_new_list_item_indent = 0
vim.g.vim_markdown_auto_insert_bullets = 0
vim.g.vim_markdown_frontmatter = 1

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

