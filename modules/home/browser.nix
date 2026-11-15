{ inputs, pkgs, ... }:
{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    # Key: Add SwiftDL's native messaging host
    nativeMessagingHosts = [
      # If your swiftdl package has the manifest installed in a standard location (such as lib/mozilla/native-messaging-hosts), just pass the package directly:
      inputs.self.packages.${pkgs.system}.swiftdl

      # If not, you can also directly specify the manifest path (adjust according to the actual find result):
      # "${inputs.self.packages.${pkgs.system}.swiftdl}/lib/mozilla/native-messaging-hosts/com.swiftdl.host.json"
    ];
  };
}