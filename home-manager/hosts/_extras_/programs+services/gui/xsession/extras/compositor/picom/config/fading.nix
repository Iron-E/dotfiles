{ ... }:
{
  imports = [ ];

  services.picom = {
    # Fade windows during opacity changes.
    fade = true;

    # The time between steps in a fade in milliseconds. (default 10).
    fadeDelta = 4;

    # Opacity change between steps while fading in and fading out. (default [0.028 0.03]).
    fadeSteps = [
      0.03
      0.03
    ];
  };
}
