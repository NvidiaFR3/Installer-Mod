#!/bin/bash

if [ "$EUID" -ne 0 ]; then 
  echo "Harap jalankan sebagai root: sudo su"
  exit 1
fi

URL_ZIP="https://github.com/NvidiaFR3/Installer-Mod/raw/main/mod.zip"
BASE_DIR="/var/www"
PTERO_DIR="/var/www/pterodactyl"

BLUE='\033[0;34m'       
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

show_menu() {
    clear
  echo -e ""
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                                                 [+]${NC}"
  echo -e "${BLUE}[+]                AUTO INSTALLER PANEL MOD             [+]${NC}"
  echo -e "${BLUE}[+]                  © FR3 NEWERA               [+]${NC}"
  echo -e "${BLUE}[+]                                                 [+]${NC}"
  echo -e "${RED}[+] =============================================== [+]${NC}"
  echo "1. Installer Panel Mod"
  echo "2. Uninstall Panel Mod"
  echo "x. Exit From Installer"
  read -p "Pilih menu [1/2/x]: " choice
}

install_mod() {
    echo "Memproses instalasi otomatis..."
    apt-get update && apt-get install -y unzip
    cd $BASE_DIR
    echo "Mengunduh file mod..."
    wget -q -O mod_temp.zip "$URL_ZIP"

    if [ -f "mod_temp.zip" ]; then
        echo "Mengekstrak file dan menimpa folder pterodactyl..."
        unzip -o mod_temp.zip -d $BASE_DIR
        rm mod_temp.zip
        echo "Finalisasi (Permission & Cache)..."
        chown -R www-data:www-data $PTERO_DIR/*
        cd $PTERO_DIR
        php artisan view:clear
        php artisan cache:clear
        echo "Selesai! Mod berhasil dipasang."
    else
        echo "Gagal mengunduh file dari GitHub. Cek koneksi atau link URL."
    fi
    read -p "Tekan Enter untuk kembali..."
}

uninstall_mod() {
    echo "Menghapus mod dan mengembalikan ke panel original..."
    cd $PTERO_DIR
    curl -L https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz | tar -xzv
    composer install --no-dev --optimize-autoloader
    chown -R www-data:www-data $PTERO_DIR/*
    echo "Panel berhasil dikembalikan ke default."
    read -p "Tekan Enter untuk kembali..."
}

while true; do
    show_menu
    case $choice in
        1) install_mod ;;
        2) uninstall_mod ;;
        x) echo "Menutup Installer..."; exit 0 ;;
        *) echo "Pilihan salah!"; sleep 1 ;;
    esac
done
