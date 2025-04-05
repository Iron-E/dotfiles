--- @class mini.ai.cursor_position
--- @field line integer
--- @field col integer

--- @class mini.ai.region
--- @field to? mini.ai.cursor_position
--- @field from mini.ai.cursor_position

--- @alias mini.ai.type 'a'|'i'

--- @alias mini.ai.custom_textobject fun(ai_type: mini.ai.type): mini.ai.region

return {{ 'echasnovski/mini.ai', opts = function(_, o)
		o.n_lines = 1000
		o.mappings = {
			goto_left = '[g',
			goto_right = ']g',
		}

		--- @type { [string]: mini.ai.custom_textobject }
		o.custom_textobjects = {
			g = function(ai_type)
				local from_line =  1
				local to_line = vim.api.nvim_buf_line_count(0)

				if ai_type == 'i' then
					from_line = vim.fn.nextnonblank(from_line)
					to_line = vim.fn.prevnonblank(to_line)

					if (from_line == 0 and to_line == 0) or (from_line > to_line) then
						return { from = { line = from_line, col = 1 } }
					end
				end

				local to_line_text = vim.api.nvim_buf_get_lines(0, to_line - 1, to_line, false)[1]
				local to_line_length = vim.api.nvim_strwidth(to_line_text)
				local to_col = math.max(to_line_length, 1)

				return {
					from = { line = from_line, col = 1 },
					to = { line = to_line, col = to_col },
				}
			end,
		}
	end,
}}
