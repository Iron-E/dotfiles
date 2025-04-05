{ ... }:
{
  imports = [ ];

  programs.yazi.keymap.manager.prepend_keymap = [
    {
      on = [ "1" ];
      run = "plugin relative-motions --args=1";
      desc = "Move in 1 relative steps";
    }
    {
      on = [ "2" ];
      run = "plugin relative-motions --args=2";
      desc = "Move in 2 relative steps";
    }
    {
      on = [ "3" ];
      run = "plugin relative-motions --args=3";
      desc = "Move in 3 relative steps";
    }
    {
      on = [ "4" ];
      run = "plugin relative-motions --args=4";
      desc = "Move in 4 relative steps";
    }
    {
      on = [ "5" ];
      run = "plugin relative-motions --args=5";
      desc = "Move in 5 relative steps";
    }
    {
      on = [ "6" ];
      run = "plugin relative-motions --args=6";
      desc = "Move in 6 relative steps";
    }
    {
      on = [ "7" ];
      run = "plugin relative-motions --args=7";
      desc = "Move in 7 relative steps";
    }
    {
      on = [ "8" ];
      run = "plugin relative-motions --args=8";
      desc = "Move in 8 relative steps";
    }
    {
      on = [ "9" ];
      run = "plugin relative-motions --args=9";
      desc = "Move in 9 relative steps";
    }
  ];
}
