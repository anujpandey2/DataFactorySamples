CREATE PROC [ETL].[UpsertDimCustomer]
AS
BEGIN

Declare @FirstLoadDate DATE

set @FirstLoadDate='2024-01-01'

Declare @MaxCustomerKey INT

select @MaxCustomerKey=isnull(max(CustomerKey),0) from SalesWH.Dim.Customer

--insert into WH_TRANFORM_DATA.Dim.Customer(CustomerID,Fullname,City,CustomerKey,FromDate)
update SalesWH.Dim.Customer
set ToDate=Convert(Date,dateadd(day,-1,GetDate()))

where CustomerKey in
(
select
dm.CustomerKey

/*dm.CustomerKey,stg.CustomerID,stg.Name,stg.City,

ROW_NUMBER() OVER(ORDER BY stg.CustomerID ASC)+@MaxCustomerKey AS CustomerKey,

Convert(Date,GetDate())*/
from LKH_Bronze.dbo.Customer stg

left outer join SalesWH.Dim.Customer dm

on stg.CustomerID=dm.CustomerID and dm.ToDate is null

where stg.City<>dm.City

)

-- get the max ID again

select @MaxCustomerKey=isnull(max(CustomerKey),0) from SalesWH.Dim.Customer

insert into SalesWH.Dim.Customer(CustomerID,Fullname,City,CustomerKey,FromDate)

select stg.CustomerID,stg.Name,stg.City,

ROW_NUMBER() OVER(ORDER BY stg.CustomerID ASC)+@MaxCustomerKey AS CustomerKey,

case @MaxCustomerKey when 0 then @FirstLoadDate else Convert(Date,GetDate()) end as FromDate

from LKH_Bronze.dbo.Customer stg

left outer join SalesWH.Dim.Customer dm

on stg.CustomerID=dm.CustomerID and dm.ToDate is null

where dm.CustomerKey is null
END