CREATE TABLE [Dim].[Customer] (

	[CustomerKey] int NOT NULL, 
	[CustomerID] int NOT NULL, 
	[Fullname] varchar(200) NOT NULL, 
	[City] varchar(200) NOT NULL, 
	[FromDate] date NOT NULL, 
	[ToDate] date NULL
);


GO
ALTER TABLE [Dim].[Customer] ADD CONSTRAINT PK_DimCustomer primary key NONCLUSTERED ([CustomerKey]);