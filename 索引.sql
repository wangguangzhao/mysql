Ø 索引
索引是存放在模式（schema）中的一个数据库对象，索引的作用就是提高对表的检索查询速度，
索引是通过快速访问的方法来进行快速定位数据，从而减少了对磁盘的读写操作。
索引是数据库的一个对象，它不能独立存在，必须对某个表对象进行依赖。
提示：索引保存在information_schema数据库里的STATISTICS表中。
创建索引方式：
自动：当表上定义主键约束、唯一、外键约束时，该表会被系统自动添加上索引。
手动：手动在相关表或列上增加索引，提高查询速度。
删除索引方式：
自动：当表对象被删除时，该表上的索引自动被删除
手动：手动删除指定表对象的相关列上的索引
索引类似于书籍的目录，可以快速定位到相关的数据，一个表可以有多个索引。
创建索引：
create index idx_temp_name on temp(name);
组合索引：
create index idx_temp_name$pwd on temp(name, pwd);
删除索引：
drop index idx_temp_name on temp;

CREATE TABLE `personinfo` (
  `uid` int(50) NOT NULL AUTO_INCREMENT COMMENT '通讯录人员编号',
  `userid` varchar(50) DEFAULT NULL COMMENT '用户编码',
  `empcode` varchar(240) DEFAULT NULL COMMENT '员工工号',
  `emptype` varchar(150) DEFAULT NULL COMMENT '员工类别（1表示HR正式人员；2表示非HR人员；3渠道人员；7表示业务帐号）',
  `persontype` varchar(150) DEFAULT NULL COMMENT '人员类别（正式/临时/社会渠道）',
  `name` varchar(240) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `position` varchar(150) DEFAULT NULL,
  `mobilephone1` varchar(150) DEFAULT NULL,
  `mobilephone2` varchar(150) DEFAULT NULL,
  `officephone` varchar(150) DEFAULT NULL,
  `fax` varchar(60) DEFAULT NULL,
  `companycode` varchar(50) DEFAULT NULL,
  `departmentcode` varchar(50) DEFAULT NULL,
  `orgcode` varchar(50) DEFAULT NULL,
  `mainsite` varchar(50) DEFAULT NULL COMMENT '所属省份简称',
  `roomnumber` varchar(150) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `secretary` varchar(150) DEFAULT NULL,
  `userstatus` varchar(10) DEFAULT NULL COMMENT '用户状态（active,delete,disable）',
  `retireflag` varchar(50) NOT NULL DEFAULT '0' COMMENT '离职标志（0－正常，1－已经离职， 2 - 暂时冻结）',
  `isaddbyperson` int(11) NOT NULL DEFAULT '1',
  `adduid` varchar(50) DEFAULT NULL,
  `isdisplay` int(11) NOT NULL DEFAULT '1',
  `personsort` int(11) NOT NULL DEFAULT '999',
  `headimg` varchar(150) DEFAULT NULL,
  `descr` text,
  `headquartersvisible` tinyint(2) DEFAULT '1',
  `islock` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `hrempcode` varchar(240) DEFAULT NULL,
  `managerid` int(11) DEFAULT '4',
  `orgname` varchar(600) DEFAULT NULL,
  `secid` varchar(200) DEFAULT NULL,
  `secfax` varchar(200) DEFAULT NULL,
  `secmobile` varchar(200) DEFAULT NULL,
  `secmail` varchar(200) DEFAULT NULL,
  `sectel` varchar(200) DEFAULT NULL,
  `secwaddress` varchar(200) DEFAULT NULL,
  `isfshow` tinyint(2) DEFAULT '1',
  `olduserid` varchar(50) DEFAULT NULL COMMENT '原通讯录userid',
  `usertype` varchar(50) DEFAULT NULL,
  `ldapuid` varchar(50) DEFAULT NULL,
  `leader` varchar(200) DEFAULT NULL,
  `ismobilephoneshow` int(11) DEFAULT '1',
  `pinyinname` varchar(150) DEFAULT NULL,
  `oldpinyinname` varchar(150) DEFAULT NULL,
  `birthday` date DEFAULT NULL COMMENT '出生日期',
  `hiredate` date DEFAULT NULL COMMENT '入职时间',
  --创建索引，departmentcode 为组合索引。创建组合索引时有个最左边原则，只有最左边的字段在查询中出现才能够使用索引
  PRIMARY KEY (`uid`),
  KEY `userid` (`userid`),
  KEY `mainsite` (`mainsite`,`isdisplay`),
  KEY `olduserid` (`olduserid`),
  KEY `departmentcode` (`departmentcode`,`isdisplay`,`headquartersvisible`,`isfshow`),
  KEY `leader` (`leader`,`isdisplay`),
  KEY `orgcode` (`orgcode`),
  KEY `companycode` (`companycode`),
  KEY `name` (`name`),
  KEY `position` (`position`),
  KEY `officephone` (`officephone`),
  KEY `mobilephone1` (`mobilephone1`),
  KEY `isaddbyperson` (`isaddbyperson`),
  KEY `managerid` (`managerid`)
) ENGINE=InnoDB AUTO_INCREMENT=3752894 DEFAULT CHARSET=utf8;
--在已经存在的表上创建索引
ALTER  TABLE  book  ADD  INDEX  NkNameIdx( bookname(30) );
--在已经存在的表上创建unique唯一索引
ALTER TABLE  book ADD UNIQUE INDEX  NkNameIdx(bookname(20));
--在已经存在的表上创建组合索引
ALTER TABLE book ADD INDEX NkNameIdx(bookname(20),shore(10));
--使用索引可以 很大程度的提高查询速度 对于数据量大的应用很有必要 
--但索引也不可以太多 索引过多会导致添加和修改的效率降低
--删除已有表的索引
alter table mysqltest.personinfo drop index  isaddbyperson;

--题记： 索引相当于书的目录  可以加快查找速度。
alter table myperson add  sex(varchar(4));