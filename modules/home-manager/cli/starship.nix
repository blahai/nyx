{ config, lib, pkgs, ... }:
{
  programs.starship = {
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
          ".config" = " ";
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
}
