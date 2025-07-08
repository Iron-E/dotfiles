return {{ 'wintermute-cell/gitignore.nvim',
	cmd = 'Gitignore',

	dependencies = 'ibhagwan/fzf-lua',

	config = function()
		local gitignore = require 'gitignore'

		--- @diagnostic disable-next-line duplicate-set-field
		gitignore.generate = function(opts)
			local picker_opts = {
				prompt = "⟩ ",

				winopts = {
					width = 0.25,
					height = 0.6,
					title = 'gitignore',
				},

				actions = {
					default = function(selected, _)
						gitignore.createGitignoreBuffer(opts.args, selected)
					end,
				},

				fzf_opts = {
					['--multi'] = true,
				},
			}

			local add_entries = function(add_entry)
				for _, prefix in ipairs(gitignore.templateNames) do
					add_entry(prefix)
				end

				-- EOF
				add_entry()
			end

			FzfLua.fzf_exec(add_entries, picker_opts)
		end

		vim.api.nvim_create_user_command('Gitignore', gitignore.generate, {
			force = true,
			nargs = '?', -- 0 or 1 arguments
			complete = 'file', -- complete with files
			bang = true, -- allow the command to be run with a !
		})

	end,
}}
