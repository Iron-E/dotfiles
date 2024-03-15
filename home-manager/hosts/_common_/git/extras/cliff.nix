{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.git-cliff = {
		enable = true;
		settings = {
			changelog = {
				# remove the leading and trailing whitespace from the templates
				trim = true;

				header = "# Changelog\n\n";

				# https://keats.github.io/tera/docs/#introduction
				body = util.strings.concat [
					"{% if version %}"
						"## [{{ version }}] - {{ timestamp | date(format=\"%Y-%m-%d\") }}"
					"{% else %}"
						"## [unreleased]"
					"{% endif %}"
					"{% for group, commits in commits | group_by(attribute=\"group\") %}"
						"### {{ group | upper_first }}"
						"{% for commit in commits"
						"| filter(attribute=\"scope\")"
						"| sort(attribute=\"scope\") %}"
							"- *({{commit.scope}})* {{ commit.message | upper_first }}"
							"{%- if commit.breaking %}"
							"{% raw %}  {% endraw %}- **BREAKING**: {{commit.breaking_description}}"
							"{%- endif -%}"
						"{%- endfor -%}"
						"{% raw %}\n{% endraw %}"
						"{%- for commit in commits %}"
							"{%- if commit.scope -%}"
							"{% else -%}"
								"- *(No Category)* {{ commit.message | upper_first }}"
								"{% if commit.breaking -%}"
								"{% raw %}  {% endraw %}- **BREAKING**: {{commit.breaking_description}}"
								"{% endif -%}"
							"{% endif -%}"
						"{% endfor -%}"
						"{% raw %}\n{% endraw %}"
					"{% endfor %}\n"
				];

				# template for the changelog footer
				footer = util.strings.concat [
					"{% for release in releases -%}"
						"{% if release.version -%}"
							"{% if release.previous.version -%}"
								"[{{ release.version }}]: "
									"https://github.com/{{ remote.github.owner }}/{{ remote.github.repo }}"
										"/compare/{{ release.previous.version }}..{{ release.version }}"
							"{% endif -%}"
						"{% else -%}"
							"[unreleased]: https://github.com/{{ remote.github.owner }}/{{ remote.github.repo }}"
								"/compare/{{ release.previous.version }}..HEAD"
						"{% endif -%}"
					"{% endfor %}"
					"<!-- generated by git-cliff -->"
				];
			};

			git = {
				# parse the commits based on https://www.conventionalcommits.org
				conventional_commits = true;

				# filter out the commits that are not conventional
				filter_unconventional = true;

				# process each line of a commit as an individual commit
				split_commits = false;

				# sort the commits inside sections by oldest/newest order
				sort_commits = "oldest";

				# sort the tags topologically
				topo_order = false;

				# protect breaking changes from being skipped due to matching a skipping commit_parser
				protect_breaking_commits = true;

				# how to group commits
				commit_parsers =
				let
					allWithGroupIdx = # put all the `parsers` in a `group`
					group: # see `withGroupIdx`
					idx: # see `withGroupIdx`
					parsers: # list of parsers, or a single parser
						map
						(parser: parser // { group = "<!-- ${idx} -->${group}"; })
						(util.lists.singleton parsers)
					;

					features = allWithGroupIdx 0 "Features";
					fixes = allWithGroupIdx 1 "Bug Fixes";
					improvements = allWithGroupIdx 2 "Improvements";
					buildChanges = allWithGroupIdx 3 "Build Changes";
					removals = allWithGroupIdx 4 "Removals";
					deprecations = allWithGroupIdx 5 "Deprecations";
					maintenance = allWithGroupIdx 6 "Maintenance";

					skip = # do not include the `parsers` in the output
					parsers: # list of parsers, or a single parser
						map
						(parser: parser // { skip = true; })
						(util.lists.singleton parsers)
					;
				in builtins.concatLists [
					(buildChanges { message = "^build"; })
					(deprecations { body = ".*deprecated"; })
					(features { message = "^feat"; })
					(fixes { message = "^fix"; })
					(improvements [
						{ message = "^perf"; }
						{ message = "^ref"; }
					])
					(maintenance [
						{ message = "^chore"; }
						{ message = "^ci"; }
						{ message = "^style"; }
					])
					(removals { message = "^rev"; })
					(skip [
						{ message = "^docs"; }
						{ message = "^test"; }
					])
				];
			};
		};
	};
}
