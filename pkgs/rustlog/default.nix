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
    
    # Configure yarn to use the offline cache properly
    yarn config --offline set yarn-offline-mirror "$offlineCache"
    
    # Fix offline mirror permissions if necessary and install dependencies
    fixup-yarn-lock yarn.lock || true
    yarn install --offline --frozen-lockfile --no-progress --ignore-scripts
    
    # Build the frontend assets
    node ./node_modules/vite/bin/vite.js build
    cd ..
  '';
}