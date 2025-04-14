do -- Brightness
	--- @param count number
	local function cmd(count)
		local opts = {'brightnessctl', 'set', math.abs(count * 5) .. '%' .. (count > -1 and '+' or '-')}
		vim.system(opts, {}, vim.schedule_wrap(function(shell)
			local output = vim.split(shell.stdout, '\n', { trimpempty = true })
			local trimmed_output = vim.trim(output[3])
			vim.notify(trimmed_output)
		end))
	end

	local opts = { count = 1, force = true }
	vim.api.nvim_create_user_command('BrightnessCtl', function(tbl) cmd(tbl.count) end, opts)
	vim.api.nvim_create_user_command('DarknessCtl', function(tbl) cmd(-tbl.count) end, opts)
end

vim.api.nvim_create_user_command('Win',
	function(tbl)
		local bufwinnr = vim.fn.bufwinid(tbl.args)
		vim.api.nvim_set_current_win(bufwinnr)
	end,
	{
		complete = function()
			return vim.iter(vim.api.nvim_list_bufs())
				:filter(function(bufnr) return vim.fn.bufwinid(bufnr) ~= -1 end)
				:map(vim.fn.bufname)
				:totable()
		end,
		desc = 'Focus the given window',
		nargs = 1,
	}
)

do -- Redshift
	local REDSHIFT_COLORS = {b = 5500, o = 2000, r = 1300, y = 3750}

	--- @param color string
	local function cmd(color)
		local opts = { 'redshift', '-PO', REDSHIFT_COLORS[color:sub(1, 1)] }
		vim.system(opts)
	end

	vim.api.nvim_create_user_command('Redshift', function(tbl) cmd(tbl.args) end, {
		complete = function() return {'blue', 'orange', 'red', 'yellow'} end,
		force = true,
		nargs = 1,
	})
end

-- Space-Tab Conversion
vim.api.nvim_create_user_command(
	'SpacesToTabs',
	function(tbl)
		vim.api.nvim_set_option_value('expandtab', false, {scope = 'local'})
		local previous_tabstop = vim.api.nvim_get_option_value('tabstop', {})
		vim.api.nvim_set_option_value('tabstop', tonumber(tbl.args), {scope = 'local'})
		vim.api.nvim_command 'retab!'
		vim.api.nvim_set_option_value('tabstop', previous_tabstop, {scope = 'local'})
	end,
	{force = true, nargs = 1}
)

vim.api.nvim_create_user_command(
	'Typora',
	function(tbl)
		vim.system({'typora', tbl.args == '' and vim.api.nvim_buf_get_name(0) or tbl.args}, {detach = true})
	end,
	{complete = 'file', nargs = '?'}
)

vim.api.nvim_create_user_command(
	'TabsToSpaces',
	function(tbl)
		vim.api.nvim_set_option_value('expandtab', true, {scope = 'local'})
		local previous_tabstop = vim.api.nvim_get_option_value('tabstop', {scope = 'local'})
		vim.api.nvim_set_option_value('tabstop', tonumber(tbl.args), {scope = 'local'})
		vim.api.nvim_command 'retab'
		vim.api.nvim_set_option_value('tabstop', previous_tabstop, {scope = 'local'})
	end,
	{force = true, nargs = 1}
)

-- Fat fingering
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('Wqa', 'wqa', {})
vim.api.nvim_create_user_command('X', 'x', {})
vim.api.nvim_create_user_command('Xa', 'xa', {})
