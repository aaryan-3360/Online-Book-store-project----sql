# 📚 Online Bookstore Database - SQL Project

A SQL-based bookstore database management system with 20 analytical queries.

---

## 📁 Project Files

- `README.md` - Project documentation
- `queries.sql` - 20 SQL queries
- `Books.csv` - Books data (Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
- `Customers.csv` - Customers data (Customer_ID, Name, Email, Phone, City, Country)
- `Orders.csv` - Orders data (Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount)

---

## 🗄️ Database Schema

**Tables:**
- `books` - Book_ID, Title, Author, Genre, Published_Year, Price, Stock
- `customers` - Customer_ID, Name, Email, Phone, City, Country
- `orders` - Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount

---

## 📊 20 SQL Queries

### 1. Fiction books
```sql
select * from books where genre = 'fiction';
```

### 2. Books published after 1950
```sql
select * from books where Published_Year > 1950 order by Published_Year;
```

### 3. Customers from Canada
```sql
select * from customers where Country = 'Canada';
```

### 4. Orders in November 2023
```sql
select * from orders where Order_Date >= '2023-11-01' and Order_Date < '2023-12-01';
```

### 5. Total stock available
```sql
select sum(stock) as Total_Stock from books;
```

### 6. Most expensive book
```sql
select Book_Id, title, Author, Genre, Published_Year, Stock, max(price) as price 
from books group by Book_Id, title, Author, Genre, Published_Year, Stock
order by price desc limit 1;
```

### 7. Customers ordered more than 1 book
```sql
select orders.Customer_ID, orders.Quantity from orders where orders.Quantity > 1;
```

### 8. Orders exceeding $20
```sql
select * from orders where Total_Amount > 20;
```

### 9. All genres
```sql
select distinct Genre from books;
```

### 10. Book with lowest stock
```sql
select Book_ID, title, min(stock) from books group by Book_ID, title order by min(stock);
```

### 11. Total revenue
```sql
select round(sum(orders.Quantity * books.Price), 2) as Total_Revenue
from orders join books on books.Book_ID = orders.Book_ID;
```

### 12. Books sold by genre
```sql
select books.Genre, sum(orders.Quantity) as total_sold
from books join orders on orders.Book_ID = books.Book_ID
group by books.Genre order by total_sold desc;
```

### 13. Average price - Fantasy books
```sql
select round(avg(books.Price), 2) as average_price
from books where genre = 'Fantasy';
```

### 14. Loyal customers (2+ orders)
```sql
select orders.Customer_ID, customers.Name, count(*) as total_order
from orders join customers on customers.Customer_ID = orders.Customer_ID
group by orders.Customer_ID, customers.Name having count(*) >= 2
order by 3 desc;
```

### 15. Most frequently ordered book
```sql
select orders.Book_ID, books.Title, count(orders.Book_ID) as Total 
from orders join books on books.Book_ID = orders.Book_ID
group by orders.Book_ID, books.Title order by Total desc limit 1;
```

### 16. Top 3 expensive Fantasy books
```sql
select * from books where Genre = 'Fantasy' order by price desc limit 3;
```

### 17. Books sold by author
```sql
select books.Author, sum(orders.quantity) as Total_Books_Sold
from orders join books on orders.Book_ID = books.Book_ID group by books.Author;
```

### 18. Cities with customers spending $30+
```sql
select customers.City, Total_amount from customers
join orders on orders.customer_ID = customers.Customer_ID where Total_Amount > 30;
```

### 19. Top spending customer
```sql
select customers.customer_ID, customers.Name, sum(orders.Total_amount) as total
from customers join orders on orders.customer_ID = customers.Customer_ID
group by customers.customer_ID, customers.Name order by 3 desc limit 1;
```

### 20. Remaining stock after orders
```sql
select books.Book_ID, books.Title, books.Stock, coalesce(sum(orders.Quantity), 0) as Total_Ordered,
books.stock - coalesce(sum(orders.Quantity), 0) as Remaining_Quantity
from books left join orders on books.Book_ID = orders.Book_ID
group by books.Book_ID, books.Title, books.Stock order by books.Book_ID;
```

---

## 🛠️ Quick Start

### Import CSV Data
```bash
mysql -u root -p bookstore
mysql> LOAD DATA LOCAL INFILE 'books.csv' INTO TABLE books FIELDS TERMINATED BY ',' IGNORE 1 ROWS;
mysql> LOAD DATA LOCAL INFILE 'customers.csv' INTO TABLE customers FIELDS TERMINATED BY ',' IGNORE 1 ROWS;
mysql> LOAD DATA LOCAL INFILE 'orders.csv' INTO TABLE orders FIELDS TERMINATED BY ',' IGNORE 1 ROWS;
```

### Run All Queries
```bash
mysql -u root -p bookstore < queries.sql
```

---

## 📊 Key Metrics

- Total revenue calculation
- Best-selling books and authors
- Customer spending patterns
- Genre performance analysis
- Inventory optimization
- Loyal customer identification

---

## 🛠️ Technologies

- MySQL / PostgreSQL
- SQL (JOINs, GROUP BY, Aggregations)
- CSV data files
- Git & GitHub

---

## 📝 License

MIT License

---

**Happy Analyzing! 📚✨**
