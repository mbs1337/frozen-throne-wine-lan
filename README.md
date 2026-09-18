# Frozen Throne on Linux (Wine + LAN)

[![License](https://img.shields.io/badge/License-GPL%20v3-blue?style=flat-square)](http://www.gnu.org/licenses/gpl-3.0.html)
[![Built for](https://img.shields.io/badge/BUILT%20FOR-Linux-FCC624?style=flat-square&logo=linux&logoColor=black)](https://kernel.org/)
[![Tested on](https://img.shields.io/badge/TESTED%20ON-Arch%20Linux-1793D1?style=flat-square&logo=archlinux&logoColor=white)](https://archlinux.org/)
[![Wine](https://img.shields.io/badge/RUNS%20ON-Wine-8c8c8c?style=flat-square)](https://www.winehq.org/)

Small helper scripts to run classic **Warcraft III: The Frozen Throne** under Wine on Linux, with focus on **LAN** (including Windows friends).

Not Reforged. Not Battle.net. Just Local Area Network.

Built for Linux. Automated setup script is written for Arch (pacman). Tested on Arch. Other distros: install Wine yourself and follow `INSTALL.md`.

## What this is

| File | Purpose |
|------|---------|
| `setup-linux.sh` | First-time setup (Arch / pacman helper) |
| `warcraft3-ft` | Launcher (any Linux with Wine) |
| `INSTALL.md` | Short install + LAN notes |

No game files. You need your own legal WC3 install.

## Quick start

1. Drop this folder into your WC3 directory as `linux-setup/` (next to `Frozen Throne.exe`)
2. Read `INSTALL.md`
3. Run `./setup-linux.sh` (Arch) or set up Wine manually, then `./warcraft3-ft`

## License

GPL-3.0 - see [LICENSE](LICENSE)

## Author

[mbsTECH.dk](https://mbstech.dk) | Michael Bay Sørensen
