nixpkgs: # `flake`
let
  inherit (nixpkgs) lib;

  entriesToPaths = # convert output of `readDir` to list of path
    parent: # `path`
    fsEntries: # the output of `readDir`
    let
      entryNames = builtins.attrNames fsEntries;
    in
    map (fsEntry: parent + "/${fsEntry}") entryNames;

  filterPaths = # removes `exclude`d elems from `path`
    paths: # `[path]`
    exclude: # `[path]`
    builtins.filter (p: !(builtins.elem p exclude)) paths;

  pathIsModule = # the path is a nix module
    path: # `path`
    let
      isNixFile = (lib.pathIsRegularFile path) && (lib.hasSuffix ".nix" path);
      isNixDir =
        (lib.pathIsDirectory path)
        && (
          let
            fsEntries = builtins.readDir path;
          in
          fsEntries ? "default.nix"
        );
    in
    isNixFile || isNixDir;

  readPaths = # convert output of `readDir` to list of path
    path: # `path`
    entriesToPaths path (builtins.readDir path);

  readModules = # convert output of `readDir` to list of module paths
    path: # `path`
    let
      paths = readPaths path;
    in
    builtins.filter pathIsModule paths;

  readSubmodules' = # read all paths from the `path` except 'default.nix'
    path: # the path to read submodules in
    let
      currentModule = path + "/default.nix";
      modules = readModules path;
    in
    builtins.filter (p: p != currentModule) modules;

  readSubmodules = # like `readSubmodules'` but skips the `lib` dir
    path:
    let
      libPath = path + "/lib";
      submodules = readSubmodules' path;
    in
    builtins.filter (path: path != libPath) submodules;
in
{
  inherit
    entriesToPaths
    filterPaths
    pathIsModule
    readModules
    readSubmodules
    readSubmodules'
    ;

  filterSubmodules = lib.flip lib.pipe [
    readSubmodules
    filterPaths
  ];
}
