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

  cargoHash = "sha256-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=";

  offlineCache = fetchYarnDeps {
    yarnLock = "${inputs.rustlog}/web/yarn.lock";
    hash = "sha256-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX="; # Replace with your actual hash when prompted
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
      yarn install --offline --frozen-lockfile --no-progress --ignore-scripts
      node ./node_modules/vite/bin/vite.js build
      cd ..
    '';
}