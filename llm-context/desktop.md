# Desktop context

Information about Jan's hardware and Hyprland/Omarchy/Mystrap desktop setup.

## When to load this

- Questions about hardware specs or laptop model
- Modifying Hyprland configuration
- Working with wallpapers, keybindings, or themes
- Creating or modifying shell scripts (stored in mystrap, symlinked to ~/.local/bin/)

## Hardware

**HP ZBook Fury 15.6" G8 Mobile Workstation**

| Component | Details |
|-----------|---------|
| CPU | Intel Core i7-11850H @ 2.50GHz (8 cores / 16 threads, 24MB cache) |
| RAM | 32GB DDR4 |
| GPU (integrated) | Intel UHD Graphics (TigerLake-H GT1) |
| GPU (discrete) | NVIDIA RTX A2000 Mobile |
| Display | 15.6" 1920x1080 (Full HD) |
| Storage 1 | 512GB Micron MTFDHBA512TDV (NVMe) |
| Storage 2 | 1TB Kingston SNV3S1000G (NVMe) |
| WiFi | Intel Wi-Fi 6 (Tiger Lake PCH CNVi) |
| Ethernet | Intel I219-LM |
| Battery | 94Wh Li-ion |

## Wallpaper system

### Storage
- **Main location**: `~/Wallpaper/` (individual files symlink to `~/dev/mystrap/dotfiles/wallpaper/Wallpaper/` via Stow)
- **Rejected wallpapers**: `~/Wallpaper/rejected/` (real directory, not symlinked)
- **Current tracking**: Symlink at `~/.config/omarchy/current/background`

### Scripts
| Script | Purpose |
|--------|---------|
| `mystrap-bg-next` | Pick random wallpaper and set it (used by cron and keybinding) |
| `mystrap-bg-reject` | Move current wallpaper to rejected/ and pick new one |

### Keybindings
| Key | Action |
|-----|--------|
| `SUPER CTRL + SPACE` | Set new random wallpaper |
| `SUPER CTRL SHIFT + SPACE` | Reject current wallpaper (move to rejected/) |

### Crontab
- `0 0,12 * * *` - Runs `mystrap-bg-next` at midnight and noon

## Configuration files

| File | Purpose |
|------|---------|
| `~/.config/hypr/hyprland.conf` | Main Hyprland config |
| `~/dev/mystrap/overrides.conf` | Custom keybindings and overrides |
| `~/dev/mystrap/hosts/laptop1/overrides.conf` | Host-specific config |

## Omarchy

Omarchy is a Hyprland configuration framework. Default configs are in:
- `~/.local/share/omarchy/default/hypr/`

Overrides in `~/dev/mystrap/overrides.conf` are sourced **after** Omarchy defaults, so they take precedence.

### Common overrides pattern
1. `unbind = <key>` - Remove Omarchy default binding
2. `bindd = <key>, <description>, exec, <command>` - Add custom binding

## Mystrap script storage

Personal shell scripts are stored in `~/dev/mystrap/dotfiles/shell/` and symlinked to `~/.local/bin/` for PATH convenience.

**Pattern when creating new scripts:**
1. Create script in `~/dev/mystrap/dotfiles/shell/` (or `.local/bin/` subfolder for vault scripts)
2. Create symlink: `ln -s ~/dev/mystrap/dotfiles/shell/script-name ~/.local/bin/script-name`
3. Use relative symlinks when inside `.local/bin/`: `ln -s ../../dev/mystrap/dotfiles/shell/script-name ~/.local/bin/script-name`

**Existing scripts follow this pattern:**
- `vault-*` scripts → `dotfiles/shell/.local/bin/vault-*`
- `calendar-today`, `tasks-today` → `dotfiles/shell/`
