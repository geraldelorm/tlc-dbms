select CONVERT ('2020-05-07', SQL_DATE) + 31


select cast(pubdate as char(20)), convert('2020-10-15', SQL_DATE)+31 from titles

select current_date

SELECT title,  DAY(pubDate), YEAR(pubDate), HOUR(pubDate), MINUTE(pubDate) FROM titles;

select month(current_date)

select  	date '2001-09-28' + integer '7'

SELECT EXTRACT(YEAR from pubdate), extract (day from pubdate) from titles;
select 	current_date as "Todays Date", 
	current_date + 7 AS "Next Week"


select 	extract (year from current_timestamp) AS Year,
	extract (month from current_timestamp) AS Month,
	extract (day from current_timestamp) AS Day,
	extract (hour from current_timestamp) AS Hour,
	extract (minute from current_timestamp) AS minute
	

select qty, price,
    CEILING(qty),       -- round up to nearest $1
    ROUND(qty, -1)       -- round naturally to nearest $1
from sales;

select price from titles;

SELECT '52093.89'::money::numeric::float8;

select 
    CEILING(price::money::numeric),       -- round up to nearest $1
    ROUND(price::money::numeric, 0)       -- round naturally to nearest $1
from titles;

SELECT '12.34'::numeric::money;
SELECT '12.34'::money::numeric;

select 
    UPPER(title),
    LOWER(title)
from titles;

select 
    TRANSLATE(title, 'def', 'abc') 
from titles;

select substr (au_fname, 1, 1), au_lname
from authors
where state != 'CA';

select count(*), 
from authors
where state != 'CA';

select au_fname || ' ' || au_lname AS "Full Name"
from authors;

-- does not work
select au_fname + ' ' + au_lname AS "Full Name"
from authors;
select coalesce(ytd_sales,0) from titles;

update titles set advance= null where title_id = 'MC3026';

select ytd_sales, royalty,   coalesce(ytd_sales, royalty, 17)
from titles;
select * from titles;
select count(ytd_sales) ,count(coalesce(ytd_sales,0)) ,count(*), avg(coalesce(ytd_sales,0)), avg(ytd_sales)
from titles ;

select type, max(ytd_sales) AS "Total Sales"
from titles
group by type;

select title, type, price from titles;
having max(ytd_sales) between 3000 and 5000
order by "Total Sales";

select avg (advance::numeric),  max (price::numeric) "Highest Price"
from titles;

select max (price::numeric)
from titles;
select min (pubdate)
from titles;
select avg(price::numeric) as avg_price,avg (coalesce (price::numeric, 0)) as coalesced_price, avg(advance::numeric) as avg_adv, max(price::numeric) as max_price, max(advance::numeric) as max_adv
from titles;

select avg (coalesce (price::numeric, 0))
from titles;

select price, type from titles;

select count (price) 
from titles; 

select count (distinct price) 
from titles 

select type, max(price) , pubdate
from titles
group by type, pubdate 
order by type, pubdate ;


select type from titles ;


select type, max(price), pubdate
from titles
group by type, pubdate
order by type ;

select type, max (advance)
from titles
group by type;

select 3
from   1
where  2
group by 4 
having 5 
order by 6 
fetch first 7

select stor_id, ord_num, sum(qty) AS "Total Qty"
from sales
--where sum(qty) > 50
group by stor_id, ord_num
having sum(qty) > 50
order by "Total Qty";


 3 -- select
 1 -- from
 2 -- where
 4 -- group by
 5 -- having
 6 -- order by

select type, max(ytd_sales) AS "Total Sales"
from titles
--max(ytd_sales) between 4000  and 5000
group by type
having max(ytd_sales) between 4000  and 5000 -- (a where clause for aggregates)
order by "Total Sales"

select rownumber() over() as id, title
from titles;

select type, max(price)
from titles
group by type

select type, max (advance)
from titles

select stor_id, ord_num, sum(qty) AS "Total Qty"
from sales
group by stor_id, ord_num
having sum(qty) > 50
order by "Total Qty";





select pub_id, pub_name  from publishers p ;
union
select pub_id, 'titles' from titles t order by 2 
;


select a.au_lname "Author last Name", p.pub_name as "Publisher", t.title as "Title" , p.pub_id "Publisher id", t.pub_id "Title pub id"
from publishers p , titles t ,titleauthor t2 , authors a ;
--where t.pub_id = p.pub_id
--and t2.title_id = t.title_id 
--and t2.au_id = a.au_id ;

--select now()= current_timestamp;

select a.au_lname "Author last Name", p.pub_name as "Publisher", t.title as "Title" 
from publishers p inner join titles t 
 on t.pub_id = p.pub_id
inner join titleauthor t2 
 on t2.title_id = t.title_id 
inner join authors a 
 on t2.au_id = a.au_id ;


select  p.pub_name as "Publisher", t.title as "Title" , p.pub_id "pub id", t.pub_id " t.pubid"
from titles t full join publishers p ;


inner join titleauthor t2 
 on t2.title_id = t.title_id 
inner join authors a 
 on t2.au_id = a.au_id ;

select pub_id "titles pub id" from titles;
select pub_id  "pub puibid" from publishers p ;

select d.discounttype , s.stor_name
from discounts d full outer join stores s
on d.stor_id = s.stor_id ;

select * from stores s; 

select distinct pub_id from titles t ;

select count(*) from titles where pub_id not in (select pub_id from publishers);

select t.title_id, t.pub_id, p.pub_name
from titles t , publishers p;
select count(*) from publishers p ;

    where t.pub_id = p.pub_id;
   
select p.pub_name, substr(pi.pr_info, 1, 60)
from pub_info pi right join publishers p
on(p.pub_id = pi.pub_id);
--limit 4 ;

select discounttype, stor_name
from discounts AS d full outer join stores AS s
   on (d.stor_id=s.stor_id)
   
   select title_id, pub_id
from titles inner join publishers
    on titles.pub_id = publishers.pub_id

    
    select title_id, t.pub_id, pub_name
from titles AS t inner join publishers AS p
    on t.pub_id = p.pub_id

select title, au_fname, au_lname
from
   titles AS t inner join titleauthor AS ta 
      on t.title_id = ta.title_id
         inner join authors a
            on ta.au_id = a.au_id;
            
select t.title_id, t.title, sum (t.price * s.qty)
from titles AS t inner join sales AS s
    on t.title_id = s.title_id
group by t.title_id;

select discounttype, stor_name, state
from discounts d, stores s
where
    d.stor_id = s.stor_id and s.state in ('MA', 'WA')
    
    select discounttype, stor_name, state from discounts AS d left outer join stores AS s    on d.stor_id = s.stor_id and s.state in ('MA', 'WA')
    
    select discounttype, stor_name, state from discounts AS d left outer join stores AS s    on d.stor_id = s.stor_id
where s.state in ('MA', 'WA')

select 'hello world' 

select * from sales
where ord_date not between '1993-01-01' and '1993-12-31';
select * from titles where pub_id in ('0877', '1389', '0736');
select 'my name is '|| au_fname from authors;

select * from titles where price is null;

select ord_date, to_char(ord_date, 'Day ddth Month yyyy') from sales;


select age('2020-04-01', '2012-03-05') as age,
       date_part('year',age('2020-04-01', '2012-03-05')) as year,
       date_part('month',age('2020-04-01', '2012-03-05')) as month,
       date_part('day',age('2020-04-01', '2012-03-05')) as day;



select cast(price as float) from titles t 
4 - functions-----------------------------------

select current_date;
select current_time;
select current_date;
select ('2018-09-26'::date);
select ('2018-09-26'::timestamp);
select days('2018-01-09')

select ('2018-12-25'::date) - ('2018-09-26'::date)

select (current_date - pubdate) days_between
from titles;

select extract(year from pubdate), pubdate
from titles;

select extract(day from pubdate), pubdate
from titles;

select (current_date - '2011-01-01'::date) + pubdate, pubdate
from titles;

select extract(days from )

select encode(au_fname , 'hex')
from authors;
