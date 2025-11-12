{ ... }:
{
  imports = [ ];

  programs.git.settings.maintenance = {
    commit-graph = true;
    gc = true;
    incremental-repack = true;
    loose-objects = true;
    pack-refs = true;
  };
}
