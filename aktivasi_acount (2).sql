-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 11 Mar 2026 pada 12.14
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aktivasi_acount`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `brand`
--

CREATE TABLE `brand` (
  `id_brand` int(11) NOT NULL,
  `nama_brand` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `brand`
--

INSERT INTO `brand` (`id_brand`, `nama_brand`) VALUES
(1, 'Samsung'),
(2, 'Xiaomi'),
(3, 'Realme'),
(4, 'Vivo'),
(5, 'Oppo'),
(12, 'Infinix'),
(13, 'iphone');

-- --------------------------------------------------------

--
-- Struktur dari tabel `cart`
--

CREATE TABLE `cart` (
  `id_cart` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `id_produk` int(11) DEFAULT NULL,
  `jumlah` int(11) DEFAULT 1,
  `id_varian` int(11) DEFAULT NULL,
  `warna` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `cart`
--

INSERT INTO `cart` (`id_cart`, `id_user`, `id_produk`, `jumlah`, `id_varian`, `warna`) VALUES
(222, 23, 34, 1, 80, ''),
(223, 23, 34, 1, 81, ''),
(224, 23, 34, 1, NULL, ''),
(226, 30, 45, 2, NULL, ''),
(237, 24, 46, 1, 104, ''),
(262, 3, 47, 1, 54, 'hitam'),
(263, 3, 34, 2, 48, 'merah'),
(268, 30, 48, 1, 56, 'biru'),
(287, 14, 51, 1, 7, 'Putih'),
(292, 33, 61, 1, 65, 'putih'),
(300, 35, 51, 1, 7, 'Hitam'),
(304, 14, 48, 1, 56, 'Hitam'),
(305, 14, 46, 1, 53, 'Hitam'),
(306, 38, 48, 1, 56, 'Hitam'),
(307, 39, 47, 1, 54, 'Hitam');

-- --------------------------------------------------------

--
-- Struktur dari tabel `data`
--

CREATE TABLE `data` (
  `id_produk` int(11) NOT NULL,
  `nama_produk` varchar(50) DEFAULT NULL,
  `spesifikasi` text DEFAULT NULL,
  `harga` decimal(12,2) DEFAULT NULL,
  `merek` varchar(20) DEFAULT NULL,
  `gambar` varchar(255) NOT NULL DEFAULT 'default.jpg',
  `stok` int(11) DEFAULT 0,
  `id_brand` int(11) DEFAULT NULL,
  `gambar1` varchar(255) DEFAULT NULL,
  `gambar2` varchar(255) DEFAULT NULL,
  `gambar3` varchar(255) DEFAULT NULL,
  `penyimpanan` int(11) NOT NULL,
  `ram` int(11) DEFAULT 0,
  `baterai` int(11) DEFAULT 0,
  `chipset` varchar(100) DEFAULT NULL,
  `layar` varchar(100) DEFAULT NULL,
  `kamera` varchar(100) DEFAULT NULL,
  `os` varchar(50) DEFAULT NULL,
  `fitur` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `data`
--

INSERT INTO `data` (`id_produk`, `nama_produk`, `spesifikasi`, `harga`, `merek`, `gambar`, `stok`, `id_brand`, `gambar1`, `gambar2`, `gambar3`, `penyimpanan`, `ram`, `baterai`, `chipset`, `layar`, `kamera`, `os`, `fitur`) VALUES
(1, 'Samsung Galaxy A14', 'Layar 6.6 inci PLS LCD, RAM 4GB, ROM 64GB, kamera utama 50MP, kamera depan 13MP, baterai 5000mAh, Android 13.', 2200000.00, 'Samsung', 'img/samsunggalaxya14.jpg', 44, 1, NULL, NULL, NULL, 64, 4, 5000, 'Exynos 850', '6.6 PLS LCD FHD+ 90Hz', '50MP + 5MP + 2MP', 'Android 13', NULL),
(2, 'Samsung Galaxy A24', 'Layar 6.5 inci Super AMOLED, RAM 6GB, ROM 128GB, kamera utama 50MP OIS, kamera depan 13MP, baterai 5000mAh, Android 13.', 2800000.00, 'Samsung', 'img/samsunggalaxya24.jpg', 33, 1, NULL, NULL, NULL, 128, 6, 5000, 'Helio G99', '6.5 Super AMOLED 90Hz', '50MP + 5MP + 2MP', 'Android 13', NULL),
(3, 'Samsung Galaxy A34', 'Layar 6.6 inci Super AMOLED 120Hz, RAM 8GB, ROM 128GB, kamera utama 48MP OIS, kamera depan 13MP, baterai 5000mAh, Android 13.', 3400000.00, 'Samsung', 'img/samsunggalaxya34.jpg', 31, 1, NULL, NULL, NULL, 128, 8, 5000, 'Dimensity 1080', '6.6 Super AMOLED 120Hz', '48MP + 8MP + 5MP', 'Android 13', NULL),
(4, 'Samsung Galaxy A54', 'Layar 6.4 inci Super AMOLED 120Hz, RAM 8GB, ROM 256GB, kamera utama 50MP OIS, kamera depan 32MP, baterai 5000mAh, Android 13.', 4600000.00, 'Samsung', 'img/galaxya54.jpg', 21, 1, NULL, NULL, NULL, 128, 8, 5000, 'Exynos 1380', '6.4 Super AMOLED 120Hz', '50MP + 12MP + 5MP', 'Android 13', NULL),
(5, 'Xiaomi Redmi 12', 'Layar 6.79 inci IPS LCD, RAM 4GB, ROM 128GB, kamera utama 50MP, kamera depan 8MP, baterai 5000mAh, Android 13.', 1900000.00, 'Xiaomi', 'img/readme12.jpg', 56, 2, NULL, NULL, NULL, 128, 4, 5000, 'Helio G88', '6.79 IPS LCD FHD+ 90Hz', '50MP + 8MP + 2MP', 'Android 13', NULL),
(6, 'Xiaomi Redmi Note 12', 'Layar 6.67 inci AMOLED 120Hz, RAM 6GB, ROM 128GB, kamera utama 50MP, kamera depan 13MP, baterai 5000mAh, Android 13.', 2400000.00, 'Xiaomi', 'img/redmi12.jpg', 40, 2, NULL, NULL, NULL, 128, 4, 5000, 'Snapdragon 685', '6.67 AMOLED 120Hz', '50MP + 8MP + 2MP', 'Android 13', NULL),
(7, 'Xiaomi Redmi 13C', 'Layar 6.74 inci IPS LCD, RAM 4GB, ROM 128GB, kamera utama 50MP, kamera depan 8MP, baterai 5000mAh, Android 13.', 1500000.00, 'Xiaomi', 'img/readme13c.jpg', 66, 2, NULL, NULL, NULL, 128, 4, 5000, 'Helio G85', '6.74 IPS LCD 90Hz', '50MP + 2MP', 'Android 13', NULL),
(8, 'Xiaomi Poco M5', 'Layar 6.58 inci IPS LCD 90Hz, RAM 6GB, ROM 128GB, kamera utama 50MP, kamera depan 5MP, baterai 5000mAh, Android 12.', 1800000.00, 'Xiaomi', 'img/pocom5.jpg', 45, 2, NULL, NULL, NULL, 128, 4, 5000, 'Helio G99', '6.58 IPS LCD 90Hz', '50MP + 2MP + 2MP', 'Android 12', NULL),
(9, 'Xiaomi Poco X5', 'Layar 6.67 inci AMOLED 120Hz, RAM 8GB, ROM 256GB, kamera utama 48MP, kamera depan 13MP, baterai 5000mAh, Android 12.', 3200000.00, 'Xiaomi', 'img/pocox5.jpg', 27, 2, NULL, NULL, NULL, 128, 6, 5000, 'Snapdragon 695', '6.67 AMOLED 120Hz', '48MP + 8MP + 2MP', 'Android 12', NULL),
(10, 'Realme C55', 'Layar 6.72 inci IPS LCD, RAM 6GB, ROM 128GB, kamera utama 64MP, kamera depan 8MP, baterai 5000mAh, Android 13.', 2300000.00, 'Realme', 'img/realme c55.jpg', 49, 3, NULL, NULL, NULL, 128, 4, 5000, 'Helio G88', '6.72 IPS LCD 90Hz', '64MP + 2MP', 'Android 13', NULL),
(11, 'Realme C53', 'Layar 6.74 inci IPS LCD, RAM 6GB, ROM 128GB, kamera utama 50MP, kamera depan 8MP, baterai 5000mAh, Android 13.', 1800000.00, 'Realme', 'img/realme c53.jpg', 51, 3, NULL, NULL, NULL, 128, 4, 5000, 'Unisoc T612', '6.74 IPS LCD 90Hz', '50MP', 'Android 13', NULL),
(12, 'Realme 10 Pro', 'Layar 6.72 inci IPS LCD 120Hz, RAM 8GB, ROM 256GB, kamera utama 108MP, kamera depan 16MP, baterai 5000mAh, Android 13.', 3500000.00, 'Realme', 'img/realme10pro_1.jpg', 31, 3, NULL, NULL, NULL, 128, 6, 5000, 'Snapdragon 695', '6.72 IPS LCD 120Hz', '108MP + 2MP', 'Android 13', NULL),
(13, 'Realme 11', 'Layar 6.4 inci AMOLED, RAM 8GB, ROM 256GB, kamera utama 108MP, kamera depan 16MP, baterai 5000mAh, Android 13.', 2600000.00, 'Realme', 'img/realme 11.jpg', 36, 3, NULL, NULL, NULL, 128, 8, 5000, 'Helio G99', '6.4 AMOLED 90Hz', '108MP', 'Android 13', NULL),
(14, 'Vivo Y17s', 'Layar 6.56 inci IPS LCD, RAM 4GB, ROM 128GB, kamera utama 50MP, kamera depan 8MP, baterai 5000mAh, Android 13', 2000000.00, 'Vivo', 'img/vivoy17s.jpg', 46, 4, NULL, NULL, NULL, 128, 4, 5000, 'Helio G85', '6.56 IPS LCD 60Hz', '50MP + 2MP', 'Android 13', NULL),
(15, 'Vivo Y21', 'Layar 6.51 inci IPS LCD, RAM 4GB, ROM 64GB, kamera utama 13MP, kamera depan 8MP, baterai 5000mAh, Android 11.', 1900000.00, 'Vivo', 'img/vivoy21.jpg', 51, 4, NULL, NULL, NULL, 64, 4, 5000, 'Helio P35', '6.51 IPS LCD', '13MP + 2MP', 'Android 11', NULL),
(16, 'Vivo Y27', 'Layar 6.64 inci IPS LCD, RAM 6GB, ROM 128GB, kamera utama 50MP, kamera depan 8MP, baterai 5000mAh, Android 13.', 2300000.00, 'Vivo', 'img/vivoy27.jpg', 37, 4, NULL, NULL, NULL, 128, 6, 5000, 'Helio G85', '6.64 IPS LCD FHD+', '50MP + 2MP', 'Android 13', NULL),
(17, 'Vivo T1 5G', 'Layar 6.58 inci IPS LCD 120Hz, RAM 8GB, ROM 128GB, kamera utama 50MP, kamera depan 16MP, baterai 5000mAh, Android 12.', 2900000.00, 'Vivo', 'img/t1pro1.jpg', 33, 4, NULL, NULL, NULL, 128, 8, 5000, 'Snapdragon 695', '6.58 IPS LCD 120Hz', '50MP + 2MP + 2MP', 'Android 12', NULL),
(18, 'OPPO A38', 'Layar 6.56 inci IPS LCD, RAM 4GB, ROM 128GB, kamera utama 50MP, kamera depan 5MP, baterai 5000mAh, Android 13.', 2100000.00, 'OPPO', 'img/oppoa381.jpg', 47, 5, NULL, NULL, NULL, 128, 4, 5000, 'Helio G85', '6.56 IPS LCD 90Hz', '50MP + 2MP', 'Android 13', NULL),
(19, 'OPPO A57', 'Layar 6.56 inci IPS LCD, RAM 4GB, ROM 64GB, kamera utama 13MP, kamera depan 8MP, baterai 5000mAh, Android 12.', 2400000.00, 'OPPO', 'img/oppoA571.jpg', 43, 5, NULL, NULL, NULL, 128, 4, 5000, 'Helio G35', '6.56 IPS LCD 60Hz', '13MP + 2MP', 'Android 12', NULL),
(20, 'OPPO A78', 'Layar 6.43 inci AMOLED, RAM 8GB, ROM 256GB, kamera utama 50MP, kamera depan 8MP, baterai 5000mAh, Android 13.', 3500000.00, 'OPPO', 'img/oppoA781.jpg', 26, 5, NULL, NULL, NULL, 128, 6, 5000, 'Dimensity 700', '6.56 IPS LCD 90Hz', '50MP + 2MP', 'Android 13', NULL),
(32, 'vivo y 91 series', 'Layar 6.22 inci IPS LCD, RAM 3GB, ROM 32GB, kamera utama 13MP, kamera depan 8MP, baterai 4030mAh, Android 8.', 1000000.00, NULL, 'img/y911.jpg', 6, 4, NULL, NULL, NULL, 32, 4, 4030, 'Helio P22', '6.22 IPS LCD', '13MP + 2MP', 'Android 8', NULL),
(33, 'Samsung A03', 'Layar 6.5 inci PLS LCD, RAM 4GB, ROM 64GB, kamera utama 48MP, kamera depan 5MP, baterai 5000mAh, Android 11.', 1300000.00, 'Samsung', 'img/a032.jpg', 9, 1, NULL, NULL, NULL, 32, 8, 5000, 'Unisoc T606', '6.5 PLS LCD', '48MP + 2MP', 'Android 11', NULL),
(34, 'Vivo Y28', 'Vivo Y28 adalah smartphone kelas menengah dengan fokus pada daya tahan baterai besar (6000mAh) dan desain menarik, menawarkan performa harian cukup baik dengan chipset Helio G85, layar 90Hz, kamera utama 50MP, serta fitur seperti 44W FlashCharge, IP64 dust/splash resistance, dan dual speaker stereo', 2000000.00, 'vivo', 'img/y282.jpg', 9, 4, NULL, NULL, NULL, 512, 4, 6000, 'Helio G85', '6.68 IPS LCD 90Hz', '50MP + 2MP', 'Android 14', NULL),
(45, 'Samsung Galaxy A56 5G', 'Layar Super AMOLED 6.7 inci resolusi FHD+ dengan refresh rate 120Hz, chipset Exynos 1580, RAM 8 GB, kamera belakang 50 MP + 12 MP + 5 MP, kamera depan 12 MP, baterai 5000 mAh dengan fast charging 45W, sistem operasi Android terbaru dengan One UI', 5699000.00, 'Samsung', 'img/samsunga561.jpg', 8, 1, NULL, NULL, NULL, 128, 8, 5000, 'Exynos 1580', '6.7 Super AMOLED 120Hz', '50MP + 12MP + 5MP', 'Android 14', NULL),
(46, 'Samsung Galaxy A26 5G', 'Layar PLS LCD 6.5 inci resolusi FHD+, chipset Exynos 1280, RAM 6 GB atau 8 GB, kamera belakang 50 MP + 2 MP, kamera depan 13 MP, baterai 5000 mAh, mendukung jaringan 5G, sistem operasi Android', 4399000.00, 'Samsung', 'img/samsunga261.jpg', 5, 1, NULL, NULL, NULL, 128, 4, 5000, 'Exynos 1280', '6.7 Super AMOLED 120Hz', '50MP + 8MP + 2MP', 'Android 14', NULL),
(47, 'Vivo Y36', 'Spesifikasi: Layar IPS LCD 6.64 inci resolusi FHD+, chipset Snapdragon 680, RAM 8 GB, kamera belakang 50 MP + 2 MP, kamera depan 16 MP, baterai 5000 mAh fast charging 44W, sistem operasi Funtouch OS berbasis Android', 2999000.00, 'vivo', 'img/vivoy361.jpg', 5, 4, NULL, NULL, NULL, 256, 8, 5000, 'Snapdragon 680', '6.64 IPS LCD 90Hz', '50MP + 2MP', 'Android 13', NULL),
(48, 'Oppo Reno 14', 'Ukuran dan Berat. Tinggi. sekitar 157,90mm · Penyimpanan. Kapasitas RAM dan ROM. 8GB + 256GB · Layar. Ukuran. 6,59 inci · Kamera. Belakang.', 3999000.00, 'oppo', 'img/opporeno141_1.jpg', 14, 5, NULL, NULL, NULL, 256, 8, 5000, 'Dimensity 9200', '6.7 AMOLED 120Hz', '50MP + 8MP + 2MPs', 'Android 14', 'None'),
(51, 'Infinix Hot 40 Pro', 'harga murah dan berkualitas tinggi', 2000000.00, 'Infinix', 'img/infinixhot40pro1.jpg', 5, 12, NULL, NULL, NULL, 32, 2, 5000, 'MediaTek Helio G99', 'layar 6.78\" FHD+ 120Hz', '108MP', 'Android 13', 'None'),
(61, 'Infinix Smart 10', 'Infinix Smart 10 (2025) adalah smartphone kelas entri yang menawarkan layar IPS LCD 6.67 inci berkecepatan refresh 120Hz, chipset Unisoc T7250, dan baterai 5000 mAh dengan pengisian daya 15W. Ponsel ini berjalan pada Android 15 (XOS 15.1), dilengkapi RAM 4GB, opsi penyimpanan 64GB/128GB, serta kamera belakang 8MP.', NULL, 'Infinix', 'img/smart10.jpg', 0, 12, NULL, NULL, NULL, 0, 0, 5000, 'Unisoc T725', ' 6.67 inci IPS LCD 120Hz', '8 MP, f/2.0', 'Android 15', ' NFC, Dynamic Bar, IP64');

-- --------------------------------------------------------

--
-- Struktur dari tabel `data_produk`
--

CREATE TABLE `data_produk` (
  `id_produk` int(11) NOT NULL,
  `nama_produk` varchar(255) DEFAULT NULL,
  `spesifikasi` text DEFAULT NULL,
  `harga` decimal(12,2) DEFAULT NULL,
  `merek` varchar(100) DEFAULT NULL,
  `gambar` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `ongkir`
--

CREATE TABLE `ongkir` (
  `id_ongkir` int(11) NOT NULL,
  `provinsi` varchar(30) DEFAULT NULL,
  `kabupaten` varchar(30) DEFAULT NULL,
  `biaya` int(11) DEFAULT NULL,
  `kecamatan` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `ongkir`
--

INSERT INTO `ongkir` (`id_ongkir`, `provinsi`, `kabupaten`, `biaya`, `kecamatan`) VALUES
(1, 'Sulawesi Selatan', 'Toraja Utara', 16000, 'Tallunglipu'),
(2, 'Sulawesi Selatan', 'Makassar', 20000, 'takalar'),
(3, 'Sulawesi Selatan', 'Bone', 25000, NULL),
(5, 'sulawesi selatan', 'Toraja Utara', 30000, 'Rindingallo'),
(6, 'Sulawesi Selatan', 'Toraja Utara', 13000, 'Baruppu');

-- --------------------------------------------------------

--
-- Struktur dari tabel `orders`
--

CREATE TABLE `orders` (
  `id_order` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `negara` varchar(20) DEFAULT NULL,
  `provinsi` varchar(50) DEFAULT NULL,
  `kota` varchar(30) DEFAULT NULL,
  `tanggal` timestamp NOT NULL DEFAULT current_timestamp(),
  `total_harga` decimal(12,2) DEFAULT NULL,
  `status_pesanan` enum('menunggu konfirmasi','diproses/packing','dikirim','selesai','dibatalkan') DEFAULT 'menunggu konfirmasi',
  `alamat_lengkap` text DEFAULT NULL,
  `metode_pembayaran` varchar(50) DEFAULT NULL,
  `bukti_transfer` varchar(255) DEFAULT NULL,
  `lat` decimal(10,8) DEFAULT NULL,
  `lng` decimal(11,8) DEFAULT NULL,
  `ongkir` int(11) DEFAULT 0,
  `alamat_map` text DEFAULT NULL,
  `kode_billing` varchar(50) DEFAULT NULL,
  `kode_qris` text DEFAULT NULL,
  `status_pembayaran` enum('Belum Bayar','Menunggu Verifikasi','Lunas') DEFAULT 'Belum Bayar',
  `bukti_pembayaran` varchar(50) NOT NULL,
  `nama_penerima` varchar(30) DEFAULT NULL,
  `no_hp` varchar(20) DEFAULT NULL,
  `kecamatan` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `orders`
--

INSERT INTO `orders` (`id_order`, `id_user`, `negara`, `provinsi`, `kota`, `tanggal`, `total_harga`, `status_pesanan`, `alamat_lengkap`, `metode_pembayaran`, `bukti_transfer`, `lat`, `lng`, `ongkir`, `alamat_map`, `kode_billing`, `kode_qris`, `status_pembayaran`, `bukti_pembayaran`, `nama_penerima`, `no_hp`, `kecamatan`) VALUES
(94, 14, 'Indonesia', 'Sulawesi Selatan', 'Makassar', '2026-01-21 16:07:27', 12520000.00, 'selesai', 'balai tanjung', 'TRANSFER', NULL, -5.13488561, 119.41374069, 20000, 'Jalan Jenderal Sudirman, Pisang Utara, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', 'BILL-B0BA6C8D28', NULL, '', 'opporeno141_1.jpg', NULL, NULL, NULL),
(95, 15, 'Indonesia', 'Riau', 'Pekanbaru', '2026-01-21 16:16:30', 18340000.00, 'selesai', 'balai tanjung', 'COD', NULL, -5.13437269, 119.41528632, 40000, 'Sop Konro Karebosi Cabang Makassar, Jalan Gunung Lompo Battang, Pisang Utara, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(96, 16, 'Indonesia', 'Sumatera Barat', 'Padang', '2026-01-21 16:21:49', 12540000.00, 'selesai', '55', 'COD', NULL, -5.13522755, 119.42507527, 40000, 'Jalan Titang, Barana, Makassar, Sulawesi Selatan, Sulawesi, 90153, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(97, 17, 'Indonesia', 'Sumatera Barat', 'Bukittinggi', '2026-01-21 17:20:14', 15940000.00, 'selesai', 'banteng', 'COD', NULL, -5.12873057, 119.42902520, 40000, 'Jalan Petta Punggawa, Timongan Lompoa, Kalukuang, Tallo, Makassar, Sulawesi Selatan, Sulawesi, 90152, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(98, 18, 'Indonesia', 'Sumatera Barat', 'Bukittinggi', '2026-01-21 17:23:05', 12540000.00, 'selesai', 'balai tanjung', 'COD', NULL, -5.12684985, 119.42185662, 40000, 'Lorong 116 A, Baraya, Bontoala Tua, Bontoala, Makassar, Sulawesi Selatan, Sulawesi, 90156, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(99, 19, 'Indonesia', 'Aceh', 'Banda Aceh', '2026-01-21 17:25:16', 10440000.00, 'selesai', 'balai tanjung', 'COD', NULL, -5.14001476, 119.40910382, 40000, 'Jalan Dg. Tompo, Maloku, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(100, 20, 'Indonesia', 'Riau', 'Dumai', '2026-01-21 17:27:44', 11940000.00, 'selesai', 'balai tanjung', 'COD', NULL, -5.14001476, 119.41425590, 40000, 'Bank Permata, Jalan Jenderal Sudirman, Sawerigading, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90114, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(101, 21, 'Indonesia', 'Riau', 'Pekanbaru', '2026-01-21 17:30:34', 10040000.00, 'selesai', '55', 'COD', NULL, -5.13608241, 119.41562979, 40000, 'Pisang Utara, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(102, 22, 'Indonesia', 'Riau', 'Pekanbaru', '2026-01-21 17:33:23', 13839000.00, 'selesai', 'banteng', 'COD', NULL, -5.13095323, 119.41837756, 40000, 'Jalan Bonto Sua, Gaddong, Bontoala, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(103, 23, 'Indonesia', 'Kepulauan Riau', 'Batam', '2026-01-21 17:36:43', 11040000.00, 'selesai', 'balai tanjung', 'COD', NULL, -5.13163712, 119.41597326, 40000, 'Rumah Sakit Akademis Jaury Jusuf Putra, Jalan Laiya 3, Pattunuang, Wajo, Makassar, Sulawesi Selatan, Sulawesi, 90156, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(104, 24, 'Indonesia', 'Kepulauan Riau', 'Batam', '2026-01-21 17:39:42', 12439000.00, 'selesai', 'banteng', 'COD', NULL, -5.13266296, 119.41288201, 40000, 'Makassar Trade Center (MTC), Jalan Haji Oemar Said Cokroaminoto, Pattunuang, Wajo, Makassar, Sulawesi Selatan, Sulawesi, 90171, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(105, 25, 'Indonesia', 'Kepulauan Riau', 'Tanjung Pinang', '2026-01-21 17:42:51', 12337000.00, 'selesai', 'balai tanjung', 'COD', NULL, -5.13522755, 119.41854930, 40000, 'SMA Negeri 1 Makassar, Jalan Gunung Bawakaraeng, Gaddong, Bontoala, Makassar, Sulawesi Selatan, Sulawesi, 90145, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(106, 26, 'Indonesia', 'Sumatera Barat', 'Bukittinggi', '2026-01-21 17:45:29', 9239000.00, 'selesai', 'banteng', 'COD', NULL, -5.12873057, 119.41253854, 40000, 'BRI, Jalan Dokter Wahidin Sudirohusodo, Ende, Wajo, Makassar, Sulawesi Selatan, Sulawesi, 90171, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(107, 27, 'Indonesia', 'Sumatera Barat', 'Payakumbuh', '2026-01-21 17:47:10', 8040000.00, 'selesai', '55', 'COD', NULL, -5.13625338, 119.41545805, 40000, 'Pisang Utara, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(108, 28, 'Indonesia', 'Kepulauan Riau', 'Batam', '2026-01-21 17:49:05', 4340000.00, 'selesai', 'balai tanjung', 'COD', NULL, -5.13300491, 119.41940798, 40000, 'Jalan G. Latimojong, Gaddong, Bontoala, Makassar, Sulawesi Selatan, Sulawesi, 90153, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(109, 30, 'Indonesia', 'Sumatera Utara', 'Pematang Siantar', '2026-02-01 13:13:50', 1040000.00, '', 'banteng', 'COD', NULL, -5.13522755, 119.41219507, 40000, 'Jalan Kartini, Baru, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(110, 30, 'Indonesia', 'Sumatera Utara', 'Medan', '2026-02-11 12:54:35', 5739000.00, '', 'banteng', 'TRANSFER', NULL, -5.16734817, 119.43357734, 40000, 'SEKOLAH DASR KOMPLEKS UKIP 1, Jalan A. Pettarani, Banta-Bantaeng, Rappocini, Makassar, Sulawesi Selatan, Sulawesi, 90221, Indonesia', 'BILL-12A21E482B', NULL, 'Menunggu Verifikasi', '', NULL, NULL, NULL),
(111, 30, 'Indonesia', 'Sulawesi Selatan', 'Toraja Utara', '2026-02-11 13:26:47', 5739000.00, '', 'kampung barereng', 'TRANSFER', NULL, -2.84257554, 119.77972820, 40000, 'Baruppu’, Toraja Utara, Sulawesi Selatan, Sulawesi, Indonesia', 'BILL-8F6CF65EF1', NULL, 'Menunggu Verifikasi', '', NULL, NULL, NULL),
(117, 30, 'Indonesia', 'Sulawesi Selatan', 'Toraja Utara', '2026-02-12 10:25:29', 4019000.00, '', 'banteng', 'COD', NULL, -5.13608241, 119.41820583, 20000, 'Lariang Bangi, Makassar, Sulawesi Selatan, Sulawesi, 90145, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(118, 30, 'Indonesia', 'Sulawesi Selatan', 'Toraja Utara', '2026-02-12 10:33:16', 2220000.00, '', 'balai tanjung', 'TRANSFER', NULL, -5.13710824, 119.41167986, 20000, 'Wisma Sultan Hasanuddin Baru, Jalan Amanagapa, Baru, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', '88087144504700', NULL, 'Menunggu Verifikasi', 'unisex.jpg', NULL, NULL, NULL),
(119, 30, 'Indonesia', 'Sulawesi Selatan', 'Toraja Utara', '2026-02-12 10:41:23', 4616000.00, 'selesai', 'balai tanjung', 'COD', NULL, -5.13471463, 119.41253854, 16000, 'Jalan Kartini, Baru, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(120, 30, 'Indonesia', 'Sulawesi Selatan', 'Toraja Utara', '2026-02-17 14:19:34', 3019000.00, '', 'banteng', 'COD', NULL, -5.13591144, 119.41047771, 20000, 'Jalan Kajoalalido, Baru, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90171, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(121, 14, 'Indonesia', 'Sulawesi Selatan', 'Toraja Utara', '2026-02-17 15:16:47', 1720000.00, '', 'balai tanjung', 'COD', NULL, -5.13385977, 119.41064944, 20000, 'Jalan Kajoalalido, Baru, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90171, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(122, 32, 'Indonesia', 'Sulawesi Selatan', 'Toraja Utara', '2026-02-17 15:32:09', 1919000.00, 'selesai', '55', 'COD', NULL, -5.13437269, 119.41631673, 20000, 'Jalan Sungai Klara, Pisang Utara, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(126, 28, 'Indonesia', 'Sulawesi Selatan', 'Toraja Utara', '2026-02-25 13:21:27', 3267000.00, 'selesai', 'balai tanjung', 'COD', NULL, -5.13710824, 119.41511458, 20000, 'Rumah Sakit Pelamonia, Jalan Gunung Tinggimae, Pisang Utara, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90154, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(127, 26, 'Indonesia', 'Sulawesi Selatan', 'Toraja Utara', '2026-02-25 13:25:02', 1594000.00, 'selesai', 'balai tanjung', 'COD', NULL, -5.13574047, 119.42463723, 20000, 'Jalan Balana 1, Barana, Makassar, Sulawesi Selatan, Sulawesi, 90153, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(128, 27, 'Indonesia', 'Sulawesi Selatan', 'Toraja Utara', '2026-02-25 13:26:12', 1469000.00, 'selesai', 'banteng', 'COD', NULL, -5.13659533, 119.41580152, 20000, 'Toko Aswan, Jalan Buntu Terpedo, Pisang Utara, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(129, 31, 'Indonesia', 'Sulawesi Selatan', 'Toraja Utara', '2026-03-02 00:19:00', 1594000.00, '', 'banteng', 'COD', NULL, -2.94801251, 119.88753505, 20000, 'Tikala, Toraja Utara, Sulawesi Selatan, Sulawesi, 91833, Indonesia', NULL, NULL, '', '', NULL, NULL, NULL),
(130, 14, 'Indonesia', 'Sulawesi Selatan', 'Toraja Utara', '2026-03-02 08:54:30', 2519000.00, 'selesai', 'tallunglipu', 'TRANSFER', NULL, -2.94801251, 119.88598942, 20000, 'Tikala, Toraja Utara, Sulawesi Selatan, Sulawesi, 91833, Indonesia', '88089965043756', NULL, '', 'pembayaran.jpeg', NULL, NULL, NULL),
(131, 35, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-06 15:20:23', 1269000.00, '', 'jalan barereng 88', 'COD', NULL, NULL, NULL, 20000, NULL, NULL, NULL, '', '', 'ucok', '098897609', 'Baruppu'),
(132, 35, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-06 15:40:23', 1594000.00, '', 'jalan barereng 88', 'COD', NULL, NULL, NULL, 20000, '', NULL, NULL, 'Belum Bayar', '', NULL, NULL, NULL),
(133, 35, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-08 08:45:33', 3819000.00, '', 'jalan barereng 88', 'TRANSFER', NULL, NULL, NULL, 20000, '', NULL, NULL, 'Belum Bayar', '', NULL, NULL, NULL),
(134, 35, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-08 08:54:00', 3219000.00, '', 'jalan barereng 88', 'TRANSFER', NULL, NULL, NULL, 20000, '', '88087707307541', NULL, 'Belum Bayar', '', NULL, NULL, NULL),
(135, 35, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-08 10:35:26', 3712000.00, 'diproses/packing', 'jalan barereng 88', 'COD', NULL, NULL, NULL, 13000, 'Jalan Gunung Tinggimae, Sawerigading, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', NULL, NULL, 'Belum Bayar', '', NULL, NULL, NULL),
(136, 35, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-09 11:55:27', 1312000.00, '', 'jalan barereng 88', 'TRANSFER', NULL, NULL, NULL, 13000, 'Jalan Sungai Calendu, Pisang Utara, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90145, Indonesia', '88084464461518', NULL, 'Menunggu Verifikasi', 'galaxy_a24.jpg', NULL, NULL, NULL),
(137, 38, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-10 02:01:34', 2312000.00, '', 'Kampung Barereng', 'COD', NULL, NULL, NULL, 13000, 'Jalan Jenderal Sudirman, Pisang Utara, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', NULL, NULL, 'Belum Bayar', '', NULL, NULL, NULL),
(138, 39, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-11 04:06:17', 8210000.00, 'selesai', 'kampung barereng', 'COD', NULL, NULL, NULL, 13000, 'Jalan Kartini, Baru, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', NULL, NULL, 'Belum Bayar', '', NULL, NULL, NULL),
(139, 40, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-11 04:08:12', 9810000.00, 'selesai', 'bar', 'COD', NULL, NULL, NULL, 13000, 'Jalan Kartini, Baru, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', NULL, NULL, 'Belum Bayar', '', NULL, NULL, NULL),
(140, 41, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-11 04:10:02', 7210000.00, 'selesai', 'barereng', 'COD', NULL, NULL, NULL, 13000, 'Jalan Jenderal Sudirman, Pisang Utara, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', NULL, NULL, 'Belum Bayar', '', NULL, NULL, NULL),
(141, 42, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-11 04:12:00', 7910000.00, 'selesai', 'barereng', 'COD', NULL, NULL, NULL, 13000, 'Jalan Jenderal Ahmad Yani, Pattunuang, Wajo, Makassar, Sulawesi Selatan, Sulawesi, 90171, Indonesia', NULL, NULL, 'Belum Bayar', '', NULL, NULL, NULL),
(142, 43, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-11 04:13:52', 6810000.00, 'selesai', 'bareeeng', 'COD', NULL, NULL, NULL, 13000, 'Bank Indonesia Cabang Sulawesi Selatan, Jalan Jenderal Sudirman, Pisang Utara, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', NULL, NULL, 'Belum Bayar', '', NULL, NULL, NULL),
(143, 44, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-11 04:15:59', 7010000.00, 'selesai', 'kampung barereng', 'COD', NULL, NULL, NULL, 13000, 'Indo Sport, Jalan Gunung Bawakaraeng, Pisang Utara, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90145, Indonesia', NULL, NULL, 'Belum Bayar', '', NULL, NULL, NULL),
(144, 45, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-11 04:17:54', 8010000.00, 'selesai', 'baruppu', 'COD', NULL, NULL, NULL, 13000, 'Jalan Kartini, Baru, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', NULL, NULL, 'Belum Bayar', '', NULL, NULL, NULL),
(145, 46, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-11 04:20:01', 9410000.00, 'selesai', 'barereng', 'COD', NULL, NULL, NULL, 13000, 'Jalan Gunung Bawakaraeng, Pisang Utara, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90145, Indonesia', NULL, NULL, 'Belum Bayar', '', NULL, NULL, NULL),
(146, 47, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-11 04:22:32', 12310000.00, 'selesai', 'bareng', 'COD', NULL, NULL, NULL, 13000, 'Jalan Kartini, Baru, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', NULL, NULL, 'Belum Bayar', '', NULL, NULL, NULL),
(147, 48, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-11 04:24:20', 8835000.00, 'selesai', 'bareng', 'COD', NULL, NULL, NULL, 13000, 'Jalan Jenderal Sudirman, Pisang Utara, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', NULL, NULL, 'Belum Bayar', '', NULL, NULL, NULL),
(148, 49, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-11 04:26:15', 13310000.00, 'selesai', 'barereng', 'COD', NULL, NULL, NULL, 13000, 'Bank Indonesia Cabang Sulawesi Selatan, Jalan Jenderal Sudirman, Pisang Utara, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', NULL, NULL, 'Belum Bayar', '', NULL, NULL, NULL),
(149, 50, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-11 04:28:25', 6110000.00, 'selesai', 'barereng', 'COD', NULL, NULL, NULL, 13000, 'Karebosi Link, Jalan Jenderal Sudirman, Pisang Utara, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', NULL, NULL, 'Belum Bayar', '', NULL, NULL, NULL),
(150, 51, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-11 04:42:25', 5959000.00, 'selesai', 'bareren', 'COD', NULL, NULL, NULL, 13000, 'Jalan Balai Kota, Baru, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90171, Indonesia', NULL, NULL, 'Belum Bayar', '', NULL, NULL, NULL),
(151, 52, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-11 04:44:10', 13310000.00, 'selesai', 'barereng', 'COD', NULL, NULL, NULL, 13000, 'Jalan Jenderal Ahmad Yani, Pattunuang, Wajo, Makassar, Sulawesi Selatan, Sulawesi, 90171, Indonesia', NULL, NULL, 'Belum Bayar', '', NULL, NULL, NULL),
(152, 53, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-11 04:45:57', 6810000.00, 'selesai', ' barereng', 'COD', NULL, NULL, NULL, 13000, 'BTN, Jalan Kajoalalido, Baru, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90171, Indonesia', NULL, NULL, 'Belum Bayar', '', NULL, NULL, NULL),
(153, 54, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-11 04:54:05', 9510000.00, 'selesai', 'barereng', 'COD', NULL, NULL, NULL, 13000, 'Toko Mercusuar, 49, Jalan Gunung Merapi, Lajangiru, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90114, Indonesia', NULL, NULL, 'Belum Bayar', '', NULL, NULL, NULL),
(154, 56, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-11 04:56:10', 8085000.00, 'selesai', 'barereng', 'COD', NULL, NULL, NULL, 13000, 'Jalan Sungai Tallo, Pisang Utara, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90115, Indonesia', NULL, NULL, 'Belum Bayar', '', NULL, NULL, NULL),
(155, 57, NULL, 'Sulawesi Selatan', 'Toraja Utara', '2026-03-11 04:58:24', 11260000.00, 'selesai', 'barereng', 'COD', NULL, NULL, NULL, 13000, 'Jalan Gunung Bawakaraeng, Pisang Utara, Ujung Pandang, Makassar, Sulawesi Selatan, Sulawesi, 90145, Indonesia', NULL, NULL, 'Belum Bayar', '', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `order_detail`
--

CREATE TABLE `order_detail` (
  `id_detail` int(11) NOT NULL,
  `id_order` int(11) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `harga` int(11) NOT NULL,
  `subtotal` int(11) GENERATED ALWAYS AS (`jumlah` * `harga`) STORED,
  `id_varian` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `order_detail`
--

INSERT INTO `order_detail` (`id_detail`, `id_order`, `id_produk`, `jumlah`, `harga`, `id_varian`) VALUES
(70, 94, 1, 1, 2200000, NULL),
(71, 94, 2, 1, 2800000, NULL),
(72, 94, 3, 1, 3400000, NULL),
(73, 94, 10, 1, 2300000, NULL),
(74, 94, 11, 1, 1800000, NULL),
(75, 95, 2, 2, 2800000, NULL),
(76, 95, 1, 1, 2200000, 15),
(77, 95, 4, 1, 4600000, 24),
(78, 95, 11, 2, 1800000, 45),
(79, 95, 10, 1, 2300000, NULL),
(80, 96, 2, 1, 2800000, NULL),
(81, 96, 3, 1, 3400000, 21),
(82, 96, 5, 1, 1900000, 28),
(83, 96, 11, 1, 1800000, 46),
(84, 96, 13, 1, 2600000, 51),
(85, 97, 3, 1, 3400000, NULL),
(86, 97, 4, 1, 4600000, 24),
(87, 97, 6, 1, 2400000, 30),
(88, 97, 12, 1, 3500000, 48),
(89, 97, 14, 1, 2000000, 54),
(90, 98, 4, 1, 4600000, NULL),
(91, 98, 5, 1, 1900000, 28),
(92, 98, 7, 1, 1500000, 33),
(93, 98, 13, 1, 2600000, 51),
(94, 98, 15, 1, 1900000, 58),
(95, 99, 5, 1, 1900000, NULL),
(96, 99, 6, 1, 2400000, 30),
(97, 99, 8, 1, 1800000, 36),
(98, 99, 14, 1, 2000000, 55),
(99, 99, 16, 1, 2300000, 62),
(100, 100, 6, 1, 2400000, NULL),
(101, 100, 7, 1, 1500000, 33),
(102, 100, 9, 1, 3200000, 39),
(103, 100, 15, 1, 1900000, 57),
(104, 100, 17, 1, 2900000, 64),
(105, 101, 7, 1, 1500000, NULL),
(106, 101, 8, 1, 1800000, 37),
(107, 101, 10, 1, 2300000, 42),
(108, 101, 16, 1, 2300000, 60),
(109, 101, 18, 1, 2100000, 66),
(110, 102, 9, 1, 3200000, NULL),
(111, 102, 1, 1, 2200000, 15),
(112, 102, 18, 1, 2100000, 66),
(113, 102, 10, 1, 2300000, 42),
(114, 102, 48, 1, 3999000, 90),
(115, 103, 10, 1, 2300000, NULL),
(116, 103, 11, 1, 1800000, 46),
(117, 103, 19, 1, 2400000, 70),
(118, 103, 20, 1, 3500000, 72),
(119, 103, 32, 1, 1000000, 77),
(120, 104, 12, 1, 3500000, NULL),
(121, 104, 13, 1, 2600000, 51),
(122, 104, 33, 1, 1300000, 78),
(123, 104, 34, 1, 2000000, 81),
(124, 104, 47, 1, 2999000, 88),
(125, 105, 47, 1, 2999000, 0),
(126, 105, 15, 1, 1900000, 58),
(127, 105, 46, 1, 4399000, 84),
(128, 105, 47, 1, 2999000, 87),
(129, 106, 16, 1, 2300000, NULL),
(130, 106, 17, 1, 2900000, 64),
(131, 106, 48, 1, 3999000, 90),
(132, 107, 18, 1, 2100000, NULL),
(133, 107, 19, 1, 2400000, 69),
(134, 107, 20, 1, 3500000, 72),
(135, 108, 32, 1, 1000000, NULL),
(136, 108, 33, 1, 1300000, 78),
(137, 108, 34, 1, 2000000, 80),
(138, 109, 32, 1, 1000000, NULL),
(139, 110, 45, 1, 5699000, 82),
(140, 111, 45, 1, 5699000, 83),
(146, 117, 48, 1, 3999000, 97),
(147, 118, 1, 1, 2200000, 16),
(148, 119, 4, 1, 4600000, 25),
(149, 120, 47, 1, 2999000, 54),
(151, 122, 1, 1, 1899000, 1),
(155, 126, 61, 1, 1249000, 65),
(156, 126, 51, 1, 1998000, 8),
(157, 127, 51, 1, 1574000, 7),
(158, 128, 61, 1, 1449000, 66),
(159, 129, 51, 1, 1574000, 7),
(160, 130, 16, 1, 2499000, 34),
(161, 131, 61, 1, 1249000, 65),
(162, 132, 51, 1, 1574000, 7),
(163, 133, 46, 1, 3799000, 53),
(164, 134, 34, 1, 3199000, 49),
(165, 135, 13, 1, 3699000, 29),
(166, 136, 32, 1, 1299000, 44),
(167, 137, 10, 1, 2299000, 5),
(168, 138, 1, 1, 1899000, 1),
(169, 138, 2, 1, 2499000, 9),
(170, 138, 3, 1, 3799000, 11),
(171, 139, 4, 1, 5499000, 14),
(172, 139, 6, 1, 2499000, 16),
(173, 139, 5, 1, 1799000, 3),
(174, 140, 7, 1, 1799000, 18),
(175, 140, 8, 1, 2099000, 20),
(176, 140, 9, 1, 3299000, 22),
(177, 141, 10, 1, 2299000, 5),
(178, 141, 11, 1, 1999000, 24),
(179, 141, 12, 1, 3599000, 26),
(180, 142, 13, 1, 3199000, 28),
(181, 142, 14, 1, 1899000, 30),
(182, 142, 15, 1, 1699000, 32),
(183, 143, 16, 1, 2499000, 34),
(184, 143, 17, 1, 3199000, 36),
(185, 143, 32, 1, 1299000, 44),
(186, 144, 19, 1, 2299000, 40),
(187, 144, 18, 1, 2199000, 38),
(188, 144, 20, 1, 3499000, 42),
(189, 145, 33, 1, 1399000, 46),
(190, 145, 34, 1, 2699000, 48),
(191, 145, 45, 1, 5299000, 50),
(192, 146, 46, 1, 3299000, 52),
(193, 146, 47, 1, 2999000, 54),
(194, 146, 48, 1, 5999000, 56),
(195, 147, 61, 1, 1249000, 65),
(196, 147, 51, 1, 1574000, 7),
(197, 147, 48, 1, 5999000, 56),
(198, 148, 47, 1, 3499000, 55),
(199, 148, 45, 1, 5999000, 51),
(200, 148, 46, 1, 3799000, 53),
(201, 149, 34, 1, 3199000, 49),
(202, 149, 33, 1, 1399000, 46),
(203, 149, 32, 1, 1499000, 45),
(204, 150, 61, 1, 1449000, 66),
(205, 150, 51, 1, 1998000, 8),
(206, 150, 18, 1, 2499000, 39),
(207, 151, 20, 1, 3999000, 43),
(208, 151, 48, 1, 5999000, 56),
(209, 151, 9, 1, 3299000, 22),
(210, 152, 9, 1, 3299000, 22),
(211, 152, 7, 1, 1799000, 18),
(212, 152, 15, 1, 1699000, 32),
(213, 153, 14, 1, 2199000, 31),
(214, 153, 12, 1, 3599000, 26),
(215, 153, 13, 1, 3699000, 29),
(216, 154, 17, 1, 3499000, 37),
(217, 154, 47, 1, 2999000, 54),
(218, 154, 51, 1, 1574000, 7),
(219, 155, 61, 1, 1449000, 66),
(220, 155, 46, 1, 3799000, 53),
(221, 155, 45, 1, 5999000, 51);

-- --------------------------------------------------------

--
-- Struktur dari tabel `order_log`
--

CREATE TABLE `order_log` (
  `id_log` int(11) NOT NULL,
  `id_order` int(11) NOT NULL,
  `action` varchar(100) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `order_status_history`
--

CREATE TABLE `order_status_history` (
  `id` int(11) NOT NULL,
  `id_order` int(11) NOT NULL,
  `status_lama` varchar(50) DEFAULT NULL,
  `status_baru` varchar(50) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `order_status_history`
--

INSERT INTO `order_status_history` (`id`, `id_order`, `status_lama`, `status_baru`, `note`, `created_at`) VALUES
(63, 94, 'Menunggu Verifikasi', 'Terverifikasi', 'Pembayaran diverifikasi oleh admin', '2026-01-21 16:08:18'),
(64, 94, 'diproses/packing', 'selesai', 'Status diperbarui oleh admin', '2026-01-21 16:08:26'),
(65, 95, '', 'selesai', 'Status diperbarui oleh admin', '2026-01-21 16:16:54'),
(66, 96, '', 'selesai', 'Status diperbarui oleh admin', '2026-01-21 16:22:06'),
(67, 97, '', 'selesai', 'Status diperbarui oleh admin', '2026-01-21 17:20:35'),
(68, 98, '', 'selesai', 'Status diperbarui oleh admin', '2026-01-21 17:23:23'),
(69, 99, '', 'selesai', 'Status diperbarui oleh admin', '2026-01-21 17:25:30'),
(70, 100, '', 'selesai', 'Status diperbarui oleh admin', '2026-01-21 17:28:02'),
(71, 101, '', 'selesai', 'Status diperbarui oleh admin', '2026-01-21 17:30:57'),
(72, 102, '', 'selesai', 'Status diperbarui oleh admin', '2026-01-21 17:33:41'),
(73, 103, '', 'selesai', 'Status diperbarui oleh admin', '2026-01-21 17:37:01'),
(74, 104, '', 'selesai', 'Status diperbarui oleh admin', '2026-01-21 17:39:59'),
(75, 105, '', 'selesai', 'Status diperbarui oleh admin', '2026-01-21 17:43:07'),
(76, 106, '', 'selesai', 'Status diperbarui oleh admin', '2026-01-21 17:45:46'),
(77, 107, '', 'selesai', 'Status diperbarui oleh admin', '2026-01-21 17:47:25'),
(78, 108, '', 'selesai', 'Status diperbarui oleh admin', '2026-01-21 17:49:26'),
(81, 119, '', 'selesai', 'Status diperbarui oleh admin', '2026-02-13 14:38:24'),
(82, 122, '', 'selesai', 'Status diperbarui oleh admin', '2026-02-17 15:49:06'),
(83, 126, '', 'selesai', 'Status diperbarui oleh admin', '2026-02-25 13:22:37'),
(84, 128, '', 'selesai', 'Status diperbarui oleh admin', '2026-02-25 13:26:45'),
(85, 127, '', 'selesai', 'Status diperbarui oleh admin', '2026-02-25 13:26:54'),
(86, 130, 'Menunggu Verifikasi', 'Terverifikasi', 'Pembayaran diverifikasi oleh admin', '2026-03-02 08:56:02'),
(87, 130, 'diproses/packing', 'selesai', 'Status diperbarui oleh admin', '2026-03-02 08:56:11'),
(88, 130, 'selesai', 'dikirim', 'Status diperbarui oleh admin', '2026-03-02 09:42:30'),
(89, 130, 'dikirim', 'selesai', 'Status diperbarui oleh admin', '2026-03-02 09:45:37'),
(90, 135, '', 'diproses/packing', 'Status diperbarui oleh admin', '2026-03-09 11:50:59'),
(91, 138, '', 'selesai', 'Status diperbarui oleh admin', '2026-03-11 04:29:02'),
(92, 139, '', 'selesai', 'Status diperbarui oleh admin', '2026-03-11 04:30:28'),
(93, 140, '', 'selesai', 'Status diperbarui oleh admin', '2026-03-11 04:30:40'),
(94, 141, '', 'selesai', 'Status diperbarui oleh admin', '2026-03-11 04:30:53'),
(95, 142, '', 'selesai', 'Status diperbarui oleh admin', '2026-03-11 04:31:01'),
(96, 143, '', 'selesai', 'Status diperbarui oleh admin', '2026-03-11 04:31:16'),
(97, 144, '', 'selesai', 'Status diperbarui oleh admin', '2026-03-11 04:31:27'),
(98, 145, '', 'selesai', 'Status diperbarui oleh admin', '2026-03-11 04:31:35'),
(99, 146, '', 'selesai', 'Status diperbarui oleh admin', '2026-03-11 04:31:42'),
(100, 147, '', 'selesai', 'Status diperbarui oleh admin', '2026-03-11 04:31:48'),
(101, 148, '', 'selesai', 'Status diperbarui oleh admin', '2026-03-11 04:31:56'),
(102, 149, '', 'selesai', 'Status diperbarui oleh admin', '2026-03-11 04:32:03'),
(103, 150, '', 'selesai', 'Status diperbarui oleh admin', '2026-03-11 04:46:53'),
(104, 151, '', 'selesai', 'Status diperbarui oleh admin', '2026-03-11 04:47:00'),
(105, 152, '', 'selesai', 'Status diperbarui oleh admin', '2026-03-11 04:47:08'),
(106, 153, '', 'selesai', 'Status diperbarui oleh admin', '2026-03-11 04:58:41'),
(107, 154, '', 'selesai', 'Status diperbarui oleh admin', '2026-03-11 04:58:49'),
(108, 155, '', 'selesai', 'Status diperbarui oleh admin', '2026-03-11 04:58:55');

-- --------------------------------------------------------

--
-- Struktur dari tabel `produk_gambar`
--

CREATE TABLE `produk_gambar` (
  `id_gambar` int(11) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `gambar` varchar(255) NOT NULL,
  `urutan` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `produk_gambar`
--

INSERT INTO `produk_gambar` (`id_gambar`, `id_produk`, `gambar`, `urutan`) VALUES
(1, 1, 'img/a14 1.jpg', 1),
(2, 1, 'img/a14 2.jpg', 1),
(3, 1, 'img/a14 3.jpg', 1),
(13, 2, 'img/a241.jpg', 1),
(14, 2, 'img/a242.jpg', 1),
(15, 2, 'img/a243.jpg', 1),
(16, 3, 'img/a341.jpg', 1),
(17, 3, 'img/a342.jpg', 1),
(18, 3, 'img/a343.jpg', 1),
(19, 4, 'img/a541.jpg', 1),
(20, 4, 'img/a542.jpg', 1),
(21, 4, 'img/a543.jpg', 1),
(22, 5, 'img/red121.jpg', 1),
(23, 5, 'img/red122.jpg', 1),
(24, 5, 'img/red123.jpg', 1),
(25, 6, 'img/rednote1.jpg', 1),
(26, 6, 'img/rednote2.jpg', 1),
(27, 6, 'img/rednote3.jpg', 1),
(28, 7, 'img/redmi1.jpg', 1),
(29, 7, 'img/redmi2.jpg', 1),
(30, 7, 'img/redmi3.jpg', 1),
(31, 8, 'img/pocom1.jpg', 1),
(32, 8, 'img/pocom2.jpg', 1),
(33, 8, 'img/pocom3.jpg', 1),
(34, 9, 'img/x51.jpg', 1),
(35, 9, 'img/x52.jpg', 1),
(36, 9, 'img/x53.jpg', 1),
(37, 10, 'img/c551.jpg', 1),
(38, 10, 'img/c552.jpg', 1),
(39, 10, 'img/c553.jpg', 1),
(40, 11, 'img/c531.jpg', 1),
(41, 11, 'img/c532.jpg', 1),
(42, 11, 'img/c533.jpg', 1),
(43, 12, 'img/realme10pro1.jpg', 1),
(44, 12, 'img/realme10pro2.jpg', 1),
(45, 12, 'img/realme10pro3.jpg', 1),
(46, 13, 'img/real111.jpg', 1),
(47, 13, 'img/real112.jpg', 1),
(48, 13, 'img/real113.jpg', 1),
(49, 14, 'img/y17s1.jpg', 1),
(50, 14, 'img/y17s2.jpg', 1),
(51, 14, 'img/y17s3.jpg', 1),
(52, 15, 'img/y211.jpg', 1),
(53, 15, 'img/y212.jpg', 1),
(54, 15, 'img/y213.jpg', 1),
(55, 16, 'img/y271.jpg', 1),
(56, 16, 'img/y272.jpg', 1),
(57, 16, 'img/y273.jpg', 1),
(58, 17, ' img/t1pro2.jpg', 1),
(59, 17, ' img/t1pro3.jpg', 1),
(60, 17, ' img/t1pro4.jpg', 1),
(61, 18, ' img/oppoa38_3.jpg', 1),
(62, 33, 'img/a031.jpg', 1),
(63, 33, 'img/a033.jpg', 1),
(64, 33, 'img/a034.jpg', 1),
(65, 32, 'img/y912.jpg', 1),
(66, 32, 'img/y9123.jpg', 1),
(67, 32, 'img/y913.jpg', 1),
(68, 20, 'img/a781.jpg', 1),
(69, 20, 'img/a782.jpg', 1),
(70, 20, 'img/a783.jpg', 1),
(71, 19, 'img/a571.jpg', 1),
(72, 19, 'img/a572.jpg', 1),
(73, 19, 'img/a573.jpg', 1),
(77, 34, 'img/y283.jpeg', 1),
(78, 34, 'img/y281.jpg', 1),
(79, 34, 'img/vivo-Y28new.webp', 1),
(80, 45, 'img/samsunga564.jpg', 1),
(81, 45, 'img/samsunga563.jpg', 1),
(82, 45, 'img/samsunga562.jpg', 1),
(83, 46, 'img/samsunga264.jpg', 1),
(84, 46, 'img/samsunga263.jpg', 1),
(85, 46, 'img/samsunga262.jpg', 1),
(86, 47, 'img/vivoy364.jpg', 1),
(87, 47, 'img/vivoy363.jpg', 1),
(88, 47, 'img/vivoy362.jpg', 1),
(89, 48, 'img/opporeno141_4.jpg', 1),
(90, 48, 'img/opporeno141_3.jpg', 1),
(91, 48, 'img/opporeno141_2.jpg', 1),
(101, 51, 'img/infinixhot40pro4.jpg', 1),
(102, 51, 'img/infinixhot40pro3.jpg', 1),
(103, 51, 'img/infinixhot40pro2.jpg', 1),
(122, 61, 'img/smart104.jpg', 1),
(123, 61, 'img/smart103.jpg', 1),
(124, 61, 'img/smart102.jpg', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `produk_variant`
--

CREATE TABLE `produk_variant` (
  `id_variant` int(11) NOT NULL,
  `id_produk` int(11) DEFAULT NULL,
  `ram` int(11) DEFAULT NULL,
  `storage` int(11) DEFAULT NULL,
  `warna` varchar(50) DEFAULT NULL,
  `harga` int(11) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `produk_variant`
--

INSERT INTO `produk_variant` (`id_variant`, `id_produk`, `ram`, `storage`, `warna`, `harga`, `stok`, `created_at`) VALUES
(9, 1, 4, 128, 'Hitam', 2800000, 15, '2026-02-16 14:25:44'),
(10, 2, 4, 128, 'Hitam', 2800000, 15, '2026-02-16 14:25:44'),
(11, 3, 4, 128, 'Hitam', 2800000, 15, '2026-02-16 14:25:44'),
(12, 4, 4, 128, 'Hitam', 2800000, 15, '2026-02-16 14:25:44'),
(13, 5, 4, 128, 'Hitam', 2400000, 15, '2026-02-16 14:25:44'),
(14, 6, 4, 128, 'Hitam', 2400000, 15, '2026-02-16 14:25:44'),
(15, 7, 4, 128, 'Hitam', 2400000, 15, '2026-02-16 14:25:44'),
(16, 8, 4, 128, 'Hitam', 2400000, 15, '2026-02-16 14:25:44'),
(17, 9, 4, 128, 'Hitam', 2400000, 15, '2026-02-16 14:25:44'),
(18, 10, 4, 128, 'Hitam', 2300000, 15, '2026-02-16 14:25:44'),
(19, 11, 4, 128, 'Hitam', 2300000, 15, '2026-02-16 14:25:44'),
(20, 12, 4, 128, 'Hitam', 2300000, 15, '2026-02-16 14:25:44'),
(21, 13, 4, 128, 'Hitam', 2300000, 15, '2026-02-16 14:25:44'),
(22, 14, 4, 128, 'Hitam', 2500000, 15, '2026-02-16 14:25:44'),
(23, 15, 4, 128, 'Hitam', 2500000, 15, '2026-02-16 14:25:44'),
(24, 16, 4, 128, 'Hitam', 2500000, 15, '2026-02-16 14:25:44'),
(25, 17, 4, 128, 'Hitam', 2500000, 15, '2026-02-16 14:25:44'),
(26, 18, 4, 128, 'Hitam', 2600000, 15, '2026-02-16 14:25:44'),
(27, 19, 4, 128, 'Hitam', 2600000, 15, '2026-02-16 14:25:44'),
(28, 20, 4, 128, 'Hitam', 2600000, 15, '2026-02-16 14:25:44'),
(29, 32, 4, 128, 'Hitam', NULL, 15, '2026-02-16 14:25:44'),
(30, 33, 4, 128, 'Hitam', 2800000, 15, '2026-02-16 14:25:44'),
(31, 34, 4, 128, 'Hitam', 2500000, 15, '2026-02-16 14:25:44'),
(32, 45, 4, 128, 'Hitam', 2800000, 15, '2026-02-16 14:25:44'),
(33, 46, 4, 128, 'Hitam', 2800000, 15, '2026-02-16 14:25:44'),
(34, 47, 4, 128, 'Hitam', 2500000, 15, '2026-02-16 14:25:44'),
(35, 48, 4, 128, 'Hitam', 2600000, 15, '2026-02-16 14:25:44'),
(36, 51, 4, 128, 'Hitam', NULL, 15, '2026-02-16 14:25:44'),
(37, 55, 4, 128, 'Hitam', 2800000, 15, '2026-02-16 14:25:44'),
(40, 1, 4, 128, 'Biru', 2800000, 10, '2026-02-16 14:25:44'),
(41, 2, 4, 128, 'Biru', 2800000, 10, '2026-02-16 14:25:44'),
(42, 3, 4, 128, 'Biru', 2800000, 10, '2026-02-16 14:25:44'),
(43, 4, 4, 128, 'Biru', 2800000, 10, '2026-02-16 14:25:44'),
(44, 5, 4, 128, 'Biru', 2400000, 10, '2026-02-16 14:25:44'),
(45, 6, 4, 128, 'Biru', 2400000, 10, '2026-02-16 14:25:44'),
(46, 7, 4, 128, 'Biru', 2400000, 10, '2026-02-16 14:25:44'),
(47, 8, 4, 128, 'Biru', 2400000, 10, '2026-02-16 14:25:44'),
(48, 9, 4, 128, 'Biru', 2400000, 10, '2026-02-16 14:25:44'),
(49, 10, 4, 128, 'Biru', 2300000, 10, '2026-02-16 14:25:44'),
(50, 11, 4, 128, 'Biru', 2300000, 10, '2026-02-16 14:25:44'),
(51, 12, 4, 128, 'Biru', 2300000, 10, '2026-02-16 14:25:44'),
(52, 13, 4, 128, 'Biru', 2300000, 10, '2026-02-16 14:25:44'),
(53, 14, 4, 128, 'Biru', 2500000, 10, '2026-02-16 14:25:44'),
(54, 15, 4, 128, 'Biru', 2500000, 10, '2026-02-16 14:25:44'),
(55, 16, 4, 128, 'Biru', 2500000, 10, '2026-02-16 14:25:44'),
(56, 17, 4, 128, 'Biru', 2500000, 10, '2026-02-16 14:25:44'),
(57, 18, 4, 128, 'Biru', 2600000, 10, '2026-02-16 14:25:44'),
(58, 19, 4, 128, 'Biru', 2600000, 10, '2026-02-16 14:25:44'),
(59, 20, 4, 128, 'Biru', 2600000, 10, '2026-02-16 14:25:44'),
(60, 32, 4, 128, 'Biru', NULL, 10, '2026-02-16 14:25:44'),
(61, 33, 4, 128, 'Biru', 2800000, 10, '2026-02-16 14:25:44'),
(62, 34, 4, 128, 'Biru', 2500000, 10, '2026-02-16 14:25:44'),
(63, 45, 4, 128, 'Biru', 2800000, 10, '2026-02-16 14:25:44'),
(64, 46, 4, 128, 'Biru', 2800000, 10, '2026-02-16 14:25:44'),
(65, 47, 4, 128, 'Biru', 2500000, 10, '2026-02-16 14:25:44'),
(66, 48, 4, 128, 'Biru', 2600000, 10, '2026-02-16 14:25:44'),
(67, 51, 4, 128, 'Biru', NULL, 10, '2026-02-16 14:25:44'),
(68, 55, 4, 128, 'Biru', 2800000, 10, '2026-02-16 14:25:44'),
(71, 1, 4, 128, 'Silver', 2800000, 8, '2026-02-16 14:25:44'),
(72, 2, 4, 128, 'Silver', 2800000, 8, '2026-02-16 14:25:44'),
(73, 3, 4, 128, 'Silver', 2800000, 8, '2026-02-16 14:25:44'),
(74, 4, 4, 128, 'Silver', 2800000, 8, '2026-02-16 14:25:44'),
(75, 5, 4, 128, 'Silver', 2400000, 8, '2026-02-16 14:25:44'),
(76, 6, 4, 128, 'Silver', 2400000, 8, '2026-02-16 14:25:44'),
(77, 7, 4, 128, 'Silver', 2400000, 8, '2026-02-16 14:25:44'),
(78, 8, 4, 128, 'Silver', 2400000, 8, '2026-02-16 14:25:44'),
(79, 9, 4, 128, 'Silver', 2400000, 8, '2026-02-16 14:25:44'),
(80, 10, 4, 128, 'Silver', 2300000, 8, '2026-02-16 14:25:44'),
(81, 11, 4, 128, 'Silver', 2300000, 8, '2026-02-16 14:25:44'),
(82, 12, 4, 128, 'Silver', 2300000, 8, '2026-02-16 14:25:44'),
(83, 13, 4, 128, 'Silver', 2300000, 8, '2026-02-16 14:25:44'),
(84, 14, 4, 128, 'Silver', 2500000, 8, '2026-02-16 14:25:44'),
(85, 15, 4, 128, 'Silver', 2500000, 8, '2026-02-16 14:25:44'),
(86, 16, 4, 128, 'Silver', 2500000, 8, '2026-02-16 14:25:44'),
(87, 17, 4, 128, 'Silver', 2500000, 8, '2026-02-16 14:25:44'),
(88, 18, 4, 128, 'Silver', 2600000, 8, '2026-02-16 14:25:44'),
(89, 19, 4, 128, 'Silver', 2600000, 8, '2026-02-16 14:25:44'),
(90, 20, 4, 128, 'Silver', 2600000, 8, '2026-02-16 14:25:44'),
(91, 32, 4, 128, 'Silver', NULL, 8, '2026-02-16 14:25:44'),
(92, 33, 4, 128, 'Silver', 2800000, 8, '2026-02-16 14:25:44'),
(93, 34, 4, 128, 'Silver', 2500000, 8, '2026-02-16 14:25:44'),
(94, 45, 4, 128, 'Silver', 2800000, 8, '2026-02-16 14:25:44'),
(95, 46, 4, 128, 'Silver', 2800000, 8, '2026-02-16 14:25:44'),
(96, 47, 4, 128, 'Silver', 2500000, 8, '2026-02-16 14:25:44'),
(97, 48, 4, 128, 'Silver', 2600000, 8, '2026-02-16 14:25:44'),
(98, 51, 4, 128, 'Silver', NULL, 8, '2026-02-16 14:25:44'),
(99, 55, 4, 128, 'Silver', 2800000, 8, '2026-02-16 14:25:44'),
(102, 1, 8, 256, 'Hitam', 3400000, 8, '2026-02-16 14:27:25'),
(103, 2, 8, 256, 'Hitam', 3400000, 8, '2026-02-16 14:27:25'),
(104, 3, 8, 256, 'Hitam', 3400000, 8, '2026-02-16 14:27:25'),
(105, 4, 8, 256, 'Hitam', 3400000, 8, '2026-02-16 14:27:25'),
(106, 5, 8, 256, 'Hitam', 3000000, 8, '2026-02-16 14:27:25'),
(107, 6, 8, 256, 'Hitam', 3000000, 8, '2026-02-16 14:27:25'),
(108, 7, 8, 256, 'Hitam', 3000000, 8, '2026-02-16 14:27:25'),
(109, 8, 8, 256, 'Hitam', 3000000, 8, '2026-02-16 14:27:25'),
(110, 9, 8, 256, 'Hitam', 3000000, 8, '2026-02-16 14:27:25'),
(111, 10, 8, 256, 'Hitam', 2900000, 8, '2026-02-16 14:27:25'),
(112, 11, 8, 256, 'Hitam', 2900000, 8, '2026-02-16 14:27:25'),
(113, 12, 8, 256, 'Hitam', 2900000, 8, '2026-02-16 14:27:25'),
(114, 13, 8, 256, 'Hitam', 2900000, 8, '2026-02-16 14:27:25'),
(115, 14, 8, 256, 'Hitam', 3100000, 8, '2026-02-16 14:27:25'),
(116, 15, 8, 256, 'Hitam', 3100000, 8, '2026-02-16 14:27:25'),
(117, 16, 8, 256, 'Hitam', 3100000, 8, '2026-02-16 14:27:25'),
(118, 17, 8, 256, 'Hitam', 3100000, 8, '2026-02-16 14:27:25'),
(119, 18, 8, 256, 'Hitam', 3200000, 8, '2026-02-16 14:27:25'),
(120, 19, 8, 256, 'Hitam', 3200000, 8, '2026-02-16 14:27:25'),
(121, 20, 8, 256, 'Hitam', 3200000, 8, '2026-02-16 14:27:25'),
(122, 32, 8, 256, 'Hitam', NULL, 8, '2026-02-16 14:27:25'),
(123, 33, 8, 256, 'Hitam', 3400000, 8, '2026-02-16 14:27:25'),
(124, 34, 8, 256, 'Hitam', 3100000, 8, '2026-02-16 14:27:25'),
(125, 45, 8, 256, 'Hitam', 3400000, 8, '2026-02-16 14:27:25'),
(126, 46, 8, 256, 'Hitam', 3400000, 8, '2026-02-16 14:27:25'),
(127, 47, 8, 256, 'Hitam', 3100000, 8, '2026-02-16 14:27:25'),
(128, 48, 8, 256, 'Hitam', 3200000, 8, '2026-02-16 14:27:25'),
(129, 51, 8, 256, 'Hitam', NULL, 8, '2026-02-16 14:27:25'),
(130, 55, 8, 256, 'Hitam', 3400000, 8, '2026-02-16 14:27:25'),
(133, 1, 8, 256, 'Biru', 3400000, 6, '2026-02-16 14:27:25'),
(134, 2, 8, 256, 'Biru', 3400000, 6, '2026-02-16 14:27:25'),
(135, 3, 8, 256, 'Biru', 3400000, 6, '2026-02-16 14:27:25'),
(136, 4, 8, 256, 'Biru', 3400000, 6, '2026-02-16 14:27:25'),
(137, 5, 8, 256, 'Biru', 3000000, 6, '2026-02-16 14:27:25'),
(138, 6, 8, 256, 'Biru', 3000000, 6, '2026-02-16 14:27:25'),
(139, 7, 8, 256, 'Biru', 3000000, 6, '2026-02-16 14:27:25'),
(140, 8, 8, 256, 'Biru', 3000000, 6, '2026-02-16 14:27:25'),
(141, 9, 8, 256, 'Biru', 3000000, 6, '2026-02-16 14:27:25'),
(142, 10, 8, 256, 'Biru', 2900000, 6, '2026-02-16 14:27:25'),
(143, 11, 8, 256, 'Biru', 2900000, 6, '2026-02-16 14:27:25'),
(144, 12, 8, 256, 'Biru', 2900000, 6, '2026-02-16 14:27:25'),
(145, 13, 8, 256, 'Biru', 2900000, 6, '2026-02-16 14:27:25'),
(146, 14, 8, 256, 'Biru', 3100000, 6, '2026-02-16 14:27:25'),
(147, 15, 8, 256, 'Biru', 3100000, 6, '2026-02-16 14:27:25'),
(148, 16, 8, 256, 'Biru', 3100000, 6, '2026-02-16 14:27:25'),
(149, 17, 8, 256, 'Biru', 3100000, 6, '2026-02-16 14:27:25'),
(150, 18, 8, 256, 'Biru', 3200000, 6, '2026-02-16 14:27:25'),
(151, 19, 8, 256, 'Biru', 3200000, 6, '2026-02-16 14:27:25'),
(152, 20, 8, 256, 'Biru', 3200000, 6, '2026-02-16 14:27:25'),
(153, 32, 8, 256, 'Biru', NULL, 6, '2026-02-16 14:27:25'),
(154, 33, 8, 256, 'Biru', 3400000, 6, '2026-02-16 14:27:25'),
(155, 34, 8, 256, 'Biru', 3100000, 6, '2026-02-16 14:27:25'),
(156, 45, 8, 256, 'Biru', 3400000, 6, '2026-02-16 14:27:25'),
(157, 46, 8, 256, 'Biru', 3400000, 6, '2026-02-16 14:27:25'),
(158, 47, 8, 256, 'Biru', 3100000, 6, '2026-02-16 14:27:25'),
(159, 48, 8, 256, 'Biru', 3200000, 6, '2026-02-16 14:27:25'),
(160, 51, 8, 256, 'Biru', NULL, 6, '2026-02-16 14:27:25'),
(161, 55, 8, 256, 'Biru', 3400000, 6, '2026-02-16 14:27:25'),
(164, 1, 8, 256, 'Silver', 3400000, 5, '2026-02-16 14:27:25'),
(165, 2, 8, 256, 'Silver', 3400000, 5, '2026-02-16 14:27:25'),
(166, 3, 8, 256, 'Silver', 3400000, 5, '2026-02-16 14:27:25'),
(167, 4, 8, 256, 'Silver', 3400000, 5, '2026-02-16 14:27:25'),
(168, 5, 8, 256, 'Silver', 3000000, 5, '2026-02-16 14:27:25'),
(169, 6, 8, 256, 'Silver', 3000000, 5, '2026-02-16 14:27:25'),
(170, 7, 8, 256, 'Silver', 3000000, 5, '2026-02-16 14:27:25'),
(171, 8, 8, 256, 'Silver', 3000000, 5, '2026-02-16 14:27:25'),
(172, 9, 8, 256, 'Silver', 3000000, 5, '2026-02-16 14:27:25'),
(173, 10, 8, 256, 'Silver', 2900000, 5, '2026-02-16 14:27:25'),
(174, 11, 8, 256, 'Silver', 2900000, 5, '2026-02-16 14:27:25'),
(175, 12, 8, 256, 'Silver', 2900000, 5, '2026-02-16 14:27:25'),
(176, 13, 8, 256, 'Silver', 2900000, 5, '2026-02-16 14:27:25'),
(177, 14, 8, 256, 'Silver', 3100000, 5, '2026-02-16 14:27:25'),
(178, 15, 8, 256, 'Silver', 3100000, 5, '2026-02-16 14:27:25'),
(179, 16, 8, 256, 'Silver', 3100000, 5, '2026-02-16 14:27:25'),
(180, 17, 8, 256, 'Silver', 3100000, 5, '2026-02-16 14:27:25'),
(181, 18, 8, 256, 'Silver', 3200000, 5, '2026-02-16 14:27:25'),
(182, 19, 8, 256, 'Silver', 3200000, 5, '2026-02-16 14:27:25'),
(183, 20, 8, 256, 'Silver', 3200000, 5, '2026-02-16 14:27:25'),
(184, 32, 8, 256, 'Silver', NULL, 5, '2026-02-16 14:27:25'),
(185, 33, 8, 256, 'Silver', 3400000, 5, '2026-02-16 14:27:25'),
(186, 34, 8, 256, 'Silver', 3100000, 5, '2026-02-16 14:27:25'),
(187, 45, 8, 256, 'Silver', 3400000, 5, '2026-02-16 14:27:25'),
(188, 46, 8, 256, 'Silver', 3400000, 5, '2026-02-16 14:27:25'),
(189, 47, 8, 256, 'Silver', 3100000, 5, '2026-02-16 14:27:25'),
(190, 48, 8, 256, 'Silver', 3200000, 5, '2026-02-16 14:27:25'),
(191, 51, 8, 256, 'Silver', NULL, 5, '2026-02-16 14:27:25'),
(192, 55, 8, 256, 'Silver', 3400000, 5, '2026-02-16 14:27:25');

-- --------------------------------------------------------

--
-- Struktur dari tabel `rating`
--

CREATE TABLE `rating` (
  `id` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `id_produk` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `ulasan` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `rating`
--

INSERT INTO `rating` (`id`, `id_user`, `id_produk`, `rating`, `ulasan`, `created_at`) VALUES
(12, 14, 1, 5, '', '2026-01-21 16:10:18'),
(13, 14, 2, 5, '', '2026-01-21 16:10:27'),
(14, 14, 3, 5, '', '2026-01-21 16:10:35'),
(15, 14, 10, 4, '', '2026-01-21 16:11:02'),
(16, 14, 11, 4, '', '2026-01-21 16:11:11'),
(17, 15, 10, 5, '', '2026-01-21 16:17:21'),
(18, 15, 4, 4, '', '2026-01-21 16:17:31'),
(19, 15, 2, 4, '', '2026-01-21 16:17:40'),
(20, 15, 1, 4, '', '2026-01-21 16:18:04'),
(21, 15, 11, 5, '', '2026-01-21 16:18:51'),
(22, 16, 13, 5, '', '2026-01-21 16:22:36'),
(23, 16, 11, 4, '', '2026-01-21 16:22:46'),
(24, 16, 5, 4, '', '2026-01-21 16:22:54'),
(25, 16, 3, 5, '', '2026-01-21 16:23:08'),
(26, 16, 2, 3, '', '2026-01-21 16:23:16'),
(27, 17, 3, 4, '', '2026-01-21 17:21:02'),
(28, 17, 4, 4, '', '2026-01-21 17:21:18'),
(29, 17, 14, 5, '', '2026-01-21 17:21:30'),
(30, 17, 6, 4, '', '2026-01-21 17:21:41'),
(31, 17, 12, 5, '', '2026-01-21 17:21:49'),
(32, 18, 4, 4, '', '2026-01-21 17:23:45'),
(33, 18, 5, 5, '', '2026-01-21 17:23:54'),
(34, 18, 7, 4, '', '2026-01-21 17:24:03'),
(35, 18, 13, 4, '', '2026-01-21 17:24:11'),
(36, 18, 15, 4, '', '2026-01-21 17:24:20'),
(37, 19, 6, 4, '', '2026-01-21 17:25:56'),
(38, 19, 5, 5, '', '2026-01-21 17:26:04'),
(39, 19, 8, 4, '', '2026-01-21 17:26:14'),
(40, 19, 16, 3, '', '2026-01-21 17:26:21'),
(41, 19, 14, 3, '', '2026-01-21 17:26:34'),
(42, 20, 6, 3, '', '2026-01-21 17:28:27'),
(43, 20, 7, 5, '', '2026-01-21 17:28:35'),
(44, 20, 9, 4, '', '2026-01-21 17:28:42'),
(45, 20, 17, 4, '', '2026-01-21 17:28:57'),
(46, 20, 15, 5, '', '2026-01-21 17:29:07'),
(47, 21, 7, 4, '', '2026-01-21 17:31:22'),
(48, 21, 8, 4, '', '2026-01-21 17:31:30'),
(49, 21, 10, 3, '', '2026-01-21 17:31:37'),
(50, 21, 16, 4, '', '2026-01-21 17:31:44'),
(51, 21, 18, 5, '', '2026-01-21 17:31:51'),
(52, 22, 9, 4, '', '2026-01-21 17:34:03'),
(53, 22, 1, 5, '', '2026-01-21 17:34:11'),
(54, 22, 18, 4, '', '2026-01-21 17:34:18'),
(55, 22, 10, 4, '', '2026-01-21 17:34:25'),
(56, 22, 48, 4, '', '2026-01-21 17:34:32'),
(57, 23, 10, 5, '', '2026-01-21 17:37:26'),
(58, 23, 11, 3, '', '2026-01-21 17:37:35'),
(59, 23, 19, 5, '', '2026-01-21 17:37:44'),
(60, 23, 20, 4, '', '2026-01-21 17:37:51'),
(61, 23, 32, 4, '', '2026-01-21 17:37:59'),
(62, 24, 47, 4, '', '2026-01-21 17:40:24'),
(63, 24, 34, 5, '', '2026-01-21 17:40:34'),
(64, 24, 33, 5, '', '2026-01-21 17:40:42'),
(65, 24, 12, 4, '', '2026-01-21 17:41:10'),
(66, 24, 13, 5, '', '2026-01-21 17:41:19'),
(67, 25, 46, 4, '', '2026-01-21 17:43:33'),
(68, 25, 47, 4, '', '2026-01-21 17:43:41'),
(69, 25, 15, 4, '', '2026-01-21 17:43:53'),
(70, 26, 16, 5, '', '2026-01-21 17:46:10'),
(71, 26, 17, 4, '', '2026-01-21 17:46:16'),
(72, 26, 48, 4, '', '2026-01-21 17:46:23'),
(73, 27, 18, 5, '', '2026-01-21 17:47:50'),
(74, 27, 19, 3, '', '2026-01-21 17:47:58'),
(75, 27, 20, 4, '', '2026-01-21 17:48:04'),
(76, 28, 32, 4, '', '2026-01-21 17:49:44'),
(77, 28, 33, 5, '', '2026-01-21 17:49:57'),
(78, 28, 34, 5, '', '2026-01-21 17:50:04'),
(82, 30, 4, 4, '', '2026-02-13 15:15:59'),
(83, 32, 1, 4, '', '2026-02-17 15:49:33'),
(84, 28, 61, 4, '', '2026-02-25 13:22:53'),
(85, 28, 51, 4, '', '2026-02-25 13:23:02'),
(86, 26, 51, 3, '', '2026-02-25 13:27:15'),
(87, 27, 61, 4, '', '2026-02-25 13:27:55'),
(88, 14, 16, 1, '', '2026-03-02 09:46:04'),
(89, 39, 1, 4, '', '2026-03-11 04:29:25'),
(90, 39, 2, 3, '', '2026-03-11 04:29:32'),
(91, 39, 3, 4, '', '2026-03-11 04:29:38'),
(92, 41, 7, 3, '', '2026-03-11 04:32:27'),
(93, 41, 8, 4, '', '2026-03-11 04:32:34'),
(94, 41, 9, 5, '', '2026-03-11 04:32:39'),
(95, 40, 4, 4, '', '2026-03-11 04:33:37'),
(96, 40, 5, 4, '', '2026-03-11 04:33:43'),
(97, 40, 6, 5, '', '2026-03-11 04:33:48'),
(98, 42, 10, 4, '', '2026-03-11 04:34:23'),
(99, 42, 11, 3, '', '2026-03-11 04:34:29'),
(100, 42, 12, 4, '', '2026-03-11 04:34:34'),
(101, 43, 13, 3, '', '2026-03-11 04:35:18'),
(102, 43, 14, 4, '', '2026-03-11 04:35:24'),
(103, 43, 15, 5, '', '2026-03-11 04:35:30'),
(104, 44, 16, 5, '', '2026-03-11 04:36:01'),
(105, 44, 17, 4, '', '2026-03-11 04:36:07'),
(106, 44, 32, 3, '', '2026-03-11 04:36:12'),
(107, 45, 18, 4, '', '2026-03-11 04:36:39'),
(108, 45, 19, 3, '', '2026-03-11 04:36:44'),
(109, 45, 20, 4, '', '2026-03-11 04:36:51'),
(110, 46, 33, 5, '', '2026-03-11 04:37:15'),
(111, 46, 34, 4, '', '2026-03-11 04:37:21'),
(112, 46, 45, 4, '', '2026-03-11 04:37:27'),
(113, 47, 46, 4, '', '2026-03-11 04:37:57'),
(114, 47, 47, 4, '', '2026-03-11 04:38:01'),
(115, 47, 48, 4, '', '2026-03-11 04:38:07'),
(116, 48, 48, 4, '', '2026-03-11 04:38:31'),
(117, 48, 51, 3, '', '2026-03-11 04:38:36'),
(118, 48, 61, 5, '', '2026-03-11 04:38:42'),
(119, 49, 45, 3, '', '2026-03-11 04:39:23'),
(120, 49, 46, 3, '', '2026-03-11 04:39:29'),
(121, 49, 47, 4, '', '2026-03-11 04:39:34'),
(122, 50, 32, 4, '', '2026-03-11 04:40:19'),
(123, 50, 33, 3, '', '2026-03-11 04:40:26'),
(124, 50, 34, 4, '', '2026-03-11 04:40:33'),
(125, 53, 7, 4, '', '2026-03-11 04:47:33'),
(126, 53, 9, 5, '', '2026-03-11 04:47:39'),
(127, 53, 15, 4, '', '2026-03-11 04:47:44'),
(128, 52, 9, 4, '', '2026-03-11 04:48:18'),
(129, 52, 20, 4, '', '2026-03-11 04:48:23'),
(130, 52, 48, 4, '', '2026-03-11 04:48:28'),
(131, 51, 18, 3, '', '2026-03-11 04:49:01'),
(132, 51, 51, 4, '', '2026-03-11 04:49:06'),
(133, 51, 61, 3, '', '2026-03-11 04:49:12'),
(134, 57, 45, 4, '', '2026-03-11 04:59:17'),
(135, 57, 46, 3, '', '2026-03-11 04:59:23'),
(136, 57, 61, 3, '', '2026-03-11 04:59:29'),
(137, 54, 12, 3, '', '2026-03-11 04:59:52'),
(138, 54, 13, 4, '', '2026-03-11 04:59:57'),
(139, 54, 14, 3, '', '2026-03-11 05:00:03'),
(140, 56, 17, 5, '', '2026-03-11 05:00:29'),
(141, 56, 47, 3, '', '2026-03-11 05:00:34'),
(142, 56, 51, 4, '', '2026-03-11 05:00:40');

-- --------------------------------------------------------

--
-- Struktur dari tabel `ratings`
--

CREATE TABLE `ratings` (
  `id_rating` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `id_produk` int(11) DEFAULT NULL,
  `rating` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `shipping_rates`
--

CREATE TABLE `shipping_rates` (
  `id_rate` int(11) NOT NULL,
  `kurir` varchar(50) DEFAULT NULL,
  `origin` varchar(100) DEFAULT NULL,
  `destination` varchar(100) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `tanggal` datetime DEFAULT current_timestamp(),
  `total_harga` decimal(12,2) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `region` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `no_hp` varchar(20) NOT NULL,
  `jenis_kelamin` varchar(20) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `foto_profil` varchar(255) DEFAULT 'default.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id_user`, `nama`, `email`, `password_hash`, `role`, `region`, `created_at`, `no_hp`, `jenis_kelamin`, `tanggal_lahir`, `foto_profil`) VALUES
(3, 'Admin Raya', 'admin@raya.com', 'scrypt:32768:8:1$ldecjo4uDjFMqnrk$147df27020ce207237572fca7196d0cbea62601976bc0c6ec671d5d5d74da9734de7752bd347f99dba295a1e863663de2c32c367790270c9978ccaf24f6f24c1', 'admin', 'Indonesia', '2025-11-11 13:29:19', '081598379786', '', '0000-00-00', 'default.png'),
(14, 'aldy', 'aldy@gmail.com', 'scrypt:32768:8:1$gjDnZgTlS0UlkLto$791e355c48619af01e4326b0ba3f816c026ceb7d904595d64e11581ffd4bd3bfb0aeee2f6711d037f4f5fd6022fee9e0d018b2ec062506b08a92d39814d742bf', 'user', 'Sulawesi', '2026-01-21 15:52:10', '081234560016', 'Laki-laki', '2006-02-22', 'user_14_oscar.jpg'),
(15, 'sem', 'sem@gmail.com', 'scrypt:32768:8:1$cctBoNWXFUYHJCau$9a6074ff9a9446a745e9470df38f8fc1631b6359d14b76025ad96c449dd9e19d6e410833073a1fecb13b195f076981806c49825f6a425d8b474c0936b4b23217', 'user', 'Sulawesi', '2026-01-21 15:52:51', '085234560015', 'Laki-laki', '2005-11-12', 'default.png'),
(16, 'johan', 'johan@gmail.com', 'scrypt:32768:8:1$ZufVFyz1UEc1jBOD$e695848b00d6176b2730a444c349eace2f35dd8103deb19717ec81b211d6eb844844d658241394580826f3570c90897e2b18e35f7c2b4a0d0ba0328defb35921', 'user', 'Sulawesi', '2026-01-21 15:53:43', '081234560016', 'Laki-laki', '2006-07-03', 'default.png'),
(17, 'mega', 'mega@gmail.com', 'scrypt:32768:8:1$Ji9Vl2AGHtCI09ET$759ef05c8eda4269eb01357662fba7c75189cb799b9fef1d8192939d7ad1cb6f5fe00e5af099c815ff413819abd0fce44304db586478664a176961d42b9b82c5', 'user', 'Sulawesi', '2026-01-21 15:54:40', '081234560017', 'Perempuan', '2005-04-18', 'default.png'),
(18, 'alex', 'alex@gmail.com', 'scrypt:32768:8:1$p6y1G6eJBOiHe24a$a76299b5238608bc884efc87cef58f1269333f78739410f8d948f1cba618493bad2c3993c54231f12862cea372725ace063d607a42b46be1e3de38c64dd3c0f7', 'user', 'Sulawesi', '2026-01-21 15:55:11', '085234560018', 'Laki-laki', '2006-09-25', 'default.png'),
(19, 'mendy', 'mendy@gmail.com', 'scrypt:32768:8:1$OJQbqjHN4SNk4Ohe$a7f7aa22f1be6b5caa1bf9a607575027f0be10af2a6882124c2dab73be27fd429b1e86c079da80bfceae67448b55151d03a4e32784a3cf995b1361ca9a6fa6af', 'user', 'Sulawesi', '2026-01-21 15:55:36', '081234560019', 'Perempuan', '2005-01-30', 'default.png'),
(20, 'alan', 'alan@gmail.com', 'scrypt:32768:8:1$BMZNDGC09E4MATrP$da548e367121b568892d60c57b5c312b362787c8c3b489316b765e7cd5c9c2a1c1065d338bb61a40402be00bdb302a990f12393cb06c2083557a41e2e4a4fc00', 'user', 'Sulawesi', '2026-01-21 15:55:57', '085234560020', 'Laki-laki', '2006-06-14', 'default.png'),
(21, 'isa', 'isa@gmail.com', 'scrypt:32768:8:1$faA4uWp3vW7RlQSE$cd8c30a6bf7eb6a7f28a1da13901642d83367e0ae20618de530eca6e4ce152672cfeb1020f073547a4ab6b86761e6bf14c9439faaf578874e861b099ff939b53', 'user', 'Sulawesi', '2026-01-21 15:56:13', '081234560021', 'Perempuan', '2007-03-08', 'default.png'),
(22, 'yesi', 'yesi@gmail.com', 'scrypt:32768:8:1$pPGX0QHC2dyZoB6A$918fac1de2bef21a099a50b28194417ae8c362960fbba4d6eab159d175c65aff974ac825bf133f78d0710b86fc94e31f634f59794322d786a2283039753d572f', 'user', 'Sulawesi', '2026-01-21 15:56:30', '085234560022', 'Perempuan', '2006-12-19', 'default.png'),
(23, 'milan', 'milan@gmail.com', 'scrypt:32768:8:1$XckZMd0Ofm75sgKT$04728f6c9b83f86454868f647073509caab025699fa7642a57c52a37c5e5f1f5c71ad8a6b9285d57ece6a143e54f92770d743f513711c5bd006660d5e328580b', 'user', 'Sulawesi', '2026-01-21 15:56:56', '081234560023', 'Perempuan', '2005-08-27', 'default.png'),
(24, 'john', 'john@gmail.com', 'scrypt:32768:8:1$9LZawNc3VAhZkwTF$82b8ba41728183a139a8b8b03c3839a7f0d6f83cddc1f3ce780c295f51ac96e878c1bf80ed9e6a66a81206ff53bdb38731fac2f58fb60ed86e8cd3f7b9729ecf', 'user', 'Sulawesi', '2026-01-21 15:57:13', '085234560024', 'Laki-laki', '2004-10-05', 'user_24_1771944716.jpg'),
(25, 'mely', 'mely@gmail.com', 'scrypt:32768:8:1$PG83SJBfnebKLqEz$0a16cbd1c9fe40d38375bea8af4c3c716d86e49a7ca4480a39bec0b0f941a1da62f625251bef88ca490c1971e495051f15a422756f8343ef4f4a4bf74777c91f', 'user', 'Sulawesi', '2026-01-21 15:57:48', '081234560025', 'Perempuan', '2006-05-16', 'default.png'),
(26, 'sela', 'sela@gmail.com', 'scrypt:32768:8:1$5WAjFWiM9iFUWVJ9$5a218ea1146733d96b3cc18c37ead7509e46edb5c5294153f9da00647ec1997d9e083bdebad73c38ecfa77d8f3717b3b2800ca5a28dd2cb8209aa65eb7c660f6', 'user', 'Sulawesi', '2026-01-21 15:58:04', '085234560026', 'Perempuan', '2007-01-11', 'default.png'),
(27, 'isan', 'isan@gmail.com', 'scrypt:32768:8:1$XHUxnDBnMbLCbb2T$63e749ade4054f72ec638df650010fb5fd8211a00e260d1c626857955593f275a56669980a4b9d76a5d821d0157fa2e0d3b5ec5aaca2086edfb4318a3185cc39', 'user', 'Sulawesi', '2026-01-21 15:58:28', '081234560027', 'Laki-laki', '2005-09-02', 'default.png'),
(28, 'max', 'max@gmail.com', 'scrypt:32768:8:1$UxhCUoOwsaRRSp7x$8f5e2b3378cfce4acedf86f2bbafa2bc9692dafb4869f884da8b19c1d50d913f796d0a7243ed839f3991cfbc9c99f1b05ff84dee05ff8982dc00a0d9a0272e98', 'user', 'Sulawesi', '2026-01-21 15:58:47', '085234560028', 'Laki-laki', '2006-03-21', 'default.png'),
(30, 'son', 'soni@gmail.com', 'scrypt:32768:8:1$SdMPRWS6SR0mo8SJ$563e6e8232a206472cfec36a37b7b3f12bc57790d1f4b19e16daef9246495a361e94e8c53bbd7b37b425e339b815729adcf86312d0229e633c12edc599a73194', 'user', 'Nusa penida bali', '2026-01-31 14:50:46', '00987293729', 'Laki-laki', '2006-02-23', 'user_30_1770558967.jpg'),
(31, 'alberto', 'albert@gmail.com', 'scrypt:32768:8:1$NWNdAxKttFx3GHSl$e6e4df91c64c1bab5c389b7683645e0f35cc7f9cd8f721fa34b1a84f3923cd8892f145cd1fb5db0e6c65cd5ed3b07ce2419d259d9194762b72347c9f7894ad64', 'user', 'Sulawesi', '2026-02-10 14:22:09', '087645352387', 'Laki-laki', '2026-02-03', 'default.jpg'),
(32, 'dion', 'dion@gmail.com', 'scrypt:32768:8:1$UbEOFyCQa7BtNDUc$8791a24891e8a36c37e9b5681e770519e4afbf8e878f2988ab19fff6fb7ad03d81aa96bbe6c255cda523cab857d10726dd123ab8466f6ba81402fb42eb80fe6f', 'user', 'Sulawesi', '2026-02-17 15:30:54', '091767534276', 'Laki-laki', '2005-06-15', 'default.jpg'),
(33, 'Join', 'join@gmail.com', 'scrypt:32768:8:1$UoYEEierSiJ3YsXB$bc90d7e654c4f1d84a0ccaaf5d877a44c42fff635e14de9e40fae13c02eb7ebaa766bda480bd6cdcacf073f3e01628c07754f122a7982648f4a29826cac2559c', 'user', 'Sulawesi', '2026-03-02 05:30:56', '0813467287578', 'Laki-laki', '2001-06-02', 'default.jpg'),
(35, 'ucok', 'cok@gmail.com', 'scrypt:32768:8:1$QBe0zzx37HwT7mZN$564039c89687ec7e90fcc38d6cdd8d8eee02197af0b4d49611652840cbbb400d41a3e1a89ba2014c18777e45e0ed536d1d941026680e1b093e2cf85357718488', 'user', 'Sulawesi', '2026-03-02 17:30:20', '098897609', 'Laki-laki', '2010-07-19', 'default.jpg'),
(36, 'ub', 'ub@gmail.com', 'scrypt:32768:8:1$xxEGvFBrbX69KlfS$dd042bfee1d8e4fd2af9c95cd1f2306df3f36883290a4191c5f5e5faf0011312edc49ee20dc36459182f8984752c44252d20abc28b92d9534805e3a647f9d64d', 'user', 'Sulawesi', '2026-03-07 13:08:25', '09777777', 'Laki-laki', '2026-03-11', 'default.jpg'),
(37, 'Wandy Fernandes', 'wandy@gmail.com', 'scrypt:32768:8:1$1SyYLaRAKJuAvmAl$734e084aef2a6c5fe71f2367011fbf3d207e217d314f75842c6961cea69ced10d68489fc8bb7e8353bf14ac58583aa9d1d5dd37714abc56612cf3c81b97c80d8', 'user', 'Sulawesi', '2026-03-10 01:53:41', '081476287499', 'Laki-laki', '2023-01-21', 'default.jpg'),
(38, 'Delon', 'delon@gmail.com', 'scrypt:32768:8:1$t2qpMpH6UvE2ABos$1251b42f3eeb17be9d8be7546e4a4d7a2926f524993694ddf7647120eaa5ec8963be03f92a2bd667f36b24f50edde6a2d214069010d58887b49fbb3e12c441b6', 'user', 'Sulawesi', '2026-03-10 02:00:06', '081576928400', 'Laki-laki', '2026-03-04', 'default.jpg'),
(39, 'Rora', 'rora@gmail.com', 'scrypt:32768:8:1$37SDVQ1mxsdSYIqL$395ce402871281433a2306f1b39962305b76c73a4ae93351240fa34060ece3ca6a16421a34da92c1f81a6b965ebafb2115e3caf41a10e024bb17e2bcee0b7e0b', 'user', 'Jawa', '2026-03-11 04:02:53', '0087726388', 'Perempuan', '2026-03-15', 'default.jpg'),
(40, 'tik', 'tik@gmail.com', 'scrypt:32768:8:1$QHMV40xOi9SOtFp5$ff04ba9d4c30a3c2477d5e394124b8f0f5bfbe52d4fcc38663d8d4b339a06373460bb9783e29d2f75a7b7d9c23c0d0910516357fc319e1f8d350885bbf60b977', 'user', 'Kalimantan', '2026-03-11 04:07:15', '08752736', 'Perempuan', '2026-03-18', 'default.jpg'),
(41, 'isak', 'isak@gmail.com', 'scrypt:32768:8:1$ZTgqP41Bo5mFK6GU$8c096e9c9887bbf539405f82cfb2ba6a6ebee57b195f46f9b7854fa8feccd62d8c47a70a13a8502c971abf29922035bb5e8636346ae740f60f1074f59a71d413', 'user', 'Sulawesi', '2026-03-11 04:09:06', '081357127', 'Laki-laki', '2026-03-09', 'default.jpg'),
(42, 'gino', 'gino@gamail.com', 'scrypt:32768:8:1$O8KqQjwCFSmpVYXY$69565a11f4a7b81f445e302579f69bc860581fb3f9e51d9202eadb910f10accb4955ca638372bef39b17e7512af4e7d602520614a0eff08013c20b6d50475ab7', 'user', 'Sulawesi', '2026-03-11 04:10:58', '08167348', 'Laki-laki', '2026-03-08', 'default.jpg'),
(43, 'yusi', 'yusi@gmail.com', 'scrypt:32768:8:1$mp1TYxrxDqlBUCH7$9daca19c7cf3a6b03d42a62800ce387a0b07ebc91772effb6d216bc38ba7bee35bec27f3f6c0fcfc374b2bb3f44e28877a1f60da24ca47c1eed383401eb81942', 'user', 'Nusa Tenggara', '2026-03-11 04:12:49', '081572389', 'Perempuan', '2026-03-02', 'default.jpg'),
(44, 'leri', 'leri@gmail.com', 'scrypt:32768:8:1$i3htyx73gqpOMX81$c810ff5e63300d57d60e78ef6eece70a1e271d92db70e5ff9848794343910b0300e2f72aed7e480327a48b4d37352dd2254f53d3831fa351419806d6d3b0e937', 'user', 'Sulawesi', '2026-03-11 04:14:41', '081472632', 'Laki-laki', '2026-03-09', 'default.jpg'),
(45, 'yabes', 'yabes@gmail.com', 'scrypt:32768:8:1$iX4JimhuBL82dlY1$6c58d6cc9b7d3eec91dc46b908c74399ab965ef394354f3cf879d831d77724a371606943440522fb8d3c8a5caab21d43ecfbf44e0956f4ade232065efe569841', 'user', 'Kalimantan', '2026-03-11 04:16:47', '08133682', 'Laki-laki', '2026-03-05', 'default.jpg'),
(46, 'arya', 'arya@gmail.com', 'scrypt:32768:8:1$yDtnV8tIIVq0IfYB$0cf03f9850bf083b5fffddbc0fb48008feb13e6496b2da3c436e7aea785ba7d6de1d46cf30aa2fa44dffcbf3c9cb3b17ba84e643651e66417e3799dbdf1cd854', 'user', 'Nusa Tenggara', '2026-03-11 04:18:54', '081247588826', 'Laki-laki', '2026-03-03', 'default.jpg'),
(47, 'valentin', 'valentin@gmail.com', 'scrypt:32768:8:1$yWZNgqBpdVlVB1QO$ebe8e9e6ad6897cf380095576a408884f69b81599f16d81f8dff5438b3719a33d856978940404ec930270e9d1753dc15f184f0155806472ab878a89d754ab160', 'user', 'Sulawesi', '2026-03-11 04:21:22', '08623624', 'Perempuan', '2026-03-09', 'default.jpg'),
(48, 'nia', 'nia@gmail.com', 'scrypt:32768:8:1$BQOt7W6te48wsCKJ$e75af3717870fd8dbb2c79f91a451c52fa3362d38e7bf438e97c46e0bdab959dc4930df691fd5d914a5413d8d5817696ec1f29406dbcbd85d72b6b01ac90de98', 'user', 'Kalimantan', '2026-03-11 04:23:25', '08163723', 'Perempuan', '2026-03-06', 'default.jpg'),
(49, 'virgo', 'virgo@gmail.com', 'scrypt:32768:8:1$iOsEZHB875Lg5I0S$779e67a9a7c0d5d46e4c31815790878aa7f52b0a2e405eb863e5b1f1f8f54a731e5718c7e17ecf1b007e7a46bf5d95f4e655c908e011da03cdecd6a3dee7978f', 'user', 'Sulawesi', '2026-03-11 04:25:13', '091767534276', 'Laki-laki', '2026-03-05', 'default.jpg'),
(50, 'aries', 'aries@gmail.com', 'scrypt:32768:8:1$iWk5FnvMDXrQXifo$66efb7a8fd1057c54077a53408274023cede5a1fa8134f05315ee92710c9da040666e9738217e5733c59cc1d1db89080ecd8e2a006a745843e71c4e7d9e68520', 'user', 'Sulawesi', '2026-03-11 04:27:11', '0813467287578', 'Laki-laki', '2026-03-01', 'default.jpg'),
(51, 'zodyl', 'zodyl@gmail.com', 'scrypt:32768:8:1$6Ssv7uxFcr6QuK1f$d9485e457aa96b39ccb1d9d5813d1947108bf3f7f146b0e284581ceb39626b1669eb22de52b214b89101d8df97287068ee387da47129362963ddf9debb87cc11', 'user', 'Sulawesi', '2026-03-11 04:41:23', '087645352387', 'Laki-laki', '2026-03-09', 'default.jpg'),
(52, 'key', 'key@gmail.com', 'scrypt:32768:8:1$PXk2Z92J1lRisRXs$b8dbccfa04fb69fb889613cdfab25a303c18f40e0343c604f6c3b4b0f65b6fe64473f6852c36d51d5fd4c5eacc864dd8931be813ccb7d33319c45ab3cc674797', 'user', 'Sulawesi', '2026-03-11 04:43:08', '0813467287578', 'Laki-laki', '2026-03-02', 'default.jpg'),
(53, 'jody', 'jody@gmail.com', 'scrypt:32768:8:1$CIDWkuNA70LTpBhb$fe4a7f2e92dd72f157ea43e2d6f60bc9c24c3bf6131eea7b73ef70168c954f5ba3b5d9ded1f17757da261afe2ca0afa96120a4a3afed7397313d7542f211b085', 'user', 'Sulawesi', '2026-03-11 04:44:55', '087645352387', 'Laki-laki', '2026-03-02', 'default.jpg'),
(54, 'asta', 'asta@gmail.com', 'scrypt:32768:8:1$NeDWEFCc7KL1DWuq$c8f7187db1f1655fe627268dbd8adb471995eb64978663551804bbce07aeacccfe204df8a4fe1321f8e3c36c41769980ef96e7d85bf50031d1eff3f6bd26a11e', 'user', 'Sulawesi', '2026-03-11 04:51:29', '00987293729', 'Laki-laki', '2026-03-13', 'default.jpg'),
(55, 'yuno', 'yuno@gmail.com', 'scrypt:32768:8:1$7bMEztM3IX4iJ00Q$8bbe591843105cc12b0007b39df82ed0fb57b065453b3dce7ebb86f241255597e33a3be60f7898c9e03993164dbf3d1f0af32cca7ae4591f908f132473308df7', 'user', 'Sulawesi', '2026-03-11 04:52:13', '091767534276', 'Laki-laki', '2026-03-04', 'default.jpg'),
(56, 'mika', 'mika@gmail.com', 'scrypt:32768:8:1$aInKwbeKYdavJAoe$01c91ce67a2cce99323f96c59a9d66c1aeaf5daf27c275b154b56221ca26316964eec1830805f4efd53cbfc3cccc0fcb1cdb9acd7a234182e0352bc566c94200', 'user', 'Sulawesi', '2026-03-11 04:52:52', '087645352387', 'Laki-laki', '2026-03-05', 'default.jpg'),
(57, 'sing', 'sing@gmail.com', 'scrypt:32768:8:1$ZhM8Iii4PdYfuZBk$2f1d1c0cd2c8732f93c8c5ad78ed12e1e14962ecddea08a52e773a5732547bd82459ed9191b50683a9158b6bd593ab6d2597ea7c71c6ad98c30e1ee1ecd090d4', 'user', 'Sulawesi', '2026-03-11 04:57:25', '00987293729', 'Laki-laki', '2026-03-06', 'default.jpg');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_addresses`
--

CREATE TABLE `user_addresses` (
  `id_address` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `nama_penerima` varchar(50) DEFAULT NULL,
  `no_hp` varchar(20) DEFAULT NULL,
  `provinsi` varchar(50) DEFAULT NULL,
  `kabupaten` varchar(50) DEFAULT NULL,
  `kecamatan` varchar(50) DEFAULT NULL,
  `detail_alamat` text DEFAULT NULL,
  `kode_pos` varchar(10) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT 1,
  `lat` decimal(10,7) DEFAULT NULL,
  `lng` decimal(10,7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `user_addresses`
--

INSERT INTO `user_addresses` (`id_address`, `id_user`, `nama_penerima`, `no_hp`, `provinsi`, `kabupaten`, `kecamatan`, `detail_alamat`, `kode_pos`, `is_default`, `lat`, `lng`) VALUES
(1, 35, 'ucok', '098897609', 'Sulawesi Selatan', 'Toraja Utara', 'Baruppu', 'jalan barereng 88', '8989', 1, NULL, NULL),
(2, 36, 'ub', '09777777', 'Sumatera Utara', 'Tanjung Balai', 'takalar', 'koja', '56565', 1, NULL, NULL),
(3, 37, 'Wandy Fernandes', '081476287499', 'Sulawesi Selatan', 'Toraja Utara', 'Baruppu', 'Kampung Barereng', '8989', 1, NULL, NULL),
(4, 38, 'Delon', '081576928400', 'Sulawesi Selatan', 'Toraja Utara', 'Baruppu', 'Kampung Barereng', '8989', 1, NULL, NULL),
(5, 39, 'Rora', '0087726388', 'Sulawesi Selatan', 'Toraja Utara', 'Baruppu', 'kampung barereng', '8989', 1, NULL, NULL),
(6, 40, 'tik', '08752736', 'Sulawesi Selatan', 'Toraja Utara', 'Baruppu', 'bar', '8989', 1, NULL, NULL),
(7, 41, 'isak', '081357127', 'Sulawesi Selatan', 'Toraja Utara', 'Baruppu', 'barereng', '8989', 1, NULL, NULL),
(8, 42, 'gino', '08167348', 'Sulawesi Selatan', 'Toraja Utara', 'Baruppu', 'barereng', '8989', 1, NULL, NULL),
(9, 43, 'yusi', '081572389', 'Sulawesi Selatan', 'Toraja Utara', 'Baruppu', 'bareeeng', '8989', 1, NULL, NULL),
(10, 44, 'leri', '081472632', 'Sulawesi Selatan', 'Toraja Utara', 'Baruppu', 'kampung barereng', '8989', 1, NULL, NULL),
(11, 45, 'yabes', '08133682', 'Sulawesi Selatan', 'Toraja Utara', 'Baruppu', 'baruppu', '8989', 1, NULL, NULL),
(12, 46, 'arya', '081247588826', 'Sulawesi Selatan', 'Toraja Utara', 'Baruppu', 'barereng', '8989', 1, NULL, NULL),
(13, 47, 'valentin', '08623624', 'Sulawesi Selatan', 'Toraja Utara', 'Baruppu', 'bareng', '8989', 1, NULL, NULL),
(14, 48, 'nia', '08163723', 'Sulawesi Selatan', 'Toraja Utara', 'Baruppu', 'bareng', '8989', 1, NULL, NULL),
(15, 49, 'virgo', '091767534276', 'Sulawesi Selatan', 'Toraja Utara', 'Baruppu', 'barereng', '8989', 1, NULL, NULL),
(16, 50, 'aries', '0813467287578', 'Sulawesi Selatan', 'Toraja Utara', 'Baruppu', 'barereng', '8989', 1, NULL, NULL),
(17, 51, 'zodyl', '087645352387', 'Sulawesi Selatan', 'Toraja Utara', 'Baruppu', 'bareren', '8989', 1, NULL, NULL),
(18, 52, 'key', '0813467287578', 'Sulawesi Selatan', 'Toraja Utara', 'Baruppu', 'barereng', '8989', 1, NULL, NULL),
(19, 53, 'jody', '087645352387', 'Sulawesi Selatan', 'Toraja Utara', 'Baruppu', ' barereng', '8989', 1, NULL, NULL),
(20, 54, 'asta', '00987293729', 'Sulawesi Selatan', 'Toraja Utara', 'Baruppu', 'barereng', '8989', 1, NULL, NULL),
(21, 55, 'yuno', '091767534276', 'Sulawesi Selatan', 'Toraja Utara', 'Baruppu', 'barereng', '8989', 1, NULL, NULL),
(22, 56, 'mika', '087645352387', 'Sulawesi Selatan', 'Toraja Utara', 'Baruppu', 'barereng', '8989', 1, NULL, NULL),
(23, 57, 'sing', '00987293729', 'Sulawesi Selatan', 'Toraja Utara', 'Baruppu', 'barereng', '8989', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `varian_detail`
--

CREATE TABLE `varian_detail` (
  `id_detail` int(11) NOT NULL,
  `id_varian` int(11) DEFAULT NULL,
  `warna` varchar(50) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `varian_detail`
--

INSERT INTO `varian_detail` (`id_detail`, `id_varian`, `warna`, `stok`) VALUES
(1, 1, 'Hitam', 4),
(2, 2, 'Hitam', 5),
(3, 9, 'Hitam', 4),
(4, 10, 'Hitam', 5),
(5, 11, 'Hitam', 4),
(6, 12, 'Hitam', 5),
(7, 13, 'Hitam', 5),
(8, 14, 'Hitam', 4),
(9, 3, 'Hitam', 4),
(10, 4, 'Hitam', 5),
(11, 15, 'Hitam', 5),
(12, 16, 'Hitam', 4),
(13, 17, 'Hitam', 5),
(14, 18, 'Hitam', 3),
(15, 19, 'Hitam', 5),
(16, 20, 'Hitam', 4),
(17, 21, 'Hitam', 5),
(18, 22, 'Hitam', 3),
(19, 23, 'Hitam', 5),
(20, 5, 'Hitam', 3),
(21, 6, 'Hitam', 5),
(22, 24, 'Hitam', 4),
(23, 25, 'Hitam', 5),
(24, 26, 'Hitam', 3),
(25, 27, 'Hitam', 5),
(26, 28, 'Hitam', 4),
(27, 29, 'Hitam', 4),
(28, 30, 'Hitam', 4),
(29, 31, 'Hitam', 4),
(30, 32, 'Hitam', 4),
(31, 33, 'Hitam', 5),
(32, 34, 'Hitam', 3),
(33, 35, 'Hitam', 5),
(34, 36, 'Hitam', 4),
(35, 37, 'Hitam', 4),
(36, 38, 'Hitam', 4),
(37, 39, 'Hitam', 5),
(38, 40, 'Hitam', 4),
(39, 41, 'Hitam', 5),
(40, 42, 'Hitam', 4),
(41, 43, 'Hitam', 4),
(42, 44, 'Hitam', 3),
(43, 45, 'Hitam', 4),
(44, 46, 'Hitam', 3),
(45, 47, 'Hitam', 5),
(46, 48, 'Hitam', 4),
(47, 49, 'Hitam', 3),
(48, 50, 'Hitam', 4),
(49, 51, 'Hitam', 3),
(50, 52, 'Hitam', 4),
(51, 53, 'Hitam', 2),
(52, 54, 'Hitam', 3),
(53, 55, 'Hitam', 4),
(54, 56, 'Hitam', 2),
(55, 57, 'Hitam', 5),
(56, 7, 'Hitam', 1),
(57, 8, 'Hitam', 4),
(64, 1, 'Putih', 3),
(65, 2, 'Putih', 3),
(66, 9, 'Putih', 3),
(67, 10, 'Putih', 3),
(68, 11, 'Putih', 3),
(69, 12, 'Putih', 3),
(70, 13, 'Putih', 3),
(71, 14, 'Putih', 3),
(72, 3, 'Putih', 3),
(73, 4, 'Putih', 3),
(74, 15, 'Putih', 3),
(75, 16, 'Putih', 3),
(76, 17, 'Putih', 3),
(77, 18, 'Putih', 3),
(78, 19, 'Putih', 3),
(79, 20, 'Putih', 3),
(80, 21, 'Putih', 3),
(81, 22, 'Putih', 2),
(82, 23, 'Putih', 3),
(83, 5, 'Putih', 3),
(84, 6, 'Putih', 3),
(85, 24, 'Putih', 3),
(86, 25, 'Putih', 3),
(87, 26, 'Putih', 3),
(88, 27, 'Putih', 3),
(89, 28, 'Putih', 3),
(90, 29, 'Putih', 2),
(91, 30, 'Putih', 3),
(92, 31, 'Putih', 3),
(93, 32, 'Putih', 2),
(94, 33, 'Putih', 3),
(95, 34, 'Putih', 3),
(96, 35, 'Putih', 3),
(97, 36, 'Putih', 3),
(98, 37, 'Putih', 3),
(99, 38, 'Putih', 3),
(100, 39, 'Putih', 2),
(101, 40, 'Putih', 3),
(102, 41, 'Putih', 3),
(103, 42, 'Putih', 3),
(104, 43, 'Putih', 3),
(105, 44, 'Putih', 3),
(106, 45, 'Putih', 3),
(107, 46, 'Putih', 3),
(108, 47, 'Putih', 3),
(109, 48, 'Putih', 3),
(110, 49, 'Putih', 3),
(111, 50, 'Putih', 3),
(112, 51, 'Putih', 3),
(113, 52, 'Putih', 3),
(114, 53, 'Putih', 3),
(115, 54, 'Putih', 3),
(116, 55, 'Putih', 3),
(117, 56, 'Putih', 3),
(118, 57, 'Putih', 3),
(119, 7, 'Putih', 2),
(120, 8, 'Putih', 2),
(130, 65, 'Biru', 8),
(131, 65, 'putih', 9),
(132, 66, 'merah', 4),
(133, 66, 'putih', 5),
(134, 66, 'biru', 3);

-- --------------------------------------------------------

--
-- Struktur dari tabel `varian_produk`
--

CREATE TABLE `varian_produk` (
  `id_varian` int(11) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `nama_varian` varchar(20) NOT NULL,
  `harga` decimal(12,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `varian_produk`
--

INSERT INTO `varian_produk` (`id_varian`, `id_produk`, `nama_varian`, `harga`, `created_at`) VALUES
(1, 1, '4GB / 64GB', 1899000.00, '2026-02-16 11:23:02'),
(2, 1, '4GB / 128GB', 2099000.00, '2026-02-16 11:23:02'),
(3, 5, '4GB / 128GB', 1799000.00, '2026-02-16 11:23:02'),
(4, 5, '8GB / 256GB', 2199000.00, '2026-02-16 11:23:02'),
(5, 10, '6GB / 128GB', 2299000.00, '2026-02-16 11:23:02'),
(6, 10, '8GB / 256GB', 2599000.00, '2026-02-16 11:23:02'),
(7, 51, '8GB / 256GB', 1574000.00, '2026-02-16 11:40:09'),
(8, 51, '12GB / 256GB', 1998000.00, '2026-02-16 11:40:09'),
(9, 2, '4GB / 128GB', 2499000.00, '2026-02-16 12:28:27'),
(10, 2, '8GB / 128GB', 2799000.00, '2026-02-16 12:28:27'),
(11, 3, '6GB / 128GB', 3799000.00, '2026-02-16 12:28:27'),
(12, 3, '8GB / 256GB', 4299000.00, '2026-02-16 12:28:27'),
(13, 4, '8GB / 128GB', 4999000.00, '2026-02-16 12:28:27'),
(14, 4, '8GB / 256GB', 5499000.00, '2026-02-16 12:28:27'),
(15, 6, '4GB / 128GB', 2199000.00, '2026-02-16 12:28:27'),
(16, 6, '6GB / 128GB', 2499000.00, '2026-02-16 12:28:27'),
(17, 6, '8GB / 256GB', 2999000.00, '2026-02-16 12:28:27'),
(18, 7, '4GB / 128GB', 1799000.00, '2026-02-16 12:28:27'),
(19, 7, '8GB / 256GB', 2299000.00, '2026-02-16 12:28:27'),
(20, 8, '4GB / 128GB', 2099000.00, '2026-02-16 12:28:27'),
(21, 8, '6GB / 128GB', 2399000.00, '2026-02-16 12:28:27'),
(22, 9, '6GB / 128GB', 3299000.00, '2026-02-16 12:28:27'),
(23, 9, '8GB / 256GB', 3799000.00, '2026-02-16 12:28:27'),
(24, 11, '6GB / 128GB', 1999000.00, '2026-02-16 12:28:27'),
(25, 11, '8GB / 128GB', 2299000.00, '2026-02-16 12:28:27'),
(26, 12, '8GB / 128GB', 3599000.00, '2026-02-16 12:28:27'),
(27, 12, '8GB / 256GB', 3999000.00, '2026-02-16 12:28:27'),
(28, 13, '8GB / 128GB', 3199000.00, '2026-02-16 12:28:27'),
(29, 13, '8GB / 256GB', 3699000.00, '2026-02-16 12:28:27'),
(30, 14, '4GB / 128GB', 1899000.00, '2026-02-16 12:28:27'),
(31, 14, '6GB / 128GB', 2199000.00, '2026-02-16 12:28:27'),
(32, 15, '4GB / 64GB', 1699000.00, '2026-02-16 12:28:27'),
(33, 15, '4GB / 128GB', 1899000.00, '2026-02-16 12:28:27'),
(34, 16, '6GB / 128GB', 2499000.00, '2026-02-16 12:28:27'),
(35, 16, '8GB / 256GB', 2999000.00, '2026-02-16 12:28:27'),
(36, 17, '6GB / 128GB', 3199000.00, '2026-02-16 12:28:27'),
(37, 17, '8GB / 128GB', 3499000.00, '2026-02-16 12:28:27'),
(38, 18, '4GB / 128GB', 2199000.00, '2026-02-16 12:28:27'),
(39, 18, '6GB / 128GB', 2499000.00, '2026-02-16 12:28:27'),
(40, 19, '4GB / 128GB', 2299000.00, '2026-02-16 12:28:27'),
(41, 19, '6GB / 128GB', 2599000.00, '2026-02-16 12:28:27'),
(42, 20, '8GB / 128GB', 3499000.00, '2026-02-16 12:28:27'),
(43, 20, '8GB / 256GB', 3999000.00, '2026-02-16 12:28:27'),
(44, 32, '2GB / 32GB', 1299000.00, '2026-02-16 12:28:27'),
(45, 32, '3GB / 64GB', 1499000.00, '2026-02-16 12:28:27'),
(46, 33, '3GB / 32GB', 1399000.00, '2026-02-16 12:28:27'),
(47, 33, '4GB / 64GB', 1599000.00, '2026-02-16 12:28:27'),
(48, 34, '8GB / 128GB', 2699000.00, '2026-02-16 12:28:27'),
(49, 34, '8GB / 256GB', 3199000.00, '2026-02-16 12:28:27'),
(50, 45, '8GB / 128GB', 5299000.00, '2026-02-16 12:28:27'),
(51, 45, '12GB / 256GB', 5999000.00, '2026-02-16 12:28:27'),
(52, 46, '6GB / 128GB', 3299000.00, '2026-02-16 12:28:27'),
(53, 46, '8GB / 256GB', 3799000.00, '2026-02-16 12:28:27'),
(54, 47, '8GB / 128GB', 2999000.00, '2026-02-16 12:28:27'),
(55, 47, '8GB / 256GB', 3499000.00, '2026-02-16 12:28:27'),
(56, 48, '8GB / 256GB', 5999000.00, '2026-02-16 12:28:27'),
(57, 48, '12GB / 256GB', 6499000.00, '2026-02-16 12:28:27'),
(65, 61, '3GB / 64GB', 1249000.00, '2026-02-25 12:46:24'),
(66, 61, '4GB / 128GB', 1449000.00, '2026-02-25 12:46:24');

-- --------------------------------------------------------

--
-- Struktur dari tabel `varian_warna`
--

CREATE TABLE `varian_warna` (
  `id_varian` int(11) NOT NULL,
  `id_produk` int(11) DEFAULT NULL,
  `warna` varchar(50) DEFAULT NULL,
  `harga` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `varian_warna`
--

INSERT INTO `varian_warna` (`id_varian`, `id_produk`, `warna`, `harga`) VALUES
(15, 1, 'Hitam', NULL),
(16, 1, 'Biru', NULL),
(17, 1, 'Hijau', NULL),
(18, 2, 'Hitam', NULL),
(19, 2, 'Merah', NULL),
(20, 2, 'Silver', NULL),
(21, 3, 'Black', NULL),
(22, 3, 'Lime', NULL),
(23, 3, 'Violet', NULL),
(24, 4, 'hitam', NULL),
(25, 4, 'putih', NULL),
(26, 4, 'hijau', NULL),
(27, 5, 'Hitam', NULL),
(28, 5, 'Silver', NULL),
(29, 5, 'Biru', NULL),
(30, 6, 'Hitam', NULL),
(31, 6, 'Biru', NULL),
(32, 6, 'Hijau', NULL),
(33, 7, 'Hitam', NULL),
(34, 7, 'Biru', NULL),
(35, 7, 'Hijau', NULL),
(36, 8, 'Hitam', NULL),
(37, 8, 'Kuning', NULL),
(38, 8, 'Hijau', NULL),
(39, 9, 'Hitam', NULL),
(40, 9, 'Biru', NULL),
(41, 9, 'Kuning', NULL),
(42, 10, 'Hitam', NULL),
(43, 10, 'Putih', NULL),
(44, 10, 'Hijau', NULL),
(45, 11, 'Hitam', NULL),
(46, 11, 'Emas', NULL),
(47, 11, 'Hijau', NULL),
(48, 12, 'Hitam', NULL),
(49, 12, 'Biru', NULL),
(50, 12, 'Putih', NULL),
(51, 13, 'Hitam', NULL),
(52, 13, 'Emas', NULL),
(53, 13, 'Hijau', NULL),
(54, 14, 'Hitam', NULL),
(55, 14, 'Ungu', NULL),
(56, 14, 'Hijau', NULL),
(57, 15, 'Hitam', NULL),
(58, 15, 'Biru', NULL),
(59, 15, 'Putih', NULL),
(60, 16, 'Hitam', NULL),
(61, 16, 'Ungu', NULL),
(62, 16, 'Merah', NULL),
(63, 17, 'Hitam', NULL),
(64, 17, 'Biru', NULL),
(65, 17, 'Putih', NULL),
(66, 18, 'Hitam', NULL),
(67, 18, 'Emas', NULL),
(68, 18, 'Hijau', NULL),
(69, 19, 'Hitam', NULL),
(70, 19, 'Hijau', NULL),
(71, 19, 'Emas', NULL),
(72, 20, 'hitam', NULL),
(73, 20, 'Ungu', NULL),
(74, 20, 'Biru', NULL),
(78, 33, 'merah', NULL),
(79, 33, 'hitam', NULL),
(80, 34, 'merah', NULL),
(81, 34, 'Hitam', NULL),
(95, 48, 'Hitam', NULL),
(96, 48, 'biru', NULL),
(97, 48, 'putih', NULL),
(99, 47, 'putih', NULL),
(100, 47, 'hitam', NULL),
(101, 47, 'biru', NULL),
(102, 46, 'Hitam', NULL),
(103, 46, 'putih', NULL),
(104, 46, 'biru', NULL),
(107, 45, 'Hitam', NULL),
(108, 45, 'putih', NULL),
(109, 32, 'Merah', NULL),
(110, 32, 'Hitam', NULL),
(114, 51, 'Hitam', NULL),
(115, 51, 'biru', NULL),
(116, 51, 'putih', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `wishlist`
--

CREATE TABLE `wishlist` (
  `id_wishlist` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `wishlist`
--

INSERT INTO `wishlist` (`id_wishlist`, `id_user`, `id_produk`, `created_at`) VALUES
(9, 4, 46, '2026-01-21 14:27:24'),
(12, 24, 47, '2026-02-22 15:21:19');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `brand`
--
ALTER TABLE `brand`
  ADD PRIMARY KEY (`id_brand`);

--
-- Indeks untuk tabel `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id_cart`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_produk` (`id_produk`);

--
-- Indeks untuk tabel `data`
--
ALTER TABLE `data`
  ADD PRIMARY KEY (`id_produk`),
  ADD KEY `fk_brand` (`id_brand`);

--
-- Indeks untuk tabel `data_produk`
--
ALTER TABLE `data_produk`
  ADD PRIMARY KEY (`id_produk`);

--
-- Indeks untuk tabel `ongkir`
--
ALTER TABLE `ongkir`
  ADD PRIMARY KEY (`id_ongkir`);

--
-- Indeks untuk tabel `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id_order`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`id_detail`),
  ADD KEY `id_produk` (`id_produk`),
  ADD KEY `id_order` (`id_order`);

--
-- Indeks untuk tabel `order_log`
--
ALTER TABLE `order_log`
  ADD PRIMARY KEY (`id_log`),
  ADD KEY `id_order` (`id_order`);

--
-- Indeks untuk tabel `order_status_history`
--
ALTER TABLE `order_status_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_order` (`id_order`);

--
-- Indeks untuk tabel `produk_gambar`
--
ALTER TABLE `produk_gambar`
  ADD PRIMARY KEY (`id_gambar`),
  ADD KEY `id_produk` (`id_produk`);

--
-- Indeks untuk tabel `produk_variant`
--
ALTER TABLE `produk_variant`
  ADD PRIMARY KEY (`id_variant`);

--
-- Indeks untuk tabel `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`id_rating`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_produk` (`id_produk`);

--
-- Indeks untuk tabel `shipping_rates`
--
ALTER TABLE `shipping_rates`
  ADD PRIMARY KEY (`id_rate`);

--
-- Indeks untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indeks untuk tabel `user_addresses`
--
ALTER TABLE `user_addresses`
  ADD PRIMARY KEY (`id_address`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `varian_detail`
--
ALTER TABLE `varian_detail`
  ADD PRIMARY KEY (`id_detail`),
  ADD KEY `id_varian` (`id_varian`);

--
-- Indeks untuk tabel `varian_produk`
--
ALTER TABLE `varian_produk`
  ADD PRIMARY KEY (`id_varian`),
  ADD KEY `fk_varian_data` (`id_produk`);

--
-- Indeks untuk tabel `varian_warna`
--
ALTER TABLE `varian_warna`
  ADD PRIMARY KEY (`id_varian`),
  ADD KEY `id_produk` (`id_produk`);

--
-- Indeks untuk tabel `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`id_wishlist`),
  ADD UNIQUE KEY `id_user` (`id_user`,`id_produk`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `brand`
--
ALTER TABLE `brand`
  MODIFY `id_brand` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `cart`
--
ALTER TABLE `cart`
  MODIFY `id_cart` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=362;

--
-- AUTO_INCREMENT untuk tabel `data`
--
ALTER TABLE `data`
  MODIFY `id_produk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT untuk tabel `data_produk`
--
ALTER TABLE `data_produk`
  MODIFY `id_produk` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `ongkir`
--
ALTER TABLE `ongkir`
  MODIFY `id_ongkir` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `orders`
--
ALTER TABLE `orders`
  MODIFY `id_order` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=156;

--
-- AUTO_INCREMENT untuk tabel `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `id_detail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=222;

--
-- AUTO_INCREMENT untuk tabel `order_log`
--
ALTER TABLE `order_log`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `order_status_history`
--
ALTER TABLE `order_status_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT untuk tabel `produk_gambar`
--
ALTER TABLE `produk_gambar`
  MODIFY `id_gambar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT untuk tabel `produk_variant`
--
ALTER TABLE `produk_variant`
  MODIFY `id_variant` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=193;

--
-- AUTO_INCREMENT untuk tabel `rating`
--
ALTER TABLE `rating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=143;

--
-- AUTO_INCREMENT untuk tabel `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id_rating` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `shipping_rates`
--
ALTER TABLE `shipping_rates`
  MODIFY `id_rate` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT untuk tabel `user_addresses`
--
ALTER TABLE `user_addresses`
  MODIFY `id_address` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT untuk tabel `varian_detail`
--
ALTER TABLE `varian_detail`
  MODIFY `id_detail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=138;

--
-- AUTO_INCREMENT untuk tabel `varian_produk`
--
ALTER TABLE `varian_produk`
  MODIFY `id_varian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT untuk tabel `varian_warna`
--
ALTER TABLE `varian_warna`
  MODIFY `id_varian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT untuk tabel `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `id_wishlist` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`id_produk`) REFERENCES `data` (`id_produk`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `data`
--
ALTER TABLE `data`
  ADD CONSTRAINT `fk_brand` FOREIGN KEY (`id_brand`) REFERENCES `brand` (`id_brand`);

--
-- Ketidakleluasaan untuk tabel `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`);

--
-- Ketidakleluasaan untuk tabel `order_detail`
--
ALTER TABLE `order_detail`
  ADD CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id_order`),
  ADD CONSTRAINT `order_detail_ibfk_2` FOREIGN KEY (`id_produk`) REFERENCES `data` (`id_produk`);

--
-- Ketidakleluasaan untuk tabel `order_log`
--
ALTER TABLE `order_log`
  ADD CONSTRAINT `order_log_ibfk_1` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id_order`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `order_status_history`
--
ALTER TABLE `order_status_history`
  ADD CONSTRAINT `order_status_history_ibfk_1` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id_order`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `produk_gambar`
--
ALTER TABLE `produk_gambar`
  ADD CONSTRAINT `produk_gambar_ibfk_1` FOREIGN KEY (`id_produk`) REFERENCES `data` (`id_produk`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`id_produk`) REFERENCES `data` (`id_produk`);

--
-- Ketidakleluasaan untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `user_addresses`
--
ALTER TABLE `user_addresses`
  ADD CONSTRAINT `user_addresses_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`);

--
-- Ketidakleluasaan untuk tabel `varian_detail`
--
ALTER TABLE `varian_detail`
  ADD CONSTRAINT `varian_detail_ibfk_1` FOREIGN KEY (`id_varian`) REFERENCES `varian_produk` (`id_varian`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `varian_produk`
--
ALTER TABLE `varian_produk`
  ADD CONSTRAINT `fk_varian_data` FOREIGN KEY (`id_produk`) REFERENCES `data` (`id_produk`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `varian_warna`
--
ALTER TABLE `varian_warna`
  ADD CONSTRAINT `varian_warna_ibfk_1` FOREIGN KEY (`id_produk`) REFERENCES `data` (`id_produk`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
