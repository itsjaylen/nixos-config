# modules/home/terminal/ssh.nix
{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        AddKeysToAgent = "yes";
      };
      "homelab" = {
        HostName = "192.168.50.232";
        User = "jaylen";
        IdentityFile = "~/.ssh/id_ed25519";
      };
      "pve" = {
        HostName = "192.168.50.215";
        User = "root";
        IdentityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}