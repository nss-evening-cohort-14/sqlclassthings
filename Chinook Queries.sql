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


