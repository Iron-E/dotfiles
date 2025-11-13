{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ../../../../lib ];

  services.swayidle =
    let
      swaylock = "/usr/bin/swaylock --daemonize";
    in
    {
      events = [
        {
          event = "before-sleep";
          command = swaylock;
        }
      ];

      timeouts =
        let
          inherit (config.lib.iron-e) swayPkg;
          pgrep = lib.getExe' pkgs.procps "pgrep";

          ifSwaylockRunning =
            isTrue: # bool
            then': # string
            "if ${if isTrue then "" else "!"} ${pgrep} -x swaylock; then ${then'}; fi";

          lockScreen = {
            timeout = 300;
            command = ifSwaylockRunning false swaylock;
          };

          setOutputPower = {
            timeout = 5;
            command = ifSwaylockRunning true setOutputPowerAfterScreenLock.command;
            resumeCommand = ifSwaylockRunning true setOutputPowerAfterScreenLock.resumeCommand;
          };

          setOutputPowerAfterScreenLock =
            let
              outputPower = onOff: ''${swayPkg.swaymsg} "output * power ${onOff}"'';
            in
            {
              timeout = builtins.add lockScreen.timeout setOutputPower.timeout;
              command = outputPower "off";
              resumeCommand = outputPower "on";
            };
        in
        [
          setOutputPower
          lockScreen
          setOutputPowerAfterScreenLock
        ];
    };
}
