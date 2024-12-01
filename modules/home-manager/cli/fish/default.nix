{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    neofetch
  ];
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      function fish_greeting
        if test -z $DEVSHELL_NIX;
          echo The time is (set_color purple; date +%T; set_color purple)
          if test -z $SSH_CLIENT;
            fastfetch
          else
            neofetch
          end
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
      os-age = ''
        function os-age
          stat / | awk '/Birth: /{print $2 " " substr($3,1,5)}'
        end
      '';

      build-iso = ''
        function build-iso
          cd ~/.config/nixos 
          nix build .#nixosConfigurations.epimetheus.config.system.build.isoImage
      '';

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
