lib: # `flake`
{
  attrsets = import ./attrsets lib;
  config = import ./config lib;
  fs = import ./fs lib;
  generators = import ./generators lib;
  lists = import ./lists lib;
  strings = import ./strings lib;
  systems = import ./systems lib;
}
