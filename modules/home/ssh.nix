{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "*" = {
        AddKeysToAgent = "1h";

        # Multiplexing (reuses single TCP connection for instant SSH calls)
        ControlMaster = "auto";
        ControlPath = "~/.ssh/control-%r@%h:%p";
        ControlPersist = "10m";

        ForwardAgent = "no";
        Compression = "no";
        ServerAliveInterval = "60";
        ServerAliveCountMax = "3";
        HashKnownHosts = "no";
        UserKnownHostsFile = "~/.ssh/known_hosts";

        # Default SSH key
        IdentityFile = "~/.ssh/id_rsa";
      };

      # GitHub
      "github.com" = {
        User = "git";
        IdentityFile = "~/.ssh/id_rsa";
        IdentitiesOnly = "yes";
      };

      # Gitea - Domain (External / Tailscale / Cloudflare)
      "gitea.itsjaylen.com" = {
        User = "git";
        IdentityFile = "~/.ssh/id_rsa";
        IdentitiesOnly = "yes";
      };

      # Gitea - Local LAN IP (Direct access)
      "192.168.50.123" = {
        User = "git";
        IdentityFile = "~/.ssh/id_rsa";
        IdentitiesOnly = "yes";
      };

      # Shortcuts for direct terminal access
      "lab" = {
        HostName = "192.168.50.178";
        User = "root";
        IdentityFile = "~/.ssh/id_rsa";
      };

      "home-lab" = {
        HostName = "192.168.50.232";
        User = "jaylen";
        IdentityFile = "~/.ssh/id_rsa";
      };
    };
  };

  services.ssh-agent.enable = true;
}
