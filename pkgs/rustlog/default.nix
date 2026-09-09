{
  rustPlatform,
  inputs,
  yarn,
  nodejs,
  pkg-config,
  openssl,
  fetchYarnDeps,
  fixup-yarn-lock,
}:

rustPlatform.buildRustPackage {
  pname = "rustlog";
  version = "unstable-2026-09-09";

  src = inputs.rustlog;

  cargoHash = "sha256-JYG+t9Cs6t55kW2kYE1jEUYEs3XvpzVSxIjbszkd4Sw=";

  offlineCache = fetchYarnDeps {
    yarnLock = "${inputs.rustlog}/web/yarn.lock";
    hash = "sha256-tyqpeAI6hu0YlTWvZMJekMU7lIHEOv137KP+ci+Cv7k=";
  };

  nativeBuildInputs = [
    yarn
    nodejs
    pkg-config
    fixup-yarn-lock
  ];

  buildInputs = [
    openssl
  ];

  preBuild = ''
    cd web
    export HOME=$(mktemp -d)
    fixup-yarn-lock yarn.lock
    yarn config --offline set yarn-offline-mirror $offlineCache
    yarn install --offline --frozen-lockfile --no-progress
    yarn build
    cd ..
  '';
}