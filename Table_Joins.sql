--Table Joins
--Q1
select p.pub_name, pi2.pr_info::char(40) from publishers p 
inner join pub_info pi2
on p.pub_id = pi2.pub_id;

--Q2
select p.pub_id, t.title_id, t.title, p.pub_name from publishers p 
inner join titles t 
on p.pub_id = t.pub_id ;

--Q3
select t.title_id, s.qty, t.title, s.ord_num, sum(s.qty) as "Total Sold"
from titles t 
inner join sales s
on t.title_id = s.title_id 
group by t.title_id, s.ord_num,  s.qty ;

--Q4
select s.stor_id, s2.ord_num, d.discount, d.discounttype
from stores s
inner join sales s2
on s.stor_id = s2.stor_id
inner join discounts d 
on s2.stor_id = d.stor_id 
order by s2.ord_num;

--Q5
select a.au_lname, p.pub_name from authors a 
inner join publishers p
on a.city = p.city;

--Q6
select a.au_lname, a.au_fname, p.pub_name, a.city, t.title 
from publishers p  inner join titles t 
on p.pub_id = t.pub_id inner join authors a on a.city = p.city 

--Q7
select p.pub_name, p2.pr_info::char(40) from publishers p 
right outer join pub_info p2
on p.pub_id = p2.pub_id;

--Q8
select p.pub_name, t.title, sum(s.qty) from publishers p 
inner join titles t 
on p.pub_id = t.pub_id 
inner join sales s 
on t.title_id = s.title_id 
group by p.pub_name, t.title 

--Business Queries
--Q1
select p.pub_name , count(t.title) from publishers p
inner join titles t 
on p.pub_id = t.pub_id 
group by p.pub_name; 

--Q2
select p.pub_name , t.type, count(t."type")  as "Book Type" from publishers p
inner join titles t 
on p.pub_id = t.pub_id 
group by p.pub_name, t."type" 

--Q3
select a.au_lname , a.au_fname, avg(t.royaltyper)
from titleauthor t 
inner join authors a 
on a.au_id = t.au_id 
group by a.au_lname, a.au_fname 

--Q4
select s.stor_name, a.au_lname, a.au_fname from stores s 
inner join sales s2 
on s.stor_id = s2.stor_id 
inner join titleauthor t 
on s2.title_id = t.title_id 
inner join authors a 
on t.au_id = a.au_id 
order by stor_name 






