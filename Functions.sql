-------------Current Time
--Q1
select current_date ;
select to_char(current_date , 'Day DDth  Month YYYY');

--Q2
select current_time;

--Q3
select current_timestamp;


-------------Converting from String
--Q1
select to_date('2018-09-26', 'YYYY-MM-DD');
select '2018-09-26' :: date;

--Q2
select to_timestamp('2018-09-26', 'YYYY-MM-DD hh:mm:ss');
select '2018-09-26' :: timestamp;

-------------Substring Date
--Q1
select  '2018-12-25' :: date - '2018-09-26' :: date;

--Q2
select pubdate , (current_date - pubdate) as "Days Elapsed" from titles t ;


--------------Extracting components from dates
--Q1
select pubdate , (extract(year from pubdate)) as "Pub Year" from titles t ;

--Q2
select pubdate , (extract(day from pubdate)) as "Pub Day" from titles t ;



---------------- Using TIMESTAMPDIFF
--Q1 
select '2018-03-02'::timestamp - '2018-02-01'::timestamp ;


-------------------Exercises-----------------
--Q1
select to_char(ord_date, 'DD-MM-YYYY') ,(( current_date - '2011-01-01'::date) + ord_date) as "Difference Added to Sales Date" from sales s; 

--Q2
select ('2021-12-25'::date - current_date) as "Days to Christmas";
select ('2021-11-25'::date - current_date) as "Days to Thanksgiving";
select ('2022-01-01'::date - current_date) as "Days to New Year";

--Q3
select (current_date - '1900-02-14'::date) as "DOB";

--Q4
select pubdate , current_date, (current_date - pubdate)::integer  as "Diff b\n pub date and current date" from titles;

--Q5
select ord_date, to_char(ord_date, 'dd/mm/yy') as "Formatted Date" from sales;

--Q6
select stor_id, ord_date from sales s 

--Q7
select

--Q8
select

--Q9
select

--Q10
select

--Q11
select coalesce (price::numeric , floor(random() * 100 + 1)::int) as new_price from titles where price is null;

-- Q12
select phone , substr(phone,4) as new_phone from authors;

-- Q13
select au_lname,  substr(au_lname,1,1) || initcap(substr(au_lname,2,1)) || substr(au_lname,3)  as LastName from authors;

