{ lib
, stdenv
, fetchFromGitHub
, rustPlatform
, cargo-tauri
, pkg-config
, wrapGAppsHook4
, glib-networking
, openssl
, webkitgtk_4_1
, libayatana-appindicator
, inputs
, ffmpeg
, makeWrapper
}:

rustPlatform.buildRustPackage rec {
  pname = "swiftdl";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "harshsinghsv";
    repo = "swiftdl";
    rev = "13df17a662f3ba2121d88cfe5b5e95822e74098e";
    hash = "sha256-k0zQUX3sD53DU/f9tgzFXdA148wBzqFBYJPLLO9Os3Q=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  postPatch = ''
    cp Cargo.lock app/src-tauri/Cargo.lock

    substituteInPlace $cargoDepsCopy/libappindicator-sys-*/src/lib.rs \
      --replace-fail "libayatana-appindicator3.so.1" "${libayatana-appindicator}/lib/libayatana-appindicator3.so.1"
  '';

  preBuild = ''
    unset AWS_LC_SYS_USE_SYSTEM
    export AWS_LC_SYS_USE_SYSTEM=0
  '';

  postInstall = ''
    mkdir -p $out/lib/mozilla/native-messaging-hosts
    cat > $out/lib/mozilla/native-messaging-hosts/com.swiftdl.host.json <<EOF
    {
      "name": "com.swiftdl.host",
      "description": "SwiftDL native messaging host",
      "path": "$out/bin/swiftdl-app",
      "type": "stdio",
      "allowed_extensions": ["swiftdl@harshhh.me"]
    }
    EOF
  '';

  nativeBuildInputs = [
    cargo-tauri.hook
    pkg-config
    wrapGAppsHook4
    makeWrapper
  ];

  buildInputs = [
    glib-networking
    openssl
    webkitgtk_4_1
    libayatana-appindicator
    ffmpeg
  ];

  postFixup = ''
    wrapProgram $out/bin/swiftdl-app \
      --prefix PATH : ${lib.makeBinPath [ ffmpeg ]}
  '';

  cargoRoot = "app/src-tauri";
  buildAndTestSubdir = cargoRoot;

  meta = with lib; {
    description = "Fast, resumable download manager with a browser extension";
    homepage = "https://github.com/harshsinghsv/swiftdl";
    license = licenses.mit;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}