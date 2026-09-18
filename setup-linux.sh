#!/usr/bin/env bash
# Install Wine and create a local prefix. All launch-related files live under the game folder.
set -euo pipefail
unset WINEARCH

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Works from linux-setup/ (published layout) or linux-setup/eng/ (local draft folder)
if [[ -f "$SCRIPT_DIR/../Frozen Throne.exe" ]]; then
  GAME_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
elif [[ -f "$SCRIPT_DIR/../../Frozen Throne.exe" ]]; then
  GAME_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
else
  GAME_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
fi
LAUNCHER="$SCRIPT_DIR/warcraft3-ft"
export WINEPREFIX="${WINEPREFIX:-$HOME/.wine-wc3}"
export WINEDLLOVERRIDES="mscoree,mshtml="

echo "==> Game dir: $GAME_DIR"
echo "==> Launcher: $LAUNCHER"
echo "==> Wine prefix (LOCAL to this machine, do not sync): $WINEPREFIX"

if ! command -v pacman >/dev/null; then
  echo "This script expects Arch/pacman. Install Wine manually on other distros." >&2
  exit 1
fi

echo "==> Installing packages (needs sudo)..."
sudo pacman -S --needed --noconfirm \
  wine winetricks cabextract \
  lib32-libpulse \
  gst-libav gst-plugins-good gst-plugins-ugly

if pacman -Q nvidia-utils >/dev/null 2>&1; then
  sudo pacman -S --needed --noconfirm lib32-nvidia-utils || true
fi

echo "==> Creating/updating Wine prefix..."
if [[ ! -d "$WINEPREFIX/drive_c" ]]; then
  wineboot --init
fi
wine winecfg -v winxp >/dev/null 2>&1 || true

ln -sfn "$GAME_DIR" "$WINEPREFIX/drive_c/Warcraft III"
wine reg add 'HKCU\Software\Blizzard Entertainment\Warcraft III' /v InstallPath /t REG_SZ /d 'C:\Warcraft III' /f >/dev/null
wine reg add 'HKCU\Software\Blizzard Entertainment\Warcraft III' /v Program /t REG_SZ /d 'C:\Warcraft III' /f >/dev/null

if [[ -d "$GAME_DIR/Movies" && ! -d "$GAME_DIR/Movies.bak" ]]; then
  if find "$GAME_DIR/Movies" -type f | read -r _; then
    mv "$GAME_DIR/Movies" "$GAME_DIR/Movies.bak"
    mkdir -p "$GAME_DIR/Movies"
    echo "==> Movies moved to Movies.bak (avoids Wine crashes on intros)"
  fi
fi

# App menu shortcut points at this launcher
mkdir -p "$HOME/.local/share/applications"
cat > "$HOME/.local/share/applications/warcraft3-frozen-throne.desktop" << DESK
[Desktop Entry]
Name=Warcraft III: The Frozen Throne
Comment=Classic TFT via Wine (LAN)
Exec="$LAUNCHER"
Path=$GAME_DIR
Icon=applications-games
Terminal=false
Type=Application
Categories=Game;
DESK
update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true

echo
echo "Done. Start with:"
echo "  $LAUNCHER"
echo "or from the app menu: Warcraft III: The Frozen Throne"
echo "LAN: Local Area Network. Same patch on every machine."
echo "Wine prefix stays on this machine ($WINEPREFIX)."
