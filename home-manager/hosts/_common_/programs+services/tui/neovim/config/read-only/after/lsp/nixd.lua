--- @type vim.lsp.Config
return {
	settings = {
		nixd = {
			nixpkgs = {
				expr = "import <nixpkgs> { }",
			},
			formatting = {
				command = { "nixfmt" },
			},
			options = {
				home_manager = {
					expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."' .. vim.uv.os_getenv(
						"HM_PROFILE"
					) .. '".options',
				},
			},
		},
	},
}
