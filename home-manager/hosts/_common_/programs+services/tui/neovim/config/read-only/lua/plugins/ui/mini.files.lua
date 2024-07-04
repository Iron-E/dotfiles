return {{ 'echasnovski/mini.files',
	keys = {
		{ '<A-w>e', desc = 'Focus current file in file explorer', function()
			if not MiniFiles.close() then
				MiniFiles.open(vim.api.nvim_buf_get_name(0))
				MiniFiles.reveal_cwd()
			end
		end },
		{ '<A-w>E', desc = 'Open previous file explorer', function()
			return MiniFiles.close() or MiniFiles.open(MiniFiles.get_latest_path())
		end },
	},
	opts = function(_, o)
		--- @type {[string]: fun(entry: fs_entry): boolean}
		o.content = { filter = function(entry)
			return not (entry.fs_type == 'directory' and (
				entry.name == '.cache' or
				entry.name == '.git' or
				entry.name == 'node_modules'
			))
		end }

		o.mappings = { go_in = 'L', go_in_plus = 'l', synchronize = '<Enter>' }
		o.windows = { preview = true }

		--- @param close? boolean
		--- @param vertical? boolean
		--- @return fun()
		local function open_file_in_split(close, vertical)
			local go_in_opts = { close_on_file = close }
			local split_opts = { mods = { split = 'belowright', vertical = vertical } }
			return function()
				local winnr = MiniFiles.get_target_window()
				if winnr == nil then
					return vim.notify('Attempted to open file without mini.files open', vim.log.levels.WARN)
				end

				local entry = MiniFiles.get_fs_entry() --- @type fs_entry|nil
				if (entry and entry.fs_type == 'file') then
					vim.api.nvim_win_call(winnr, function()
						vim.cmd.split(split_opts)
						MiniFiles.set_target_window(vim.api.nvim_get_current_win())
					end)
				end

				MiniFiles.go_in(go_in_opts)
			end
		end

		--- @param chdir fun(dir: string): boolean|nil # returns `true` if it changed the tab-local directory
		--- @return fun()
		local function set_dir_to_entry(chdir)
			return function()
				local entry = MiniFiles.get_fs_entry() --- @type fs_entry|nil
				if entry == nil then return vim.notify('No FS entry selected', vim.log.levels.INFO) end
				local dir = vim.fs.dirname(entry.path)
				vim.notify(':' .. (chdir(dir) and 't' or '') .. 'cd changed to ' .. vim.inspect(dir), vim.log.levels.INFO)
			end
		end

		vim.api.nvim_create_autocmd('User', {
			pattern = 'MiniFilesBufferCreate',
			callback = function(args)
				local buf = args.data.buf_id

				vim.api.nvim_buf_set_keymap(buf, 'n', '<C-s>', '', {
					callback = open_file_in_split(true),
					desc = 'Open file in horizontal split and close file browser',
				})

				vim.api.nvim_buf_set_keymap(buf, 'n', '<C-w>s', '', {
					callback = open_file_in_split(false),
					desc = 'Open file in horizontal split',
				})

				vim.api.nvim_buf_set_keymap(buf, 'n', '<C-w>v', '', {
					callback = open_file_in_split(false, true),
					desc = 'Open file in vertical split',
				})

				vim.api.nvim_buf_set_keymap(buf, 'n', '<C-x>', '', {
					callback = open_file_in_split(true, true),
					desc = 'Open file in vertical split and close file browser',
				})

				vim.api.nvim_buf_set_keymap(buf, 'n', 'gf', '', {
					callback = set_dir_to_entry(function(dir) vim.loop.chdir(dir) end),
					desc = 'Set current directory',
				})

				vim.api.nvim_buf_set_keymap(buf, 'n', 'gF', '', {
					callback = set_dir_to_entry(function(dir)
						vim.cmd.tcd {args = {dir}}
						return true
					end),
					desc = 'Set the tab-local directory',
				})
			end,
		})

		vim.api.nvim_create_autocmd('User', {
			pattern = 'MiniFilesWindowOpen',
			callback = function(args) vim.api.nvim_win_set_config(args.data.win_id, { border = 'rounded' }) end,
		})
	end,
}}
