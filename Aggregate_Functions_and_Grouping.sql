--Grouping and Aggregate Functions
--Q1
select type::char(30), avg(coalesce(price::numeric, 0)) from titles t  
group by type;

--Q2
select (max(pubdate) - min(pubdate)) from titles t ;

--Q3
select pub_id, type, avg(price::numeric), min(price), max(price) from titles t 
group by type, pub_id ;

--Q4
select pub_id, type, avg(price::numeric), min(price), max(price) 
from titles t 
group by t.pub_id, t.type
having avg(price::numeric) > 20
order by avg;

--Q5
select title from titles order by character_length(title);
select title from titles order by length(title) DESC;


--Business Queries
--Q1
select avg(age(current_date, pubdate)), type from titles group by type;
select avg(date_part('year',age(current_date, pubdate))*12 + date_part('month',age(current_date, pubdate))),type  from titles group by type;

--Q2
select count(au_lname), city from authors group by city;

--Q3
select title, length(title) from titles;
select title, length(title) from titles  order by character_length(title) desc;

--Q4
--a
select s.stor_id, s.stor_name, sum(s2.qty) from stores s 
inner join sales s2 
on s.stor_id = s2.stor_id 
group by s.stor_name, s.stor_id;

--b
select sum(s2.qty) "Total Books Sold" from stores s 
inner join sales s2 
on s.stor_id = s2.stor_id;