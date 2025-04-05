nixpkgs:
let
  inherit (nixpkgs.lib)
    attrByPath
    nameValuePair
    optionalAttrs
    recursiveUpdate
    ;
in
{
  concat = # recursively merges a list of attrsets together
    attrsets: builtins.foldl' recursiveUpdate { } attrsets;

  optionalMapByPath = # @returns output of `fn` or empty set
    attrPath: # string[]
    set: # attrset
    fn: # `attrset: any`
    let
      attrs = attrByPath attrPath null set;
    in
    if attrs == null then { } else fn attrs;

  optionalIfAny = # returns `attrset` if any `predicate` returns `true` in `list`
    predicate: # see `builtins.any`
    list: # see `builtins.any`
    attrset: # seet `lib.optionalAttrs`
    let
      hadAny = builtins.any predicate list;
    in
    optionalAttrs hadAny attrset;

  pair = # converts a name value pair to an attribute
    name: # see listToAttrs
    value: # see listToAttrs
    builtins.listToAttrs [ (nameValuePair name value) ];
}
