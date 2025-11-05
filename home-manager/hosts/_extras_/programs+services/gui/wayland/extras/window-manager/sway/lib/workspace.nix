{
  config,
  lib,
  outputs,
  ...
}:
let
  util = outputs.lib;
in
{
  imports = [ ];

  lib.iron-e.swayWorkspace = rec {
    count = 10;

    default = get 3;

    names = util.lists.reserveWith (i: toString (i + 1)) count [
      "1 | Browsers"
      "2 | Misc"
      "3 | Editors"
      "4 | Background"
      "5 | Comms"
    ];

    get =
      idx: # integer
      builtins.elemAt names (idx - 1);

    assignOutput =
      workspace: # string
      outputs: # [string]
      {
        inherit workspace;
        output = outputs;
      };
  };
}
