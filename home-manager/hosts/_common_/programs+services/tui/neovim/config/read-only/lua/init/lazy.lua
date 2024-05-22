--[[
 _                              _
| | __ _ _____   _   _ ____   _(_)_ __ ___
| |/ _` |_  / | | | | '_ \ \ / / | '_ ` _ \
| | (_| |/ /| |_| |_| | | \ V /| | | | | | |
|_|\__,_/___|\__, (_)_| |_|\_/ |_|_| |_| |_|
             |___/
--]]

--[[/* Install lazy.nvim */]]

local install_dir = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(install_dir) then
	vim.system(
		{ 'git', 'clone', '--branch=stable', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', install_dir },
		{ text = true }
	):wait()
end

--[[/* Load plugins */]]

vim.g.lazy_event_file_read = { 'BufNewFile', 'BufReadPre' }

vim.opt.rtp:prepend(install_dir)
require('lazy').setup('plugins', {
	dev = { fallback = true, path = '~/Programming', patterns = { 'Iron-E' } },
	install = { colorscheme = { 'highlite', 'habamax' } },
	performance = { rtp = { disabled_plugins = {
		'gzip',
		'netrwPlugin',
		'rplugin',
		'tarPlugin',
		'tohtml',
		'tutor',
		'zipPlugin',
	}}},
	ui = { border = 'rounded' },
})
