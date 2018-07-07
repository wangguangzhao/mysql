--约束：
	unique 唯一性约束； 创建表时给字段加上unique 唯一性约束同时创建了一个唯一索引。
	create table temp (
        id int not null,
        name varchar(25),
        password varchar(16),
        --使用表级约束语法，
        constraint uk_name_pwd unique(name, password)--組合約束 
);	
			例：用户名和密码不能重复 alter table temp add unique(name, password);
	not null 非空约束   指定字段不能为空
	primary key 主键约束；相当于唯一性约束和非空约束的组合主键不允许重复
	alter table temp drop primary key --删除逐渐约束
	alter table temp add primary key(name,pwd);--添加主键约束
	alter table temp modify id int primary key;--修改主键
	AUTO_INCREMENT= id;--设置逐渐自增
	foreign key 外键约束；--保证一个或两个表之间的参照完整性，外键是构建在一个表中的两个字段或者连个表中的连个字段之间的。
	也就是从表的外键值必须在主表中能找到或者为空。
	当主表的记录被从表参照时，主表的记录将不允许删除，如果要删除数据，需要先删除从表中依赖该记录的数据，
	然后才可以删除主表的数据。还有一种就是级联删除子表数据。
	注意：外键约束的参照列，在主表中引用的只能是主键或唯一键约束的列，假定引用的主表列不是唯一的记录，
	那么从表引用的数据就不确定记录的位置。同一个表可以有多个外键约束。
	例如：
	use mysqltest;
	/*创建主表*/
	create table Classes(
		id int auto_increment primary key not null,
		name varchar(20)
	)engine=InnoDB DEFAULT charset=utf8;
	/*创建从表*/
	create table Student(
		id int auto_increment primary key,
		name varchar (25),
		classes_id int,
		foreign key (classes_id) references Classes(id)
	)engine=InnoDB default charset=utf8;
	通常先建主表，然后再建从表，这样从表的参照引用的表才存在。
	删除时则相反。
	alter table Student drop foreign key classes_id --删除外键约束
	alter table Student drop foreign key (classes_id) references Classes(id) --创建外键约束。
	级联删除：删除主表的数据时，关联的从表数据也删除，则需要在建立外键约束的后面增加on delete cascade
	create table student(
        id int auto_increment primary key,
        name varchar(20),
        classes_name varchar(20),
        classes_number int,
        /*表级别联合外键*/
        foreign key(classes_name, classes_number) references classes(name, number) on delete cascade
);
	check 制定一个表达式用于检验指定数据
