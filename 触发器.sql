触发器：
trigger;
create trigger triggerName after|begin inset|update|delete on table1 for each row
	begin
	update table2 XXXX
		end;
例如：
create trigger g1 
after
 insert
 on org
 for each row 
 begin
	update goods set gnum=gnum -new.num where gid = new.gid;
end;
--创建监听器g1 监听事件 insert 监听表 org表  在事件发生后监听，触发事件
-- update goods set gnum=gnum -new.num where gid = new.gid; 其中new代表新插入的数据old代表旧表
--附：org代表update 或delete 的旧表
--use myshop;
--delimiter $;//delimiter 结束定界符
use myshop;
delimiter $;
create trigger g2 after delete on org for each row
	begin
	update goods set gnum=gnum+old.num where gid = old.gid;
	end;