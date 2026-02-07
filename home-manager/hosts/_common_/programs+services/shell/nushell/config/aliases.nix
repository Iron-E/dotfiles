{ config, lib, ... }:
{
  imports = [ ];

  programs.nushell.shellAliases =
    # nushell does not support most posixisms
    (builtins.mapAttrs (
      _: v: lib.mkOverride 90 "exec bash -ic r#'${v}; exec nu'#"
    ) config.home.shellAliases)
    // {
      a = "append";
      clr = lib.mkForce "clear";
      "from jsonl" = "from json -o";
      ins = "insert";
      la = lib.mkForce "ls -a";
      mkdir = lib.mkForce "mkdir";
      o = "open";
      p = "prepend";
      up = "update";
      ups = "upsert";
    };
}
