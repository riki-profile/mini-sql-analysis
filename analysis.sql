-- 1. Analisis Produk
-- Tim Product ingin mengetahui karakteristik produk yang dijual. Tampilkan nama produk,
-- kategori, department, merek, dan harga retail dari tabel products. Batasi hasil menjadi 20 produk pertama.
SELECT
  name,
  category,
  department,
  brand,
  retail_price
FROM
  bigquery-public-data.thelook_ecommerce.products
LIMIT 20;

-- 2. Identifikasi Produk Premium
-- Tim Marketing ingin menyiapkan kampanye untuk produk premium. Cari produk dengan
-- retail_price di atas 100. Tampilkan nama produk, kategori, merek, dan harga retail, lalu
-- urutkan dari harga tertinggi ke terendah.
SELECT
  name,
  category,
  department,
  brand,
  retail_price
FROM
  bigquery-public-data.thelook_ecommerce.products
WHERE retail_price > 100
ORDER BY retail_price DESC;

-- 3. Evaluasi Kategori Produk
-- Tim Product ingin mengetahui kategori dengan jumlah produk terbanyak. Hitung jumlah
-- produk pada setiap kategori dari tabel products, lalu urutkan hasil dari jumlah produk
-- terbesar.
SELECT
  category,
  COUNT(id) AS jmlh_produk
FROM
  bigquery-public-data.thelook_ecommerce.products
GROUP BY category
ORDER BY jmlh_produk DESC;

-- INSIGT
-- kategori produk dengan jumlah produk terbanyak adalah kategori "Intimates" dengan 2.363 produk
-- sedangkan kategori "Clothing Sets" merupakan kategori dengan produk paling sedikit dengan 37 produk

-- 4. Mengenal Pelanggan dan Pesanan
-- Tim CRM ingin melihat pelanggan yang melakukan pemesanan. Gabungkan tabel users dan
-- orders untuk menampilkan ID pesanan, status pesanan, tanggal pesanan dibuat, serta nama
-- depan dan nama belakang pelanggan.
SELECT
  u.first_name,
  u.last_name,
  oi.order_id,
  oi.status,
  oi.created_at AS tgl_pesanan
FROM
  bigquery-public-data.thelook_ecommerce.order_items AS oi
JOIN
  bigquery-public-data.thelook_ecommerce.users AS u
ON
  oi.user_id = u.id;  

-- 5. Analisis Penjualan per Kategori
-- Manajer bisnis ingin mengetahui kategori produk dengan nilai penjualan terbesar. Gabungkan
-- tabel order_items dan products, lalu hitung total nilai penjualan berdasarkan kategori.
-- Tampilkan kategori dan total penjualan, kemudian urutkan dari nilai terbesar. Gunakan
-- order_items.sale_price sebagai nilai transaksi per item.
SELECT
  p.category,
  SUM(oi.sale_price) AS total_revenue
FROM
  bigquery-public-data.thelook_ecommerce.order_items AS oi
JOIN
  bigquery-public-data.thelook_ecommerce.products AS p
ON oi.product_id = p.id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- INSIGHT
-- Kategori dengan penjualan terbesar dipegang oleh "Outerwear & Coats" dengan nilai 1,324,934.13
-- Sedangkan kategori penjualan terendah adalah "Clothing Sets" dengan nilai 16,631.51







