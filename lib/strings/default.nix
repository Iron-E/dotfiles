{ lib, ... }: # nixpkgs flake
let
  inherit (lib)
    concatLines
    concatStrings
    flatten
    pipe
    toList
    ;

  join' = # join the nested list of strings together without any separator
    fn: # the fn to join with
    stringLists: # `[[string]]`
    fn (
      pipe stringLists [
        toList
        flatten
      ]
    );
in
{
  join = join' concatStrings;
  joinLines = join' concatLines;
}
