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
					width = 0.4,
					height = 0.3,
					title = 'gitignore',
				},

				actions = {
					default = function(selected, _)
						gitignore.createGitignoreBuffer(opts.args, selected)
					end,
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
	end,
}}
