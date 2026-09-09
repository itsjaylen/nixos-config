{
  rustPlatform,
  inputs,
  yarn,
  nodejs,
  pkg-config,
  openssl,
}:

rustPlatform.buildRustPackage {
  pname = "rustlog";
  version = "unstable-2026-09-09";

  src = inputs.rustlog;

  cargoHash = "sha256-JYG+t9Cs6t55kW2kYE1jEUYEs3XvpzVSxIjbszkd4Sw=";

  nativeBuildInputs = [
    yarn
    nodejs
    pkg-config
  ];

  buildInputs = [
    openssl
  ];

  preBuild = ''
    cd web
    export HOME=$(mktemp -d)
    yarn install --offline || yarn install
    yarn build
    cd ..
  '';
}