{ ... }:
{
  imports = [
    ./key.nix
    ./pkg.nix
  ];

  lib.iron-e.swayColor = rec {
    # generate common color layouts for bars
    barPreset =
      {
        background ? preset.default.background,
        text ? preset.default.text,
        border ? background,
        ...
      }:
      {
        inherit background border text;
      };

    # generate common colors for client.*
    clientPreset =
      colors@{
        indicator ? preset.default.indicator,
        childBorder ? null,
        ...
      }:
      let
        colors' = barPreset colors;
      in
      colors'
      // {
        inherit indicator;
        childBorder = if childBorder == null then colors'.border else childBorder;
      };

    preset = rec {
      default = {
        indicator = "#22ff22";
        text = "#ffffff";
        background = "#af60af";
      };

      inactive = {
        inherit (default) indicator;
        background = "#35353a";
        text = "#c0c0c0";
      };

      urgent = {
        inherit (default) indicator text;
        background = "#a80000";
      };
    };
  };

}
