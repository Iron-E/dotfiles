--- @module 'mini.icons'
--- @module 'gitsigns'
--- @module 'heirline'

return {{ 'rebelot/heirline.nvim',
	dependencies = { 'gitsigns.nvim', 'echasnovski/mini.icons' },
	config = function()
		local heirline = require 'heirline'
		local utils = require 'heirline.utils'

		local function setup_colors()
			local colors = {
				-- Defined in https://github.com/Iron-E/nvim-highlite
				black        = '#202020',
				blue         = '#7766ff',
				cyan         = '#33dbc3',
				gray_dark    = '#353535',
				gray_light   = '#c0c0c0',
				green        = '#22ff22',
				green_dark   = '#70d533',
				green_light  = '#99ff99',
				ice          = '#95c5ff',
				magenta      = '#d5508f',
				magenta_dark = '#bb0099',
				orange       = '#ff8900',
				orange_light = '#f0af00',
				pink         = '#ffa6ff',
				pink_light   = '#ffb7b7',
				purple       = '#cf55f0',
				purple_light = '#af60af',
				red          = '#ee4a59',
				red_dark     = '#a80000',
				red_light    = '#ff4090',
				tan          = '#f4c069',
				teal         = '#60afff',
				turqoise     = '#2bff99',
				white        = '#ffffff',
				yellow       = '#f0df33',
			}

			colors.sidebar = colors.black
			colors.midbar = colors.gray_dark
			colors.text = colors.gray_light

			return colors
		end

		vim.api.nvim_create_autocmd('ColorScheme', {
			desc = 'Reset heirline colors',
			group = 'config',
			callback = function()
				utils.on_colorscheme(setup_colors)
			end,
		})

		--- Redraw the statusline
		local redrawstatus = vim.schedule_wrap(function()
			vim.api.nvim_command 'redrawstatus'
		end)

		--[[/* HEIRLINE CONFIG */]]

		--- Components separated by this component will be padded with an equal number of spaces.
		local ALIGN = { provider = '%=' }

		--- A left separator.
		local LEFT_SEPARATOR = { provider = '' }

		--- A right separator.
		local RIGHT_SEPARATOR = { provider = '' }

		local vi_mode = {
			static = {
				group = 'HeirlineViMode',
				modes = {
					['c']  = { 'COMMAND-LINE', 'red' },
					['ce'] = { 'NORMAL EX', 'red_dark' },
					['cv'] = { 'EX', 'red_light' },

					['i'] = { 'INSERT', 'green' },

					['ic']  = { 'INS-COMPLETE', 'green_light' },
					['ix']  = { 'INS-COMPLETE', 'green_light' },
					['Rc']  = { 'REP-COMPLETE', 'green_light' },
					['Rvc'] = { 'VIRT-REP-COMPLETE', 'green_light' },
					['Rvx'] = { 'VIRT-REP-COMPLETE', 'green_light' },
					['Rx']  = { 'REP-COMPLETE', 'green_light' },

					['n']   = { 'NORMAL', 'purple_light' },
					['niI'] = { 'INS-NORMAL', 'purple_light' },
					['niR'] = { 'REP-NORMAL', 'purple_light' },
					['niV'] = { 'VIRT-REP-NORMAL', 'purple_light' },
					['nt']  = { 'TERM-NORMAL', 'purple_light' },
					['ntT'] = { 'TERM-NORMAL', 'purple_light' },

					['no']   = { 'OPERATOR-PENDING', 'purple' },
					['nov']  = { 'CHAR OPERATOR-PENDING', 'purple' },
					['noV']  = { 'LINE OPERATOR-PENDING', 'purple' },
					['no'] = { 'BLOCK OPERATOR-PENDING', 'purple' },

					['R']  = { 'REPLACE', 'pink' },
					['Rv'] = { 'VIRT-REPLACE', 'pink_light' },

					['r']   = { 'HIT-ENTER', 'cyan' },
					['rm']  = { '--MORE', 'cyan' },
					['r?']  = { ':CONFIRM', 'cyan' },

					['s']   = { 'SELECT', 'turqoise' },
					['S']   = { 'SELECT LINE', 'turqoise' },
					['']  = { 'SELECT', 'turqoise' },

					['v']   = { 'VISUAL', 'blue' },
					['vs']  = { 'SEL-VISUAL', 'blue' },
					['V']   = { 'VISUAL LINE', 'blue' },
					['Vs']  = { 'SEL-VISUAL LINE', 'blue' },
					['']  = { 'VISUAL BLOCK', 'blue' },
					['s'] = { 'VISUAL BLOCK', 'blue' },

					['t']   = { 'TERMINAL', 'orange' },
					['!']   = { 'SHELL', 'yellow' },

					-- libmodal
					['BUFFERS'] = 'teal',
					['TABLES']  = 'orange_light',
					['TABS']    = 'tan',
				}
			},

			init = function(self)
				if vim.g.libmodalActiveModeName then
					self.name = vim.g.libmodalActiveModeName
					self.color = self.modes[self.name]
					return
				end

				local current_mode = self.modes[vim.api.nvim_get_mode().mode]

				self.name = current_mode[1]
				self.color = current_mode[2]
			end,

			update = {
				'ModeChanged',
				callback = redrawstatus,
				pattern = '*:*',
			},

			hl = function(self)
				return { bg = 'sidebar', fg = self.color, bold = true }
			end,

			provider = function(self)
				return '▊ ' .. self.name .. ' '
			end,
		}

		local file_icon = {
			init = function(self)
				local filename = vim.api.nvim_buf_get_name(0)
				local icon, color, _ = MiniIcons.get('file', filename)

				local hl = vim.api.nvim_get_hl(0, { link = false, name = color })
				self.file = {
					color = hl.fg,
					icon = icon,
				}
			end,

			update = { 'BufEnter' },

			hl = function(self)
				return { bg = 'sidebar', fg = self.file.color }
			end,

			LEFT_SEPARATOR,

			{
				hl = function(self)
					return { bg = self.file.color, fg = 'sidebar' }
				end,

				provider = function(self)
					return ' ' .. self.file.icon .. ' %Y '
				end,
			},

			RIGHT_SEPARATOR,
		}

		local file_info = {
			hl = { bg = 'sidebar', fg = 'text', bold = true },

			-- File name
			{ provider = ' %t ' },
			{ -- Readonly
				condition = function()
					return vim.api.nvim_get_option_value('readonly', { buf = 0 })
				end,

				update = { 'OptionSet', pattern = 'readonly' },
				provider = ' ',
			},

			{ -- Modified
				condition = function()
					return vim.api.nvim_get_option_value('modified', {})
				end,

				update = 'BufModifiedSet',
				provider = ' ',
			},

			{ -- File size
				init = function(self)
					self.stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(0))
				end,

				update = { 'BufEnter', 'BufWritePost' },

				{
					static = {
						conversion = 1024,
						units = { '', 'k', 'm', 'g', 't', 'p', 'e', 'z', 'y' },
					},

					condition = function(self)
						return self.stat
					end,

					provider = function(self)
						local size = self.stat.size

						local i = 1
						while size > self.conversion and i < #self.units do
							size = size / self.conversion
							i = i + 1
						end

						return ('%.2f%sb '):format(size, self.units[i])
					end,
				},
			},

			{ hl = { fg = 'midbar' }, LEFT_SEPARATOR },
		}

		--- @param fg HeirlineColor
		--- @param severity vim.diagnostic.Severity
		--- @return table
		local function severity_section(fg, severity)
			return {
				hl = { fg = fg },
				provider = function(self)
					return self:provide(severity)
				end,
			}
		end

		local diagnostics = {
			init = function(self)
				--- @type { [vim.diagnostic.Severity]: integer }
				local diagnostics = vim.diagnostic.count(0)

				for _, _ in pairs(diagnostics) do
					-- if this block is entered, it means there are diagnostics
					self.diagnostics = diagnostics
					return
				end

				-- otherwise, there are no diagnostics
				self.diagnostics = nil
			end,

			update = { 'BufEnter', 'DiagnosticChanged' },

			hl = { bg = 'midbar', fg = 'sidebar' },

			{
				condition = function(self) return self.diagnostics end,

				LEFT_SEPARATOR,

				{
					static = {
						icons = { ' ', ' ', ' ', ' ' },

						--- @param severity 1|2|3|4
						--- @return nil|string
						provide = function(self, severity)
							local count = self.diagnostics[severity]
							if count == nil or count == 0 then
								return
							end

							local str = self.icons[severity] .. count
							for i = severity + 1, #vim.diagnostic.severity do
								if self.diagnostics[i] then
									str = str .. ' '
									break
								end
							end

							return str
						end,
					},

					hl = { bg = 'sidebar' },

					severity_section('red', vim.diagnostic.severity.ERROR),
					severity_section('orange', vim.diagnostic.severity.WARN),
					severity_section('pink_light', vim.diagnostic.severity.INFO),
					severity_section('magenta', vim.diagnostic.severity.HINT),
				},

				RIGHT_SEPARATOR,
			},
		}

		do
			local command = 'doautocmd User BufEnterOrGitSignsUpdate'
			vim.api.nvim_create_autocmd('BufEnter', { command = command, group = 'config' })
			vim.api.nvim_create_autocmd('User', { command = command, group = 'config', pattern = 'GitSignsUpdate' })
		end

		--- @param fg HeirlineColor
		--- @param sign string
		--- @param change string
		--- @return table
		local function diff_section(fg, sign, change)
			return {
				hl = { fg = fg },
				provider = function(self)
					return self:provide('+', 'added')
				end,
			}
		end

		local git = {
			init = function(self) self.status = vim.b.gitsigns_status_dict end,
			update = { 'User', pattern = 'BufEnterOrGitSignsUpdate', callback = redrawstatus },

			{ -- Diff
				hl = { bg = 'midbar' },

				{
					static = {
						--- @param sign string
						--- @param change string
						--- @return nil|string
						provide = function(self, sign, change)
							local count = self.status[change] or 0
							if count > 0 then return sign .. count end
						end,
					},

					condition = function(self)
						return self.status
					end,

					diff_section('green', '+', 'added'),
					diff_section('orange_light', '~', 'changed'),
					diff_section('red_light', '-', 'removed'),
					{ provider = ' ' },
				},
			},

			{ -- Branch
				hl = { bg = 'green_dark' },

				{ hl = { fg = 'midbar' }, RIGHT_SEPARATOR },
				{ provider = ' ' },
				{
					condition = function(self) return self.status end,
					hl = { fg = 'sidebar', bold = true },
					provider = function(self) return ' ' .. self.status.head .. ' ' end,
				},

				{ hl = { fg = 'sidebar' }, LEFT_SEPARATOR },
			},
		}

		local column_number = {
			hl = { fg = 'text', bg = 'sidebar' },
			provider = '  %v ',
		}

		local line_percent = {
			hl = { bg = 'magenta_dark' },

			{ hl = { fg = 'sidebar' }, RIGHT_SEPARATOR },
			{ hl = { fg = 'white' }, provider = ' %p%% ' },
		}

		heirline.setup {
			opts = {
				colors = setup_colors,
			},

			--- @diagnostic disable-next-line missing-fields
			statusline = {
				vi_mode,
				file_icon,
				file_info,

				{ hl = { bg = 'midbar' }, ALIGN },

				diagnostics,

				{ hl = { bg = 'midbar' }, ALIGN },

				git,
				column_number,
				line_percent,
			},
		}
	end,
}}
