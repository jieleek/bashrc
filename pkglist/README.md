Run the script for your platform from the repository root:

- Debian/Ubuntu: `./pkglist/apt-list.sh` (requires sudo).
- Linux Homebrew: `./pkglist/linuxbrew-combined.sh`.
- macOS Homebrew: `./pkglist/macos-brew.sh`.
- Windows PowerShell 5.1: `.\pkglist\scoop-list.ps1`.

Homebrew or Scoop must already be installed, with the buckets needed by the
listed packages available. The Scoop script includes BusyBox and its `gfind`
shim. Package names and version selections follow the original inventories.

`dot.condarc` remains Conda configuration; copy it to `~/.condarc`.
