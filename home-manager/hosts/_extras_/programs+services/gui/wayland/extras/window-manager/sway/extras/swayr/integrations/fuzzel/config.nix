{ ... }:
{
  imports = [ ];

  programs.swayr.settings = {
    menu = {
      executable = "fuzzel";
      args = [
        "--dmenu"
        "--prompt=Switch Window ❯ "
        "--width=100"
        "--line-height=28"
      ];
    };

    format = {
      window_format = "{app_name:{:<11.11}} “{title:{:<60.60}...}” {id:{:<3.3}} on {workspace_name:{:<13.13}}\u0000icon\u001f{app_icon}";
      indent = "    ";
    };
  };
}
