``` CREATE procedure prcStatic_SearchOrders_1
	@OrderID nvarchar(200)		= null ,
	@CustomerID nvarchar(200)	= null ,
	@CustomerName nvarchar(200)	= null ,
	@ProductName nvarchar(200)	= null ,
	@EmployeeID nvarchar(200)	= null , 
	@FromDate	datetime		= null ,
	@ToDate		datetime		= null ,
	@MinPrice	datetime		= null ,
	@MaxPrice	datetime		= null ,
	@ShippedDate nvarchar(200)	= null ,
	@ShipName nvarchar(200)		= null ,
	@ShipAddress nvarchar(200)	= null ,
	@ShipCity nvarchar(200)		= null ,
	@ShipRegion nvarchar(200)	= null as
	
	Select  A.OrderID, A.OrderDate, E.UnitPrice, E.Quantity,C.CustomerID, C.CompanyName, C.Address, C.City, C.Region,
			C.PostalCode, C.Country, C.Phone, F.ProductID, F.ProductName, F.UnitsInStock, F.UnitsOnOrder
	from	Orders A
	join	Customers C on A.CustomerID =  C.CustomerID
	join	employees D on A.EmployeeID =  D.EmployeeID
	join	[Order Details] E on A.OrderID = E.OrderID
	join	Products F on E.ProductID =  E.ProductID
		WHERE	(A.OrderID = @OrderID OR @OrderID IS NULL)
		AND	(A.OrderDate >= @FromDate OR @FromDate IS NULL)
		AND	(A.OrderDate <= @ToDate OR @ToDate IS NULL)
		AND	(A.CustomerID >= @CustomerID OR @CustomerID IS NULL)
		AND (F.UnitPrice >= @MinPrice OR @MinPrice IS NULL)
		AND (F.UnitPrice <= @MaxPrice OR @MaxPrice IS NULL)
		AND (A.ShipRegion = @ShipRegion OR @ShipRegion IS NULL)
		AND (C.CompanyName LIKE @CustomerName + '%' OR @CustomerName IS NULL)
		AND (F.ProductName LIKE @ProductName + '%' OR @ProductName IS NULL) 
	ORDER	BY A.OrderID ```
### Recompile
Forcing a recompile every time with OPTION (RECOMPILE) can add too much load to the system, 
The TOP 200 for the search on customer name limits the output

Difference between static vs dynamic sql
(loading...)

### And condition use 
 	WHERE	(A.OrderID = @OrderID OR @OrderID IS NULL)
		AND	(A.OrderDate >= @FromDate OR @FromDate IS NULL)
		AND	(A.OrderDate <= @ToDate OR @ToDate IS NULL)
		AND	(A.CustomerID >= @CustomerID OR @CustomerID IS NULL)
		AND (F.UnitPrice >= @MinPrice OR @MinPrice IS NULL)
		AND (F.UnitPrice <= @MaxPrice OR @MaxPrice IS NULL)
		AND (A.ShipRegion = @ShipRegion OR @ShipRegion IS NULL)
		AND (C.CompanyName LIKE @CustomerName + '%' OR @CustomerName IS NULL)
		AND (F.ProductName LIKE @ProductName + '%' OR @ProductName IS NULL)
      
here AND  (c.Region = @region OR @region IS NULL)
The effect of all the @x IS NULL clauses is that if an input parameter is NULL, then the corresponding AND condition is always true.

3. coalesce()
==========
coalesce() is a function that takes a list of values as argument, and returns the first non-NULL value in the list,  

### ORDER BY USE CASE CONDITION 
4. ``` ORDER BY CASE @sortcol WHEN 'OrderID'   THEN o.OrderID
                       WHEN 'EmployeeID'   THEN o.EmployeeID
                       WHEN 'ProductID'    THEN od.ProductID
         END,
         CASE @sortcol WHEN 'CustomerName' THEN c.CompanyName
                       WHEN 'ProductName'  THEN p.ProductName
         END,
         CASE @sortcol WHEN 'OrderDate'    THEN o.OrderDate 
         END ```

## Why Dynamic SQL?
It might as well be said directly: solutions with dynamic SQL require more from you as a programmer. Not only in skill, but foremost in discipline and understanding of what you are doing. Dynamic SQL is a wonderful tool when used correctly, but in the hands of the unexperienced it far too often leads to solutions that are flawed and hopeless to maintain.

### That said, the main advantages with dynamic SQL are:

Dynamic SQL gives you a lot more flexibility; as the complexity of the requirements grows, the complexity of the code tends to grow linearly or less than so.
Query plans are cached by the query string, meaning that commonly recurring search criterias will not cause unnecessary recompilations.

### The disadvantages with dynamic SQL are:

1. I said above, poor coding discipline can lead to code that is difficult to maintain.
2. Dynamic SQL introduces a level of difficulty from the start, so for problems of low to moderate complexity, it's a bit of too heavy artillery.
Because queries are built dynamically, 
3. testing is more difficult, and some odd combination of parameters can prove to yield a syntax error when a poor user tries it.
4. You need to consider permissions on the tables accessed by the dynamic SQL since users do not get permission just because the code in a stored procedure; it does not work that way.
   Caching is not always what you want; sometimes you want different plans for different values of the same set of input parameters
   
  ### ASSIGNMENT-1
```  USE [DevSkillExample]
GO
/****** Object:  StoredProcedure [dbo].[prcDynamic_search_Assignment1]    Script Date: 9/11/2019 12:23:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[prcDynamic_search_Assignment1]
	@PageIndex		int 						 ,
	@PageSize		int 						 ,	
	@Id				int					=	null ,
	@ProdName		nvarchar(200)		=	null ,
	@Price			money				=	null ,
	@MinPrice		money				=	null ,
	@MaxPrice		money				=	null ,
	@Description	nvarchar(200)		=	null ,
	@ImageUrl		nvarchar(200)		=	null ,
	@Category		nvarchar(200)		=	null ,
	@Rating			decimal				=	null ,
	@Weight			decimal				=	null ,
	@IsActive		bit					=	null ,
	@Width			nvarchar(200)		=	null ,
	@Height			nvarchar(200)		=	null,
	@Debug			bit					=	0	 AS

DECLARE @sql        nvarchar(MAX),                                 
        @paramlist  nvarchar(4000),                                
        @nl         char(2) = char(13) + char(10)      

SELECT @sql='WITH Product_Page_IndexSize 
     AS (SELECT *,
                Row_number() OVER(ORDER BY Id) AS  IndexRow
         FROM product)'

SELECT @sql = @sql+	
		'SELECT	*
		FROM	Product_Page_IndexSize WHERE  IndexRow BETWEEN ('
		+CONVERT(nvarchar(20), @PageIndex)+' - 1 ) * '
		+CONVERT(nvarchar(20),@PageSize)+' + 1 AND '
		+CONVERT(nvarchar(20),@PageIndex)+' * '
		+CONVERT(nvarchar(20),@PageSize)+' and 1 = 1' + @nl  


IF @Id IS NOT NULL                                            
SELECT @sql += ' AND Id = @Id' +  @nl                   
                                                                                               
IF @ProdName IS NOT NULL                                           
   SELECT @sql += ' AND Name LIKE  @ProdName + ''%''' + @nl          
                                                                   
IF @minprice IS NOT NULL                                           
   SELECT @sql += ' AND Price >= @minprice'  + @nl  

IF @maxprice IS NOT NULL                                           
   SELECT @sql += ' AND Price >= @maxprice'  + @nl             
                                                                   
IF @Price IS NOT NULL                                           
   SELECT @sql += ' AND Price = @price'  + @nl          
                                                                                                                                      
IF @Description IS NOT NULL                                           
   SELECT @sql += ' AND Description LIKE @Description + ''%''' + @nl
                                                                   
IF @ImageUrl IS NOT NULL                                               
   SELECT @sql += ' AND ImageUrl = @ImageUrl' + @nl
                                                                    
SELECT @sql += ' ORDER BY Id' + @nl                         
   		                                                                   
IF @debug = 1                                                      
   PRINT @sql   
                                                                                                     
SELECT @paramlist = '@Id			int,				                   
                     @ProdName		nvarchar(200),	                   
                     @Price			money,			                   
                     @MinPrice		money,			                   
                     @MaxPrice		money,			                   
                     @Description	nvarchar(200),	                   
                     @ImageUrl		nvarchar(200),	                   
                     @Category		nvarchar(200),	                   
                     @Rating		decimal,			                   
                     @Weight		decimal,			                   
                     @IsActive		bit,				                   
                     @Width			nvarchar(200),	                   
                     @Height		nvarchar(200)'	             
          			   
                                                                   
EXEC sp_executesql @sql, @paramlist, @Id, @ProdName, @Price, @MinPrice, @MaxPrice, @Description, 
				  @ImageUrl, @Category, @Rating, @Weight, @IsActive, @Width, @Height ```
