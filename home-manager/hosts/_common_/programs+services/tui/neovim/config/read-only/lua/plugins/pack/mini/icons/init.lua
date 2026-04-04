local opts = {
	default = {
		lsp = { hl = "@markup.raw" },
	},

	-- NOTE: these tables are empty so that aliases can be in `config`
	directory = {},
	file = {},
	filetype = {},
	os = {},

	lsp = {
		array = { hl = "@punctuation.bracket" },
		boolean = { hl = "@boolean" },
		class = { hl = "@lsp.type.class" },
		color = { hl = "@label" },
		constant = { hl = "@constant" },
		constructor = { hl = "@constructor" },
		enum = { hl = "@lsp.type.enum" },
		enummember = { hl = "@lsp.type.enumMember" },
		event = { hl = "@lsp.type.event" },
		field = { hl = "@variable.member" },
		file = { hl = "Directory" },
		folder = { hl = "Directory" },
		["function"] = { hl = "@function" },
		interface = { hl = "@lsp.type.interface" },
		key = { hl = "@property" },
		keyword = { hl = "@keyword" },
		method = { hl = "@function.method" },
		module = { hl = "@module" },
		namespace = { hl = "@lsp.type.namespace" },
		null = { hl = "@constant.builtin" },
		number = { hl = "@number" },
		object = { hl = "@variable" },
		operator = { hl = "@operator" },
		package = { hl = "@module" },
		property = { hl = "@variable.member" },
		reference = { hl = "@type.pointer" },
		snippet = { hl = "@function.macro" },
		string = { hl = "@string" },
		struct = { hl = "@structure" },
		text = { hl = "@markup.quote" },
		typeparameter = { hl = "@lsp.type.typeParameter" },
		unit = { hl = "@type.builtin" },
		value = { hl = "@operator" },
		variable = { hl = "@variable" },
	},
}

local icons = require("mini.icons")

-- aliases
do
	do
		local glyph, hl, _ = icons.get("file", ".gitlab-ci.yml")
		opts.filetype["yaml.gitlab"] = { glyph = glyph, hl = hl }
	end

	do
		local glyph, hl = icons.get("filetype", "helm")
		opts.filetype["yaml.helm-values"] = { glyph = glyph, hl = hl }
	end

	do
		local glyph, hl = icons.get("filetype", "terraform")
		local icon = { glyph = glyph, hl = hl }
		opts.filetype.opentofu = icon
		opts.filetype["opentofu-vars"] = icon
		opts.filetype["terraform-vars"] = icon
		opts.filetype["hcl.terragrunt"] = icon
		opts.filetype["hcl.terragrunt-stack"] = icon
	end
end

icons.setup(opts)
icons.mock_nvim_web_devicons()
