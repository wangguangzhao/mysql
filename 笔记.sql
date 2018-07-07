mysql 笔记
 1.查看存储过程；
 show procedure status;
 2.查看存储过程内容
 show create procedure procedurename;

#存储过程
\d //
create procedure p2()
begin
set @i =3;
while @i<=100 do
insert into t1(name) values(concat("user",@i));
set @i = @i+1;
end while;
end;
\d ;