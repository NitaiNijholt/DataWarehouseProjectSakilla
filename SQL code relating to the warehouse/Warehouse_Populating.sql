-- Making sure it does not fill full tables 
DELETE FROM sakila_warehouse.date_table;
DELETE FROM sakila_warehouse.film_table;
DELETE FROM sakila_warehouse.store_table;
DELETE FROM sakila_warehouse.customer_table;
DELETE FROM sakila_warehouse.fact_table;

-- Filling Date_Table
insert into sakila_warehouse.date_table(Day,Month,Year) 
select CAST(payment_date as DATE), month(CAST(payment_date as DATE)), year(CAST(payment_date as DATE)) 
from sakila.payment group by CAST(payment_date as DATE);

-- Filling Film_Table 
insert into sakila_warehouse.film_table(Film_name, Category, Language) 
select f.title , c.name, l.name from sakila.film f 
inner join sakila.language l on f.language_id = l.language_id 
inner join sakila.film_category fc on f.film_id = fc.film_id 
inner join sakila.category c on fc.category_id = c.category_id 
order by f.title;

-- Filling Store_table
insert into sakila_warehouse.store_table(Store,Staff) 
SELECT co.country, concat(sf.first_name,' ',sf.last_name) FROM sakila.store st 
inner join sakila.staff sf on st.store_id = sf.store_id
inner join sakila.address a on st.address_id = a.address_id
inner join sakila.city ci on a.city_id = ci.city_id
inner join sakila.country co on ci.country_id = co.country_id;

-- Filling Customer_location_table
insert into sakila_warehouse.customer_table(country,City,Customer_Name,Customer_Activity) 
SELECT co.country, ci.city, concat(cu.first_name, ' ', cu.last_name), cu.active 
FROM sakila.customer cu 
inner join sakila.address a on cu.address_id = a.address_id
inner join sakila.city ci on a.city_id = ci.city_id
inner join sakila.country co on ci.country_id = co.country_id;

-- Filling fact table

insert into sakila_warehouse.fact_table(Payments,Replacement_cost, Rental_duration, Date_key, Film_key, Store_key, Customer_key)
Select X.payment, X.replacement, X.duration, D.Date_key,F.Film_key,S.Store_key,C.Customer_key
FROM (
	select p.amount as payment, f.replacement_cost as replacement, f.rental_duration as duration,
    CAST(payment_date as DATE) as Day_filter, concat(cu.first_name, ' ', cu.last_name) as C_filter,
    f.title as F_filter, concat(sf.first_name,' ',sf.last_name) as S_filter
	from sakila.payment p 
	inner join sakila.rental r on p.rental_id = r.rental_id
	inner join sakila.inventory i on r.inventory_id = i.inventory_id 
	inner join sakila.film f on i.film_id = f.film_id
    inner join sakila.customer cu on p.customer_id = cu.customer_id
    inner join sakila.staff sf on p.staff_id = sf.staff_id

	) X 
    
    inner join
    (
    select Date_key, Day from sakila_warehouse.date_table 
    ) D ON D.Day = X.Day_filter 
    
    inner join
    (
    select Customer_key, Customer_Name from sakila_warehouse.customer_table
    ) C on C.Customer_Name = X.C_filter
    
    inner join
    (
    select Film_key,Film_name from sakila_warehouse.film_table
    ) F ON F.Film_name = X.F_filter
    
    inner join
    (
    select Store_key, Staff from sakila_warehouse.store_table
    ) S ON S.staff = X.S_filter
	