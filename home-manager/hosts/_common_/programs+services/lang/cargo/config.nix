{
  pkgs,
  lib,
  ...
}:
{
  imports = [ ];

  home.file.".cargo/config.toml".source = (pkgs.formats.toml { }).generate "cargo-config" {
    build.rustc-wrapper = lib.getExe pkgs.sccache;
    target.x86_64-unknown-linux-gnu = {
      linker = "clang";
      rustflags = [
        "-C"
        "link-arg=-fuse-ld=${lib.getExe pkgs.mold}"
      ];
    };
  };
}
