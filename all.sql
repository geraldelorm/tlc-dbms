--DATA TYPES
--Question 1 Find all titles with an undefined price in table titles--
select title, price from titles t
where price is null; 

--Question 2 Find all titles with an undefined price in table titles and supply a price of $20.00 for those with no defined price--
select title, coalesce(price::numeric , 20)::money as "New Prices" from titles

--Question 3 List the first 50 characters (of the pr_info column) of the pub_info table--
select substr(pr_info,1,50) from pub_info pi2 ;

-- Question 4 Examine the Postgres function reference for alternative ways of converting date values to varchar --
select cast(ord_date as varchar) from sales s; 
select ord_date::varchar from sales s ;

-- Question 5 Locate and use one the functions that would allow you to specify the format to be used when outputting a date. Format the ord_date in sales so it looks like this: Tuesday 13th September 1994--
select to_char(ord_date, 'Day DDth  Month YYYY') from sales;






--FUNCTIONS
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

-- Q12 Print all phone numbers from the authors table without the three digit area code.
select phone , substr(phone,4) as new_phone from authors;

-- Q13 Capitalise the second character in all last names from the authors table.
select au_lname,  substr(au_lname,1,1) || initcap(substr(au_lname,2,1)) || substr(au_lname,3)  as LastName from authors;







--Grouping and Aggregate Functions
--Q1 Get average prices from the titles table for each type of book, and convert type to char(30)
select type::char(30), avg(coalesce(price::numeric, 0)) from titles t  
group by type;

--Q2 Print the difference between (to a resolution of days) the earliest and latest publication date in titles
select (max(pubdate) - min(pubdate)) from titles t ;

--Q3 Print the average, min and max book prices within the titles table organised into groups based on type and publisher id
select pub_id, type, avg(price::numeric), min(price), max(price) from titles t 
group by type, pub_id ;

--Q4 Refine the previous question to show only those types whose average price is > $20 and output the results sorted on the average price
select pub_id, type, avg(price::numeric), min(price), max(price) 
from titles t 
group by t.pub_id, t.type
having avg(price::numeric) > 20
order by avg;

--Q5 List the books in order of the length of their title
select title from titles order by character_length(title);
select title from titles order by length(title) DESC;


--Business Queries
--Q1 What is the average age in months of each type of title?
select avg(age(current_date, pubdate)), type from titles group by type;
select avg(date_part('year',age(current_date, pubdate))*12 + date_part('month',age(current_date, pubdate))),type  from titles group by type;

--Q2 How many authors live in each city?
select count(au_lname), city from authors group by city;

--Q3 What is the longest title?
select title, length(title) from titles;
select title, length(title) from titles  order by character_length(title) desc;

--Q4 How many books have been sold by each store and how many books have been sold in total?
--a
select s.stor_id, s.stor_name, sum(s2.qty) from stores s 
inner join sales s2 
on s.stor_id = s2.stor_id 
group by s.stor_name, s.stor_id;

--b
select sum(s2.qty) "Total Books Sold" from stores s 
inner join sales s2 
on s.stor_id = s2.stor_id;






--Table Joins
--Q1 Join the publishers and pub_info and show the publisher name and the first 40 characters of the pr_info information
select p.pub_name, pi2.pr_info::char(40) from publishers p 
inner join pub_info pi2
on p.pub_id = pi2.pub_id;

--Q2 Join the publishers and titles tables to show all titles published by each publisher. Display the pub_id, pub_name and and title_id

select p.pub_id, t.title_id, t.title, p.pub_name from publishers p 
inner join titles t 
on p.pub_id = t.pub_id ;

--Q3 For each title_id in the table titles, rollup the corresponding qty in sales and show: title_id, title, ord_num and the rolled-up value as a column aggregate called Total Sold
select t.title_id, s.qty, t.title, s.ord_num, sum(s.qty) as "Total Sold"
from titles t 
inner join sales s
on t.title_id = s.title_id 
group by t.title_id, s.ord_num,  s.qty ;

--Q4 For each stor_id in stores, show the corresponding ord_num in sales and the discount type from table discounts. The output should consist of three columns: ord_num, discount and discounttype and should be sorted on ord_num
select s.stor_id, s2.ord_num, d.discount, d.discounttype
from stores s
inner join sales s2
on s.stor_id = s2.stor_id
inner join discounts d 
on s2.stor_id = d.stor_id 
order by s2.ord_num;

--Q5 Show au_lname from authors, and pub_name from publishers when both publisher and author live in the same city.

select a.au_lname, p.pub_name from authors a 
inner join publishers p
on a.city = p.city;

--Q6 Refine 5 so that for each author you show all publishers who live in the same city and have published one of the authors titles.
select a.au_lname, a.au_fname, p.pub_name, a.city, t.title 
from publishers p  inner join titles t 
on p.pub_id = t.pub_id inner join authors a on a.city = p.city 

--Q7  Refine 1 so that an outer join is performed. All of the publishers from the first table should be shown, not just those with pr_info information in pub_info. You should use the ANSI SQL92 syntax.

select p.pub_name, p2.pr_info::char(40) from publishers p 
right outer join pub_info p2
on p.pub_id = p2.pub_id;

--Q8 List each publisher's name, the title of each book they have sold and the total quantity of that title
select p.pub_name, t.title, sum(s.qty) from publishers p 
inner join titles t 
on p.pub_id = t.pub_id 
inner join sales s 
on t.title_id = s.title_id 
group by p.pub_name, t.title 

--Business Queries
--Q1 How many books have been published by each publisher?
select p.pub_name , count(t.title) from publishers p
inner join titles t 
on p.pub_id = t.pub_id 
group by p.pub_name; 

--Q2 How many different types of book has each publisher published?
select p.pub_name , t.type, count(t."type")  as "Book Type" from publishers p
inner join titles t 
on p.pub_id = t.pub_id 
group by p.pub_name, t."type" 

--Q3 What is the average royalty percentage payed to each author?
select a.au_lname , a.au_fname, avg(t.royaltyper)
from titleauthor t 
inner join authors a 
on a.au_id = t.au_id 
group by a.au_lname, a.au_fname 

--Q4 For each store list which authors have had their books sold through that store.
select s.stor_name, a.au_lname, a.au_fname from stores s 
inner join sales s2 
on s.stor_id = s2.stor_id 
inner join titleauthor t 
on s2.title_id = t.title_id 
inner join authors a 
on t.au_id = a.au_id 
order by stor_name 







--Sub-Queries
--Q1 Which publishers have published at least one book?
select pub_id, pub_name 
from publishers p 
where pub_id in (
	select pub_id 
	from titles t 
);

--Q2 Which authors have been published by more than one publisher?
select * 
from authors a 
where au_id in (
	select t2.au_id 
	from titles t 
	inner join titleauthor t2 
	on t2.title_id = t.title_id 
	group by t2.au_id 
	having count(t2.au_id) > 1 
);
	
--Q3 Which authors live in a city where a publisher exists?
select au_id, au_lname, au_fname , city
	from authors a 
	where city in (
	select city from publishers p 
);
	
--Q4 How many authors are there with the same first initial?
select a.au_fname 
from authors a
where  substr(a.au_fname ,1,1) in (
	select substr(a.au_fname ,1,1)
	from authors a 
	group by substr(a.au_fname ,1,1)
	having count(substr(a.au_fname ,1,1)) >= 2 
);	

--Q5 What is the most expensive book?
select title, price 
from titles t 
where price in (
	select max(price) 
	from titles t 
);
	
--Q6 Which is the oldest published book? Which is the youngest?
--Oldest 
select *
from titles  
where pubdate in (
	select min(pubdate) 
	from titles t 
);
--Youngest
select *
from titles  
where pubdate in (
	select max(pubdate) 
	from titles t 
);

--Q7 Which books are more expensive than all books of any other type?
	
	