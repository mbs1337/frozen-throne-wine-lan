# Warcraft III: The Frozen Throne on Linux (Wine + LAN)

Run classic **Frozen Throne** under Wine and play **LAN** with Windows friends.

Classic Battle.net is gone. Use **Local Area Network**.


---

## Layout

Put `linux-setup` inside your own legal WC3 install:

```text
Warcraft III/
|-- Frozen Throne.exe
|-- war3.mpq
|-- ...
`-- linux-setup/
    |-- INSTALL.md
    |-- setup-linux.sh
    `-- warcraft3-ft
```

---

## Quick start

Built for Linux. The automated script targets Arch (pacman) and is what was tested. Other distros: install Wine yourself, then use the launcher.

```bash
cd "/path/to/Warcraft III/linux-setup"
chmod +x setup-linux.sh warcraft3-ft
./setup-linux.sh    # Arch helper - skip on other distros if you install Wine manually
./warcraft3-ft
```

The setup script installs Wine + deps, creates `~/.wine-wc3`, links the game as `C:\Warcraft III`, and adds an app-menu shortcut.

On other distros: install Wine (with 32-bit/multilib + audio), create the same prefix/link manually if needed, then run `./warcraft3-ft`.

---

## Tips

- **Video:** windowed, 1280x960 or 1920x1080
- **Intros crash:** move `Movies` to `Movies.bak`, leave an empty `Movies/` folder
- **NVIDIA:** keep `lib32-nvidia-utils` matching your driver
- **Odd fullscreen:** only then try `WC3_VIRTUAL_DESKTOP=1920x1080 ./warcraft3-ft`

---

## LAN

1. Same patch on Linux and Windows
2. In-game: **Local Area Network**
3. Same network, or Tailscale/ZeroTier if remote
4. If the list is empty: open UDP/TCP **6112-6119** on both machines (firewall)

```bash
# firewalld
sudo firewall-cmd --add-port=6112-6119/udp --add-port=6112-6119/tcp

# ufw
sudo ufw allow 6112:6119/udp
sudo ufw allow 6112:6119/tcp
```

Empty LAN list is almost always patch mismatch or firewall.
