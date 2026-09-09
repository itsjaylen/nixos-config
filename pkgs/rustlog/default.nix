{
  rustPlatform,
  inputs,
  yarn,
  nodejs,
  pkg-config,
  openssl,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage {
  pname = "rustlog";
  version = "unstable-2026-09-09";

  # Fetch from GitHub directly with submodules enabled instead of using inputs.rustlog directly,
  # or use fetchGit on the flake input path if it supports submodules.
  src = fetchFromGitHub {
    owner = "Julia-Roman";
    repo = "rustlog";
    rev = "master"; # or a specific commit hash
    fetchSubmodules = true;
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # update this hash on first build
  };

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