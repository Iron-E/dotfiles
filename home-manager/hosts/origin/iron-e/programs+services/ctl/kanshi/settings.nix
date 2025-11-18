{ ... }:
{
  imports = [ ];

  services.kanshi.settings =
    let
      output' =
        criteria: # string
        settings: # attrset
        { inherit criteria; } // settings;

      output =
        criteria: # string
        alias: # string
        settings: # attrset
        {
          output = output' criteria ({ inherit alias; } // settings);
        };

      profile =
        name: # string
        outputs: # attrset
        { profile = { inherit name outputs; }; };
    in
    [
      (output "AU Optronics 0x403D Unknown" "laptop" {
        mode = "1920x1080@60.049Hz";
      })

      (output "LG Electronics LG HDR 4K 0x0004DF17" "left_monitor" {
        mode = "2560x1440@59.951Hz";
        transform = "90";
      })

      (output "Dell Inc. DELL U2725QE 2B11H84" "right_monitor" {
        mode = "2560x1440@59.951Hz";
      })

      (profile "undocked" [
        (output' "$laptop" { position = "0,0"; })
      ])

      (profile "docked-leftMonitor" [
        (output' "$left_monitor" { position = "0,0"; })
        (output' "$laptop" { position = "1440,0"; })
      ])

      (profile "docked-rightMonitor" [
        (output' "$right_monitor" { position = "0,0"; })
        (output' "$laptop" { position = "2560,572"; })
      ])

      (profile "docked" [
        (output' "$left_monitor" { position = "0,0"; })
        (output' "$right_monitor" { position = "1440,572"; })
        (output' "$laptop" { position = "4000,572"; })
      ])
    ];
}
