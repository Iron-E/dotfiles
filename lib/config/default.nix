nixpkgs: # `flake`
let
  inherit (nixpkgs) lib;
  inherit (lib)
    getAttrFromPath
    recursiveUpdate
    ;

  attrsets = import ../attrsets nixpkgs;

  getEnabled = builtins.getAttr "enable";
in
{
  inherit getEnabled;

  nixpkgs =
    flakesWithOverlays: # flake inputs that have overlays
    overlays: # regular overlays to apply
    extraConfig: # the nixpkgs config
    let
      defaultNixpkgsConfig = {
        config.allowUnfree = true;
        overlays =
          overlays
          ++ (map (getAttrFromPath [
            "overlays"
            "default"
          ]) flakesWithOverlays);
      };
    in
    if extraConfig == null then
      defaultNixpkgsConfig
    else
      recursiveUpdate extraConfig defaultNixpkgsConfig;

  optionalIfAnyEnabled = # returns `attrset` if any in the `list` where `{ enabled = true; }`
    list: # see `optionalIfAny`
    attrset: # see `optionalIfAny`
    attrsets.optionalIfAny getEnabled list attrset;
}
