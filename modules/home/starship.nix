{ pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true; # Enables Starship integration for fish shell automatically

    settings = {
      format = ''
        $directory$git_branch$rust$python$golang$container
        $character'';

      palette = "colors";

      palettes.colors = {
        mustard = "#af8700";
        color1 = "#f8b1dc";
        color2 = "#501e41";
        color3 = "#d3c2c9";
        color4 = "#251e21";
        color5 = "#501e41";
        color6 = "#181115";
        color7 = "#181115";
        color8 = "#f8b1dc";
        color9 = "#f4ba9f";
      };

      character = {
        success_symbol = "[🞈](color9 bold)";
        error_symbol = "[🞈](color8 bold)";
        vicmd_symbol = "[🞈](#f9e2af)";
      };

      directory = {
        format = "[](fg:color1 bg:color4)[󰉋](bg:color1 fg:color2)[ ](fg:color1 bg:color4)[$path ](fg:color3 bg:color4)[ ](fg:color4)";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
        };
      };

      git_branch = {
        format = "[](fg:color8 bg:color4)[ ](bg:color8 fg:color5)[](fg:color8 bg:color4)[(bg:color8 fg:color5) $branch](fg:color3 bg:color4)[](fg:color4) ";
      };

      time = {
        format = "[](fg:color8 bg:color4)[ ](bg:color8 fg:color5)[](fg:color8 bg:color4)[(bg:color8 fg:color5) $time](fg:color3 bg:color4)[](fg:color4) ";
        disabled = false;
        time_format = "%R";
      };

      python = {
        format = "[](fg:color8 bg:color4)[\${symbol}\${version}](bg:color8 fg:color5)[](fg:color8 bg:color4)[(bg:color8 fg:color5)( \${virtualenv})](fg:color3 bg:color4)[](fg:color4) ";
        symbol = "🐍";
        pyenv_prefix = "venv";
      };

      golang = {
        format = "[](fg:color8 bg:color4)[🐹 \${version}]({bg:color8 fg:color5})[](fg:color8 bg:color4)[](fg:color4) ";
      };

      container = {
        format = "[](fg:color8 bg:color4)[󰡨 \${symbol}]({bg:color8 fg:color5})[](fg:color8 bg:color4)[](fg:color4) ";
      };
    };
  };
}