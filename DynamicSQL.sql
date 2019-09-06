--========= Intialize Dynamic SQL =================
declare @sql nvarchar(1000)
declare @params nvarchar(1000)
set @sql= 'Select * from tblCat_Supplier '+'where Email = @Email'
set @params= '@Email nvarchar(100)'

exec sp_executesql @sql, @params, @Email='a@mail.vom'
--exec sp_executesql @sql, @params, 'a@mail.vom'

/*  ============== NOTE : Start =============
to execute the dynamic sql use systemprocedure sp_executesql . it takse two pre-defined 
@statement = the first parameter which is mandatory
@params = this is the second parameter , its used to declare paramter 
============== NOTE : End ============= */ 

---================= Example 1 : Start ========================
Alter procedure prcGerProduct @dbname nvarchar(max), @tbl nvarchar(max), @topN int, @byColumnd nvarchar(max)
as
Begin
	declare 
			@sql nvarchar(max),
			@topNStr nvarchar(max)

	set @topNStr = CAST(@topN as nvarchar(100));

--- construct SQL
	set @sql= 'select top '+ @topNStr +
				' * from '+ QUOTENAME(@dbname) +
					'.dbo.'+ QUOTENAME(@tbl) +
						' order by '+QUOTENAME(@byColumnd)
--- print SQL
	print @sql
--- execute the SQL
	exec sp_executesql @sql

End
---================= Example 1 : End ========================


---================= Example 2 : Start ========================
alter PROCEDURE prcExec2 @tblname nvarchar(127),
                                 @key     varchar(10) AS
EXEC('SELECT CustomerId, CompanyName, ContactName
      FROM ' + @tblname + '
      WHERE companyid = '''' + @key + ''''')
	  --print @key
---================= Example 2 : End ========================
