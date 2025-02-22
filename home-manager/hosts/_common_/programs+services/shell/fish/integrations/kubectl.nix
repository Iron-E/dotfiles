{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.fish.functions = {
		kubectl-new =
		let gojq = lib.getExe pkgs.gojq;
		in {
			description = "Generate boilerplate for a kubernetes resource";
			wraps = "kubectl";
			body = multiline /* fish */ ''
				# the name of the file should also be in the third
				switch "$argv[1]|$argv[2]"
					case "run|*"
						set -f name_idx 2
					case "create|secret" "create|service"
						set -f name_idx 4
					case "create|*"
						set -f name_idx 3
				end

				set -f dest "$argv[$name_idx]".yml

				set -l output "$(kubectl $argv --dry-run=client --output=json \
					| ${gojq} --yaml-output 'del(.status) | walk(if type == "object" and .metadata != null then .metadata |= ({annotations, labels, name, namespace} | map_values(select(.))) else . end)')"

				echo ---\n$output >> $dest
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
