\# NixOS Config

A flake-based NixOS configuration managing a fleet of machines (desktop, laptop, compute node, k3s agent, server) plus a home-manager setup, custom packages, k3s manifests, and secrets.

\## Table of Contents

\- [Overview](#overview)
\- [Repository Layout](#repository-layout)
\- [Hosts](#hosts)
\- [Modules](#modules)
\- [Services (Server)](#services-server)
\- [Minecraft Services](#minecraft-services)
\- [Home Manager](#home-manager)
\- [Packages](#packages)
\- [Manifests (k3s / Flux)](#manifests-k3s--flux)
\- [Secrets](#secrets)
\- [Scripts](#scripts)
\- [Getting Started](#getting-started)
\- [Conventions](#conventions)

\## Overview

This repository is a single Nix flake that:

\- Defines multiple NixOS hosts under `hosts/`.
\- Shares reusable system modules under `modules/core/`.
\- Shares reusable user modules under `modules/home/`.
\- Declares custom packages under `pkgs/`.
\- Ships Kubernetes manifests for a k3s cluster under `manifests/`.
\- Manages secrets with sops-nix under `secrets/`.
\- Uses `treefmt` for formatting.

\## Repository Layout

```text
.
├── docs
├── flake.lock
├── flake.nix
├── hosts
│   ├── compute
│   │   ├── default.nix
│   │   └── hardware-configuration.nix
│   ├── desktop
│   │   ├── default.nix
│   │   ├── hardware-configuration.nix
│   │   └── nvidia-ogkm.nix
│   ├── k3s-agent
│   │   ├── default.nix
│   │   ├── hardware-configuration.nix
│   │   └── networking.nix
│   ├── laptop
│   │   ├── default.nix
│   │   └── hardware-configuration.nix
│   ├── server
│   │   ├── default.nix
│   │   ├── hardware-configuration.nix
│   │   ├── services
│   │   │   ├── adguard.nix
│   │   │   ├── clickhouse.nix
│   │   │   ├── cloudflared.nix
│   │   │   ├── default.nix
│   │   │   ├── garage.nix
│   │   │   ├── gitea.nix
│   │   │   ├── glance.nix
│   │   │   ├── grafana.nix
│   │   │   ├── immich.nix
│   │   │   ├── ingestgo.nix
│   │   │   ├── k3s.nix
│   │   │   ├── kaneo.nix
│   │   │   ├── loki.nix
│   │   │   ├── mediamtx.nix
│   │   │   ├── minecraft
│   │   │   │   ├── cobblemon.nix
│   │   │   │   ├── default.nix
│   │   │   │   ├── modded-mods
│   │   │   │   │   ├── default.nix
│   │   │   │   │   ├── gameplay.nix
│   │   │   │   │   ├── plugins.nix
│   │   │   │   │   ├── structures.nix
│   │   │   │   │   ├── utility.nix
│   │   │   │   │   └── worldgen.nix
│   │   │   │   ├── modded.nix
│   │   │   │   ├── packwiztest.nix
│   │   │   │   ├── vanilla.nix
│   │   │   │   ├── youer.nix
│   │   │   │   └── youer-plugins
│   │   │   │       ├── default.nix
│   │   │   │       └── plugins.nix
│   │   │   ├── obs.nix
│   │   │   ├── postgresql.nix
│   │   │   ├── prometheus.nix
│   │   │   ├── redis.nix
│   │   │   ├── restic.nix
│   │   │   ├── rustlog.nix
│   │   │   ├── slopuploader.nix
│   │   │   └── tailscale.nix
│   │   └── tools.nix
│   ├── install.sh
│   ├── manifests
│   │   ├── apps
│   │   │   ├── cloudflared.yaml
│   │   │   └── slopuploader.yaml
│   │   ├── descheduler.yaml
│   │   ├── flux-system
│   │   │   ├── gotk-components.yaml
│   │   │   ├── gotk-sync.yaml
│   │   │   └── kustomization.yaml
│   │   ├── monitoring
│   │   │   ├── helm-repo.yaml
│   │   │   └── kube-prometheus-stack.yaml
│   │   └── namespace.yaml
│   ├── modules
│   │   ├── core
│   │   │   ├── bluetooth.nix
│   │   │   ├── bootloader.nix
│   │   │   ├── default.nix
│   │   │   ├── flatpak.nix
│   │   │   ├── fonts.nix
│   │   │   ├── hardware.nix
│   │   │   ├── network.nix
│   │   │   ├── nh.nix
│   │   │   ├── niri-session-manager.nix
│   │   │   ├── nixpkgs.nix
│   │   │   ├── nvidia.nix
│   │   │   ├── piper.nix
│   │   │   ├── pipewire.nix
│   │   │   ├── program.nix
│   │   │   ├── security.nix
│   │   │   ├── services.nix
│   │   │   ├── sops.nix
│   │   │   ├── steam.nix
│   │   │   ├── system.nix
│   │   │   ├── torrent.nix
│   │   │   ├── user.nix
│   │   │   ├── virtualization.nix
│   │   │   ├── wayland.nix
│   │   │   └── xserver.nix
│   │   └── home
│   │       ├── bat.nix
│   │       ├── browser.nix
│   │       ├── btop.nix
│   │       ├── chatterino.nix
│   │       ├── default.nix
│   │       ├── direnv.nix
│   │       ├── discord.nix
│   │       ├── easyeffects
│   │       │   └── default.nix
│   │       ├── fastfetch
│   │       │   ├── config.jsonc
│   │       │   ├── default.nix
│   │       │   └── images
│   │       │       ├── image2.png
│   │       │       ├── image3.png
│   │       │       └── image.png
│   │       ├── fish
│   │       │   ├── aliases.nix
│   │       │   ├── default.nix
│   │       │   ├── fish.nix
│   │       │   ├── functions.nix
│   │       │   └── plugins.nix
│   │       ├── fzf.nix
│   │       ├── gaming.nix
│   │       ├── git.nix
│   │       ├── gtk.nix
│   │       ├── kde.nix
│   │       ├── kitty.nix
│   │       ├── lazygit.nix
│   │       ├── niri
│   │       │   ├── binds.nix
│   │       │   ├── config.nix
│   │       │   ├── default.nix
│   │       │   ├── niri.nix
│   │       │   ├── piri.toml
│   │       │   ├── rules.nix
│   │       │   └── scripts
│   │       │       └── uploader.sh
│   │       ├── noctalia
│   │       │   ├── default.nix
│   │       │   ├── noctalia.nix
│   │       │   └── settings.json
│   │       ├── nvim.nix
│   │       ├── packages
│   │       │   ├── cli.nix
│   │       │   ├── default.nix
│   │       │   ├── dev.nix
│   │       │   ├── gui.nix
│   │       │   └── nix.nix
│   │       ├── spicetify.nix
│   │       ├── ssh.nix
│   │       ├── starship.nix
│   │       ├── superfile
│   │       │   ├── config.toml
│   │       │   └── default.nix
│   │       ├── swaylock.nix
│   │       ├── swaync
│   │       │   ├── config.json
│   │       │   ├── style.css
│   │       │   └── swaync.nix
│   │       ├── xdg-mines.nix
│   │       └── zoxide.nix
│   ├── pkgs
│   │   ├── default.nix
│   │   ├── maple-mono
│   │   │   └── default.nix
│   │   └── rustlog
│   │       └── default.nix
│   ├── result -> /nix/store/aflvsbmdlqal5nb24vbaynlmysfgrcgc-amethyst-mod-manager-unstable-2026091221
│   ├── scripts
│   │   └── deploy-slopuploader.sh
│   ├── secrets
│   │   └── secrets.yaml
│   └── treefmt.toml
```

\## Hosts

| Host | Path | Purpose |
|------|------|---------|
| `compute` | `hosts/compute/` | Compute node |
| `desktop` | `hosts/desktop/` | Desktop workstation with NVIDIA (open kernel modules) |
| `k3s-agent` | `hosts/k3s-agent/` | Kubernetes agent node |
| `laptop` | `hosts/laptop/` | Laptop |
| `server` | `hosts/server/` | Primary server hosting services below |

Each host has a `default.nix` (entry point), a `hardware-configuration.nix`, and optionally extra host-specific files (`nvidia-ogkm.nix`, `networking.nix`, `services/`, `tools.nix`).

\## Modules

\### Core (`modules/core`)

System-level reusable modules imported by hosts:

| Module | Description |
|--------|-------------|
| `bluetooth.nix` | Bluetooth stack |
| `bootloader.nix` | Bootloader configuration |
| `default.nix` | Aggregates/imports core modules |
| `flatpak.nix` | Flatpak support |
| `fonts.nix` | System fonts |
| `hardware.nix` | Generic hardware tweaks |
| `network.nix` | Networking basics |
| `nh.nix` | `nh` (Nix helper) integration |
| `niri-session-manager.nix` | Niri session manager registration |
| `nixpkgs.nix` | nixpkgs config, overlays, allowUnfree |
| `nvidia.nix` | NVIDIA driver config |
| `piper.nix` | Piper (mouse config) |
| `pipewire.nix` | PipeWire audio |
| `program.nix` | Common system programs |
| `security.nix` | Security hardening |
| `services.nix` | Core system services |
| `sops.nix` | sops-nix secret decryption |
| `steam.nix` | Steam system config |
| `system.nix` | System basics (hostname, locale, etc.) |
| `torrent.nix` | Torrenting support |
| `user.nix` | User accounts |
| `virtualization.nix` | Virtualization (libvirt, etc.) |
| `wayland.nix` | Wayland enablement |
| `xserver.nix` | X11 enablement |

\### Home (`modules/home`)

Home-manager user modules:

| Module | Description |
|--------|-------------|
| `bat.nix` | `bat` pager config |
| `browser.nix` | Browser setup |
| `btop.nix` | `btop` config |
| `chatterino.nix` | Chatterino (Twitch chat) |
| `default.nix` | Aggregates home modules |
| `direnv.nix` | direnv integration |
| `discord.nix` | Discord client |
| `easyeffects/` | EasyEffects audio presets/config |
| `fastfetch/` | fastfetch config + images |
| `fish/` | Fish shell (aliases, functions, plugins) |
| `fzf.nix` | fzf integration |
| `gaming.nix` | Gaming user config |
| `git.nix` | Git config |
| `gtk.nix` | GTK theme/settings |
| `kde.nix` | KDE apps/config |
| `kitty.nix` | Kitty terminal |
| `lazygit.nix` | lazygit config |
| `niri/` | Niri compositor (binds, rules, scripts, `piri.toml`) |
| `noctalia/` | Noctalia shell config |
| `nvim.nix` | Neovim |
| `packages/` | Split package sets (`cli`, `dev`, `gui`, `nix`) |
| `spicetify.nix` | Spicetify (Spotify theming) |
| `ssh.nix` | SSH client config |
| `starship.nix` | Starship prompt |
| `superfile/` | superfile TUI file manager config |
| `swaylock.nix` | swaylock config |
| `swaync/` | SwayNC notification daemon (config + CSS) |
| `xdg-mines.nix` | XDG mime defaults |
| `zoxide.nix` | zoxide integration |

\## Services (Server)

Located under `hosts/server/services/`. `default.nix` imports all service modules.

| Service | File | Notes |
|---------|------|-------|
| AdGuard Home | `adguard.nix` | DNS/ad-blocking |
| ClickHouse | `clickhouse.nix` | Columnar DB |
| Cloudflared | `cloudflared.nix` | Cloudflare Tunnel |
| Garage | `garage.nix` | S3-compatible object storage |
| Gitea | `gitea.nix` | Git forge |
| Glance | `glance.nix` | Dashboard |
| Grafana | `grafana.nix` | Dashboards |
| Immich | `immich.nix` | Photo/video backup |
| IngestGo | `ingestgo.nix` | Ingest service |
| k3s | `k3s.nix` | Kubernetes control plane |
| Kaneo | `kaneo.nix` | Project management |
| Loki | `loki.nix` | Log aggregation |
| MediaMTX | `mediamtx.nix` | Media streaming server |
| OBS | `obs.nix` | OBS (headless/streaming) |
| PostgreSQL | `postgresql.nix` | Postgres DB |
| Prometheus | `prometheus.nix` | Metrics |
| Redis | `redis.nix` | Cache |
| Restic | `restic.nix` | Backups |
| Rustlog | `rustlog.nix` | Twitch IRC log bot (see `pkgs/rustlog`) |
| SlopUploader | `slopuploader.nix` | File uploader (see `scripts/deploy-slopuploader.sh`) |
| Tailscale | `tailscale.nix` | Mesh VPN |

\## Minecraft Services

Under `hosts/server/services/minecraft/`:

| File | Description |
|------|-------------|
| `default.nix` | Aggregates Minecraft services |
| `vanilla.nix` | Vanilla server |
| `modded.nix` | Modded server (Forge/Fabric) |
| `cobblemon.nix` | Cobblemon server |
| `youer.nix` | Youer server |
| `packwiztest.nix` | Packwiz-based test server |
| `modded-mods/` | Mod lists split by category |
| `youer-plugins/` | Youer plugin sets |

\### `modded-mods/`

| File | Category |
|------|----------|
| `default.nix` | Aggregates all mod lists |
| `gameplay.nix` | Gameplay mods |
| `plugins.nix` | Plugin mods |
| `structures.nix` | Structure mods |
| `utility.nix` | Utility mods |
| `worldgen.nix` | World generation mods |

\### `youer-plugins/`

| File | Description |
|------|-------------|
| `default.nix` | Aggregates plugins |
| `plugins.nix` | Plugin definitions |

\## Packages

Custom packages in `pkgs/`:

| Path | Description |
|------|-------------|
| `pkgs/default.nix` | Package set aggregator |
| `pkgs/maple-mono/` | Maple Mono font package |
| `pkgs/rustlog/` | Rustlog (Twitch IRC logger) package |

\## Manifests (k3s / Flux)

Kubernetes manifests under `manifests/`:

| Path | Description |
|------|-------------|
| `manifests/namespace.yaml` | Namespaces |
| `manifests/descheduler.yaml` | Descheduler deployment |
| `manifests/apps/cloudflared.yaml` | Cloudflared app |
| `manifests/apps/slopuploader.yaml` | SlopUploader app |
| `manifests/monitoring/helm-repo.yaml` | Helm repo source |
| `manifests/monitoring/kube-prometheus-stack.yaml` | Prometheus stack |
| `manifests/flux-system/gotk-components.yaml` | Flux components |
| `manifests/flux-system/gotk-sync.yaml` | Flux sync config |
| `manifests/flux-system/kustomization.yaml` | Flux kustomization |

\## Secrets

\- `secrets/secrets.yaml` — sops-encrypted secrets.
\- Decryption is wired up via `modules/core/sops.nix`.

\## Scripts

| Script | Description |
|--------|-------------|
| `hosts/install.sh` | Installer script |
| `scripts/deploy-slopuploader.sh` | Deploy helper for SlopUploader |

\## Getting Started

\### Prerequisites

\- Nix with flakes enabled.
\- A machine listed in `flake.nix` under `nixosConfigurations`.

\### Rebuild

```bash
# rebuild current host
sudo nixos-rebuild switch --flake .#<hostname>

# or with nh
nh os switch .#<hostname>
```

\### Format

```bash
treefmt
```

\## Conventions

\- Each host has its own `default.nix` entry point and `hardware-configuration.nix`.
\- Shared system config lives in `modules/core/`; user config in `modules/home/`.
\- Secrets are sops-encrypted; never commit plaintext.
\- Custom packages go in `pkgs/` and are exposed via `pkgs/default.nix`.
\- Kubernetes manifests follow a Flux-style layout under `manifests/`.