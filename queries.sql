-- 1. Reterive all books in the "fiction" genre
select * from books where genre = 'fiction';

-- 2.find books publish after the year 1950
select * from books where Published_Year >1950 order by Published_Year;

-- 3. List all customer from the Canada
select * from customers where Country ='Canada';

-- 4. Show order placed in november 2023
select * from orders where Order_Date >='2023-11-01' and Order_Date < '2023-12-01';

-- 5.Retrieve the total stock of book available.
select sum(stock) as Total_Stock from books;

-- 6. Find the detail of most expensive book.
select Book_Id,title,Author,Genre,Published_Year,Stock,max(price) as price from books 
group by Book_Id,title,Author,Genre,Published_Year,Stock
order by price desc
limit 1;

-- 7.Show all the customer who ordered more then one quatity of books.
select orders.Customer_ID,orders.Quantity from orders
where orders.Quantity > 1;

-- 8.Retreive all order where the total amount exceeds $20
select * from orders where orders.Total_Amount>20;


-- 9. Lists all genre available in book store
select distinct Genre from books;

-- 10.Find the book with lowest stock
select Book_ID,title,min(stock) from books
group by Book_ID,title
order by min(stock);

-- 11.calculate the total revenue generated from the orders.
select round(sum(orders.Quantity*books.Price),2) as Total_Revenue
from orders
join books
on books.Book_ID=orders.Book_ID;

-- 12.Reterive the total number of books sold for each genre
select books.Genre,sum(orders.Quantity) as  total_sold
from books
join orders
on orders.Book_ID=books.Book_ID
group by books.Genre
order by total_sold desc;

-- 13.Find the average price of books in 'fantasy' genre
select round(avg(books.Price),2) as average_books
from books
where genre = 'Fantasy';

-- 14.List customers who have placed at least 2 orders
select orders.Customer_ID,customers.Name,count(*) as total_order
from orders
join customers
on customers.Customer_ID = orders.Customer_ID
group by orders.Customer_ID,customers.Name
having count(*) >=2
order by 3 desc;

-- 15.find the most frequently ordered book
select orders.Book_ID,books.Title,count(orders.Book_ID) as Total from orders
join books
on books.Book_ID=orders.Book_ID
group by orders.Book_ID,books.Title
order by Total desc
limit 1;  

-- 16. show the top 3 most expensive books of 'fantasy' genre
select * from books 
where Genre='Fantasy'
order by price desc 
limit 3;

-- 17. Retrieve the total quantity of books sold by each author:
SELECT books.Author, SUM(orders.quantity) AS Total_Books_Sold
FROM orders 
JOIN books  
ON orders.Book_ID =books.Book_ID
GROUP BY books.Author;

-- 18. List the cities where customers who spent over $30 are located:
select customers.City,Total_amount
from customers
join orders 
on orders.customer_ID =customers.Customer_ID
where Total_Amount >30;

-- 19. Find the customer who spent the most on orders:
select customers.customer_ID,customers.Name, sum(orders.Total_amount) as total
from customers
join orders 
on orders.customer_ID =customers.Customer_ID
group by  customers.customer_ID,customers.Name
order by 3 desc
limit 1;

--  20. Calculate the stock remaining after fulfilling all orders:
SELECT books.Book_ID, books.Title, books.Stock, COALESCE(SUM(orders.Quantity),0),  
	books.stock- COALESCE(SUM(orders.Quantity),0) AS Remaining_Quantity
FROM books 
LEFT JOIN orders ON books.Book_ID=orders.Book_ID
GROUP BY books.Book_ID, books.Title, books.Stock, COALESCE(SUM(orders.Quantity),0)
 ORDER BY books.Book_ID;
