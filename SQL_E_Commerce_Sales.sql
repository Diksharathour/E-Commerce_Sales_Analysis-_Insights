 --- SQL E_Commerce_Sales_Analysis
 
 Use sql_project4;
 Create table e_commerce_sales
 (Customer_id int primary key,
 Gender	VARCHAR(20),
 Age int,
 City VARCHAR(50),
 Membership VARCHAR(20),
 Total_spend decimal(15,2),
 Items_purchased int,
 Average_rating decimal(15,1),
 Discount VARCHAR(20),
 last_purchase int,
 Satisfaction VARCHAR(20)
 );

Select * from e_commerce_sales;

-- Data Analysis and Business insights

-- 1. Which membership generates the highest revenue?

select membership, round(sum(total_spend),2) as total_revenue from e_commerce_sales
group by membership
order by total_revenue desc;

-- 2. Which cities contribute the most sales?

select city, round(sum(total_spend),2) as total_sales from e_commerce_sales
group by city
order by total_sales desc;

-- 3. Which age group spends the most?

select 
case when age between 26 and 30 then '26-30'
when age between 31 and 35 then '31-35'
when age between 36 and 40 then '36-40'
else '40+'
end as age_group,
round(sum(total_spend),2) as total_spend from e_commerce_sales
group by age_group
order by total_spend desc;

-- 4. Do customers using discounts spend more?

select discount, count(*) as customers, round(avg(total_spend),2) as avg_spend, 
round(AVG(items_purchased),2) as avg_items from e_commerce_sales
group by discount;

-- 5. Which membership type has the highest customer satisfaction?

select membership, satisfaction, count(*) AS customers from e_commerce_sales
group by membership, satisfaction
order by customers desc;

-- 6. Build a Customer Segmentation Model.

select customer_id, membership, total_spend, items_purchased,
case when total_spend > 1200
and items_purchased > 15
then 'High Value'
when total_spend between 700 and 1200
then 'Medium Value'
else 'Low Value'
end as customer_segment
from e_commerce_sales;

-- 7. Identify At Risk Customers.

select customer_id, city, membership, total_spend, last_purchase,
case when last_purchase > 45
then  'At Risk'
else 'Active'
end as customer_status
from e_commerce_sales
order by last_purchase desc;

-- 8. Which customer segments generate the highest revenue?

select
case when total_spend > 1200
and items_purchased > 15
then  'High Value'
when total_spend between 700 and 1200
then  'Medium Value'
else  'Low Value'
end as  customer_segment,
count(*) as customers,
round(sum(total_spend),2) as revenue,
round(avg(total_spend),2) as avg_spend
from e_commerce_sales
group by customer_segment
order by revenue DESC;

-- End of Project