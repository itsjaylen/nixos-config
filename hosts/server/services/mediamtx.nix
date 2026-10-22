{ pkgs, ... }:
{
  services.mediamtx.enable = true;

  services.mediamtx.settings = {
    # Logging
    logLevel = "info";
    logDestinations = [ "stdout" ];

    # Enable all protocols (corresponding to your Docker port mappings)
    rtsp = true;
    rtmp = true;
    hls = true;
    webrtc = true;
    srt = true;          # UDP 8890 in Docker
    api = true;
    apiAddress = ":9997";

    # Key: define a generic path so OBS can publish and ingestgo can query
    paths = {
      all_others = {};   # Allow any path name without pre-definition
      # Or explicitly define the path used by OBS:
      # mystream = { source = "publisher"; };
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      1935   # RTMP
      8554   # RTSP
      8888   # HLS
      8889   # WebRTC
      9997   # API
    ];
    allowedUDPPorts = [
      8890   # SRT
      8189   # WebRTC ICE
    ];
  };
}