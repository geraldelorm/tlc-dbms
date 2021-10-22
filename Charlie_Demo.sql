select * from titles
fetch first 10 rows only;

select title from titles fetch first 10 rows only;
select count(*) from titles t ;

select 1 + 1;

select * from authors;

select au_fname  "First name", au_lname as "Last Name" 
from authors a
order by au_lname asc 
;

select title    from titleauthor t 
select * from publishers p ;

select title_id, title , type, ytd_sales , pubdate , price
from titles
where price::numeric not between 10 and 20;

where ytd_sales > 1000 and type = 'psychology' and pubdate > '1991-06-13'
order by ytd_sales ;

SELECT   title_id, type , price, price * 1.5 "new price", price/2 "lower price"
FROM titles 
where price is not null
and price::numeric > 20
order by price desc;

SELECT   title_id, type , price, price * 1.5 "new price", price/2 "lower price"
FROM titles 
--where price is not null
where price::numeric > 20
order by price desc;

select type, nullif(type, 'business'), type, nullif(type, 'trad_cook')
from titles;

select notes, nvl(notes, 'NO NOTES')
from titles;

SELECT concat('My name is: ', substr(au_fname,1,1),initcap(au_lname)) "Full Name", au_fname 
FROM authors a 
 where upper(au_lname) like '%I%'
order by au_lname;

select au_lname , substr
from authors a ;

select p.pub_name
from publishers AS p
where exists (
     select 1
     from   titles AS t
     where  p.pub_id = t.pub_id
     and    t.type = 'psychology'
)

;


create table list_1 (col_1 integer);
create table list_2 (col_2 integer);

insert into list_1 values (1);
insert into list_1 values (2);
insert into list_1 values (3);
insert into list_1 values (4);

insert into list_2 values (4);
insert into list_2 values (5);
insert into list_2 values (6);
insert into list_2 values (2);

select col_1 from list_1
union all
select col_2 from list_2
;

create view pubtitles
as
select t.title_id, t.title, t.type, 
       t.price, t.pubdate, p.pub_id, p.pub_name
from titles AS t inner join publishers AS p
on t.pub_id = p.pub_id
;

create view NYAuthors (FName, LName, City, State)
as
select au_fname, au_lname, city, state
from authors
where state = 'NY'
;

select pub_name, title
from pubtitles
;
commit;
update titles set ytd_sales = null where type = 'UNDECIDED';
select title, price from titles;

select title_id,qty
from sales;



select distinct price 
from titles ;

3 -- select
1 -- from
2 -- where
4 -- group by
5 -- having
6 -- order by

select title, price
from titles t2 
where price is not null
order by price desc
fetch first 3 rows only;


select 2+3;

select title, price, pubdate, type, advance, royalty
 from (select title, price, pubdate, type, advance, royalty
from titles 
where price is not null
order by price desc 
fetch first 5 rows only) top_5
order by pubdate;

where price::numeric between 20 and 10;

20<= price <=10



select type, advance
from titles
--order by advance;
where  advance::numeric < 5000;

create table table (col1 date);

select au_id, au_fname, au_lname, state 
from authors 
where au_lname like '_ing%';

select distinct state from authors;
where state not in ('CA', 'MD');

select title, type,
case type 
      when 'business' then 'Business' 
      when 'mod_cook' then 'Modern Cooking' 
      when 'UNDECIDED' then 'null'
      when 'popular_comp' then 'Popular Computing' 
      when 'psychology' then 'Psychology' 
      when 'trad_cook' then 'Traditional Cooking' 
      else 'Unknown type' 
     end AS decoded_type
    from titles ;
    
select distinct state 
from authors a; 

select au_lname , au_fname , state 
from authors a 
where state = 
   
select price
from titles t
where price::numeric > 1;
where price is not null;

select * from titles;

   select title, type, nullif(type,'business')
   from titles;
   select * from titles a ;
  update titles set ytd_sales = 500 where title_id ='MC3026';
 
 
 
 
select month(current_date)

select  	date '2021-10-19' + integer '7';

SELECT pubdate, EXTRACT(YEAR from pubdate), extract (day from pubdate) from titles;

select 	current_date as "Todays Date", 
	current_date + 7 AS "Next Week"


select 	extract (year from current_timestamp) AS Year,
	extract (month from current_timestamp) AS Month,
	extract (day from current_timestamp) AS Day,
	extract (hour from current_timestamp) AS Hour,
	extract (minute from current_timestamp) AS minute
	

 
  select royalty,ytd_sales ,coalesce(royalty,ytd_sales,78) as "column Alias"
  from titles t; 
  
  select pubdate, extract(month from pubdate) as month_part ,extract(day from pubdate)  as day_part, extract(year from pubdate)  as year_part
  from titles t; 
  
 select title, translate(title, 'def', 'abc') as translated
 from titles t ;
  
  select current_timeom pubdate),pubdate
  from titles;
  
 select price, ceiling(price::numeric)
 from titles;
 
 select au_fname, upper(au_fname) , lower(au_fname), upper(substr(au_fname, 1,3)), substr(au_fname, 1,1) || ' ' || au_lname 
from authors
where
group by 
having
order by;
 
 
 select current_timestamp;
 
select 'Charlie';

desc titles;



-- Hector question:

select title, price, pubdate, type, advance, royalty
 from (select title, price, pubdate, type, advance, royalty
from titles 
where price is not null, 
order by price desc fetch first 5 rows only) Mickey_Mouse
order by pubdate;


select min(price::numeric), max(price::numeric), avg(price::numeric), sum(price::numeric), count(price), count(*), ((sum(price::numeric))/count(title)) man_avg
from titles;

select coalesce (price::numeric, 0), price
from titles;

select type,pubdate,  max(coalesce (price::numeric, 0))         --3
from titles                                                     --1
where type like '%cook%'                                        --2
group by type, pubdate                                          --4
having max(coalesce (price::numeric, 0)) > 15                   --5
order by type;                                                  --6

having is a where-clause for aggregate functions

select * from publishers;
select * from titles;

select  max(price::numeric)
from titles;

select t.title, p.pub_name, a.au_fname||' ' || a.au_lname 
from titles t  join publishers p   on t.pub_id = p.pub_id
join titleauthor ta on t.title_id = ta.title_id 
join authors a  on a.au_id = ta.au_id 
order by t.pub_id;

select s.stor_id, s.ord_date, t.title, t.pubdate
from titles t  join sales s 
on t.pubdate < s.ord_date;

select s.stor_name, p.pub_name
from stores s join publishers p
on s.state = p.state ;

select coalesce(t.title, 'no titles by this publisher'), p.pub_name
from titles t right outer join publishers p   
     on t.pub_id = p.pub_id
order by t.pub_id;

select d.discounttype, s.stor_name
from discounts d  right outer join stores s
on d.stor_id = s.stor_id ;

select t.title, p.pub_name
from titles t  , publishers p   
--     on t.pub_id = p.pub_id
order by t.title ;
