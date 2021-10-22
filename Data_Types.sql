--Question 1 --
select title, price from titles t
where price is null; 

--Question 2 --
select title, coalesce(price::numeric , 20)::money as "New Prices" from titles

--Question 3 --
select substr(pr_info,1,50) from pub_info pi2 ;

-- Question 4 --
select cast(ord_date as varchar) from sales s; 
select ord_date::varchar from sales s ;

-- Question 5 --
select to_char(ord_date, 'Day DDth  Month YYYY') from sales;

