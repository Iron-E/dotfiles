{
  outputs,
  lib,
  ...
}:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  home.file =
    let
      inherit (util.lists) repeat;

      twoOf = repeat 2;
      inTwoOf = # interspersed in two of `value` is `delim` (e.g. `(inTwice "foo" "bar") == ["foo" "bar" "foo"]`
        value: # the value for `twice`
        delim: # the value to put in the middle of `twice`
        let
          list = twoOf value;
        in
        lib.intersperse delim list;

      sixOf = repeat 6;
      sixOfThen = # sixOf concated with the valueAfter
        value: valueAfter: (sixOf value) ++ (lib.toList valueAfter);

      common = {
        "8" = null;
        "9" = inTwoOf "Escape" "NoSymbol";
        "10" = twoOf [
          1
          "exclam"
        ];
        "11" = twoOf [
          2
          "at"
        ];
        "12" = twoOf [
          3
          "numbersign"
        ];
        "13" = twoOf [
          4
          "dollar"
        ];
        "14" = twoOf [
          5
          "percent"
        ];
        "15" = twoOf [
          6
          "asciicircum"
        ];
        "16" = twoOf [
          7
          "ampersand"
        ];
        "17" = twoOf [
          8
          "asterisk"
        ];
        "18" = twoOf [
          9
          "parenleft"
        ];
        "19" = twoOf [
          0
          "parenright"
        ];
        "20" = twoOf [
          "minus"
          "underscore"
        ];
        "21" = twoOf [
          "equal"
          "plus"
        ];
        "22" = twoOf [
          "BackSpace"
          "BackSpace"
        ];
        "23" = twoOf [
          "Tab"
          "ISO_Left_Tab"
        ];
        "24" = twoOf [
          "q"
          "Q"
        ];
        "25" = twoOf [
          "w"
          "W"
        ];
        "26" =
          (twoOf [
            "e"
            "E"
          ])
          ++ (inTwoOf "EuroSign" "NoSymbol");
        "27" = twoOf [
          "r"
          "R"
        ];
        "28" = twoOf [
          "t"
          "T"
        ];
        "29" = twoOf [
          "y"
          "Y"
        ];
        "30" = twoOf [
          "u"
          "U"
        ];
        "31" = twoOf [
          "i"
          "I"
        ];
        "32" = twoOf [
          "o"
          "O"
        ];
        "33" = twoOf [
          "p"
          "P"
        ];
        "34" = twoOf [
          "bracketleft"
          "braceleft"
        ];
        "35" = twoOf [
          "bracketright"
          "braceright"
        ];
        "36" = inTwoOf "Return" "NoSymbol";
        "37" = inTwoOf "Control_L" "NoSymbol";
        "38" = twoOf [
          "a"
          "A"
        ];
        "39" = twoOf [
          "s"
          "S"
        ];
        "40" = twoOf [
          "d"
          "D"
        ];
        "41" = twoOf [
          "f"
          "F"
        ];
        "42" = twoOf [
          "g"
          "G"
        ];
        "43" = twoOf [
          "h"
          "H"
        ];
        "44" = twoOf [
          "j"
          "J"
        ];
        "45" = twoOf [
          "k"
          "K"
        ];
        "46" = twoOf [
          "l"
          "L"
        ];
        "47" = twoOf [
          "semicolon"
          "colon"
        ];
        "48" = twoOf [
          "apostrophe"
          "quotedbl"
        ];
        "49" = twoOf [
          "grave"
          "asciitilde"
        ];
        "50" = inTwoOf "Shift_L" "NoSymbol";
        "51" = twoOf [
          "backslash"
          "bar"
        ];
        "52" = twoOf [
          "z"
          "Z"
        ];
        "53" = twoOf [
          "x"
          "X"
        ];
        "54" = twoOf [
          "c"
          "C"
        ];
        "55" = twoOf [
          "v"
          "V"
        ];
        "56" = twoOf [
          "b"
          "B"
        ];
        "57" = twoOf [
          "n"
          "N"
        ];
        "58" = twoOf [
          "m"
          "M"
        ];
        "59" = twoOf [
          "comma"
          "less"
        ];
        "60" = twoOf [
          "period"
          "greater"
        ];
        "61" = twoOf [
          "slash"
          "question"
        ];
        "62" = inTwoOf "Shift_R" "NoSymbol";
        "63" = sixOfThen "KP_Multiply" "XF86ClearGrab";
        "64" = twoOf [
          "Alt_L"
          "Meta_L"
        ];
        "65" = inTwoOf "space" "NoSymbol";
        "66" = inTwoOf "Caps_Lock" "NoSymbol";
        "67" = sixOfThen "F1" "XF86Switch_VT_1";
        "68" = sixOfThen "F2" "XF86Switch_VT_2";
        "69" = sixOfThen "F3" "XF86Switch_VT_3";
        "70" = sixOfThen "F4" "XF86Switch_VT_4";
        "71" = sixOfThen "F5" "XF86Switch_VT_5";
        "72" = sixOfThen "F6" "XF86Switch_VT_6";
        "73" = sixOfThen "F7" "XF86Switch_VT_7";
        "74" = sixOfThen "F8" "XF86Switch_VT_8";
        "75" = sixOfThen "F9" "XF86Switch_VT_9";
        "76" = sixOfThen "F10" "XF86Switch_VT_10";
        "77" = inTwoOf "Num_Lock" "NoSymbol";
        "78" = inTwoOf "Scroll_Lock" "NoSymbol";
        "79" = twoOf [
          "KP_Home"
          "KP_7"
        ];
        "80" = twoOf [
          "KP_Up"
          "KP_8"
        ];
        "81" = twoOf [
          "KP_Prior"
          "KP_9"
        ];
        "82" = sixOfThen "KP_Subtract" "XF86Prev_VMode";
        "83" = twoOf [
          "KP_Left"
          "KP_4"
        ];
        "84" = twoOf [
          "KP_Begin"
          "KP_5"
        ];
        "85" = twoOf [
          "KP_Right"
          "KP_6"
        ];
        "86" = sixOfThen "KP_Add" "XF86Next_VMode";
        "87" = twoOf [
          "KP_End"
          "KP_1"
        ];
        "88" = twoOf [
          "KP_Down"
          "KP_2"
        ];
        "89" = twoOf [
          "KP_Next"
          "KP_3"
        ];
        "90" = twoOf [
          "KP_Insert"
          "KP_0"
        ];
        "91" = twoOf [
          "KP_Delete"
          "KP_Decimal"
        ];
        "92" = inTwoOf "ISO_Level3_Shift" "NoSymbol";
        "93" = null;
        "94" = [
          "less"
          "greater"
          "less"
          "greater"
          "bar"
          "brokenbar"
          "bar"
        ];
        "95" = sixOfThen "F11" "XF86Switch_VT_11";
        "96" = sixOfThen "F12" "XF86Switch_VT_12";
        "97" = null;
        "98" = inTwoOf "Katakana" "NoSymbol";
        "99" = inTwoOf "Hiragana" "NoSymbol";
        "100" = inTwoOf "Henkan_Mode" "NoSymbol";
        "101" = inTwoOf "Hiragana_Katakana" "NoSymbol";
        "102" = inTwoOf "Muhenkan" "NoSymbol";
        "103" = null;
        "104" = inTwoOf "KP_Enter" "NoSymbol";
        "105" = inTwoOf "Control_R" "NoSymbol";
        "106" = sixOfThen "KP_Divide" "XF86Ungrab";
        "107" = twoOf [
          "Print"
          "Sys_Req"
        ];
        "108" = twoOf [
          "Alt_R"
          "Meta_R"
        ];
        "109" = inTwoOf "Linefeed" "NoSymbol";
        "110" = inTwoOf "Home" "NoSymbol";
        "111" = inTwoOf "Up" "NoSymbol";
        "112" = inTwoOf "Prior" "NoSymbol";
        "113" = inTwoOf "Left" "NoSymbol";
        "114" = inTwoOf "Right" "NoSymbol";
        "115" = inTwoOf "End" "NoSymbol";
        "116" = inTwoOf "Down" "NoSymbol";
        "117" = inTwoOf "Next" "NoSymbol";
        "118" = [ "Multi_key" ]; # compose key
        "119" = inTwoOf "Delete" "NoSymbol";
        "120" = null;
        "121" = inTwoOf "XF86AudioMute" "NoSymbol";
        "122" = inTwoOf "XF86AudioLowerVolume" "NoSymbol";
        "123" = inTwoOf "XF86AudioRaiseVolume" "NoSymbol";
        "124" = inTwoOf "XF86PowerOff" "NoSymbol";
        "125" = inTwoOf "equal" "NoSymbol";
        "126" = inTwoOf "plusminus" "NoSymbol";
        "127" = twoOf [
          "Pause"
          "Break"
        ];
        "128" = inTwoOf "XF86LaunchA" "NoSymbol";
        "129" = twoOf [
          "KP_Decimal"
          "KP_Decimal"
        ];
        "130" = inTwoOf "Hangul" "NoSymbol";
        "131" = inTwoOf "Hangul_Hanja" "NoSymbol";
        "132" = null;
        "133" = inTwoOf "Super_L" "NoSymbol";
        "134" = inTwoOf "Super_R" "NoSymbol";
        "135" = inTwoOf "Menu" "NoSymbol";
        "136" = inTwoOf "Cancel" "NoSymbol";
        "137" = inTwoOf "Redo" "NoSymbol";
        "138" = inTwoOf "SunProps" "NoSymbol";
        "139" = inTwoOf "Undo" "NoSymbol";
        "140" = inTwoOf "SunFront" "NoSymbol";
        "141" = inTwoOf "XF86Copy" "NoSymbol";
        "142" = inTwoOf "XF86Open" "NoSymbol";
        "143" = inTwoOf "XF86Paste" "NoSymbol";
        "144" = inTwoOf "Find" "NoSymbol";
        "145" = inTwoOf "XF86Cut" "NoSymbol";
        "146" = inTwoOf "Help" "NoSymbol";
        "147" = inTwoOf "XF86MenuKB" "NoSymbol";
        "148" = inTwoOf "XF86Calculator" "NoSymbol";
        "149" = null;
        "150" = inTwoOf "XF86Sleep" "NoSymbol";
        "151" = inTwoOf "XF86WakeUp" "NoSymbol";
        "152" = inTwoOf "XF86Explorer" "NoSymbol";
        "153" = inTwoOf "XF86Send" "NoSymbol";
        "154" = null;
        "155" = inTwoOf "XF86Xfer" "NoSymbol";
        "156" = inTwoOf "XF86Launch1" "NoSymbol";
        "157" = inTwoOf "XF86Launch2" "NoSymbol";
        "158" = inTwoOf "XF86WWW" "NoSymbol";
        "159" = inTwoOf "XF86DOS" "NoSymbol";
        "160" = inTwoOf "XF86ScreenSaver" "NoSymbol";
        "161" = inTwoOf "XF86RotateWindows" "NoSymbol";
        "162" = inTwoOf "XF86TaskPane" "NoSymbol";
        "163" = inTwoOf "XF86Mail" "NoSymbol";
        "164" = inTwoOf "XF86Favorites" "NoSymbol";
        "165" = inTwoOf "XF86MyComputer" "NoSymbol";
        "166" = inTwoOf "XF86Back" "NoSymbol";
        "167" = inTwoOf "XF86Forward" "NoSymbol";
        "168" = null;
        "169" = inTwoOf "XF86Eject" "NoSymbol";
        "170" = twoOf [
          "XF86Eject"
          "XF86Eject"
        ];
        "171" = inTwoOf "XF86AudioNext" "NoSymbol";
        "172" = twoOf [
          "XF86AudioPlay"
          "XF86AudioPause"
        ];
        "173" = inTwoOf "XF86AudioPrev" "NoSymbol";
        "174" = twoOf [
          "XF86AudioStop"
          "XF86Eject"
        ];
        "175" = inTwoOf "XF86AudioRecord" "NoSymbol";
        "176" = inTwoOf "XF86AudioRewind" "NoSymbol";
        "177" = inTwoOf "XF86Phone" "NoSymbol";
        "178" = null;
        "179" = inTwoOf "XF86Tools" "NoSymbol";
        "180" = inTwoOf "XF86HomePage" "NoSymbol";
        "181" = inTwoOf "XF86Reload" "NoSymbol";
        "182" = inTwoOf "XF86Close" "NoSymbol";
        "183" = null;
        "184" = null;
        "185" = inTwoOf "XF86ScrollUp" "NoSymbol";
        "186" = inTwoOf "XF86ScrollDown" "NoSymbol";
        "187" = inTwoOf "parenleft" "NoSymbol";
        "188" = inTwoOf "parenright" "NoSymbol";
        "189" = inTwoOf "XF86New" "NoSymbol";
        "190" = inTwoOf "Redo" "NoSymbol";
        "191" = inTwoOf "XF86Tools" "NoSymbol";
        "192" = inTwoOf "XF86Launch5" "NoSymbol";
        "193" = inTwoOf "XF86Launch6" "NoSymbol";
        "194" = inTwoOf "XF86Launch7" "NoSymbol";
        "195" = inTwoOf "XF86Launch8" "NoSymbol";
        "196" = inTwoOf "XF86Launch9" "NoSymbol";
        "197" = null;
        "198" = inTwoOf "XF86AudioMicMute" "NoSymbol";
        "199" = inTwoOf "XF86TouchpadToggle" "NoSymbol";
        "200" = inTwoOf "XF86TouchpadOn" "NoSymbol";
        "201" = inTwoOf "XF86TouchpadOff" "NoSymbol";
        "202" = null;
        "203" = inTwoOf "Mode_switch" "NoSymbol";
        "204" = twoOf [
          "NoSymbol"
          "Alt_L"
        ];
        "205" = twoOf [
          "NoSymbol"
          "Meta_L"
        ];
        "206" = twoOf [
          "NoSymbol"
          "Super_L"
        ];
        "207" = twoOf [
          "NoSymbol"
          "Hyper_L"
        ];
        "208" = inTwoOf "XF86AudioPlay" "NoSymbol";
        "209" = inTwoOf "XF86AudioPause" "NoSymbol";
        "210" = inTwoOf "XF86Launch3" "NoSymbol";
        "211" = inTwoOf "XF86Launch4" "NoSymbol";
        "212" = inTwoOf "XF86LaunchB" "NoSymbol";
        "213" = inTwoOf "XF86Suspend" "NoSymbol";
        "214" = inTwoOf "XF86Close" "NoSymbol";
        "215" = inTwoOf "XF86AudioPlay" "NoSymbol";
        "216" = inTwoOf "XF86AudioForward" "NoSymbol";
        "217" = null;
        "218" = inTwoOf "Print" "NoSymbol";
        "219" = null;
        "220" = inTwoOf "XF86WebCam" "NoSymbol";
        "221" = inTwoOf "XF86AudioPreset" "NoSymbol";
        "222" = null;
        "223" = inTwoOf "XF86Mail" "NoSymbol";
        "224" = inTwoOf "XF86Messenger" "NoSymbol";
        "225" = inTwoOf "XF86Search" "NoSymbol";
        "226" = inTwoOf "XF86Go" "NoSymbol";
        "227" = inTwoOf "XF86Finance" "NoSymbol";
        "228" = inTwoOf "XF86Game" "NoSymbol";
        "229" = inTwoOf "XF86Shop" "NoSymbol";
        "230" = null;
        "231" = inTwoOf "Cancel" "NoSymbol";
        "232" = inTwoOf "XF86MonBrightnessDown" "NoSymbol";
        "233" = inTwoOf "XF86MonBrightnessUp" "NoSymbol";
        "234" = inTwoOf "XF86AudioMedia" "NoSymbol";
        "235" = inTwoOf "XF86Display" "NoSymbol";
        "236" = inTwoOf "XF86KbdLightOnOff" "NoSymbol";
        "237" = inTwoOf "XF86KbdBrightnessDown" "NoSymbol";
        "238" = inTwoOf "XF86KbdBrightnessUp" "NoSymbol";
        "239" = inTwoOf "XF86Send" "NoSymbol";
        "240" = inTwoOf "XF86Reply" "NoSymbol";
        "241" = inTwoOf "XF86MailForward" "NoSymbol";
        "242" = inTwoOf "XF86Save" "NoSymbol";
        "243" = inTwoOf "XF86Documents" "NoSymbol";
        "244" = inTwoOf "XF86Battery" "NoSymbol";
        "245" = inTwoOf "XF86Bluetooth" "NoSymbol";
        "246" = inTwoOf "XF86WLAN" "NoSymbol";
        "247" = null;
        "248" = null;
        "249" = null;
        "250" = null;
        "251" = inTwoOf "XF86MonBrightnessCycle" "NoSymbol";
        "252" = null;
        "253" = null;
        "254" = inTwoOf "XF86WWAN" "NoSymbol";
        "255" = inTwoOf "XF86RFKill" "NoSymbol";
      };
    in
    {
      ".Xmodmap".text = util.generators.toXmodmap (
        common
        // {
          "9" = common."66"; # escape is caps lock
          "66" = common."9"; # caps lock is escape
        }
      );

      ".Xmodmap-ext".text = util.generators.toXmodmap common;
    };

  xsession.initExtra = # sh
    ''
      xmodmap "$HOME/.Xmodmap-ext"
    '';
}
