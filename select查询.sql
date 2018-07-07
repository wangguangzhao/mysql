--对查询的数据进行运算操作
select age+2,age/2,age-2,age*2 from temp where age-2>22;
select sore+1 from  sorce where sore+1>50;
--concat()函数链接连个字符串
concat():
select name from  sorce  where name=concat('张','是');--查询出名字为'张是'的数据。
--as 对列重命名
as:
select name as username  from  sorce  where name=concat('张','是');--查询显示的列名变为username；
select name as "`姓名`"  from  sorce  where name=concat('张','是');--as也可以省略不写，效果一样
--如果重命名的列名出现特殊字符，如“‘”单引号，那就需要用双引号引在外面
distinct():
select count(distinct(sore)) from sorce --distinct()函数去除sore中的重复数据 （相同的sore只显示一个）
select distinct id, age from temp;  --dostinct去除多列重复数据；
 where 条件查询 大于>、大于等于>=、小于<、小于等于<=、等于=、不等于<> 都可以出现在where语句中
where:
select * from t where a > 2 or a >= 3 or a < 5 or a <= 6 or a = 7 or a <> 0;
and 并且
and:
select * from temp where age > 20 and name = ‘jack’;--查询名称等于jack并且年龄大于20的
 or 或者
 or:
 select * from tmep where name = ‘jack’ or name = ‘jackson’;--两个条件满足一个即可
 between v1 and v2
 select * form temp where age between 20 and 25;--大于等于v且小于等于v2
 in 查询 可以多个条件 类似于or	
 in:
 select * from temp where id in (1, 2, 3);查询id在括号中出现的数据
 like 模糊匹配 
 select * from temp where name like 'j%';--name以j开头的数据
 select * from temp where name like '%j';--name以j结尾的数据
 select * from temp where name like '%j%';--name中带j的数据
 escape转义
 select * from temp where name like '%\_%' escape '\\'; --默认支持\/转义
 is null、is not null
 --查询为null的数据
 select * from temp where name is null;
 --查询不为null的数据
 select * from temp where name is not null;
  not：
  select * from temp where not (age > 20);--取小于等于20的数据
  select * from temp where id not in(1, 2);
  order by：
  排序，有desc、asc升序、降序
  支持多字段
  select * from temp order by name age desc;