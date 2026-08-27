{ pkgs, ... }:
{
  security = {
    rtkit.enable = true;
    sudo.enable = true;

    pam.services = {
      login.kwallet.enable = true;

      swaylock.kwallet.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    kdePackages.kwallet
    kdePackages.kwalletmanager
    kdePackages.kwallet-pam
  ];
}