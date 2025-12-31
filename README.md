PTERODACTYL PANEL MOD v2.0
by FR3NEWERA

==================================================

Custom Pterodactyl Panel Modification dengan fitur administratif lanjutan,
sistem keamanan berlapis, dan real-time VPS monitoring untuk manajemen
server game yang aman, stabil, dan profesional.

==================================================

TABLE OF CONTENTS

1. Features
2. System Requirements
3. Quick Installation
4. Feature Details
5. Maintenance & Troubleshooting
6. Backup & Restore
7. Support & Contact
8. License & Disclaimer
9. Changelog
10. Roadmap

==================================================

FEATURES

1. Telegram User Notification
   - Notifikasi real-time saat user baru dibuat

2. Customer Service Sidebar
   - Shortcut Telegram support di sidebar admin

3. Admin Dashboard Real-Time
   - Monitoring CPU, RAM, Disk, Uptime VPS

4. Custom Branding & Footer
   - Ganti footer default Pterodactyl dengan branding sendiri

5. God-Mode Protection (User ID 1)
   - Proteksi penuh akun owner dari edit & delete

6. Strict Admin Creation
   - Hanya owner (ID 1) bisa membuat admin baru

7. Node View Protection
   - Admin biasa tidak bisa membuka detail node

8. API Access Monetization
   - Pop-up pembayaran API + redirect ke owner

==================================================

SYSTEM REQUIREMENTS

Supported OS:
- Ubuntu 20.04 LTS
- Ubuntu 22.04 LTS (Recommended)
- Debian 10
- Debian 11
- Debian 12

Software:
- PHP 8.0 or newer
- MySQL 8.0 or newer
- Pterodactyl Panel 1.x

==================================================

QUICK INSTALLATION

Automatic Installation (Recommended):

bash <(curl -s https://raw.githubusercontent.com/NvidiaFR3/Installer-Mod/main/install.sh)

Manual Installation:

cd /var/www/pterodactyl
git clone https://github.com/NvidiaFR3/Pterodactyl-Mod.git mod-temp
cp -r app resources/views backup-original/

==================================================

FEATURE DETAILS

Telegram User Notification
File:
app/Services/Users/UserCreationService.php

Configuration:
$botToken = "YOUR_BOT_TOKEN"
$chatId   = "YOUR_CHAT_ID"

--------------------------------------------------

Customer Service Sidebar
File:
resources/views/layouts/admin.blade.php

--------------------------------------------------

Real-Time Admin Dashboard
- CPU Load
- RAM Usage
- Disk Usage
- System Uptime
- Total Users
- Total Servers

--------------------------------------------------

Custom Branding & Footer
File:
resources/views/layouts/admin.blade.php

--------------------------------------------------

God-Mode Protection (User ID 1)
Proteksi:
- Email tidak bisa diubah
- Password tidak bisa di-reset oleh admin lain
- Root admin permanent
- Akun tidak bisa dihapus

--------------------------------------------------

Strict Admin Creation
Hanya User ID 1 yang bisa membuat admin baru

--------------------------------------------------

Node View Protection
Admin biasa tidak dapat mengakses detail node via URL

--------------------------------------------------

API Access Monetization
- SweetAlert2 popup
- Redirect ke WhatsApp owner
- Harga default: 5K / akun

==================================================

MAINTENANCE

Jalankan setelah modifikasi:

php artisan optimize
php artisan view:clear
chown -R www-data:www-data /var/www/pterodactyl

==================================================

BACKUP & RESTORE

Backup Database:
mysqldump -u root -p pterodactyl > backup.sql

Restore Database:
mysql -u root -p pterodactyl < backup.sql

==================================================

SUPPORT & CONTACT

Telegram  : @fr3newera
WhatsApp  : +62 882-0087-71871
GitHub    : NvidiaFR3
Email     : support@fr3newera.com

==================================================

LICENSE & DISCLAIMER

Pterodactyl Panel Mod © 2024 FR3NEWERA
Original Pterodactyl Panel © 2015 - 2024 Dane Everitt and contributors
License: MIT

This modification is provided "as is" without warranty.
Always backup your data before installation.

==================================================

CHANGELOG

Version 2.0
- Real-time VPS Monitoring Dashboard
- Enhanced God-Mode Protection
- API Access Monetization
- Improved UI/UX

Version 1.0
- Telegram Notification
- Basic Security
- Footer Branding

==================================================

ROADMAP

Q2 2024 - Discord Webhook Integration
Q3 2024 - Advanced Billing System
Q4 2024 - Mobile Admin Panel
Q1 2025 - Multi-language Support

==================================================

Maintained by FR3NEWERA
