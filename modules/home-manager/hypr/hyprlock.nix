{ config, ... }: {

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 5;
        no_fade_in = true;
        no_fade_out = true;
      };

      backgruond = {
        color = "rgba(000000FF)";
      };

      input-field = [{
        monitor = "";
        size = "250, 50";
        outline_thickness = 2;
        dots_size = 0.1;
        dots_spacing = 0.3;
        outer_color = "rgba(8C909F55)";
        inner_color = "rgba(0F131C11)";
        font_color = "rgba(C2C6D6FF)";

        position = "0, 20";
        halign = "center";
        valign = "center";
      }];

      label = [
        { # Clock
          monitor  = "";
          text     = "$TIME";
          shadow_passes  = 1;
          shadow_boost  = 0.5;
          color    = "rgba(FFFFFFFF)";
          font_size   = "65";
          font_family = "Rubik Light";

          position = "0, 300";
        }

        { # Greeting
          monitor = "";
          text = "Hi $USER !!!";
          shadow_passes = 1;
          shadow_boost = 0.5;
          color = "rgba(FFFFFFFF)";
          font_size = "20";
          font_family = "Rubik Light";

          position = "0, 240";
          halign = "center";
          valign = "center";
        }

        { # lock icon
          monitor = "";
          text    = "lock";
          shadow_passes   = 1;
          shadow_boost   = 0.5;
          color     = "rgba(FFFFFFFF)";
          font_size    = "21";
          font_family  = "Material Symbols Rounded";

          position = "0, 65";
          halign = "center";
          valign = "center";
        }

        { # "locked" text
          monitor = "";
          text = "locked";
          shadow_passes = 1;
          shadow_boost = 0.5;
          color     = "rgba(FFFFFFFF)";
          font_size    = "14";
          font_family   = "Rubik Light";
          position = "0, 45";
          halign = "center";
          valign = "center";
        }

        #{ # Status
        #  monitor = "";
        #  text     = "";
        #  shadow_passes    = 1;
        #  shadow_boost    = 0.5;
        #  color      = "rgba(FFFFFFFF)";
        #  font_size     = "24";
        #  font_family   = "Rubik Light";
        #}
      ];

    };
  };
}