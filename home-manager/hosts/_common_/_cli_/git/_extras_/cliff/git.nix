{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.git-cliff.settings.git = {
		conventional_commits = true; # parse the commits based on https://www.conventionalcommits.org
		filter_unconventional = true; # filter out the commits that are not conventional
		protect_breaking_commits = true; # protect breaking changes from being skipped due to matching a skipping commit_parser
		sort_commits = "oldest"; # sort the commits inside sections by oldest/newest order
		split_commits = false; # process each line of a commit as an individual commit
		topo_order = false; # sort the tags topologically

		commit_parsers = # how to group commits
		let
			# put all the `parsers` in a `group`
			withGroupIdx = idx: group: util.lists.map (
				parser: parser // { group = "<!-- ${builtins.toString idx} -->${group}"; }
			);

			# do not include the `parsers` in the output
			skip = util.lists.map (parser: parser // { skip = true; });
		in builtins.concatLists [
			(withGroupIdx 0 "Features" { message = "^feat"; })
			(withGroupIdx 1 "Bug Fixes" { message = "^fix"; })
			(withGroupIdx 2 "Improvements" [
				{ message = "^perf"; }
				{ message = "^ref"; }
			])
			(withGroupIdx 3 "Build Changes" { message = "^build"; })
			(withGroupIdx 4 "Removals" { message = "^rev"; })
			(withGroupIdx 5 "Deprecations" { body = ".*deprecated"; })
			(withGroupIdx 6 "Maintenance" [
				{ message = "^chore"; }
				{ message = "^ci"; }
				{ message = "^style"; }
			])
			(skip [
				{ message = "^docs"; }
				{ message = "^test"; }
			])
		];
	};
}
