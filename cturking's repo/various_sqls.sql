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


---------  Subqueries --------------------------
-- when writing subqueries - ALWAYS write and get to work the subquery first.
select city
from publishers
where pub_id = '1389'
;

select au_fname, city
from authors
where city = (
   select city
   from publishers
   where pub_id = '1389'
);

SELECT type, title, price 
FROM titles AS t1 
WHERE price > ALL ( 
    SELECT t2.price 
    FROM titles AS t2
    WHERE type = 'business') 
;


SELECT type, title, price 
FROM titles AS t1 
WHERE price >  ( 
    SELECT max(t2.price) 
    FROM titles AS t2
    WHERE type = 'business') 
;
SELECT type, title, price 
FROM titles AS t1 
WHERE price > ANY ( 
    SELECT price 
    FROM titles AS t2
    WHERE type = 'business') 
;

select title
from titles
where title_id in (
   select title_id
   from sales
   where qty > 20
)
;

select title_id, price
from titles
where price::numeric > (
   select avg (price::numeric)
   from titles
)

;
-- both corrolated (because innner and out queries are joined) AND in-line view (because it is in the select statement)
SELECT a.au_fname, a.au_lname, a.city,
     (SELECT COUNT(*) -1
      FROM authors AS others 
      WHERE others.city = a.city ) AS Neighbours 
FROM authors AS a
;
select au_lname , city from authors a ;

SELECT au_fname, au_lname 
FROM authors 
WHERE EXISTS 
       ( SELECT 1 
         FROM publishers 
         WHERE publishers.city = authors.city )
         ;
 
select type, BookCount 
from (select type, count(*) as BookCount 
      from titles 
      group by type) as BooksByType 
where BookCount > 3
;
--------------Set operators------------------------

drop table list_1;
drop table list_2;
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
 select * from list_1;

select col_2::character , 'CT' from list_2
union all       -- except = minus
select 'AB', col_1::character from list_1
;

customer_emea, customer_amer, customer_apac -- bring them all into my data warehouse in one query
insert into wh_table.....
select ......
from customer_emea
union all
select ......
from customer_amer
union all
select ......
from customer_apac


-------------------Views---------------------
create  view pubtitles
as 
select t.title_id, t.title, t.type, 
       t.price, t.pubdate, p.pub_id, p.pub_name
from titles AS t inner join publishers AS p
on t.pub_id = p.pub_id
;
select * from pubtitles p ;

create or replace view buss_titles 
as select title_id, title, type 
from pubtitles p 
where type = 'business';

select * from buss_titles ;

create or replace view NYAuthors (FName, LName, City, State)
as
select au_fname, au_lname, city, state
from authors
where state = 'NY'
;

select pub_name, title
from pubtitles
order by title
;
select MAX(PRICE) from pubtitles p; 

select * from pubtitles p  where title like 'Sushi, Anyone?%';
update titles  set title = 'Sushi, Anyone? - Yes PLEASE' where title = 'Sushi, Anyone?';

----------------Updating Data----------------------------------
create table ct_publishers as select * from publishers;  -- CTAS  create table as select  ... where 1=2 to give me an empty table;
select * from ct_publishers ;
insert into ct_publishers (pub_id, pub_name, city, state, country) 
values ('007','New world Publishers', 'City of London','UK','United Kingdom' );
select * from ct_publishers cp ;

update ct_publishers set city = 'London' where pub_id ='007';
delete from  ct_publishers ;
insert into ct_publishers select * from publishers;

update titles set pub_id = '007';

create table test as select pub_id, pub_name, city, state, country, 'ABC'  from publishers p ;



-----------------Creating Tables-------------------------------
drop table if exists accounts;

create table accounts (
    id int generated by default as identity,
    name varchar(100) not null,
    balance dec(15,2) not null,
    primary key(id)
);

insert into accounts(name,balance)
values('Bob',10000);

insert into accounts(name,balance)
values('Alice',10000);

drop table t1;
CREATE TABLE t1
(c1 CHAR(30),
 c2 INT,
 c3 INT NOT NULL GENERATED ALWAYS as identity
     (START WITH 100 INCREMENT BY 5));

    insert into t1 values ('Charlie', 3, default);
  select * from t1;

 
drop table publishers;
---------------PLpgSQL---------------------------------
drop table if exists accounts;

create table accounts (
    id int generated by default as identity,
    name varchar(100) not null,
    balance dec(15,2) not null,
    primary key(id)
);

insert into accounts(name,balance)
values('Bob',10000);

insert into accounts(name,balance)
values('Alice',10000);

select * from accounts;

create or replace procedure transfer(
   sender int,
   receiver int, 
   amount dec
)
language plpgsql    
as $$
begin
    -- subtracting the amount from the sender's account 
    update accounts 
    set balance = balance - amount 
    where id = sender;

    -- adding the amount to the receiver's account
    update accounts 
    set balance = balance + amount 
    where id = receiver;

    commit;
end;$$
--
;
call transfer(1,2,1000);

SELECT * FROM accounts;


create or replace procedure transfer_if(
   sender int,
   receiver int, 
   amount dec
)
language plpgsql    
as $$
declare 
  v_name 	accounts.name%type;
  v_balance accounts.balance%type;
begin
	select name, balance
	into v_name, v_balance
	from accounts
	where id = sender;

	if not found then 
		raise notice 'Account Not Found';
	else
		if v_balance > amount then
    -- subtracting the amount from the sender's account 
 	      update accounts 
    	  set balance = balance - amount 
    	  where id = sender;

    -- adding the amount to the receiver's account
	      update accounts 
	      set balance = balance + amount 
	      where id = receiver;
	      commit;
		else
		  raise notice 'Not enough funds to perform transfer';
		end if;
	end if;

end;$$
;
--call stored_procedure_name(argument_list);

call transfer_if(1,2,1000);

SELECT * FROM accounts;
