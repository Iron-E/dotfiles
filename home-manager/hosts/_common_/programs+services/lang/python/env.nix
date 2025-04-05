{ config, ... }:
{
  imports = [ ];

  home.sessionVariables =
    let
      inherit (config) xdg;
    in
    {
      PYTHON_HISTORY = "${xdg.stateHome}/python/history";
      PYTHONPYCACHEPREFIX = "${xdg.cacheHome}/python";
      PYTHONUSERBASE = "${xdg.dataHome}/python";
    };
}
