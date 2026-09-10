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
      export HOME=$(mktemp -d)
      
      # Configure yarn offline mirror
      yarn config --offline set yarn-offline-mirror "$offlineCache"
      
      # Install dependencies and build vite from the web directory or root as appropriate
      cd web
      yarn install --offline --frozen-lockfile --no-progress --ignore-scripts
      node ./node_modules/vite/bin/vite.js build
      cd ..
    '';
}