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

