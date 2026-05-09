{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkIf
    mkOption
    types
    ;

  cfg = config.programs.kubectl;

  format = pkgs.formats.yaml { };

  kubercModule = types.submodule {
    options = {
      apiVersion = mkOption {
        type = types.str;
        default = "v1beta1";
        description = "The api version";
      };

      defaults = mkOption {
        type = types.attrsOf (types.attrsOf types.str);
        default = { };
        description = "Command defaults";
      };

      aliases = mkOption {
        type = types.attrsOf aliasModule;
        default = [ ];
        description = "Command aliases";
      };

      credentialPluginPolicy = mkOption {
        type = types.enum [
          ""
          "AllowAll"
          "DenyAll"
          "Allowlist"
        ];

        default = "";
        description = "Credential plugin policy";
      };

      credentialPluginAllowlist = mkOption {
        type = types.nullOr (types.attrsOf types.str);
        default = null;
        description = "Credential plugins allowed";
      };
    };
  };

  aliasModule = types.submodule {
    options = {
      command = mkOption {
        type = types.str;
        description = "The command";
      };

      prependArgs = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "Args to prepend";
      };

      appendArgs = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "Args to append";
      };

      options = mkOption {
        type = types.attrsOf types.str;
        default = { };
        description = "Args to append";
      };
    };
  };
in
{
  options.programs.kubectl = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable kubectl integration";
    };

    package = mkOption {
      type = types.package;
      default = pkgs.kubectl;
      description = "Kubectl package";
    };

    kuberc = mkOption {
      type = kubercModule;
      default = { };
      description = "The kuberc config";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.sessionVariables.KUBERC = "${config.xdg.configHome}/kube/kuberc.yaml";

    xdg.configFile."kube/kuberc.yaml".source =
      let
        # foldlattrs is a confusing function.
        #
        # hopefully this will help:
        # function foldlAttrs(f: (acc: T, name, default) => T, init: T, attrs) {}
        fromOptionSet = lib.foldlAttrs (
          acc: name: default:
          acc ++ [ { inherit name default; } ]
        ) [ ];
      in
      format.generate "kuberc.yaml" {
        apiVersion = "kubectl.config.k8s.io/${cfg.kuberc.apiVersion}";
        kind = "Preference";

        aliases = lib.foldlAttrs (
          acc: name: value:
          acc
          ++ [
            (
              value
              // {
                inherit name;
                options = fromOptionSet value.options;
              }
            )
          ]
        ) [ ] cfg.kuberc.aliases;

        defaults = lib.foldlAttrs (
          acc: command: optionSet:
          acc
          ++ [
            {
              inherit command;
              options = fromOptionSet optionSet;
            }
          ]
        ) [ ] cfg.kuberc.defaults;

        credentialPluginPolicy = cfg.kuberc.credentialPluginPolicy;
        credentialPluginAllowlist =
          if cfg.kuberc.credentialPluginAllowlist == null then
            null
          else
            lib.foldlAttrs (
              acc: name: command:
              acc ++ [ { inherit name command; } ]
            ) [ ] cfg.kuberc.credentialPluginAllowlist;
      };
  };
}
