{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ ];

  home =
    let
      kubectl-fuzzy = pkgs.writeShellApplication {
        name = "kubectl-fuzzy";
        runtimeInputs = [ ];
        text = # sh
          ''
            progname="kzf"

            function usage {
            	echo "$progname is a fuzzy finder for kubectl."
            	printf "Usage:\n\n"
            	printf "\t-A, --all-namespaces  Show resources from every namespace.\n";
            	printf "\t-c, --context         The kubeconfig context to use.\n";
            	printf "\t-h, --help            Show usage information.\n";
            	printf "\t-n, --namespace       The namespace to fuzzy find in.\n";
            	printf "\t                      If an empty string, the namespace will be fuzzy found as well.\n";
            	printf "\t    --query           The default fzf search text.\n";
            }

            function unknown_option {
            	usage
            	printf "\nUnknown option: %s\n" "$1"
            	exit 1
            }

            short_flags="An:c:"
            long_flags="all-namespaces,namespace:,context:,query:"

            flags="$(getopt -n "$progname" -o "$short_flags" -l "$long_flags" -- "$@")"
            eval set -- "$flags"

            base_fzf_opts=(
            	'--header-lines' '1'
            	'--delimiter' '\s+'
            	'--accept-nth' '{1}'
            )

            fzf_opts=()
            kubectl_opts=()

            for opt; do
            	case "$opt" in
            		-A|--all-namespaces)
            			# all_namespaces=true
            			kubectl_opts+=("$opt")
            			shift
            			;;
            		-c|--context)
            			# context="$2"
            			kubectl_opts+=("$opt" "$2")
            			shift 2
            			;;
            		-n|--namespace)
            			namespace="$2"
            			kubectl_opts+=("$opt" "$2")
            			shift 2
            			;;
            		--query)
            			fzf_opts+=("$opt" "$2")
            			shift 2
            			;;
            		-h|--help)
            			usage;
            			exit
            			;;
            		--) ;;
            		-*) unknown_option "$opt";;
            	esac
            done

            # remove last --
            shift

            if [[ -v "$namespace" && -z "$namespace" ]]; then # namespace should be selected
            	namespace="$(kubectl get namespace | fzf "''${base_fzf_opts[@]}")"
            fi

            resource="$1"
            if [[ -z "$resource" ]]; then
            	resource="$( kubectl api-resources -o name --no-headers | fzf )"
            	if [[ -z "$resource" ]]; then
            		echo "No resource selected"
            		exit 1
            	fi
            fi

            CMD=("kubectl" "get" "$resource" "''${kubectl_opts[@]}")

            "''${CMD[@]}" |
            	fzf \
            	"''${base_fzf_opts[@]}" \
            	"''${fzf_opts[@]}" \
            	--bind "ctrl-r:reload(''${CMD[*]})"
          '';
      };
    in
    lib.optionalAttrs config.programs.fzf.enable {
      packages = [ kubectl-fuzzy ];
      shellAliases.kzf = "${kubectl-fuzzy}";
    };
}
