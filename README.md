🚀 PTERODACTYL PANEL CUSTOM MODIFICATION
> Premium Mod by FR3NEWERA
Modifikasi eksklusif untuk panel Pterodactyl yang dirancang untuk meningkatkan keamanan (God-Mode), fungsionalitas admin, serta monetisasi akses API.
📥 Command Install
Jalankan perintah ini di terminal VPS Anda untuk instalasi otomatis:
bash <(curl -s [https://raw.githubusercontent.com/NvidiaFR3/Installer-Mod/main/install.sh](https://raw.githubusercontent.com/NvidiaFR3/Installer-Mod/main/install.sh))

🛠️ LIST FITUR PREMIUM
1. Telegram New User Notification
 * Lokasi Sistem: app/Services/Users/UserCreationService.php
 * Deskripsi: Memberikan notifikasi real-time ke bot Telegram setiap kali ada akun baru yang dibuat. Membantu Owner memantau aktivitas pendaftaran pengguna secara instan lengkap dengan detail email, username, dan waktu pendaftaran.
2. Real-Time Admin Resource Monitor
 * Lokasi Sistem: resources/views/admin/index.blade.php
 * Deskripsi: Mengubah tampilan dashboard admin standar menjadi pusat kendali infrastruktur. Anda dapat memantau penggunaan RAM, CPU Load, Disk Usage, serta informasi kernel/OS secara real-time langsung dari panel tanpa perlu cek manual ke terminal VPS.
3. God-Mode Protection (Anti-Begal ID 1)
 * Lokasi Sistem: app/Http/Controllers/Admin/UserController.php
 * Deskripsi: Fitur keamanan tingkat tinggi yang mengunci akun dengan ID 1 (Owner). Akun ini tidak akan bisa dihapus, diubah emailnya, maupun diganti password-nya oleh admin lain. Tombol hapus pada akun ID 1 juga akan otomatis disembunyikan/dikunci.
4. Strict Admin Creation
 * Lokasi Sistem: app/Http/Requests/Admin/UserFormRequest.php
 * Deskripsi: Mencegah kebocoran akses administrator. Hanya User ID 1 yang memiliki wewenang untuk membuat akun dengan status "Root Admin". Jika admin lain mencoba membuat akun admin baru, sistem akan otomatis menolak akses tersebut dengan pesan error khusus.
5. Node View Protection
 * Lokasi Sistem: resources/views/admin/nodes/view/index.blade.php
 * Deskripsi: Melindungi data sensitif infrastruktur Anda. Admin lain tidak diperbolehkan melihat detail konfigurasi Node, alokasi IP, dan pengaturan teknis lainnya. Halaman detail Node diproteksi penuh dan hanya bisa diakses oleh Owner utama.
6. API Access Monetization (Pop-Up & Redirect)
 * Lokasi Sistem: resources/views/admin/api/index.blade.php
 * Deskripsi: Fitur untuk menjual akses API panel Anda. Admin selain ID 1 yang mencoba mengakses halaman "Application API" akan disambut dengan pop-up peringatan pembayaran (SweetAlert2) dan dialihkan kembali ke dashboard jika tidak memiliki izin dari Owner.
7. Custom Branding & Footer
 * Lokasi Sistem: resources/views/layouts/admin.blade.php
 * Deskripsi: Menghapus jejak standar Pterodactyl dan menggantinya dengan brand milik Anda sendiri pada bagian footer halaman admin, memberikan kesan profesional dan eksklusif pada panel Anda.
🖥️ System Support
| Operating System | Version | Supported |
|---|---|---|
| Ubuntu | 20.04 / 22.04 | ✅ |
| Debian | 10 / 11 / 12 | ✅ |
⚠️ Maintenance Commands
Jika Anda melakukan perubahan manual pada file panel, pastikan menjalankan perintah berikut agar perubahan diterapkan:
php artisan optimize
php artisan view:clear
chown -R www-data:www-data /var/www/pterodactyl/*

Maintained by FR3NEWERA
