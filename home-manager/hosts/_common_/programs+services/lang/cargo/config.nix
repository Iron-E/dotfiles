{ pkgs, lib, config, ... }:
{
  imports = [ ];

  home.file.".cargo/config.toml".source = (pkgs.formats.toml { }).generate "cargo-config" {
    target.x86_64-unknown-linux-gnu = {
      linker = "clang";
      rustflags = [
        "-C"
        "link-arg=-fuse-ld=${lib.getExe pkgs.mold}"
      ];
    };
  };
}
