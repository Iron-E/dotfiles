--- @class iron-e.BenchOpts
--- @field title? string optional title
--- @field iter? integer the number of times to run the code. Higher number = more accurate average
--- @field cont? integer interrupt execution after this many iter, to give neovim a chance to do other things

--- Benchmark some `fn`, printing the average time it takes to run given the number of `iter`.
--- @param fn fun(i: integer) the code to benchmark
--- @param opts? iron-e.BenchOpts
function Bench(fn, opts)
	coroutine.resume(coroutine.create(function()
		opts = opts or {}
		opts.iter = opts.iter or 100000
		opts.cont = opts.cont or 100

		if opts.title == nil then
			opts.title = ""
		elseif opts.title ~= "" then
			opts.title = opts.title .. " "
		end

		local co = coroutine.running()
		local now = vim.uv.hrtime --- @type fun(): integer
		local total = 0

		for i = 1, opts.iter do
			local start = now()
			fn(i)
			total = total + (now() - start)

			if i % opts.cont == 0 then
				vim.schedule(function()
					coroutine.resume(co)
				end)

				coroutine.yield()
			end
		end

		vim.notify("Benchmark " .. opts.title .. "complete: " .. tostring(total / opts.iter), vim.log.levels.INFO)
	end))
end

--- @return string fold_text a neat template for the summary of what is on a fold
function NeatFoldText()
	local end_ = vim.v.foldend --- @type number
	local start = vim.v.foldstart --- @type number

	local lines = { start, end_ }
	for i, line_nr in ipairs(lines) do
		local line = vim.api.nvim_buf_get_lines(0, line_nr - 1, line_nr, true)[1]
		--- @diagnostic disable-next-line: assign-type-mismatch
		lines[i] = line
	end

	--- @cast lines string[]

	do
		local columns = vim.api.nvim_win_get_width(0)
		local first_line = lines[1]
		local first_line_len = #first_line

		-- NOTE: 10 is the magic number for the base width of the template line.
		--       5 is a heuristic because linenr/sign column width is indeterminable
		--       3 is the magic number for joining the lines
		local needed_width = #lines[2] + 10 + 5 + 3

		if first_line_len + needed_width > columns then
			local overflow = math.abs(first_line_len - columns)

			-- NOTE: 5 is the magic number for the replacement len.
			local remove = math.ceil(bit.rshift(overflow, 1) + needed_width + 5)
			local middle = bit.rshift(first_line_len, 1)

			lines[1] = first_line:sub(1, middle - remove) .. " […] " .. first_line:sub(middle + remove)
		end
	end

	return ("   %-6d%s"):format(end_ - start + 1, table.concat(lines, " … "))
end
