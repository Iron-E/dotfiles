--- @type vim.lsp.Config
return {
	cmd = {
		'Microsoft.CodeAnalysis.LanguageServer',
		'--logLevel=Information',
		'--extensionLogDirectory=' .. vim.fs.dirname(vim.lsp.get_log_path()),
		'--stdio',
	},
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
