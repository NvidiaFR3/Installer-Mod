sudo su
cd /root
cat > install_mod_fixed.sh << 'EOF'
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
    echo -e "${BLUE}[+]                AUTO INSTALLER PANEL MOD         [+]${NC}"
    echo -e "${BLUE}[+]                  © FR3 NEWERA                   [+]${NC}"
    echo -e "${BLUE}[+]                                                 [+]${NC}"
    echo -e "${RED}[+] =============================================== [+]${NC}"
    echo -e "${GREEN}"
    echo "1. Installer Panel Mod"
    echo "2. Uninstall Panel Mod"
    echo "x. Exit From Installer"
    echo -e "${NC}"
    read -p "Pilih menu [1/2/x]: " choice
}

install_mod() {
    echo -e "${YELLOW}Memproses instalasi otomatis...${NC}"
    
    apt-get update && apt-get install -y unzip wget curl
    
    if [ ! -d "$PTERO_DIR" ]; then
        echo -e "${RED}Direktori $PTERO_DIR tidak ditemukan!${NC}"
        echo -e "${YELLOW}Pastikan Pterodactyl Panel sudah terinstall.${NC}"
        read -p "Tekan Enter untuk kembali..."
        return
    fi
    
    cd $BASE_DIR
    echo -e "${YELLOW}Mengunduh file mod...${NC}"
    wget --no-check-certificate -q --show-progress -O mod_temp.zip "$URL_ZIP"
    
    if [ -f "mod_temp.zip" ]; then
        echo -e "${YELLOW}Mengekstrak file dan menimpa folder pterodactyl...${NC}"
        
        BACKUP_DIR="$PTERO_DIR-backup-$(date +%Y%m%d-%H%M%S)"
        echo -e "${YELLOW}Membuat backup ke: $BACKUP_DIR${NC}"
        cp -r "$PTERO_DIR" "$BACKUP_DIR"
        
        unzip -o mod_temp.zip -d $BASE_DIR
        
        rm -f mod_temp.zip
        
        echo -e "${YELLOW}Finalisasi (Permission & Cache)...${NC}"
        chown -R www-data:www-data $PTERO_DIR/*
        chmod -R 755 $PTERO_DIR/*
        
        cd $PTERO_DIR
        php artisan view:clear
        php artisan cache:clear
        php artisan config:clear
        
        echo -e "${GREEN}Selesai! Mod berhasil dipasang.${NC}"
        echo -e "${YELLOW}Backup tersimpan di: $BACKUP_DIR${NC}"
    else
        echo -e "${RED}Gagal mengunduh file dari GitHub.${NC}"
        echo -e "${YELLOW}Cek koneksi internet atau URL.${NC}"
    fi
    
    read -p "Tekan Enter untuk kembali..."
}

uninstall_mod() {
    echo -e "${YELLOW}Menghapus mod dan mengembalikan ke panel original...${NC}"
    
    if [ ! -d "$PTERO_DIR" ]; then
        echo -e "${RED}Direktori $PTERO_DIR tidak ditemukan!${NC}"
        read -p "Tekan Enter untuk kembali..."
        return
    fi
    
    cd $PTERO_DIR
    
    BACKUP_DIR="$PTERO_DIR-mod-backup-$(date +%Y%m%d-%H%M%S)"
    echo -e "${YELLOW}Membuat backup mod saat ini ke: $BACKUP_DIR${NC}"
    cp -r "$PTERO_DIR" "$BACKUP_DIR"
    
    echo -e "${YELLOW}Mengunduh panel original...${NC}"
    
    LATEST_RELEASE=$(curl -s https://api.github.com/repos/pterodactyl/panel/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
    
    if [ -z "$LATEST_RELEASE" ]; then
        LATEST_RELEASE="v1.11.6"
        echo -e "${YELLOW}Gagal mendapatkan versi terbaru, menggunakan fallback: $LATEST_RELEASE${NC}"
    fi
    
    DOWNLOAD_URL="https://github.com/pterodactyl/panel/releases/download/$LATEST_RELEASE/panel.tar.gz"
    
    curl -L -o panel_original.tar.gz "$DOWNLOAD_URL"
    
    if [ -f "panel_original.tar.gz" ]; then
        echo -e "${YELLOW}Mengekstrak panel original...${NC}"
        
        mkdir -p /tmp/panel_original
        tar -xzf panel_original.tar.gz -C /tmp/panel_original
        
        echo -e "${YELLOW}Mengganti file...${NC}"
        cp -rf /tmp/panel_original/* $PTERO_DIR/
        
        rm -f panel_original.tar.gz
        rm -rf /tmp/panel_original
        
        echo -e "${YELLOW}Menginstall dependencies...${NC}"
        composer install --no-dev --optimize-autoloader --quiet
        
        chown -R www-data:www-data $PTERO_DIR/*
        chmod -R 755 $PTERO_DIR/*
        
        php artisan view:clear
        php artisan cache:clear
        php artisan config:clear
        
        echo -e "${GREEN}Panel berhasil dikembalikan ke default.${NC}"
        echo -e "${YELLOW}Backup mod tersimpan di: $BACKUP_DIR${NC}"
    else
        echo -e "${RED}Gagal mengunduh panel original.${NC}"
    fi
    
    read -p "Tekan Enter untuk kembali..."
}

while true; do
    show_menu
    case $choice in
        1) 
            echo -e "${YELLOW}Memulai instalasi mod...${NC}"
            install_mod 
            ;;
        2) 
            echo -e "${YELLOW}Memulai uninstall mod...${NC}"
            uninstall_mod 
            ;;
        x|X) 
            echo -e "${GREEN}Menutup Installer...${NC}"
            exit 0 
            ;;
        *) 
            echo -e "${RED}Pilihan salah!${NC}"
            sleep 1 
            ;;
    esac
done
EOF

chmod +x install_mod_fixed.sh
./install_mod_fixed.sh