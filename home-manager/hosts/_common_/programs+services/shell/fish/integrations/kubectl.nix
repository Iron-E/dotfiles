{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.fish.functions = {
		ktl-new = {
			description = "Generate boilerplate for a kubernetes resource";
			wraps = "kubectl";
			body = multiline /* fish */ ''
				# the name of the file should also be in the third
				set -l dest "$argv[3].yaml"
				echo "---" >> $dest

				set -l strip "  creationTimestamp"
				kubectl $argv --dry-run=client --output=yaml | while read --line l
					set -l stripped false # WARN: stripping is not recursive! it could be but I am lazy
					for field in $strip
						if string match -q -r "^$field:" $l
							set stripped true
							break
						end
					end

					if $stripped
						continue
					end

					# do not store status
					if string match -q -r '^status:' $l
						break
					end

					echo $l >> $dest
				end
			'';
		};

		kubectl-proxy-endpoint = {
			description = "Get the url of a kubectl proxy endpoint";
			wraps = "kubectl get pods";
			body = multiline /* fish */ ''
				argparse \
					(fish_opt -s h -l help) \
					(fish_opt -s n -l namespace --required-val) \
					(fish_opt -s o -l host --required-val) \
					(fish_opt -s p -l port --required-val) \
					-- $argv

				if [ -n "$_flag_help" ] || [ -z "$argv[1]" ]
					echo  "
				Usage: kubectl-proxy-endpoint [FLAGS] [PODS]

				Example: kubectl-proxy-endpoint -n default -o localhost -p 8080

				Options:
				  -h, --help       Print help
				  -n, --namespace  The pod's namespace
				  -o, --host       The proxy host
				  -p, --port       The pod's endpoint port
				"
					return
				end

				if [ -n "$_flag_host" ]
					set -f host $_flag_host
				else
					set -f host "http://localhost:8001"
				end

				if [ -n "$_flag_namespace" ]
					set -f namespace $_flag_namespace
				else
					set -f namespace default
				end

				if [ -n "$_flag_port" ]
					set -f port $_flag_port
				else
					set -f port 8080
				end

				for arg in $argv
					echo $host/api/v1/namespaces/$namespace/pods/$arg:$port/proxy/
				end
			'';
		};
	};
}
