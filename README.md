# Mini Project SQL: TheLook E-commerce

## Project Overview
This project focuses on analyzing data for **TheLook E-commerce** using SQL queries in **Google BigQuery**. The goal is to assist the product, marketing, CRM, and executive business teams in understanding product characteristics, identifying high-value customers, evaluating inventory distributions, and discovering top-performing product categories by revenue.

---

## Dataset
- **Database / Project:** `bigquery-public-data.thelook_ecommerce`
- **Tables Used:**
  - `products`: Contains details about product catalog, categories, departments, brands, and retail prices.
  - `users`: Contains customer demographics and profiles.
  - `orders`: Contains order transaction metadata and status.
  - `order_items`: Contains line-item transaction records, sale prices, and product mapping.

---

## Business Questions & SQL Queries

### 1. Product Analysis (Analisis Produk)
**Objective:** The Product team wants to understand the basic characteristics of products sold.  
**Task:** Retrieve product name, category, department, brand, and retail price for the first 20 products.

```sql
SELECT 
  name, 
  category, 
  department, 
  brand, 
  retail_price
FROM `bigquery-public-data.thelook_ecommerce.products`
LIMIT 20;

````

-----

### 2\. Premium Product Identification (Identifikasi Produk Premium)

**Objective:** The Marketing team is preparing a campaign targeting high-end/premium products.  
**Task:** Find all products with a `retail_price` greater than 100, displaying name, category, brand, and retail price sorted from highest to lowest.

``` sql
SELECT 
  name, 
  category, 
  brand, 
  retail_price
FROM `bigquery-public-data.thelook_ecommerce.products`
WHERE retail_price > 100
ORDER BY retail_price DESC;

```

-----

### 3\. Category Volume Evaluation (Evaluasi Kategori Produk)

**Objective:** The Product team wants to identify which product categories have the largest volume of items.  
**Task:** Count the total number of products in each category, sorted in descending order of product count.

``` sql
SELECT 
  category, 
  COUNT(id) AS total_products
FROM `bigquery-public-data.thelook_ecommerce.products`
GROUP BY category
ORDER BY total_products DESC;

```

-----

### 4\. Customer Order Analysis (Mengenal Pelanggan dan Pesanan)

**Objective:** The CRM team wants to inspect orders alongside customer profile details.  
**Task:** Join `users` and `orders` to display order ID, order status, order creation date, and the customer's first and last name.

``` sql
SELECT 
  o.order_id, 
  o.status, 
  o.created_at AS order_date, 
  u.first_name, 
  u.last_name
FROM `bigquery-public-data.thelook_ecommerce.orders` AS o
INNER JOIN `bigquery-public-data.thelook_ecommerce.users` AS u
  ON o.user_id = u.id;

```

-----

### 5\. Sales Performance by Category (Analisis Penjualan per Kategori)

**Objective:** Business management wants to determine which categories generate the highest total sales value.  
**Task:** Join `order_items` and `products` to calculate the total sales value (`sale_price`) grouped by product category, sorted from highest to lowest sales.

``` sql
SELECT 
  p.category, 
  SUM(oi.sale_price) AS total_sales
FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
JOIN `bigquery-public-data.thelook_ecommerce.products` AS p
  ON oi.product_id = p.id
GROUP BY p.category
ORDER BY total_sales DESC;

```

-----

## Business Insights

1.  **Product Volume vs. Revenue Generation:**  
    Categories with high product counts (from Question 3) do not automatically guarantee the highest revenue generation (from Question 5). Focusing marketing budgets on high-revenue categories yields a better return on investment (ROI) than focusing solely on categories with large product catalogs.

2.  **Premium Segment Opportunities:**  
    Identifying products priced above $100 enables targeted luxury/premium campaigns. Cross-referencing top-performing sales categories with high-priced items can help optimize promotional strategies and increase Average Order Value (AOV).

-----
