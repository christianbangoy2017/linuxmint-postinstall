#!/bin/bash

set -e

echo "======================================"
echo " Linux Mint Post-Install Setup Script "
echo "======================================"

# -----------------------------
# System Update & Upgrade
# -----------------------------
echo "[1/9] Updating system..."
sudo apt update -y
sudo apt upgrade -y

# -----------------------------
# OpenSSH Server
# -----------------------------
echo "[2/9] Installing OpenSSH Server..."
sudo apt install openssh-server -y
sudo systemctl enable ssh
sudo systemctl start ssh

# -----------------------------
# KDE Plasma Desktop
# -----------------------------
echo "[3/9] Installing KDE Plasma Desktop..."
sudo apt install kde-plasma-desktop kde-standard plasma-widgets-addons -y

# -----------------------------
# Flatpak + Flathub
# -----------------------------
echo "[4/9] Installing Flatpak and Flathub..."
sudo apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# -----------------------------
# Browsers & Office Apps
# -----------------------------
echo "[5/9] Installing Flatpak applications..."
sudo flatpak install flathub com.brave.Browser -y
sudo flatpak install flathub org.onlyoffice.desktopeditors -y
sudo flatpak install flathub com.google.Chrome -y

# -----------------------------
# Google Chrome (.deb fallback)
# -----------------------------
echo "[6/9] Installing Google Chrome (DEB)..."
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb || sudo apt -f install -y
rm google-chrome-stable_current_amd64.deb

# -----------------------------
# CasaOS
# -----------------------------
echo "[7/9] Installing CasaOS..."
curl -fsSL https://get.casaos.io | sudo bash

# -----------------------------
# Syncthing
# -----------------------------
echo "[8/9] Installing Syncthing..."
sudo apt install syncthing -y
syncthing --version

echo "[9/9] Enabling Syncthing user service..."
systemctl --user enable syncthing
systemctl --user start syncthing

# -----------------------------
# Done
# -----------------------------
echo "======================================"
echo " ✅ Setup Complete!"
echo " ℹ Reboot recommended."
echo "======================================"
