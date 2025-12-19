# 📒 SafeContact

**SafeContact** adalah aplikasi mobile untuk menyimpan, mengelola, dan mengamankan **kontak penting** seperti kontak darurat, keluarga, teman, dan rekan kerja. Aplikasi ini dibuat untuk memastikan data kontak selalu tersedia, aman, dan mudah diakses kapan saja.

---

## 📌 Deskripsi Aplikasi

Dalam kehidupan sehari-hari, kontak penting sering kali tersebar di berbagai tempat dan berisiko hilang. **SafeContact** hadir sebagai solusi pencatatan kontak terpusat dengan fitur **pencarian cepat** dan **backup data**, sehingga kontak tetap aman meskipun terjadi kehilangan perangkat atau penghapusan data.

Aplikasi ini dikembangkan menggunakan **Flutter** dan dapat digunakan **tanpa login**, sehingga lebih sederhana dan mudah digunakan oleh semua pengguna.

---

## 🚀 Fitur Aplikasi

### 📇 Manajemen Kontak

* Menambahkan kontak penting
* Mengedit data kontak
* Menghapus kontak
* Melihat detail kontak

### 🏷️ Kategori Kontak

* Kontak Darurat
* Keluarga
* Teman
* Rekan Kerja
* Kategori khusus (custom)

### 🔍 Pencarian Kontak

* Pencarian kontak berdasarkan nama
* Pencarian berdasarkan nomor telepon
* Pencarian berdasarkan kategori

### 💾 Backup & Restore Data

* Backup data kontak ke penyimpanan (file)
* Restore data kontak dari file backup
* Mencegah kehilangan data saat ganti perangkat

---

## 🛠️ Teknologi yang Digunakan

### Mobile / Frontend

* Flutter
* Bahasa Dart

### Backend / API

* REST API
* Laravel

### Database

* MySQL

---

## 📱 Tampilan Aplikasi

* Halaman Login
* Halaman Register
* Dashboard Kontak
* Halaman Tambah & Edit Kontak
* Halaman Detail Kontak

---

## 📂 Struktur Folder Flutter

```
lib/
├── models/        # Model data
├── services/      # API & service
├── screens/       # Halaman aplikasi
│   ├── auth/      # Login & Register
│   ├── home/      # Dashboard
│   └── contact/   # Kontak
├── widgets/       # Komponen UI
└── main.dart      # Entry point
```

---

## 🔌 Pengelolaan Data

Aplikasi **SafeContact** tidak menggunakan fitur login atau autentikasi pengguna. Semua data kontak dikelola langsung oleh pengguna pada perangkat atau melalui API tanpa proses autentikasi.

### Kontak

* **GET** `/api/contacts` → Menampilkan semua kontak
* **POST** `/api/contacts` → Menambah kontak
* **GET** `/api/contacts/{id}` → Detail kontak
* **PUT** `/api/contacts/{id}` → Update kontak
* **DELETE** `/api/contacts/{id}` → Hapus kontak

---

## ⚙️ Cara Menjalankan Aplikasi

1. Clone repository

```bash
git clone https://github.com/username/safecontact.git
```

2. Masuk ke folder project

```bash
cd safecontact
```

3. Install dependency

```bash
flutter pub get
```

4. Jalankan aplikasi

```bash
flutter run
```

---

## 📋 Kebutuhan Sistem

* Flutter SDK
* Android Studio / VS Code
* Emulator atau perangkat Android
* Backend API aktif

---

## 👤 Penggunaan Aplikasi

* Aplikasi digunakan langsung tanpa login
* Semua fitur dapat diakses oleh pengguna
* Kontak dikelola secara mandiri oleh pengguna

---

## 🎯 Tujuan Pengembangan

* Menyediakan penyimpanan kontak penting yang aman
* Mempermudah pencarian kontak dengan cepat
* Menyediakan fitur backup untuk mencegah kehilangan data
* Mengurangi risiko kehilangan data kontak penting

---

## 📝 Lisensi

Aplikasi ini dikembangkan untuk keperluan pembelajaran dan pengembangan.

---

## 👩‍💻 Pengembang

Nama: **Indah Puji Astuti**

---

> **SafeContact** – Solusi Aman untuk Menyimpan Kontak Penting 🔐📞

# link apk

https://github.com/puji0704/uas_pemrograman_mobile/releases/download/v1.0.0/app-release.apk
