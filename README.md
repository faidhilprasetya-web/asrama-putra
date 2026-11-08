# Monitoring Asrama

Aplikasi web (PWA) untuk mencatat absensi, kartu kuning/hijau, poin, dan kebersihan kamar asrama. Data disimpan di Supabase, dan aplikasi bisa dipasang di HP seperti aplikasi biasa.

## Isi repo
- `index.html` aplikasi utama
- `report.html` Weekly Report Generator (PDF per siswa)
- `config.js` alamat dan kunci publik Supabase
- `sw.js`, `manifest.webmanifest`, `icon-*.png` agar bisa dipasang dan jalan offline
- `setup.sql` pembuatan tabel di Supabase
- `PANDUAN.md` panduan pemasangan dan pemakaian

## Pasang lewat GitHub Pages
1. Buat repo baru di GitHub, lalu upload semua file di folder ini (termasuk `.nojekyll`).
2. Buka **Settings → Pages**. Pada **Source** pilih **Deploy from a branch**, branch `main`, folder `/ (root)`, lalu **Save**.
3. Tunggu 1 sampai 2 menit. Aplikasi bisa dibuka di `https://USERNAME.github.io/NAMA-REPO/`.
4. Buat database sesuai `PANDUAN.md` bagian 1, lalu isi `url` dan `key` di `config.js`.

Setiap kali file diubah dan di-commit, GitHub Pages memperbarui situsnya otomatis. Naikkan nomor versi cache di `sw.js` (`asrama-vXX`) agar HP yang sudah memasang aplikasi memuat versi baru.

## Keamanan
- Repo publik bisa dibaca siapa saja. Jangan taruh kode akses di repo. `setup.sql` di sini memakai `GANTI_KODE_INI`, ganti hanya di Supabase SQL Editor, jangan di file yang di-commit.
- Kunci di `config.js` adalah kunci publik (publishable/anon) Supabase. Memang dirancang boleh terlihat, tapi data aman hanya jika tabel tertutup (RLS aktif) seperti di `setup.sql`. Jangan pernah memasukkan `service_role` key.
