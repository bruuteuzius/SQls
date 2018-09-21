declare @tablename nvarchar(200) = 'persons'
declare @columnnames nvarchar(max)

set @columnnames = stuff((select ', ' + c.name as [text()]
from sys.tables t 
inner join sys.columns c on c.object_id = t.object_id
where t.name = @tablename and c.name <> 'id'
for xml path('')), 1, 2, '')

declare @sql nvarchar(max) = N'
create nonclustered index ix_bjd_coveringindexxxx
on dbo._tablename_(id)  
include (
	_columnnames_
);  
'
set @sql = replace(@sql, '_tablename_', @tablename)
set @sql = replace(@sql, '_columnnames_', @columnnames)

declare @cnt int = 0;
declare @thesql nvarchar(max);
declare @rij varchar(100)


while @cnt < 900
begin
	set @thesql = replace(@sql, 'ix_bjd_coveringindexxxx', 'ix_bjd_coveringindex' + cast(@cnt as varchar(3)));
   print @thesql;
   exec sp_executesql @thesql;
   
   set @rij = 'we are at index number ' + cast(@cnt as varchar(3))
   raiserror (@rij, 0, 1) with nowait

   set @cnt = @cnt + 1;
end;



