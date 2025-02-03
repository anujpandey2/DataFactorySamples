CREATE PROC [ETL].[InsertNewFactSalesRecords]

AS

BEGIN

declare @LastETLDate Date

select @LastETLDate=max(OrderDate) from SalesWH.Fact.Sales

insert into SalesWH.Fact.Sales(CustomerKey,OrderNumber,SalesAmount,OrderDate)

select dim.CustomerKey,fact.OrderNumber,fact.SalesAmount,fact.OrderDate from LKH_Bronze.dbo.Sales fact

inner join SalesWH.Dim.Customer dim

on fact.Customer_ID=dim.CustomerID and fact.OrderDate between dim.FromDate and isnull(dim.ToDate,'9999-12-31')

where OrderDate>isnull(@LastETLDate,'1900-01-01')

END