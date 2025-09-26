{ ... }:
{
  imports = [ ];

  home.shellAliases = rec {
    jq = "gojq";
    jqy = "${jq} --yaml-output";

    yqj = "gojq --yaml-input";
    yq = "${yqj} --yaml-output";
  };
}
