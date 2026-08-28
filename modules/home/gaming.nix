{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ## Minecraft
    prismlauncher
    lunar-client
  ];
}
