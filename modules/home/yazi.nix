# modules/home/yazi.nix
{ pkgs, lib, ... }:

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
          { mime = "application/zip"; run = "ouch"; }
          { mime = "application/tar*"; run = "ouch"; }
          { mime = "application/bzip2"; run = "ouch"; }
          { mime = "application/x-7z-compressed"; run = "ouch"; }
          { mime = "application/vnd.rar"; run = "ouch"; }
          { mime = "application/xz"; run = "ouch"; }
          { mime = "application/zstd"; run = "ouch"; }
          { mime = "application/java-archive"; run = "ouch"; }
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
      repo = "audio-preview.yazi";
      rev = "74dfea3";
      hash = "sha256-IK0Ye/EPjOGC+//HpjExVTAKfXtlgOrYbFLrhy/DF6k="; # <--- Updated with real hash
    };

    "yazi/plugins/ouch.yazi".source = pkgs.fetchFromGitHub {
      owner = "ndtoan96";
      repo = "ouch.yazi";
      rev = "406ce6c";
      hash = "sha256-14x/bD0aD9hXONaqQD8Dt7rLBCMq7bkVLH6uCPOQ0C8=";
    };

    "yazi/flavors/dracula.yazi".source = (pkgs.fetchFromGitHub {
      owner = "yazi-rs";
      repo = "flavors";
      rev = "36c49ac";
      hash = "sha256-IK0Ye/EPjOGC+//HpjExVTAKfXtlgOrYbFLrhy/DF6k="; # <--- Still needs real hash
    }) + "/dracula.yazi";

    "yazi/flavors/catppuccin-frappe.yazi".source = (pkgs.fetchFromGitHub {
      owner = "yazi-rs";
      repo = "flavors";
      rev = "36c49ac";
      hash = "sha256-IK0Ye/EPjOGC+//HpjExVTAKfXtlgOrYbFLrhy/DF6k="; # <--- Still needs real hash
    }) + "/catppuccin-frappe.yazi";
  };
}
