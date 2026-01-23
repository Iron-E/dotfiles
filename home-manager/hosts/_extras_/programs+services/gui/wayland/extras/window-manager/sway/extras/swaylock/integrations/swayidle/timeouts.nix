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
      pgrep = lib.getExe' pkgs.procps "pgrep";
      swaylock = "/usr/bin/swaylock --daemonize";

      ifSwaylockRunning =
        isTrue: # bool
        then': # string
        "if ${if isTrue then "" else "!"} ${pgrep} -x swaylock; then ${then'}; fi";
    in
    {
      events = {
        "before-sleep" = ifSwaylockRunning false swaylock;
        "lock" = swaylock;
      };

      timeouts =
        let
          inherit (config.lib.iron-e) swayPkg;

          lockScreen = {
            timeout = 300;
            command = ifSwaylockRunning false swaylock;
          };

          setOutputPowerAfterLockScreenTimeout =
            let
              outputPower = onOff: ''${swayPkg.swaymsg} "output * power ${onOff}"'';
            in
            {
              timeout = builtins.add lockScreen.timeout setOutputPowerAfterManuallyLockingScreen.timeout;
              command = outputPower "off";
              resumeCommand = outputPower "on";
            };

          setOutputPowerAfterManuallyLockingScreen = {
            timeout = 5;
            command = ifSwaylockRunning true setOutputPowerAfterLockScreenTimeout.command;
            resumeCommand = ifSwaylockRunning true setOutputPowerAfterLockScreenTimeout.resumeCommand;
          };
        in
        [
          lockScreen
          setOutputPowerAfterLockScreenTimeout
          setOutputPowerAfterManuallyLockingScreen
        ];
    };
}
