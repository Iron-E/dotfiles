local lint = require("lint")

lint.linters.jq.cmd = "gojq"

lint.linters_by_ft = {
	dockerfile = { "hadolint" },
	env = { "dotenv_linter" },
	fish = { "fish" },
	go = { "golangcilint" },
	html = { "htmlhint" },
	javascript = { "eslint_d" },
	json = { "jq" },
	nix = { "deadnix", "nix" },
	proto = { "buf_lint" },
	python = { "ruff" },
	sh = { "shellcheck" },
	sql = { "sqlfluff" },
	terraform = { "terraform_validate", "tflint", "trivy" },
	opentofu = { "tofu", "tflint", "trivy" },
}

lint.linters_by_ft.less = lint.linters_by_ft.css
lint.linters_by_ft.scss = lint.linters_by_ft.css
lint.linters_by_ft.sass = lint.linters_by_ft.scss

lint.linters_by_ft.typescript = lint.linters_by_ft.javascript
lint.linters_by_ft.javascriptreact = lint.linters_by_ft.javascript
lint.linters_by_ft.typescriptreact = lint.linters_by_ft.javascriptreact

lint.linters_by_ft["terraform-vars"] = lint.linters_by_ft.terraform

local group = vim.api.nvim_create_augroup("config.lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
	desc = "Try lint",
	group = group,
	callback = function()
		lint.try_lint()
	end,
})
