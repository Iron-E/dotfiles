--- mode for mapping
local nx = { "n", "x" }

--- the options to use when aligning a markdown table
local align_markdown_table = "tm<Space><CR>s<Bar><CR>"

return {
	{
		"echasnovski/mini.align",
		keys = {
			{ "<Leader>a", mode = nx, desc = "Align" },
			{ "<Leader>A", mode = nx, desc = "Align with preview" },
			{
				"<Leader>t",
				"<Leader>aip" .. align_markdown_table,
				ft = "markdown",
				mode = "n",
				remap = true,
				silent = true,
				desc = "Align markdown table in paragraph",
			},
			{
				"<Leader>t",
				"<Leader>a" .. align_markdown_table,
				ft = "markdown",
				mode = "x",
				remap = true,
				silent = true,
				desc = "Align selected markdown table",
			},
		},
		opts = function(_, o)
			o.mappings = {
				start = "<Leader>a",
				start_with_preview = "<Leader>A",
			}
		end,
	},
}
