return {
	{ 'neovim/nvim-lspconfig',
		cond = vim.g.man ~= true,
		dependencies = 'blink.cmp',
		config = function()
			local lspconfig  = require 'lspconfig'

			--- @type vim.lsp.Config
			local settings = {
				capabilities = require('blink.cmp').get_lsp_capabilities(),
			}

			lspconfig.jsonnet_ls.setup(settings)
			lspconfig.tailwindcss.setup(settings)
		end,
	},
	{ 'seblj/roslyn.nvim',
		ft = 'cs',
		opts = function(_, o)
			o.exe = 'Microsoft.CodeAnalysis.LanguageServer'
			o.config = {
				settings = {
					['csharp|background_analysis'] = {
						dotnet_analyzer_diagnostics_scope = 'fullSolution',
						dotnet_compiler_diagnostics_scope = 'fullSolution',
					},
					['csharp|code_lens'] = {
						dotnet_enable_references_code_lens = true,
						dotnet_enable_tests_code_lens = true,
					},
					['csharp|completion'] = {
						dotnet_provide_regex_completions = true,
						dotnet_show_completion_items_from_unimported_namespaces = true,
						dotnet_show_name_completion_suggestions = true,
					},
					['csharp|inlay_hints'] = {
						csharp_enable_inlay_hints_for_implicit_object_creation = true,
						csharp_enable_inlay_hints_for_implicit_variable_types = true,
						dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
						dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
						dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
					},
					['csharp|symbol_search'] = {
						dotnet_search_reference_assemblies = true,
					},
				},
			}
		end,
	},
}
