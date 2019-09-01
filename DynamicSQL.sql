--========= Intialize Dynamic SQL =================
declare @sql nvarchar(1000)
declare @params nvarchar(1000)
set @sql= 'Select * from tblCat_Supplier '+'where Email = @Email'
set @params= '@Email nvarchar(100)'

exec sp_executesql @sql, @params, @Email='a@mail.vom'
