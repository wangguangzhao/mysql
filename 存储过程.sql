procedure：存储过程；

use test;
delimiter $;
create procedure p2( in n int )
begin
	declare total int default 0 ;
	declare num  int default 0;
	while num < n do
		set num := num+1;
		set total := total+num;
    end while;
	select total;
end;


use test;
set @num = 50;
call p2(@num);




delimiter $;
create procedure p3(in n int ,out total int )
begin
	declare num int default 0;
	set total:=0;
	while num<n do 
     set num := num+1;
	set total := total+num;
    end while;
	
end;


 use test;
call p4(100,@total);
select @total;


 use test;
 delimiter $;
create procedure p5(inout age int)
begin
	set age := age + 20;
end; 


 use test;
set @total = 100;
call p5(@total);
select @total;

use test;
delimiter $;
create procedure p6(in peo int)
	begin
		case peo
			when 1 then select "select 1";
			when 2 then select "select 2";
			when 3 then select "select 3";
			when 4 then select "select 4";
			else select "no select";
			end case;
	end;

call p6(1);