# modules/home/yazi.nix
{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;

    settings = {
      mgr = {
        show_hidden = true;
        sort_by = "alphabetical";
      };
      plugin = {
        prepend_previewers = [
          { url = "*.md"; run = "mdcat"; }
          { url = "*"; run = "eza-preview"; }
          { mime = "application/{*zip,tar,bzip2,7z*,rar,xz,zstd,java-archive}"; run = "ouch"; }
        ];
      };
    };

    theme = {
      flavor = {
        dark = "dracula";
      };
    };
  };

  xdg.configFile = {
    "yazi/plugins/audio-preview.yazi".source = pkgs.fetchFromGitHub {
      owner = "gesellkammer";
      repo = "audio-preview";
      rev = "74dfea3";
      hash = "sha256-IK0Ye/EPjOGC+//HpjExVTAKfXtlgOrYbFLrhy/DF6k=";
    };

    "yazi/plugins/eza-preview.yazi".source = pkgs.fetchFromGitHub {
      owner = "ahkohd";
      repo = "eza-preview.yazi";
      rev = "dc9c103";
      hash = "sha256-14x/bD0aD9hXONaqQD8Dt7rLBCMq7bkVLH6uCPOQ0C8=";
    };

    "yazi/plugins/ouch.yazi".source = pkgs.fetchFromGitHub {
      owner = "ndtoan96";
      repo = "ouch.yazi";
      rev = "406ce6c";
      hash = pkgs.lib.fakeHash;
    };

    "yazi/flavors/dracula.yazi".source = pkgs.fetchFromGitHub {
      owner = "yazi-rs";
      repo = "flavors";
      rev = "36c49ac";
      hash = pkgs.lib.fakeHash;
    } + "/dracula.yazi";

    "yazi/flavors/catppuccin-frappe.yazi".source = pkgs.fetchFromGitHub {
      owner = "yazi-rs";
      repo = "flavors";
      rev = "36c49ac";
      hash = pkgs.lib.fakeHash;
    } + "/catppuccin-frappe.yazi";
  };
}