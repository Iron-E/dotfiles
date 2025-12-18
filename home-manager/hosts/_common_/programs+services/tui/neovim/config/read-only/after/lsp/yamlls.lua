--- @type vim.lsp.Config
return {
	filetypes = {
		"yaml",
		"yaml.docker-compose",
		"yaml.gitlab",
		"yaml.helm-values",
		"yaml.taskfile",
	},

	settings = {
		yaml = {
			schemas = { -- SEE: https://www.schemastore.org/json/
				kubernetes = '*.{yml,yaml}',
				['http://json.schemastore.org/ansible-playbook'] = '*play*.{yml,yaml}',
				['http://json.schemastore.org/ansible-stable-2.9'] = 'roles/tasks/*.{yml,yaml}',
				['http://json.schemastore.org/chart'] = 'Chart.{yml,yaml}',
				['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
				['http://json.schemastore.org/github-workflow'] = '.github/workflows/*',
				['http://json.schemastore.org/kustomization'] = 'kustomization.{yml,yaml}',
				['http://json.schemastore.org/prettierrc'] = '.prettierrc.{yml,yaml}',
				['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] = '*gitlab-ci*.{yml,yaml}',
				['https://golangci-lint.run/jsonschema/golangci.jsonschema.json'] = '.golangci.{yml,yaml,toml,json}',
				['https://json.schemastore.org/buf.gen.json'] = 'buf.gen.{yml,yaml}',
				['https://json.schemastore.org/buf.json'] = 'buf.{yml,yaml}',
				['https://json.schemastore.org/buf.plugin.json'] = 'buf.plugin.{yml,yaml}',
				['https://json.schemastore.org/buf.work.json'] = 'buf.work.{yml,yaml}',
				['https://json.schemastore.org/dependabot-v2'] = '.github/dependabot.{yml,yaml}',
				['https://json.schemastore.org/pre-commit-config.json'] = '.pre-commit-config.{yml,yaml}',
				['https://json.schemastore.org/pre-commit-hooks.json'] = '.pre-commit-hooks.{yml,yaml}',
				['https://nfpm.goreleaser.com/static/schema.json'] = '*nfpm*.{yml,yaml}',
				['https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json'] = '*flow*.{yml,yaml}',
				['https://raw.githubusercontent.com/chainguard-dev/apko/main/pkg/build/types/schema.json'] = '*apko*.{yml,yaml}',
				['https://raw.githubusercontent.com/chainguard-dev/melange/main/pkg/config/schema.json'] = '*melange*.{yml,yaml}',
				['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = '*docker-compose*.{yml,yaml}',
				['https://raw.githubusercontent.com/evilmartians/lefthook/master/schema.json'] = 'lefthook.{yml,yaml}',
				['https://raw.githubusercontent.com/hadolint/hadolint/master/contrib/hadolint.json'] = '{.,}hadolint.{yml,yaml}',
				['https://raw.githubusercontent.com/OAI/OpenAPI-Specification/refs/heads/main/schemas/v3.1/schema.yaml'] = '*api*.{yml,yaml}',
				['https://taskfile.dev/schema.json'] = '{T,t}askfile{.dist,}.y{a,}ml',
			},
		},
	},
}
