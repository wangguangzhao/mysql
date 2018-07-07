视图：
视图就是一个表或多个表的查询结果，因为它并不能存储，
视图的作用和优点：
限制对数据的访问
让复杂的查询变得简单
提供数据的独立性
可以完成相同数据的不同显示
创建视图
create or replace view view_temp
	as
		select name,age from temp;
--view_temp视图名称  temp表的名称 select name,age from temp; SML语句
通常不对视图数据做修改操作，因为视图是一张虚拟表，并不存储实际数据，如果想让
视图不被修改，用with check option;
create or replace view view_temp
	as 
		select name,age from temp
		with check option;
--修改视图
alter view view_temp 
	as
		select id,name from temp
--删除视图
drop view  view_temp;
--显示创建语法
show create view view_temp;