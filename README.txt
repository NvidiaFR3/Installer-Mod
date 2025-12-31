PTERODACTYL PANEL MOD BY FR3NEWERA
========================================

Custom Modifikasi Panel Pterodactyl dengan fitur-fitur administratif canggih, sistem keamanan berlapis, dan monitoring real-time untuk manajemen server game yang optimal.

DAFTAR ISI
==========
1. Fitur Utama
2. Sistem yang Didukung
3. Instalasi Cepat
4. Detail Fitur
5. Pemeliharaan
6. Restorasi Database
7. Developer Information

FITUR UTAMA
===========
No.  Fitur                      Kategori       Deskripsi Singkat
---  -------------------------  -------------  -------------------------------------------------
1.   Notifikasi Telegram        Monitoring     Notifikasi real-time user baru via bot Telegram
2.   Customer Service Sidebar   UI/UX          Tombol akses cepat ke support Telegram
3.   Dashboard Admin Real-time  Monitoring     Statistik VPS live (CPU, RAM, Disk)
4.   Branding Custom            UI/UX          Ganti copyright dengan branding pribadi
5.   God-Mode Protection        Security       Proteksi akun utama (ID 1) dari modifikasi
6.   Strict Admin Creation      Security       Hanya owner bisa membuat admin baru
7.   Node View Protection       Security       Blokir akses detail node untuk admin biasa
8.   API Access Monetization    Monetization   Pop-up pembelian akses API untuk admin biasa

SISTEM YANG DIDUKUNG
====================
Operating System   Version        Status      Keterangan
-----------------  -------------  ----------  --------------------------------------------
Ubuntu             20.04 LTS      Supported   Full compatibility
Ubuntu             22.04 LTS      Supported   Recommended version
Debian             10 (Buster)    Supported   Stable
Debian             11 (Bullseye)  Supported   Recommended
Debian             12 (Bookworm)  Supported   Latest

Note: Sistem operasi lain dapat diuji coba secara mandiri. Pastikan environment PHP 8.0+ dan MySQL 8.0+.

INSTALASI CEPAT
===============
Instalasi Otomatis:
bash <(curl -s https://raw.githubusercontent.com/NvidiaFR3/Installer-Mod/main/install.sh)

DETAIL FITUR
============

1. NOTIFIKASI TELEGRAM USER BARU
---------------------------------
Deskripsi:
Sistem notifikasi otomatis yang mengirimkan alert ke Telegram admin setiap kali user baru terdaftar di panel. Mendukung format Markdown dengan informasi lengkap.

Karakteristik:
- Real-time notification - Instant alert via Telegram bot
- Rich information - Email, username, admin creator, timestamp
- Error handling - Logging system for failed notifications
- Easy configuration - Simple token & chat ID setup

Konfigurasi:
File: app/Services/Users/UserCreationService.php
Kode: 
$botToken = "YOUR_BOT_TOKEN";  // From @BotFather
$chatId = "YOUR_CHAT_ID";      // From @userinfobot

Data yang Dikirim:
🔔 *User Baru Dibuat*
👤 Admin: system
📧 Email: user@example.com
🆔 User: newuser123
📅 Tgl: 2024-01-01 12:00:00

2. TOMBOL CUSTOMER SERVICE SIDEBAR
-----------------------------------
Deskripsi:
Integrasi langsung ke layanan customer service Telegram melalui sidebar admin panel. Akses cepat tanpa perlu meninggalkan panel.

Karakteristik:
- Direct access - One-click to Telegram support
- Custom icon - Medical cross icon for visibility
- Organized menu - Separate "SUPPORT SYSTEM" section
- New tab opening - Non-intrusive user experience

Lokasi File:
resources/views/layouts/admin.blade.php

Tampilan UI:
<li class="header">SUPPORT SYSTEM</li>
<li>
    <a href="https://t.me/your_support" target="_blank">
        <i class="fa fa-user-md"></i> <span>Customer Service</span>
    </a>
</li>

3. CUSTOM ADMIN DASHBOARD REAL-TIME
------------------------------------
Deskripsi:
Dashboard admin yang sepenuhnya dikustomisasi dengan monitoring real-time sistem VPS. Menampilkan statistik live CPU, RAM, Disk, dan informasi sistem lengkap.

Fitur Utama:
- Live Resource Monitoring:
  * CPU Load (1m, 5m, 15m) dengan progress bar
  * RAM Usage dengan visualisasi persentase
  * Disk Space monitoring dengan free space indicator
- System Information Panel:
  * Hostname, OS Version, Kernel
  * Uptime, Panel Version
  * Live date & time display
- Modern UI Design:
  * Gradient color cards
  * Responsive grid layout
  * Color-coded health indicators

Metrik yang Dimonitor:
Metric           Source               Update Frequency
---------------  -------------------  ----------------
CPU Load        sys_getloadavg()     Real-time
RAM Usage       free -m              Real-time
Disk Usage      df -h /              Real-time
System Uptime   uptime -p            Real-time
Total Users     Database query       On page load
Active Servers  Database query       On page load

Health Status Indicators:
Status      Color      Condition
----------  ---------  ------------------------------------
Normal      Green      CPU < 2, RAM < 80%, Disk < 80%
Warning     Yellow     CPU 2-3, RAM 80-90%, Disk 80-90%
Critical    Red        CPU > 3, RAM > 90%, Disk > 90%

4. UBAH COPYRIGHT FOOTER (BRANDING)
------------------------------------
Deskripsi:
Customisasi branding panel dengan mengganti footer default Pterodactyl dengan identitas brand Anda sendiri.

Karakteristik:
- Full branding control - Custom text, link, version
- Professional appearance - Clean footer design
- Multi-page consistency - Applies to all admin pages

Lokasi File:
resources/views/layouts/admin.blade.php

Kode Customisasi:
<footer class="main-footer">
    <div class="pull-right hidden-xs"><b>Ver</b> 2.0</div>
    <strong>Copyright &copy; 2024 <a href="https://fr3newera.com">FR3NEWERA PANEL MOD</a>.</strong>
</footer>

5. GOD-MODE PROTECTION (AKUN ID 1)
-----------------------------------
Deskripsi:
Sistem keamanan berlapis untuk melindungi akun utama (ID 1) dari modifikasi tidak sah, baik melalui panel UI maupun direct database access.

Layer Proteksi:
1. Database Protection - Model-level protection di User.php
2. UI Protection - Read-only form fields di view
3. Delete Protection - Hidden/disabled delete button
4. Admin Lock - Permanent admin status lock

Lokasi Implementasi:
Layer      File Location                                  Protection Type
---------  ---------------------------------------------  --------------------------
Database   app/Models/User.php                            Updating & deleting events
UI/View    resources/views/admin/users/view.blade.php     Read-only fields, hidden buttons

Kode Proteksi Database:
protected static function booted()
{
    static::updating(function ($user) {
        if ($user->getOriginal('id') === 1 || $user->id === 1) {
            if ($user->isDirty(['email', 'password', 'root_admin', 'username'])) {
                throw new \Exception('FATAL ERROR: Akun GOD-MODE (ID 1) Terlindungi!');
            }
        }
    });
}

Protected Fields:
- Email address - Cannot be changed
- Password - Cannot be reset by others
- Admin status - Permanently root admin
- Username - Cannot be modified
- Account deletion - Complete protection

6. STRICT ADMIN CREATION
-------------------------
Deskripsi:
Membatasi hak membuat admin baru hanya kepada owner (user ID 1). Admin biasa tidak dapat membuat user dengan status root_admin.

Karakteristik:
- Controller-level validation - Early request validation
- Clear error messages - User-friendly exception messages
- Owner-exclusive privilege - Only ID 1 can create admins

Lokasi File:
app/Http/Controllers/Admin/UserController.php

Kode Validasi:
// --- MOD START: PROTEKSI CREATE ADMIN ---
if ($request->input('root_admin') == '1') {
    if ($request->user()->id !== 1) {
        throw new \Pterodactyl\Exceptions\DisplayException(
            'AKSES DITOLAK: Hanya Owner (ID 1) yang diizinkan membuat user Admin baru!'
        );
    }
}
// --- MOD END ---

7. NODE VIEW PROTECTION
------------------------
Deskripsi:
Mencegah admin biasa mengakses halaman detail node melalui URL manual. Melindungi informasi sensitif node seperti IP address, configuration, dan resource allocation.

Karakteristik:
- URL bypass protection - Blocks manual URL access
- Sensitive data protection - Hides node IPs and configs
- Owner-only access - Exclusive to user ID 1

Lokasi File:
app/Http/Controllers/Admin/Nodes/NodeViewController.php

Kode Proteksi:
public function index(Request $request, Node $node): View
{
    // --- MOD START: PROTEKSI NODE VIEW ---
    if ($request->user()->id !== 1) {
        throw new \Pterodactyl\Exceptions\DisplayException(
            'AKSES DITOLAK: Halaman detail Node ini diproteksi oleh System (God-Mode).'
        );
    }
    // --- MOD END ---
    
    // ... original code
}

8. API ACCESS MONETIZATION
---------------------------
Deskripsi:
Sistem monetisasi untuk akses API panel. Admin biasa akan melihat pop-up pembelian saat mencoba mengakses halaman Application API.

Karakteristik:
- SweetAlert2 popup - Professional modal dialog
- Dual action choice - Return to dashboard or contact owner
- WhatsApp integration - Direct link to owner's WhatsApp
- Content hiding - Hides original API content
