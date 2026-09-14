

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tmux
    jq
    htop
  ];
}
