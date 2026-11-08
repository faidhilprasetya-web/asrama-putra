# Panduan Pemasangan Aplikasi Monitoring Asrama

Isi folder: `index.html`, `config.js`, `sw.js`, `manifest.webmanifest`, ikon, dan `setup.sql`.
Total waktu sekitar 15 menit. Semua layanan di bawah punya paket gratis.

## 1. Buat database (Supabase)
1. Daftar di https://supabase.com lalu klik **New project**. Pilih region terdekat (Singapore), buat password database, tunggu selesai.
2. Buka **SQL Editor** → **New query**.
3. Buka `setup.sql`, ganti `GANTI_KODE_INI` dengan **kode akses bersama** pilihan Anda, tempel semuanya ke editor, klik **Run**.
4. Buka **Project Settings → API**. Salin **Project URL** dan **anon public key**.

## 2. Sambungkan aplikasi
Buka `config.js` dengan Notepad/editor teks, ganti `url` dan `key` dengan dua nilai tadi, lalu simpan.
(Anon key memang boleh ada di aplikasi. Data tetap aman karena tabel tertutup dan hanya bisa dibuka dengan kode akses.)

## 3. Taruh di internet (Netlify)
1. Buka https://app.netlify.com/drop (daftar gratis jika diminta).
2. Seret seluruh folder ini ke halaman itu.
3. Anda mendapat link seperti `https://nama-acak.netlify.app`. Nama bisa diganti di Site settings.

### Alternatif: GitHub Pages
Kalau lebih suka GitHub: buat repo, upload semua file folder ini, lalu **Settings → Pages → Deploy from a branch → main / (root)**. Link-nya `https://USERNAME.github.io/NAMA-REPO/`. Jangan menulis kode akses di `setup.sql` yang di-commit ke repo publik.

## 4. Pasang di HP
- **Android (Chrome)**: buka link → menu ⋮ → **Instal aplikasi** / **Tambahkan ke layar utama**.
- **iPhone (Safari)**: buka link → tombol Bagikan → **Tambah ke Layar Utama**.

Pertama kali dibuka, masukkan kode akses. Bagikan link dan kode itu ke semua pembina/pengurus.

## Cara pakai singkat
- Halaman utama selalu **Dashboard**. Semua input lewat tombol hijau **＋ Input Data** (pop up) dengan empat tab: Absensi, Kartu, Siswa, Kategori.
- **Siswa**: isi data siswa (bisa banyak sekaligus).
- **Kategori**: isi sendiri kategori Kartu Kuning dan Kartu Hijau beserta **poinnya** (bawaan 1). Hijau menambah poin, kuning mengurangi. **Total poin = poin hijau − poin kuning.**
- **Absensi**: pilih tanggal, isi **nama dua pembina piket**, pilih kegiatan, ketuk status, **Simpan Absensi**. Nama kedua pembina piket wajib diisi dan ikut tercatat.
- **Kartu**: pilih siswa, jenis kartu, kategori, lalu **Simpan Kartu**.
- Tab **Peringatan** (di ＋ Input Data): atur batas total poin dan jumlah kartu kuning bulan ini. Siswa yang melewati batas ditandai merah di Dashboard dan Monitoring Siswa.
- Di bawah Dashboard ada tombol **Cadangkan semua data (Excel)**. Lakukan sekali seminggu dan simpan filenya.
- Tab **Rekap**: filter lalu **Unduh Excel** (sheet Rekap, Detail, Piket, Kartu).
- Tanpa sinyal: data tersimpan di HP dan terkirim otomatis saat online (indikator di pojok atas).

## Catatan
- Ganti kode akses: jalankan di SQL Editor `update config set code = 'KODE_BARU' where id = 1;` lalu beri tahu semua orang. HP lama akan diminta memasukkan kode baru.
- Proyek Supabase gratis bisa dijeda jika tidak dipakai sekitar seminggu. Kalau itu terjadi, buka dashboard Supabase dan klik Restore. Pakai rutin biasanya aman.
- Karena satu kode dipakai bersama, aplikasi hanya mencatat nama piket yang diketik, bukan identitas login masing-masing.
- Ekspor Excel memakai library dari internet, jadi tombol Unduh Excel butuh sinyal sesekali (setelah pernah termuat, biasanya tersimpan untuk offline).

- 20 siswa dengan total poin tertinggi (hanya yang poinnya di atas 0) ditandai 🟢 hijau di Dashboard, Rekap, dan Monitoring Siswa.
