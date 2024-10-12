{ config, lib, pkgs, ... }: {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      function fish_greeting
        echo The time is (set_color purple; date +%T; set_color purple)
        if test -z $SSH_CLIENT;
          fastfetch
        else
          neofetch
        end
      end
    '';

    shellAliases = {
      "ls" = "eza -l -a --group-directories-first --icons";
      "grep" = "rg -p";
      "rg" = "rg -p";

      "cp" = "cp -rv";

      ":q" = "exit";
      ":qa" = "pkill fish";
      ".." = "z ..";
      ".2" = "z ../..";
      ".3" = "z ../../..";
      ".4" = "z ../../../..";
      ".5" = "z ../../../../..";
      ".r" = "z /";
      ".h" = "z ~";
      ".c" = "z ~/.config/";
      ".a" = "z ~/.config/ags/";
      ".d" = "z ~/Documents/";
      ".C" = "z ~/Documents/code/";
      ".D" = "z ~/Downloads/";
      ".p" = "z ~/Pictures/";

      # git
      "gc" = "git clone";
      "gp" = "git push";
      "ga" = "git add";
      "gcm" = "git commit -m";

      "fetch" = "clear ; fastfetch --logo ~/Downloads/gay.png --logo-width 32";
      "hvim" = "z ~/.config/hypr/ ; nvim ; z";
      "fvim" = "nvim ~/.config/fish/config.fish";
      "se" = "sudoedit";
      "vim" = "nvim";
      "nvide" = "env -u WAYLAND_DISPLAY neovide --multigrid";
      "transcat" = "queercat -b -f 1 -v 0.45 -h 0.45";
      "clock" = "tty-clock -s -C 5 -D -c -b";
    };

    functions = {
      # Credit for these 3
      # https://www.reddit.com/r/linux/comments/1fq0za8/comment/lp1ybdn
      disks = ''
        function disks
          lsblk -o NAME,MOUNTPOINT,FSTYPE,FSUSE%,SIZE
        end
      '';

      gr = ''
        function gr
          set GROOT (git rev-parse --show-toplevel 2>/dev/null); and cd $GROOT; or return $argv
        end
      '';

      mkcd = ''
        function mkcd
          mkdir -p -- $argv[1] && cd $argv; or return $status
        end
      '';

    };
  };

  programs = {
    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = false;
        format = "[](bg:none fg:#f38ba8)$username[](bg:#fab387 fg:#f38ba8)$hostname[](bg:#f9e2af fg:#fab387)$directory[](bg:#a6e3a1 fg:#f9e2af)$git_branch[](bg:#74c7ec fg:#a6e3a1)$cmd_duration[](bg:none fg:#74c7ec)$line_break$character";

        character = {
          success_symbol = "[ 󱞪](#a6e3a1 bold)";
          error_symbol = "[ 󱞪](#f38ba8)";
          vicmd_symbol = "[ 󱞪❯](#f9e2af)";
        };

        username = {
          format = "[ $user ](bg:#f38ba8 fg:#1e1e2e bold)";
          show_always = true;
        };

        hostname = {
          format = "[  $hostname ]( bg:#fab387 fg:#1e1e2e bold)";
          ssh_only = false;
        };

        directory = {
          truncation_length = 5;
          format = "[  $path](bg:#f9e2af fg:#1e1e2e bold)";
          substitutions = {
            "Documents" = "󰈙 ";
            "Downloads" = " ";
            "Music" = " ";
            "Pictures" = " ";
            "Videos" = " ";
            "iso" = "󰌽 ";
            ".config" = "";
          };
        };

        git_branch = {
          format = "[  $branch](bg:#a6e3a1 fg:#1e1e2e bold)";
        };

        cmd_duration = {
          min_time = 4;
          show_milliseconds = false;
          format = "[ 󱑆 $duration](bg:#74c7ec fg:#1e1e2e bold)";
        };
      };
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    atuin = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
