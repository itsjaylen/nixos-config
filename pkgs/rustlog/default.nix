{
  rustPlatform,
  inputs,
  yarn,
  nodejs,
  pkg-config,
  openssl,
  fetchYarnDeps,
}:

rustPlatform.buildRustPackage {
  pname = "rustlog";
  version = "unstable-2026-09-09";

  src = inputs.rustlog;

  cargoHash = "sha256-YaW6P3FIasnLioK/abpxGeglw8ViDR9MNzQ6AITgsTI=";

  offlineCache = fetchYarnDeps {
    yarnLock = "${inputs.rustlog}/web/yarn.lock";
    hash = "sha256-tyqpeAI6hu0YlTWvZMJekMU7lIHEOv137KP+ci+Cv7k=";
  };

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

    # Tell yarn to look for the offline mirror
    yarn config --offline set yarn-offline-mirror "$offlineCache"

    # Run yarn install pointing directly to the locked dependencies
    yarn install --offline --frozen-lockfile --no-progress --ignore-scripts

    # Build using node directly against the local node_modules binary
    node node_modules/.bin/vite build
    cd ..
  '';
}