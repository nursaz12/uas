-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 07 Des 2024 pada 20.23
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `recipes`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `recipes`
--

CREATE TABLE `recipes` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `ingredients` text NOT NULL,
  `instructions` text NOT NULL,
  `category` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `recipes`
--

INSERT INTO `recipes` (`id`, `title`, `image`, `ingredients`, `instructions`, `category`) VALUES
(1, 'Martabak Manis', 'uploads/MM.jpg', 'Bahan 1\n\n225 g tepung terigu protein sedang\n20 g tepung maizena atau tang mien atau  tapioka\n30 g gula pasir\n250 ml air\n1 butir telur\n3/4 sdt baking powder\nBahan 2\n\n50 ml air\n3/4 sdt baking soda\n2 sdt perisa pandan atau vanila (sesuai selera)\nGula pasir secukupnya\nBahan topping\n\nMentega atau margarin, susu kental manis, keju, dan wijen sangrai', 'Cara membuat:\n\nUntuk adonan martabak: Campurkan tepung terigu, tepung maizena, gula, dan air. Aduk menggunakan mixer hingga semua bahan menyatu.\nMasukkan telur dan baking powder. Aduk rata. Diamkan adonan minimal 1 jam. Setelah itu, bagi adonan menjadi dua (untuk vanila dan pandan).\nPanaskan Teflon di atas api sedang.\nUntuk adonan vanila: campurkan baking soda dengan air, aduk rata. Untuk adonan pandan, campurkan baking soda, air, dan perisa pandan. Aduk rata\nMasukkan campuran baking soda dan perisa vanila ke adonan pertama, lalu aduk rata. Masukkan campuran baking soda dan perisa pandan ke adonan kedua. Aduk rata.\nTuang adonan vanila ke teflon, ratakan adonan agar menempel di pinggiran teflon.\nTunggu hingga gelembung-gelembung naik, kecilkan api sedikit\nTaburkan gula pasir di atasnya untuk membantu gelembung-gelembung pecah.\nSetelah bersarang, tutup adonan masak hingga matang dan bagian atasnya tidak lengket.\nTuang adonan pandan ke Teflon. Masak seperti adonan yang pertama.\nSetelah matang, olesi dengan mentega di seluruh permukaan.\nPotong martabak menjadi dua.\nTaburkan dengan keju parut, wijen, dan susu kental manis\nTumpuk martabak menjadi satu, lalu potong menjadi beberapa bagian\nSiap disajikan!', 'cemilan'),
(12, 'Martabak Asin', 'uploads/MA.jpg', 'Bahan-Bahan: \n\n• 3 butir telur\n• 1 buah wortel, parut\n• 2 lembar kol, rajang\n• 2 siung bawang putih, iris\n• 1 batang daun bawang, rajang\n• Setengah sendok teh kari bubuk\n• 1 sendok teh kaldu bubuk\n• Setengah sendok teh merica bubuk\n• 2 sendok makan tepung serbaguna\n• 1 sendok makan terigu\n• Air, kulit lumpia, dan garam secukupnya ', 'Cara Membuat: \n\n1. Siapkan wadah, kocok telur dan masukkan semua bahan-bahan, kecuali tepung terigu dan kulit lumpia. Aduk rata dan tes rasa\n2. Siapkan kulit lumpia dan isi dengan adonan secukupnya\n3. Larutkan tepung terigu dengan sedikit air, gunakan untuk merekatkan kulit lumpia\n4. Panaskan minyak dan goreng martabak telur sampai matang.  ', 'cemilan');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `recipes`
--
ALTER TABLE `recipes`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `recipes`
--
ALTER TABLE `recipes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
