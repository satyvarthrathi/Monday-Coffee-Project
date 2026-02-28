-- Monday Coffee -- Data Analysis

Select * from city;
Select * from products;
Select * from customers;
Select * from sales;

-- Reports & Data Analysis

-- Q1. Coffee Consumers count
-- How many people in each city are estimated to consume coffee, given tha 25% of the population does?

Select
	city_name, 
	ROUND((population * 0.25)/1000000, 2) as coffee_consumer_in_millions,
	city_rank
From city
ORDER BY 2 DESC

-- Q2. Total Revenue from coffee sales
-- What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?

Select 
	Extract(Year from sale_date) as year,
	Extract(Quarter from sale_date) as qtr
from sales
where
	Extract(Year from sale_date) = 2023
	AND
	Extract(Quarter from sale_date) = 4

Select 
	ci.city_name,
	SUM(s.total) as total_revenue
from sales as s
JOIN customers as c
On s.customer_id = c.customer_id
JOIN city as ci
ON ci.city_id = c.city_id
where
	Extract(Year from s.sale_date) = 2023
	AND
	Extract(Quarter from s.sale_date) = 4
GROUP BY ci.city_name
ORDER BY total_revenue DESC

--Q3. Sales count for each product
-- How many units of each coffee product have been sold?

Select 
	p.product_name,
	Count(s.sale_id) as total_sales
from products as p
Left join sales as s
On s.product_id = p.product_id
Group By p.product_name
Order By total_sales DESC

-- Q4. Average sales amount per city?
-- What is the average sales amount per customer in each city?

Select 
	ci.city_name,
	SUM(s.total) as total_revenue,
	COUNT(DISTINCT s.customer_id) as total_customers,
	ROUND(SUM(s.total)::numeric/COUNT(DISTINCT s.customer_id)::numeric,2) as Avg_sale_per_cust
from sales as s
JOIN customers as c
On s.customer_id = c.customer_id
JOIN city as ci
ON ci.city_id = c.city_id
GROUP BY ci.city_name
ORDER BY Avg_sale_per_cust DESC













