#Requires -Version 5.1
$ErrorActionPreference = 'Stop'

scoop install 7zip ag ant aria2 busybox cacert chromium cloc cmder curl dark
scoop install draw.io firefox-esr gcc git go gpg gradle groovy helm ilspy
scoop install innounp insomnia jq keystore-explorer kotlin kotlin-native
scoop install kustomize lessmsi lua make maven miniconda3 nmap nodejs-lts
scoop install notepad3 openjdk11 openlens pdftk-builder perl pnpm putty python
scoop install sdl2 sudo sumatrapdf temurin11-jdk temurin17-jdk temurin8-jdk upx
scoop install vim wget windirstat windows-terminal winmerge winscp wkhtmltopdf
scoop install z.lua zip zstd

# BusyBox find does not support Windows junctions (mklink /j).
$busyboxPath = Join-Path (scoop prefix busybox) 'busybox.exe'
scoop shim add gfind $busyboxPath '--' find
