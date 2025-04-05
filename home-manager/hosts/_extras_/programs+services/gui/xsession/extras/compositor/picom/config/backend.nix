{ ... }:
{
  imports = [ ];

  # Backend to use: "xrender" or "glx".
  # GLX backend is typically much faster but depends on a sane driver.
  services.picom.backend = "xr_glx_hybrid";
}
