{
  stdenv,
  inputs,
  meson,
  ninja,
  pkg-config,
  python3,
  rustPlatform,
  cargo,
  rustc,
  wrapGAppsHook4, # or makeWrapper if not using GNOME/GTK stack directly, but standard Python/PySide6 often uses wrapQtAppsHook
  qt6,
  git,
  zstandard,
  lz4,
}:

let
  pythonEnv = python3.withPackages (ps: with ps; [
    pyside6
    requests
    py7zr
    pillow
    lz4
    zstandard
    websocket-client
    keyring
    msgpack
    bsdiff4
  ]);
in
stdenv.mkDerivation {
  pname = "amethyst-mod-manager";
  version = "unstable-2026-09-13";

  src = inputs.amethyst-mod-manager;

  cargoDeps = rustPlatform.fetchCargoTarball {
    src = inputs.amethyst-mod-manager;
    hash = "REPLACE_WITH_CARGO_HASH";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    cargo
    rustc
    rustPlatform.cargoSetupHook
    qt6.wrapQtAppsHook
  ];

  buildInputs = [
    pythonEnv
    zstandard
    lz4
    qt6.qtbase
  ];

  preConfigure = ''
    # Build the native filegraph rust extension as specified in the wiki instructions
    pushd native/amethyst_filegraph
    cargo build --release
    # Ensure the compiled shared object goes where Meson expects it
    popd
  '';

  meta = {
    description = "Universal mod manager written in Python and Qt";
    homepage = "https://github.com/ChrisDKN/Amethyst-Mod-Manager";
    license = lib.licenses.gpl3Only;
  };
}