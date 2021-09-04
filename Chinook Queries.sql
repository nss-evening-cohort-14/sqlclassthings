---------------------------------------------------------------------------------------------------------------------
-- what artists' music do we sell that starts with the letter c? ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

select *,
	   ArtistId + 100000
from Artist
where [Name] like 'c%'  --Stuff based on matching a partial string? use Like operator

---------------------------------------------------------------------------------------------------------------------
-- how many customers are in each state? ----------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

--Count is for getting a count of either an entire table
--string_agg combines strings together in aggregate
--aliasing is done one of these ways...
select isnull([State], Country) as [Customer Location] , --with an as
	   count(*) "Number of Customers", -- without an as
	   [Customer Names] = string_agg(firstname,',') -- with an equals sign
from Customer c
--grouping based on state
--group by FirstName
--group by [State], Country
group by isnull([State], Country)

--null is a special thing, you have to use is null and is not null to compare it to things
select *
from Customer
where [state] is not null

---------------------------------------------------------------------------------------------------------------------
-- how many music tracks were purchased by each customer country? ----------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

--number of invoice lines by country
select BillingCountry, count(*)
from Invoice i
	join InvoiceLine il 
		on i.InvoiceId = il.InvoiceId
group by BillingCountry
order by 1

--number of invoices by country
select BillingCountry, count(*)
from Invoice i
group by BillingCountry
order by 1

select * 
from Invoice i
	join InvoiceLine il 
		on i.InvoiceId = il.InvoiceId
		
select *
from Invoice --customerid, billingcountry

--counting with distinct only counts unique instances of a specified field/expression
select count(distinct TrackId), count(*)
from InvoiceLine -- tracks on the invoice



--When you want only the first x number of rows, use TOP
Select top 5 *
from Invoice
order by Total desc --desc is for descending, asc is for ascending orders


-------------------------------------------------------------------------------
--------------    Subqueries    -----------------------------------------------
-------------------------------------------------------------------------------
--nesting one or more queries inside another one
-- subquery, and correlated subquery are the  two main categories

-- artists and their longest track

-- joining to a subquery
select *
From Artist a
left outer join ( select ArtistId, max(Milliseconds) LongestSongLength
		From track t 
			join Album a 
				on a.AlbumId = t.AlbumId
		group by ArtistId
	  ) maxSong
	on a.ArtistId = maxSong.ArtistId

-- correlated subquery in the select statement
select a.ArtistId, 
       a.name,
	   (select max(Milliseconds) LongestSongLength
		From track t 
			join Album al
				on al.AlbumId = t.AlbumId
		where al.ArtistId = a.ArtistId
		group by ArtistId
	  )
From Artist a


-- which artists have no tracks
-- correlated subquery in the where clause
select * 
from Artist a
where not exists (
	select 'poop'
	From track t 
		join Album al
			on al.AlbumId = t.AlbumId
	where al.ArtistId = a.ArtistId
)

--regular subquery
select * 
from Artist a
where ArtistId not in (
	select ArtistId
	From track t 
		join Album al
			on al.AlbumId = t.AlbumId
)


-------------------------------------------------------------------------------
------------  UNION, EXCEPT, UNION ALL, Intersect  ----------------------------
-------------------------------------------------------------------------------
-- combining/comparing two or more resultsets that may or may not have anything in common


--1,2,3,4,5,6,7,8,9,10
--union
--8,9,10,11,12,13,14,15
--=
--1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
	

--1,2,3,4,5,6,7,8,9,10
--except
--8,9,10,11,12,13,14,15
--=
--1,2,3,4,5,6,7

--must have the same number of columns, aliases only matter on the first set
select Email, 'Employee' as [type]
from Employee
union
select Email, 'Customer'
from Customer


--except operator, 
select ArtistId
from Artist a
except 
select ArtistId
From Album

--intersect, gives the middle portion of the venn diagram
select ArtistId
from Artist a
intersect 
select ArtistId
From Album

--
select left(FirstName,1)
from Employee
except
select left(FirstName,1)
from Customer

select left(FirstName,1)
from Customer
except
select left(FirstName,1)
from Employee


