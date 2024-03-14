{ config, ... }:
let
	templateFile = "git/message";
in {
	imports = [];

	programs.git.extraConfig.commit = {
		template = "${config.xdg.configHome}/${templateFile}";
	};

	xdg.configFile.${templateFile}.text = /* gitcommit */ ''

# <type> ::=
#   build | change to the build script / dependencies
#   chore | cleanup / maintenance
#   ci    | continuous integration
#   docs  | add or improve documentation
#   feat  | add feature or functionality
#   fix   | make it work like it was supposed to
#   perf  | performance improvement
#   ref   | catch-all change to existing component
#   rev   | reversion to previous commit/functionality
#   style | formatting
#   test  | tests / verification

# <body>

# <footer> ::=
#   BREAKING CHANGE: description
#   CLOSES #n
#   FIXES #n
#   NOTE: important note about non-breaking change
#   RELATED: https://foo.org
#   SEE #n
#   TODO: something left to do

# vim: ft=gitcommit
'';
}
