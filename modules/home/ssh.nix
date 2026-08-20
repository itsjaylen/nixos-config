{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        addKeysToAgent = "1h";

        # Multiplexing (reuses single TCP connection for instant SSH calls)
        controlMaster = "auto";
        controlPath = "~/.ssh/control-%r@%h:%p";
        controlPersist = "10m";

        forwardAgent = false;
        compression = false;
        serverAliveInterval = 60;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";

        # Default SSH key
        identityFile = "~/.ssh/id_rsa";
      };

      # GitHub
      "github.com" = {
        host = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_rsa";
        identitiesOnly = true;
      };

      # Gitea - Domain (External / Tailscale / Cloudflare)
      "gitea.itsjaylen.com" = {
        host = "gitea.itsjaylen.com";
        user = "git";
        identityFile = "~/.ssh/id_rsa";
        identitiesOnly = true;
        # If running SSH on custom port (e.g., 2222), uncomment and change:
        # port = 2222;
      };

      # Gitea - Local LAN IP (Direct access)
      "192.168.50.123" = {
        host = "192.168.50.123";
        user = "git";
        identityFile = "~/.ssh/id_rsa";
        identitiesOnly = true;
      };

      # Shortcuts for direct terminal access
      "lab" = {
        hostname = "192.168.50.178";
        user = "root";
        identityFile = "~/.ssh/id_rsa";
      };

      "home-lab" = {
        hostname = "192.168.50.232";
        user = "jaylen";
        identityFile = "~/.ssh/id_rsa";
      };
    };
  };

  services.ssh-agent.enable = true;
}