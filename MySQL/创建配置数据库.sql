-- 主题：增

-- 新建表
CREATE DATABASE IF NOT EXISTS company;

CREATE SCHEMA PETSTORE;
-- 指定字符集与校对规则
CREATE DATABASE IF NOT EXISTS yggl character set gb2312 collate gb2312_chinese_ci;
-- 浮点型
CREATE TABLE `float_type` (
  `id` int(11) NOT NULL,
  `n1` float(3,2) DEFAULT NULL COMMENT '"浮点型"的长度是用来限制数字存储范围的. 支持科学计数法表示。浮点数表示近似值。float(单精度) 4字节',
  `n2` double(5,4) DEFAULT NULL COMMENT 'double(双精度) 8字节 double(M, D)M表示总位数，D表示小数位数 M既表示总位数（不包括小数点和正负号），也表示显示宽度（所有显示符号均包括）',
  `n3` double(6,3) unsigned zerofill DEFAULT NULL COMMENT '浮点型既支持符号位 unsigned 属性,支持显示宽度 zerofill 属性 不同于整型，前后均会补填0',
  `n4` decimal(2,1) DEFAULT NULL COMMENT '定点数 decimal 保存一个精确的数值，不会发生数据的改变，不同于浮点数的四舍五入 将浮点数转换为字符串来保存，每9位数字保存为4个字节。',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 整型
CREATE TABLE `int_type` (
  `id` int(11) NOT NULL COMMENT '4字节 使用int时，在满足要求的情况下，越小越好',
  `i1` tinyint(4) DEFAULT NULL COMMENT ' 1字节 -128 ~ 127 无符号位：0 ~ 255',
  `i2` smallint(6) DEFAULT NULL COMMENT '2字节 -32768 ~ 32767',
  `i3` mediumint(9) DEFAULT NULL COMMENT '3字节 -8388608 ~ 8388607',
  `i5` int(5) unsigned DEFAULT NULL COMMENT 'int(M) M表示总位数 默认存在符号位，unsigned 属性修改 显示宽度，如果某个数不够定义字段时设置的位数，则前面以0补填，zerofill 属性修改 ',
  `ib` tinyint(1) DEFAULT NULL COMMENT 'MySQL没有布尔类型，通过整型0和1表示。常用tinyint(1)表示布尔型',
  `iz` int(8) unsigned zerofill DEFAULT NULL COMMENT '"整型"的长度实际上可以理解为"显示长度", 如果该字段开启 "Zerofill/补零"就能很明显地知道它的作用.大量用于所谓“流水号”的生成 比较常用的应该是月份或日期前补0',
  `iu` tinyint(3) unsigned DEFAULT NULL COMMENT 'unsigned 既为非负数，用此类型可以增加数据长度',
  `it` bigint(20) DEFAULT NULL COMMENT 'BIGINT记录时间 不用担心范围或精度 只需存储自历元以来的毫秒数 BIGINT存储货币值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 字符串类型
CREATE TABLE `string_type` (
  `id` int(11) NOT NULL,
  `s1` char(255) DEFAULT NULL COMMENT '定长字符串，速度快，但浪费空间 M表示能存储的最大长度，此长度是字符数，非字节数 char,最多255个字符，与编码无关 不同的编码，所占用的空间不同。',
  `s2` varchar(34) DEFAULT NULL COMMENT 'varchar,最多65535字符，与编码有关。一条有效记录最大不能超过65535个字节。utf8 最大为21844个字符，gbk 最大为32766个字符，latin1 最大为65532个字符.因为在varchar存字符串时，第一个字节是空的，不存在任何数据，然后还需两个字节来存放字符串的长度，所以有效长度是65535-1-2=65532字节',
  `bs` blob COMMENT 'BLOB 值被视为二进制字符串（字节字符串）。它们没有字符集，排序和比较是基于列值中字节的数值',
  `bs1` tinyblob COMMENT 'BLOB 存储超过 2 GB 的二进制数据 BLOB和TEXT系列之间的唯一区别是BLOB 类型存储没有排序规则或字符集的二进制数据，但TEXT 类型具有字符集和排序规则',
  `bs2` mediumblob COMMENT 'BLOB 的最大大小为 4 GB 大多数情况下，BLOB 用于保存实际的图像二进制文件，而不是路径和文件信息。',
  `bs3` longblob COMMENT '二进制数据是指非结构化数据，即图像、音频文件、视频文件、数字签名。只需存储字节。',
  `t1` text COMMENT 'TEXT 将被 Varchar(MAX) 替换，但现在取决于您的 mysql 版本。文本用于大量字符串字符。通常，博客或新闻文章将构成 TEXT 字段',
  `t2` tinytext COMMENT 'text 在定义时，不需要定义长度，也不会计算总长度。text 类型在定义时，不可给default值-',
  `t3` mediumtext COMMENT '类似于char和varchar，用于保存二进制字符串，也就是保存字节字符串而非字符字符串。',
  `t4` longtext COMMENT 'TEXT 值被视为非二进制字符串（字符串）。它们有一个字符集，并根据字符集的排序规则对值进行排序和比较',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 日期时间类型
CREATE TABLE `datetime_type` (
  `id` int(11) NOT NULL COMMENT 'MySQL中的时间戳通常用于跟踪记录的更改，并且通常在每次记录更改时进行更新。如果要存储特定值，则应使用datetime字段',
  `d1` datetime DEFAULT NULL COMMENT ' 8字节 YYYY-MM-DD hh:mm:ss 日期及时间 1000-01-01 00:00:00 到 9999-12-31 23:59:59 而delete_at和created_at我使用日期时间',
  `d2` date DEFAULT NULL COMMENT '3字节 日期 1000-01-01 到 9999-12-31 DATETIME和TIMESTAMP可以分别使用CURRENT_TIMESTAMP，NOW（）作为默认值，但是DATE不能使用，因为它默认使用''0000-00-00''，因此要解决该问题，应该写您自己的该表触发器，以使用DATE mysql类型在字段/列中插入当前日期（无时间）',
  `d3` timestamp NULL DEFAULT NULL COMMENT '4字节 时间戳 19700101000000 到 2038-01-19 03:14:07 如果我有updated_at列，我将设置为使用时间戳。 要在PHP中获得当前的Unix时间戳，只需time();\r\n在MySQL中执行即可SELECT UNIX_TIMESTAMP();。',
  `d4` time DEFAULT NULL COMMENT '3字节 时间 -838:59:59 到 838:59:59',
  `d5` year(4) DEFAULT NULL COMMENT '1字节 年份 19012155',
  `d6` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '要指定自动属性，使用DEFAULT CURRENT_TIMESTAMP和ON UPDATE CURRENT_TIMESTAMP条款',
  `d7` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '每当记录更改时，时间戳记字段并不总是自动更新 也可以在“日期时间”字段上设置此属性 在MySQL 5及更高版本中，TIMESTAMP值从当前时区转换为UTC以进行存储，并从UTC转换回当前时区以进行检索 您很可能会达到一般使用的TIMESTAMP的下限-例如，存储生日。如果您在银行或房地产行业，您也可以轻松达到上限... 30年的抵押贷款现在已经超过2038 年',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

insert into datetime_type(d1,d3) values ((now()),(now()));

-- 枚举和集合
CREATE TABLE `enum_set_type` (
  `e1` enum('12','343','453') NOT NULL COMMENT '在已知的值中进行单选。最大数量为65535.枚举值在保存时，以2个字节的整型(smallint)保存。每个枚举值，按保存的位置顺序，从1开始逐一递增。',
  `e2` enum('a','b','e') DEFAULT NULL COMMENT '表现为字符串类型，存储却是整型 NULL值的索引是NULL 空字符串错误值的索引值是0 ',
  `s1` set('男','女') DEFAULT '' COMMENT '最多可以有64个不同的成员。以bigint存储，共8个字节。采取位运算的形式 当创建表时，SET成员值的尾部空格将自动被删除。'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- MySQL常用的存储引擎
-- MyISAM是MySQL的默认存储引擎。全表锁，拥有较高的执行速度，一个写请求请阻塞另外相同表格的所有读写请求，并发性能差，占用空间相对较小
-- MyISAM适合(1)做很多count 的计算；(2)插入不频繁，查询非常频繁；(3)没有事务。
-- ENGINE = engine_name
CREATE TABLE `engine1` (
  `id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- MEMORY(HEAP)存储引擎 全表锁，使用存在内存中的内容来创建表。每个MEMORY表只实际对应一个磁盘文件。
-- MEMORY类型的表访问非常得快，因为它的数据是放在内存中的，并且默认使用HASH索引。但是一旦服务关闭，表中的数据就会丢失掉。
CREATE TABLE `engine2` (
  `id` int(11) DEFAULT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8mb4;

-- MERGE存储引擎 是一组MyISAM表的组合，这些MyISAM表必须结构完全相同。MERGE表本身没有数据，对MERGE类型的表进行查询、更新、删除的操作，就是对内部的MyISAM表进行的
CREATE TABLE `engine3` (
  `id` int(11) DEFAULT NULL
) ENGINE=MRG_MyISAM DEFAULT CHARSET=utf8mb4;

-- 被用来无索引地，非常小地覆盖存储的大量数据。
CREATE TABLE `engine4` (
  `id` int(11) DEFAULT NULL
) ENGINE=ARCHIVE DEFAULT CHARSET=utf8mb4;

-- CSV存储引擎
-- 把数据以逗号分隔的格式存储在文本文件中。
-- 不允许主键 不允许空值
CREATE TABLE `engine5` (
  `id` int(10) unsigned zerofill NOT NULL
) ENGINE=CSV DEFAULT CHARSET=utf8mb4;

-- InnoDB，比较大的特点在于支持事务。但是这是以损失效率来换取的。比起MyISAM存储引擎，InnoDB写的处理效率差一些并且会占用更多的磁盘空间以保留数据和索引。
-- InnoDB适合：(1)可靠性要求比较高，或者要求事务；(2)表更新和查询都相当的频繁，并且表锁定的机会比较大的情况。
CREATE TABLE `engine6` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



-- 创建库
 CREATE DATABASE[ IF NOT EXISTS] 数据库名 数据库选项
-- 数据库选项：
COLLATE collation_name
CREATE DATABASE IF NOT EXISTS test1;

CREATE [TEMPORARY] TABLE[ IF NOT EXISTS] [库名.]表名 ( 表的结构定义 )[ 表选项]
-- 每个字段必须有数据类型
-- 最后一个字段后不能有逗号
-- TEMPORARY 临时表，会话结束时表自动消失

create table if not exists book
(
    图书编号 char(10) not null primary key ,
    图书类别 varchar(20) not null default '未知',
    单价 float(10) not null ,
    数量 smallint,
    封面图片 blob
)engine =InnoDB;

create TEMPORARY TABLE book1
(
    图书编号 char(10) not null primary key ,
    图书类别 varchar(20) not null default '未知',
    单价 float(10) not null ,
    数量 smallint,
    封面图片 blob
)engine =InnoDB;

-- 对于字段的定义：
字段名 数据类型 [NOT NULL | NULL] [DEFAULT default_value] [AUTO_INCREMENT] [UNIQUE [KEY] | [PRIMARY] KEY] [COMMENT 'string']-- 表选项
-- -- 字符集
CHARSET = charset_name
-- 如果表没有设定，则使用数据库字符集


-- 创建视图create view
CREATE VIEW 视图名(列1，列2...) AS SELECT (列1，列2...) FROM ...;
-- 修改和创建视图
CREATE OR REPLACE VIEW 视图名 AS SELECT [...] FROM [...];


-- 复制表
create table if not exists book1 like book;

create table if not exists book2  as select * from book where book.价格<3;
-- default则用默认值 ignore违背唯一约束时，不执行该语句
insert ignore into library.book
values (2,default,22,4,null,"三毛","文艺出版社");

-- 指定列名
insert ignore into library.book(图书编号,图书类别, 价格, 数量, 作者1, 出版商)
values (3,default,22,4,"三毛","文艺出版社");

-- 指定参数
insert into book set 图书编号=4,价格=12,图书类别=default,作者1="菲茨杰拉德";
-- 插入多条
insert ignore into library.book
values (5,default,22,5,null,"三毛","文艺出版社"),
       (6,default,22,3,null,"三毛","文艺出版社"),
       (7,default,22,7,null,"三毛","文艺出版社"),
       (8,default,22,4,null,"三毛","文艺出版社");

-- 插入图片路径
insert ignore into library.book
values (9,default,22,4,"/usr/src/picture.jpg","三毛","文艺出版社");

-- 插入图片
insert ignore into library.book
values (10,default,22,4,LOAD_FILE("/usr/src/picture.jpg"),"三毛","文艺出版社");
-- 定义主键
create table if not exists book_copy
(
    图书编号 char(10) not null primary key ,
    封面图片 blob
);
-- 定义联合主键
create table if not exists book_copy1
(
    图书编号 char(10) not null  ,
    图书类别 varchar(20) not null default '未知',
    单价 float(10) not null ,
    数量 int(2),
    封面图片 blob,
    primary key (图书编号,图书类别)
);
-- 增加索引
create table if not exists book_copy2
(
    图书编号 char(10) not null  ,
    图书类别 varchar(20) not null default '未知',
    单价 float(10) not null ,
    数量 mediumint,
    封面图片 blob,
    primary key index_book(图书编号,图书类别)
);

-- 替代键约束
create table if not exists book_copy3
(
    图书编号 char(10) not null unique ,
    封面图片 blob
);
-- 定义替代键
create table if not exists book_copy5
(
    图书编号 char(10) not null  ,
    书名 varchar(30)not null ,
    图书类别 varchar(20) not null default '未知',
    单价 float(10) not null ,
    封面图片 blob,
    primary key (图书编号,图书类别),
    unique(书名)
);

-- 创建外键约束
create table if not exists book_ref
(
    图书编号 char(10) not null  ,
    书名 varchar(20) not null default '未知',
    出版日期 date null ,
    primary key (书名),
    foreign key (图书编号)
        references book(图书编号)
            on DELETE RESTRICT
            on UPDATE RESTRICT
)ENGINE =INNODB;

-- 列完整性约束1
create table if not exists student
(
    学号 char(6) not null,
    性别 char(2) not null check ( 性别 in ('男','女') )
);
-- 列完整性约束2
create table student1
(
    学号 char(6) not null,
    出生日期 date not null ,
    学分 smallint null ,
    check ( 出生日期>'1980-01-01' )
);

-- 复杂表达式的列完整性约束
create table student2
(
    学号 char(6) not null,
    出生日期 date not null ,
    学分 smallint null ,
    check ( 学号 in (SELECT 学号 FROM student))
);
create table student3
(
    学号 char(6) not null,
    最好成绩 smallint null ,
    平均成绩 smallint null ,
    check ( 最好成绩>=平均成绩)
);
INSERT [INTO] 表名 [(字段列表)] VALUES (值列表)[, (值列表), ...]
-- 如果要插入的值列表包含所有字段并且顺序一致，则可以省略字段列表。
-- 可同时插入多条数据记录！
REPLACE 与 INSERT 完全一样，可互换。
INSERT [INTO] 表名 SET 字段名=值[, 字段名=值, ...]
PRIMARY 主键
能唯一标识记录的字段，可以作为主键。
一个表只能有一个主键。
主键具有唯一性。
声明字段时，用 primary key 标识。
也可以在字段列表之后声明
例：create table tab ( id int, stu varchar(10), primary key (id));
主键字段的值不能为null。
主键可以由多个字段共同组成。此时需要在字段列表后声明的方法。
例：create table tab ( id int, stu varchar(10), age int, primary key (stu, age));

UNIQUE 唯一索引（唯一约束）
使得某字段的值也不能重复。
NULL 约束
null不是数据类型，是列的一个属性。
表示当前列是否可以为null，表示什么都没有。
null, 允许为空。默认。
not null, 不允许为空。
insert into tab values (null, 'val');
-- 此时表示将第一个字段的值设为null, 取决于该字段是否允许为null
DEFAULT 默认值属性
当前字段的默认值。
insert into tab values (default, 'val'); -- 此时表示强制使用默认值。
create table tab ( add_time timestamp default current_timestamp );
-- 表示将当前时间的时间戳设为默认值。
current_date, current_time5. AUTO_INCREMENT 自动增长约束
自动增长必须为索引（主键或unique）
只能存在一个字段为自动增长。
默认为1开始自动增长。可以通过表属性 auto_increment = x进行设置，或 alter table tbl auto_increment = x;
COMMENT 注释
例：create table tab ( id int ) comment '注释内容';
FOREIGN KEY 外键约束
用于限制主表与从表数据完整性。














-- 主题：删

-- 删除数据库
DROP DATABASE yggl;
DROP DATABASE IF EXISTS yggl;

DELETE FROM 表名[ 删除条件子句]
没有条件子句，则会删除全部
delete from book where 数量<10;
-- 同时删除多张表的记录
delete ignore book,book_ref from book,book_ref
where book_ref.图书编号=book_ref.图书编号
and book.作者1='三毛';

-- 同时删除多张表的记录
delete from book,book_ref
    using book,book_ref
where book_ref.图书编号=book_ref.图书编号
  and book.作者1='三毛';



-- 删

删除
drop
命令格式：drop table tb -- tb表示数据表的名字,下同。
说明：删除内容和定义，释放空间。简单来说就是把整个表去掉.以后要新增数据是不可能的,除非新增一个表。
-- 删除表
drop table if exists book2;
truncate
删除内容、释放空间但不删除定义，也就是数据表的结构还在。与drop不同的是,它只是清空表数据而已。
-- 没有参与索引和视图的表，可以用truncate快速删除表的所有记录 该方法无法恢复
TRUNCATE book_copy1;
1、truncate table 在功能上与不带 WHERE 子句的 delete语句相同，二者均删除表中的全部行，但 truncate 比 delete速度快，且使用的系统和事务日志资源少。
2、delete 语句每次删除一行，并在事务日志中为所删除的每行记录一项，所以可以对delete操作进行roll back。
3、truncate 在各种表上无论是大的还是小的都非常快。如果有ROLLBACK命令Delete将被撤销，而 truncate 则不会被撤销。
4、truncate 是一个DDL语言，向其他所有的DDL语言一样，它将被隐式提交，不能对 truncate 使用ROLLBACK命令。
5、truncate 将重新设置高水平线和所有的索引。在对整个表和索引进行完全浏览时，经过 truncate 操作后的表比Delete操作后的表要快得多。
6、truncate 不能触发任何Delete触发器。
7、当表被清空后表和表的索引讲重新设置成初始大小，而delete则不能。
8、不能清空父表。
delete
命令格式：delete table tb 或 delete table tb where 条件
说明：删除内容不删除定义，不释放空间。其中，delete table tb 虽然也是删除整个表的数据,但是过程是痛苦的(系统一行一行地删,效率较truncate低)。
区别
1，	truncate 是删除表再创建，delete 是逐条删除2，truncate 重置auto_increment的值。而delete不会3，truncate 不知道删除了几条，而delete知道。4，当被用于带分区的表时，truncate 会保留分区。

-- 删除库
DROP DATABASE[ IF EXISTS] 数据库名
-- 同时删除该数据库相关的目录及其目录内容











-- 主题：改

-- 修改数据库
ALTER DATABASE PETSTORE character set gb2312 collate gb2312_chinese_ci;


-- 修改库的选项信息
ALTER DATABASE 库名 选项信息
--  设置时区
set time_zone="america/new_york";

 -- 修改表的存储引擎
ALTER TABLE  enum_set_type ENGINE =INNODB;


-- 增加列
Alter table book
    add column 作者1 char(10) null,
    add column 作者2 char(10) null,
    add column 出版商 varchar(20) null ;

-- 重命名表
Alter table book rename to books ;
rename table books to book;

-- 重命名列
Alter table book  change 单价 价格 float(9);

-- 修改指定列的类型
    ALTER table book
        modify 数量 bigint not null default 0,
        drop column 作者2;

-- 删除列或约束
Alter table book
    drop column 作者;

-- replace可以替换记录，不用考虑主键冲突 影响两行，插入一行，删除一行。
replace into library.book
values (2,default,16,4,null,"三毛","文艺出版社");

-- 增加索引 改变主键
alter table book_copy1
    drop primary key ,
add primary key(单价),
    add unique u_idx(数量);

-- 删除主键
alter table book_copy1
    drop primary key;

-- 删除索引
alter table book_copy1
    drop primary key,
    drop index u_idx;

-- 增加外键约束
ALTER TABLE book_ref
add foreign key (图书编号)
    references book_copy5(图书编号)
    on DELETE CASCADE
    on UPDATE CASCADE;



-- 删除完整性约束
ALTER TABLE book_copy5 DROP primary key ;

ALTER TABLE book_ref DROP FOREIGN KEY book_ref_ibfk_2;

/* Windows服务 */-- 启动MySQL
net start mysql-- 创建Windows服务
-- 断开服务器
-- \q
-- QUIT
-- 
-- 授权：
GRANT ALL ON *.* TO 'root'@'%';
-- 刷新权限：
flush privileges;
-- 更新加密规则：
ALTER USER 'root'@'localhost' IDENTIFIED BY 'password' PASSWORD EXPIRE NEVER;
-- 更新root用户密码：
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '123456';

-- 事务
-- 事务开启
START TRANSACTION; 
-- 或者 
BEGIN; 
-- 开启事务后，所有被执行的SQL语句均被认作当前事务内的SQL语句。
-- 事务提交
COMMIT;
-- 事务回滚 如果部分操作发生问题，映射到事务开启前。
-- 数据定义语言（DDL）语句不能被回滚，比如创建或取消数据库的语句，和创建、取消或更改表或存储的子程序的语句。
ROLLBACK;

-- 设置一个事务保存点
SAVEPOINT 保存点名称 
-- 回滚到保存点
ROLLBACK TO SAVEPOINT 保存点名称 
 -- 删除保存点
RELEASE SAVEPOINT 保存点名称

-- InnoDB自动提交特性设置 0表示关闭自动提交，1表示开启自动提交。
-- 如果关闭了，那普通操作的结果对其他客户端也不可见，需要commit提交后才能持久化数据操作。
-- 也可以关闭自动提交来开启事务。但与START TRANSACTION不同的是，
-- SET autocommit是永久改变服务器的设置，直到下次再次修改该设置。(针对当前连接)
-- 而START TRANSACTION记录开启前的状态，而一旦事务提交或回滚后就需要再次开启事务。(针对当前事务)
SET autocommit = 0|1; 
SET autocommit = 1;
-- 修改表
-- 修改表本身的选项
ALTER TABLE 表名 表的选项
eg: ALTER TABLE 表名 ENGINE=MYISAM;
-- 对表进行重命名
RENAME TABLE 原表名 TO 新表名
RENAME TABLE 原表名 TO 库名.表名 （可将表移动到另一个数据库）
-- RENAME可以交换两个表名
-- 修改表的字段机构（13.1.2. ALTER TABLE语法）
ALTER TABLE 表名 操作名
-- 操作名
ADD[ COLUMN] 字段定义 -- 增加字段
AFTER 字段名 -- 表示增加在该字段名后面
FIRST -- 表示增加在第一个
ADD PRIMARY KEY(字段名) -- 创建主键
ADD UNIQUE [索引名] (字段名)-- 创建唯一索引
ADD INDEX [索引名] (字段名) -- 创建普通索引
DROP[ COLUMN] 字段名 -- 删除字段
MODIFY[ COLUMN] 字段名 字段属性 -- 支持对字段属性进行修改，不能修改字段名(所有原有属性也需写上)
CHANGE[ COLUMN] 原字段名 新字段名 字段属性 -- 支持对字段名修改
DROP PRIMARY KEY -- 删除主键(删除主键前需删除其AUTO_INCREMENT属性)
DROP INDEX 索引名 -- 删除索引
DROP FOREIGN KEY 外键 -- 删除外键-- 删除表
DROP TABLE[ IF EXISTS] 表名 ...-- 清空表数据
TRUNCATE [TABLE] 表名-- 复制表结构
CREATE TABLE 表名 LIKE 要复制的表名-- 复制表结构和数据
CREATE TABLE 表名 [AS] SELECT * FROM 要复制的表名-- 检查表是否有错误
CHECK TABLE tbl_name [, tbl_name] ... [option] ...-- 优化表
OPTIMIZE [LOCAL | NO_WRITE_TO_BINLOG] TABLE tbl_name [, tbl_name] ...-- 修复表
REPAIR [LOCAL | NO_WRITE_TO_BINLOG] TABLE tbl_name [, tbl_name] ... [QUICK] [EXTENDED] [USE_FRM]-- 分析表
ANALYZE [LOCAL | NO_WRITE_TO_BINLOG] TABLE tbl_name [, tbl_name] ...
-- 改
UPDATE 表名 SET 字段名=新值[, 字段名=新值] [更新条件]
SET character_set_client = gbk;
SET character_set_results = gbk;
SET character_set_connection = gbk;SET NAMES GBK; -- 相当于完成以上三个设置
alter table t1 add constraint `t1_t2_fk` foreign key (t1_id) references t2(id);
-- 将表t1的t1_id外键关联到表t2的id字段。
-- 每个外键都有一个名字，可以通过 constraint 指定
存在外键的表，称之为从表（子表），外键指向的表，称之为主表（父表）。
作用：保持数据一致性，完整性，主要目的是控制存储在外键表（从表）中的数据。
MySQL中，可以对InnoDB引擎使用外键约束：
语法：
foreign key (外键字段） references 主表名 (关联字段) [主表记录删除时的动作] [主表记录更新时的动作]
此时需要检测一个从表的外键需要约束为主表的已存在的值。外键在没有关联的情况下，可以设置为null.前提是该外键列，没有not null。
可以不指定主表记录更改或更新时的动作，那么此时主表的操作被拒绝。
如果指定了 on update 或 on delete：在删除或更新时，有如下几个操作可以选择：
1. cascade，级联操作。主表数据被更新（主键值更新），从表也被更新（外键值更新）。主表记录被删除，从表相关记录也被删除。
2. set null，设置为null。主表数据被更新（主键值更新），从表的外键被设置为null。主表记录被删除，从表相关记录外键被设置成null。但注意，要求该外键列，没有not null属性约束。
3. restrict，拒绝父表删除和更新。
注意，外键只被InnoDB存储引擎所支持。其他引擎是不支持的。

-- Update更新
update aa set name=concat('x',name)







-- 主题：查

-- 查看数据库
show DATABASES;

-- 查看字符集和默认校对规则
show character set;

-- 查看版本
-- mysql –V
-- mysql
SHOW VARIABLES LIKE '%version%';
SELECT VERSION();

-- 打开数据库
use petzoo;



-- 时区更改后，时间戳表示正确的时间，而不是日期时间。
-- 显示时区
 show variables like '%time_zone%';



select * from datetime_type;
-- 主要区别在于DATETIME是常数，而TIMESTAMP受time_zone设置影响。仅当您拥有（或将来可能拥有）跨时区的同步集群时，它才有意义。
--  您的应用程序不应依赖于服务器的时区。在发出任何查询之前，应用程序应始终在其使用的数据库连接会话中选择时区。
-- 如果多个用户（例如：webapp）之间共享连接，请使用UTC并在呈现端进行时区转换。

-- 显示表信息
show tables;

-- 显示表结构
desc book;
describe book1;
describe book1 图书编号;

-- 查看表的所有信息
SHOW CREATE TABLE student3;

-- 多表查询可以跨数据库
select * from library.book_ref as bookref,company.employee as user;

-- 全连接后筛选
select book.出版商,sell.订购者,sell.是否发货
from book,sell
where book.图书编号=sell.图书编号;

-- 如果book_ref的外键是book的图书编号，这个语句不会返回结果
SELECT * FROM book_ref
where 图书编号 NOT IN
      (SELECT 图书编号 FROM book);

-- 定义列别名as
select id as '员工id',lastname as 'last name' from  company.employee;

-- where语句不能使用列别名
select id as 员工id,lastname as 'last name'
from  company.employee
where id=211;

-- 替换查询结果中的数据case
select 图书编号,作者1,
       case
            when 数量 is NULL THEN '缺货'
            when 数量 <5 THEN '需要进货'
            when 数量 >=5 and 数量 <30 THEN '库存正常'
            when 数量 >30 THEN '库存积压'
           else
               '库存异常'
        end as 库存
from library.book;

-- 计算列值round
select 图书编号,ROUND(数量*单价,2) As 订购金额
from sell where 是否发货='已发货';

-- 消除重复行distinct
select distinct 作者1,出版商 from book;

-- <=>用于和null比较，都是null或者值相等为true，不会返回unknown 等价于is null
select * from sell
where 是否发货<=>NULL;

-- 模板匹配like
select 图书编号,ROUND(数量*单价,2) As 订购金额
from sell where 是否发货 like '已发_';

select 图书编号,ROUND(数量*单价,2) As 订购金额
from sell where 是否发货 like '已%';

--  查找_或%需要用#来转义
select 图书编号,ROUND(数量*单价,2) As 订购金额
from sell where 是否发货 like '已#%';

-- between
select * from book_ref where 出版日期
between '1900-1-1' AND '2020-1-1';

-- in
select * from book_ref where 出版日期  not in ('1990-2-23' );

-- 登录账号
-- mysql -uroot -p123456
-- mysql -h47.107.225.159:3306 -uroot -p123456
-- mysql -h 地址 -P 端口 -u 用户名 -p 密码
SHOW PROCESSLIST -- 显示哪些线程正在运行
SHOW VARIABLES -- 显示系统变量信息
-- 查看当前数据库
SELECT DATABASE();
-- 显示当前时间、用户名、数据库版本
SELECT now(), user(), version();
SHOW ENGINES 
-- 显示存储引擎的状态信息
SHOW ENGINE 引擎名 {LOGS|STATUS} 
-- 显示存储引擎的日志或状态信息
-- 自增起始数
AUTO_INCREMENT = 行数
-- 数据文件目录
DATA DIRECTORY = '目录'
-- 索引文件目录
INDEX DIRECTORY = '目录'
-- 表注释
COMMENT = 'string'
-- 分区选项
PARTITION BY ... (详细见手册)
-- 查看所有表
SHOW TABLES[ LIKE 'pattern']
SHOW TABLES FROM 库名
-- 查看表结构
SHOW CREATE TABLE 表名 （信息更详细）
DESC 表名 / DESCRIBE 表名 / EXPLAIN 表名 / SHOW COLUMNS FROM 表名 [LIKE 'PATTERN']
SHOW TABLE STATUS [FROM db_name] [LIKE 'pattern']
-- 查
SELECT 字段列表 FROM 表名[ 其他子句]
-- 可来自多个表的多个字段
-- 其他子句可以不使用
-- 字段列表可以用*代替，表示所有字段
字符集编码
/* 字符集编码 */ -------------------- MySQL、数据库、表、字段均可设置编码-- 数据编码与客户端编码不需一致
SHOW VARIABLES LIKE 'character_set_%' -- 查看所有字符集编码项
character_set_client 客户端向服务器发送数据时使用的编码
character_set_results 服务器端将结果返回给客户端所使用的编码
character_set_connection 连接层编码SET 变量名 = 变量值
-- 校对集
校对集用以排序
SHOW CHARACTER SET [LIKE 'pattern']/SHOW CHARSET [LIKE 'pattern'] 查看所有字符集
SHOW COLLATION [LIKE 'pattern'] 查看所有校对集
CHARSET 字符集编码 设置字符集编码
COLLATE 校对集编码 设置校对集编码
-- GROUP BY
-- GROUP BY 字段/别名 [排序方式]
-- 分组后会进行排序。升序：ASC，降序：DESC
-- 以下[合计函数]需配合 GROUP BY 使用：
-- count 返回不同的非NULL值数目 count(*)、count(字段)
-- sum 求和
-- max 求最大值
-- min 求最小值
-- avg 求平均值
-- group_concat 返回带有来自一个组的连接的非NULL值的字符串结果。组内字符串连接。


-- DISTINCT原理
-- distinct 去除重复记录
-- 默认为 all, 全部记录
-- DISTINCT实际上和GROUP BY的操作非常相似，只不过是在GROUP BY之后的每组中只取出一条记录。


-- 将多个select查询的结果组合成一个结果集合。
-- SELECT ... UNION [ALL|DISTINCT] SELECT ...
-- 默认 DISTINCT 方式，即所有返回的行都是唯一的

-- 子查询
-- 子查询需用括号包裹。-- from型
-- 行子查询
-- from后要求是一个表，必须给子查询结果取个别名。
-- 简化每个查询内的条件。
-- from型需将结果生成一个临时表格，可用以原表的锁定的释放。
-- 子查询返回一个表，表型子查询。
select * from (select * from tb where id>0) as subfrom where id>1;-- where型
-- 子查询返回一个值，标量子查询。
-- 不需要给子查询取别名。
-- where子查询内的表，不能直接用以更新。
select * from tb where money = (select max(money) from tb); 
-- 查询条件是一个行。
select * from t1 where (id, gender) in (select id, gender from t2);
-- 行构造符：(col1, col2, ...) 或 ROW(col1, col2, ...)
-- 行构造符通常用于与对能返回两个或两个以上列的子查询进行比较。
-- -- 特殊运算符
-- != all() 相当于 not in
-- = some() 相当于 in。any 是 some 的别名
-- != some() 不等同于 not in，不等于其中某一个。
-- all, some 可以配合其他运算符一起使用。
-- 列子查询
-- 如果子查询结果返回的是一列。
-- 使用 in 或 not in 完成查询
-- exists 和 not exists 条件
-- 如果子查询返回数据，则返回1或0。常用于判断条件。
select column1 from t1 where exists (select * from t2);
-- 查看表详情一样使用desc 视图名，另外一种方法是show fields from 视图名
desc 视图名
show fields from 视图名

FROM 子查询
用于标识查询来源。
-- 可以为表起别名。使用as关键字。
SELECT * FROM tb1 AS tt, tb2 AS bb;
-- from子句后，可以同时出现多个表。
-- 多个表会横向叠加到一起，而数据会形成一个笛卡尔积。
SELECT * FROM tb1, tb2;
-- 向优化符提示如何选择索引
USE INDEX、IGNORE INDEX、FORCE INDEX


-- 查看已有库
 SHOW DATABASES[ LIKE 'PATTERN']
 -- 查看当前库信息
SHOW CREATE DATABASE 数据库名
WHERE 子句
-- 从from获得的数据源中进行筛选。
-- 整型1表示真，0表示假。
-- 表达式由运算符和运算数组成。
-- 运算数：变量（字段）、值、函数返回值
-- 运算符：
=, <=>, <>, !=, <=, <, >=, >, !, &&, ||,
in (not) null, (not) like, (not) in, (not) between and, is (not), and, or, not, xor
is/is not 加上ture/false/unknown，检验某个值的真假
<=>与<>功能相同，<=>可用于null比较

-- HAVING 子句，条件子句
-- 与 where 功能、用法相同，执行时机不同。
-- where 在开始时执行检测数据，对原数据进行过滤。
-- having 对筛选出的结果再次进行过滤。
-- having 字段必须是查询出来的，where 字段必须是数据表存在的。
-- where 不可以使用字段的别名，having 可以。因为执行WHERE代码时，可能尚未确定列值。
-- where 不可以使用合计函数。一般需用合计函数才会用 having
-- SQL标准要求HAVING必须引用GROUP BY子句中的列或用于合计函数中的列。
-- 显示每个地区的总人口数和总面积．仅显示那些面积超过1000000的地区。
SELECT region, SUM(population), SUM(area)
FROM bbc
GROUP BY region
HAVING SUM(area)>1000000
-- 查询出两门及两门以上不及格者的平均成绩(注意是所有科目的平均成绩)
SELECT name,avg(score), sum(score<60) as 'gk' FROM stu GROUP BY name having gk >= 2;
-- 取出价格最高的前3至5件商品
SELECT goods_name,cat_id,goods_number,shop_price FROM goods ORDER BY shop_price DESC LIMIT

-- EXPLAIN 获取关于查询执行计划的信息，以及如何解释输出。Explain命令是查看查询优化器如何决定执行查询
EXPLAIN SELECT * FROM TEMP WHERE TYPE = 'A' ORDER BY CREATED_AT DESC LIMIT 10;


-- LIMIT 子句，限制结果数量子句
-- limit子句用于限制查询结果返回的数量。从第i条数据开始返回n条数据。
select * from limit tableName limit i,n 
-- limit 起始位置, 获取条数
-- 参数：
-- tableName : 为数据表；
-- i : 为查询结果的索引值（默认从0开始）； 
-- n : 为查询结果返回的数量
-- 省略第一个参数，仅对处理好的结果进行数量限制。将处理好的结果的看作是一个集合，按照记录出现的顺序，索引从0开始。


-- Join连接查询
-- 将多个表的字段进行连接，可以指定连接条件。
-- 自动判断连接条件完成连接。
-- 相当于省略了using，会自动查找相同字段名。
natural join
natural left join
natural right joinselect info.id, info.name, info.stu_num, extra_info.hobby, extra_info.sex from info, extra_info where info.stu_num = extra_info.stu_id;
-- join 用于多表中字段之间的联系，语法如下：
-- INNER JOIN（内连接,或等值连接）
-- 默认就是内连接，可省略inner。
还有 using, 但需字段名相同。 using(字段名)
取得两个表中存在连接匹配关系的记录。inner join产生同时符合A和B的一组数据

-- 只有数据存在时才能发送连接。即连接结果不能出现空行。
-- LEFT JOIN（左连接）RIGHT JOIN（右连接）
-- 取得左表（table1）完全记录，即是右表（table2）并无对应匹配记录。
-- 与 LEFT JOIN 相反，取得右表（table2）完全记录，即是左表（table1）并无匹配对应记录。
-- 在使用left jion时，on和where条件的区别如下：
-- 1、 on条件是在生成临时表时使用的条件，它不管on中的条件是否为真，都会返回左边表中的记录。
-- 2、where条件是在临时表生成好后，再对临时表进行过滤的条件。这时已经没有left join的含义（必须返回左边表的记录）了，条件不为真的就全部过滤掉。
-- 
... FROM table1 INNER|LEFT|RIGHT JOIN table2 ON conditiona
table1:左表；table2:右表。

SELECT * FROM `orders` JOIN `order` ON `order`.game_order_id=CONCAT('inner_',orders.id) LIMIT 3;

SELECT * FROM `orders` JOIN `order` ON orders.id=REPLACE(`order`.game_order_id,'inner_','') LIMIT 3;


-- 时间相关查询
SELECT count(*) as count,sum(cp_pay_fee)* 0.03170 as fee FROM users_pay WHERE ts_pay>UNIX_TIMESTAMP('2021-04-01 00:00:00') AND sand_box=0;
SELECT count(*) as count,sum(standard_price) as fee FROM user_order WHERE ts_payed>UNIX_TIMESTAMP('2021-04-01 00:00:00') AND sand_box=0;
##查询今天

SELECT column_name(s) FROM table_name WHERE DATE_FORMAT( create_time,'%Y-%m-%d') = DATE_FORMAT(NOW(), '%Y-%m-%d');
-- 数据库日期类型是int类型的，该查询结果是datetime类型的
SELECT from_unixtime(call_time),game_order_id FROM `order` WHERE call_time> UNIX_TIMESTAMP('2021-08-06 00:00:00')
-- DATE_FORMAT()函数用于以不同的格式显示日期/时间数据
-- DATE_FORMAT(date,format)

-- date参数是合法的日期。format规定日期/时间的输出格式

-- NOW()函数返回当前的日期和时间

/* SELECT 
一个查询语句同时出现了where,group by,having,order by的时候，执行顺序和编写顺序是：
1.执行where xx对全表数据做筛选，返回第1个结果集。
2.针对第1个结果集使用group by分组，返回第2个结果集。
3.针对第2个结果集中的每1组数据执行select xx，有几组就执行几次，返回第3个结果集。
4.针对第3个结集执行having xx进行筛选，返回第4个结果集。
5.针对第4个结果集排序。
通过一个顺口溜总结下顺序：我(W)哥(G)是(SH)偶(O)像。按照执行顺序的关键词首字母分别是W（where）->G（Group）->S（Select）->H（Having）->O（Order），对应汉语首字母可以编成容易记忆的顺口溜：我(W)哥(G)是(SH)偶(O)像
*/ ----------------
SELECT [ALL|DISTINCT] select_expr FROM -> WHERE -> GROUP BY [合计函数] -> HAVING -> ORDER BY -> LIMIT
-- 
-- 尽量避免子查询，而用join.
select * from Ainner join B on B.name = A.nameleft join C on C.name = B.name and C.status>1left join D on D.id = C.id and D.status=1
-- 在使用INNER JOIN时会产生一个结果集，WHERE条件在这个结果集中再根据条件进行过滤，如果把条件都放在ON中，在INNER JOIN的时候就进行过滤了，
SELECT *
FROM A
INNER JOIN B
ON B.ID = A.ID
AND B.State = 1
INNER JOIN C
ON B.ID = C.ID

SELECT `game_order_id`,`server_id`, `uid`,  `product_id`,  `order`.`channel`, `channel_uid`,`order_id`,
                `order`.`money`, `order`.`currency`, `deliver_status`,  from_unixtime(`deliver_time`) as `deliver`,
                `extra`, from_unixtime(`create_time`) as `create` FROM `orders` 
                JOIN `order` ON orders.id=REPLACE(`order`.game_order_id,'inner_','') WHERE `order`.`order_id` not like 'dummy%';
								
								
						
SELECT SUM(`order`.`money`),  `uid`, `server_id` FROM `orders` 
                JOIN `order` ON orders.id=REPLACE(`order`.game_order_id,'inner_','') WHERE `order`.`order_id` not like 'dummy%'
								GROUP BY `server_id`, `uid`
内置函数
数值函数
abs(x) -- 绝对值 abs(-10.9) = 10
format(x, d) -- 格式化千分位数值 format(1234567.456, 2) = 1,234,567.46
ceil(x) -- 向上取整 ceil(10.1) = 11
floor(x) -- 向下取整 floor (10.1) = 10
round(x) -- 四舍五入去整
mod(m, n) -- m%n m mod n 求余 10%3=1
pi() -- 获得圆周率
pow(m, n) -- m^n
sqrt(x) -- 算术平方根
rand() -- 随机数
truncate(x, d) -- 截取d位小数
时间日期函数
now(), current_timestamp(); -- 当前日期时间
current_date(); -- 当前日期
current_time(); -- 当前时间
date('yyyy-mm-dd hh:ii:ss'); -- 获取日期部分
time('yyyy-mm-dd hh:ii:ss'); -- 获取时间部分
date_format('yyyy-mm-dd hh:ii:ss', '%d %y %a %d %m %b %j'); -- 格式化时间
unix_timestamp(); -- 获得unix时间戳
from_unixtime(); -- 从时间戳获得时间
字符串函数
length(string) -- string长度，字节
char_length(string) -- string的字符个数
substring(str, position [,length]) -- 从str的position开始,取length个字符
replace(str ,search_str ,replace_str) -- 在str中用replace_str替换search_str
instr(string ,substring) -- 返回substring首次在string中出现的位置
concat(string [,...]) -- 连接字串
charset(str) -- 返回字串字符集
lcase(string) -- 转换成小写
left(string, length) -- 从string2中的左边起取length个字符
load_file(file_name) -- 从文件读取内容
locate(substring, string [,start_position]) -- 同instr,但可指定开始位置
lpad(string, length, pad) -- 重复用pad加在string开头,直到字串长度为length
ltrim(string) -- 去除前端空格
repeat(string, count) -- 重复count次
rpad(string, length, pad) -- 在str后用pad补充,直到长度为length
rtrim(string) -- 去除后端空格
strcmp(string1 ,string2) -- 逐字符比较两字串大小
流程函数
case when [condition] then result [when [condition] then result ...] [else result] end 多分支
if(expr1,expr2,expr3) 双分支。
-- 聚合函数
count()sum();max();min();avg();
group_concat()-- 其他常用函数
md5();
default();















QL编程
定义变量
MySQL存储过程中，定义变量有两种方式： 
1、使用set或select直接赋值，变量名以@开头
例如:
set @var=1; 
可以在一个会话的任何地方声明，作用域是整个会话，称为用户变量。
2、以declare关键字声明的变量，只能在存储过程中使用，称为存储过程变量，例如： 
declare var1 int default 0; 
主要用在存储过程中，或者是给存储传参数中。
两者的区别是： 
在调用存储过程时，以declare声明的变量都会被初始化为null。而会话变量（即@开头的变量）则不会被再初始化，在一个会话内，只须初始化一次，之后在会话内都是对上一次计算的结果，就相当于在是这个会话内的全局变量。
局部变量 
局部变量，只在当前begin/end代码块中有效。
局部变量一般用在sql语句块中，比如存储过程的begin/end。其作用域仅限于该语句块，在该语句块执行完毕后，局部变量就消失了。declare语句专门用于定义局部变量，可以使用default来说明默认值。set语句是设置不同类型的变量，包括会话变量和全局变量。 
局部变量定义语法形式
这个语句被用来声明局部变量。要给变量提供一个默认值，请包含一个default子句。值可以被指定为一个表达式，不需要为一个常数。如果没有default子句，初始值为null。
declare var_name [, var_name]... data_type [ DEFAULT value ];
使用 set 和 select into 语句为变量赋值。
例如在begin/end语句块中添加如下一段语句，接受函数传进来的a/b变量然后相加，通过set语句赋值给c变量。 
set语句语法形式set var_name=expr [, var_name=expr]...; set语句既可以用于局部变量的赋值，也可以用于用户变量的申明并赋值。
declare c int default 0;
set c=a+b;
select c as C;
或者用select …. into…形式赋值
select into 语句句式：select col_name[,...] into var_name[,...] table_expr [where...];
declare v_employee_name varchar(100);
declare v_employee_salary decimal(8,4);
select employee_name, employee_salary
into v_employee_name, v_employee_salary
from employees
where employee_id=1;
DELIMITER $$
DROP PROCEDURE IF EXISTS `example`.`test` $$
CREATE PROCEDURE `example`.`test` ()
BEGIN
DECLARE FOO varchar(7);
DECLARE oldFOO varchar(7);
SET FOO = '138';
SET oldFOO = CONCAT('0', FOO);
update mypermits
set person = FOO
where person = oldFOO;
END $$
DELIMITER ;
-- the @ symbol is required
SET @FOO = '138'; 
SET @oldFOO = CONCAT('0', FOO);
UPDATE mypermits SET person = FOO WHERE person = oldFOO; 
- 注意：在函数内是可以使用全局变量（用户自定义的变量）--// 全局变量 ------------ 定义、赋值set 语句可以定义并为变量赋值。set @var = value;
也可以使用select into语句为变量初始化并赋值。这样要求select语句只能返回一行，但是可以是多个字段，就意味着同时为多个变量进行赋值，变量的数量需要与查询的列数一致。
还可以把赋值语句看作一个表达式，通过select执行完成。此时为了避免=被当作关系运算符看待，使用:=代替。（set语句可以使用= 和 :=）。select @var:=20;select @v1:=id, @v2=name from t1 limit 1;select * from tbl_name where @var:=30;select into 可以将表中查询获得的数据赋给变量。
-| select max(height) into @max_height from tb;-- 自定义变量名
为了避免select语句中，用户自定义的变量与系统标识符（通常是字段名）冲突，用户自定义变量在变量名前使用@作为开始符号。
@var=10;
变量被定义后，在整个会话周期都有效（登录到退出）
用户变量 
用户变量，在客户端链接到数据库实例整个过程中用户变量都是有效的。
MySQL中用户变量不用事前申明，在用的时候直接用“@变量名”使用就可以了。 
第一种用法：set @num=1; 或set @num:=1; //这里要使用set语句创建并初始化变量，直接使用@num变量 
第二种用法：select @num:=1; 或 select @num:=字段名 from 表名 where ……， 


控制结构
if语句
if search_condition then
statement_list 
[elseif search_condition then
statement_list]
...
[else
statement_list]
end if;-- case语句
CASE value WHEN [compare-value] THEN result
[WHEN [compare-value] THEN result ...]
[ELSE result]
END
while循环
[begin_label:] while search_condition do
statement_list
end while [end_label];- 如果需要在循环内提前终止 while循环，则需要使用标签；标签需要成对出现。
退出循环
退出整个循环 leave
退出当前循环 iterate
通过退出的标签决定退出哪个循环--// 
--  存储函数，自定义函数 ------------ 新建
CREATE FUNCTION function_name (参数列表) RETURNS 返回值类型
函数体
函数名，应该合法的标识符，并且不应该与已有的关键字冲突。
一个函数应该属于某个数据库，可以使用db_name.funciton_name的形式执行当前函数所属数据库，否则为当前数据库。
参数部分，由"参数名"和"参数类型"组成。多个参数用逗号隔开。
函数体由多条可用的mysql语句，流程控制，变量声明等语句构成。
多条语句应该使用 begin...end 语句块包含。
一定要有 return 返回值语句。
-- 删除
DROP FUNCTION [IF EXISTS] function_name;
-- 查看
SHOW FUNCTION STATUS LIKE 'partten'
SHOW CREATE FUNCTION function_name;
-- 修改
ALTER FUNCTION function_name 函数选项—

存储过程，自定义功能 
定义
存储过程是一段可执行性代码的集合。相比函数，更偏向于业务逻辑。
例如报名，交班费，订单入库等。而一个函数通常专注与某个功能，视为其他程序服务的，需要在其他语句中调用函数才可以，而存储过程不能被其他调用，是自己执行 通过call执行。
创建
CREATE PROCEDURE sp_name (参数列表)
过程体
参数列表：不同于函数的参数列表，需要指明参数类型IN，表示输入型
OUT，表示输出型
INOUT，表示混合型
注意，没有返回值。
调用
CALL 过程名-- 注意- 没有返回值。- 只能单独调用，不可夹杂在其他语句中-- 参数IN|OUT|INOUT 参数名 数据类型IN 输入：在调用过程中，将数据输入到过程体内部的参数
OUT 输出：在调用过程中，将过程体处理完的结果返回到客户端
INOUT 输入输出：既可输入，也可输出-- 语法
CREATE PROCEDURE 过程名 (参数列表)BEGIN
过程体
END
备份与还原
/* 备份与还原 */ ------------------
备份，将数据的结构与表内数据保存起来。
利用 mysqldump 指令完成。-- 导出
mysqldump [options] db_name [tables]
mysqldump [options] ---database DB1 [DB2 DB3...]
mysqldump [options] --all--database1. 导出一张表
mysqldump -u用户名 -p密码 库名 表名 > 文件名(D:/a.sql)2. 导出多张表
mysqldump -u用户名 -p密码 库名 表1 表2 表3 > 文件名(D:/a.sql)3. 导出所有表
mysqldump -u用户名 -p密码 库名 > 文件名(D:/a.sql)4. 导出一个库
mysqldump -u用户名 -p密码 --lock-all-tables --database 库名 > 文件名(D:/a.sql)
可以-w携带WHERE条件-- 导入1. 在登录mysql的情况下：
source 备份文件2. 在不登录的情况下
mysql -u用户名 -p密码 库名 < 备份文件

操作语句
创建视图
CREATE [OR REPLACE] [ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}] VIEW view_name [(column_list)] AS select_statement
视图名必须唯一，同时不能与表重名。
视图可以使用select语句查询到的列名，也可以自己指定相应的列名。
可以指定视图执行的算法，通过ALGORITHM指定。
column_list如果存在，则数目必须等于SELECT语句检索的列数-- 查看结构
更新视图
WITH CHECK OPTION 如果在创建视图的时候制定了“WITH CHECK OPTION”，那么更新数据时不能插入或更新不符合视图限制条件的记录。
SHOW CREATE VIEW view_name—
删除视图
删除视图后，数据依然存在。
可同时删除多个视图。
DROP VIEW [IF EXISTS] view_name ...-- 修改视图结构
一般不修改视图，因为不是所有的更新视图都会映射到表上。
ALTER VIEW view_name [(column_list)] AS select_statement—
视图作用
1. 简化业务逻辑
2. 对客户端隐藏真实的表结构-- 视图算法(ALGORITHM)
MERGE 合并
将视图的查询语句，与外部查询需要先合并再执行！
TEMPTABLE 临时表
将视图执行完毕后，形成临时表，再做外层查询！
UNDEFINED 未定义(默认)，指的是MySQL自主去选择相应的算法。

查看锁信息
SHOW ENGINE INNODB STATUS命令来查看当前请求锁的信息:
要查看锁，则需要INNODB_LOCKS表，
lock_id: 锁的ID
lock_trx_id: 事务ID
lock_mode: 锁的模式。
lock_type: 锁的类型，表锁还是行锁。
lock_table: 要加锁的表。
lock_index :锁的索引。
lock_space: InnoDB 存储引擎表空间的ID号。
lock_page: 被锁住的页的数量。若是表锁，则该值为NULL
lock_rec: 被锁住的行的数量。若是表锁，则该值为NULL
lock_data: 被锁住的行的主键值。当是表锁肘，该值为NULL
INNODB_LOCK_WAITS可以很直观地反映出当前的等待
requesting_trx_id: 申请锁资源的事务ID
requesting_lock_id: 申请的锁的ID
blocking_trx_id: 阻塞的事务ID
blocking_trx_id: 阻塞的锁的ID

锁的应用
自增长和锁
InnoDB存储引擎的内存结构中，对每个含有自增长值的表都有一个自增长计数器
对含有自增长计数器的表进行插人操作时，这个计数器会被初始化，
实现方式
AUTO-INC Locking
这种锁其实是采用一种特殊的表锁机制，为了提高插入的性能，锁不是在一个事务完成后才释放，而是在完成对自增长值插人的SQL语句后立即释放。
缺点
对于有自增长值的列的并发插入性能较差，所以必须等待前一个插人的完成
参数innodb_autoinc_lock_mode
选择合适的计数器累加模式
自增长的插入分类
INSERT-like
指所有的插入语句，如INSERT REPLACE
Simple inserts
指能在插入前就确定插入行数的语句。
Bulk inserts
指在插入前不能确定得到插入行数的语句
Mixed-mode inserts
指插入中有一部分的值是自增长的。
外键和锁
外键主要用于引用完整性的约束检查。
对于一个外键列，如果没有显式地对这个列加索引， InnoDB 存储引擎自动对其加一个索引，
因为这样可以避免表锁
对于外键值的插入或者更新，首先需要查询父表中的记录，即SELECT父表
使用的是SELECT ... LOCK IN SHARE MODE方式
如果这时父表上已经这样加 锁，那么子表上的操作会被阻塞
锁的算法
Record Lock
单个行记录上的锁。
Record Lock总是会去锁住索引记录。
没有显式索引InnoDB 存储引擎会使用隐式的主键来进行锁定。
Gap Lock
间隙锁，锁定一个范围，但不包含记录本身。
Next-Key Lock
Gap Lock + Record Lock ，锁定一个范围，并且锁定记录本身。
默认配置下，即事务的隔离级别为REPEATABLE READ的模式下。Next-Key Lock算法是默认的行记录锁定算法。
表锁定只用于防止其它客户端进行不正当地读取和写入
MyISAM 支持表锁，InnoDB 支持行锁-- 锁定
LOCK TABLES tbl_name [AS alias]-- 解锁
UNLOCK TABLES

MySQL隐式和显示锁定
两阶段锁定协议
MySQL InnoDB采用的是两阶段锁定协议（two-phase locking protocol）。在事务执行过程中，随时都可以执行锁定，锁只有在执行 COMMIT或者ROLLBACK的时候才会释放，并且所有的锁是在同一时刻被释放。前面描述的锁定都是隐式锁定，InnoDB会根据事务隔离级别在需要的时候自动加锁。
读取操作显式锁定
InnoDB也支持通过特定的语句进行显示锁定，这些语句不属于SQL规范：
SELECT ... FOR UPDATE
对读取的行记录加一个X锁。其他事务想在这些行上加任何锁都会被阻塞。
SELECT … LOCK IN SHARE MODE
对读取的行记录加一个S锁。其他事务可以向被锁定的记录加S锁，但是对于加X锁，则会被阻塞。
上述两句SELECT锁定语句必须在一个事务中，当事务提交了，锁也就释放了，在使用时，务必加上BEGIN START TRANSACTION或者SET AUTOCOMMIT=O

一个lock in share mode 引起的死锁问题：
1、准备环境：
create database tempdb;
use tempdb;
create table t(x int);
insert into t(x) values(1);
2、事务一执行如下语句：mysql> start transaction;
Query OK, 0 rows affected (0.00 sec)
mysql> select * from t where x=1 lock in share mode;
+------+
| x |
+------+
| 1 |
+------+
1 row in set (0.00 sec)3、事务二执行如下语句：
mysql> start transaction;
Query OK, 0 rows affected (0.00 sec)
mysql> delete from t where x=1;
4、接着事务一又执行如下语句：
mysql> delete from t where x=1;
5、最后mysql 监控到死锁
ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction
原因分析：
1、事务一先是得到了x=1 这一行上的s 锁；
2、事务二要去申请x=1 这一行上的x锁，由于事务一已经得到了s锁，所以它要等待事务一释放s锁。
3、事务一又想去申请x=1 这一行上的x锁，由于事务二的申请在事务一的前面发起，所以它要等待事务二完成后才能得到。
由以上分析可知，事务一，事务二产生了相互等待；进而死锁产生。


触发器
触发程序是与表有关的命名数据库对象，当该表出现特定事件时，将激活该对象
监听：记录的增加、修改、删除。
创建触发器CREATE TRIGGER trigger_name trigger_time trigger_event ON tbl_name FOR EACH ROW trigger_stmt
参数：
trigger_time是触发程序的动作时间。它可以是 before 或 after，以指明触发程序是在激活它的语句之前或之后触发。
trigger_event指明了激活触发程序的语句的类型
INSERT：将新行插入表时激活触发程序
UPDATE：更改某一行时激活触发程序
DELETE：从表中删除某一行时激活触发程序
tbl_name：监听的表，必须是永久性的表，不能将触发程序与TEMPORARY表或视图关联起来。
trigger_stmt：当触发程序激活时执行的语句。执行多个语句，可使用BEGIN...END复合语句结构-
删除DROP TRIGGER [schema_name.]trigger_name
可以使用old和new代替旧的和新的数据
更新操作，更新前是old，更新后是new.
删除操作，只有old.
增加操作，只有new.-- 注意
1. 对于具有相同触发程序动作时间和事件的给定表，不能有两个触发程序。-- 字符连接函数
concat(str1,str2,...])
concat_ws(separator,str1,str2,...)-- 分支语句
if 条件 then
执行语句
elseif 条件 then
执行语句
else
执行语句
end if;-- 修改最外层语句结束符
delimiter 自定义结束符号
SQL语句
自定义结束符号
delimiter ; -- 修改回原来的分号-- 语句块包裹begin
语句块
end-- 特殊的执行1. 只要添加记录，就会触发程序。2. Insert into on duplicate key update 语法会触发：
如果没有重复记录，会触发 before insert, after insert;
如果有重复记录并更新，会触发 before insert, before update, after update;
如果有重复记录但是没有发生更新，则触发 before insert, before update3. Replace 语法 如果有记录，则执行 before insert, before delete, after delete, after insert

系统管理
用户和权限管理
root密码重置
1. 停止MySQL服务2. [Linux] /usr/local/mysql/bin/safe_mysqld --skip-grant-tables &
[Windows] mysqld --skip-grant-tables3. use mysql;4. UPDATE `user` SET PASSWORD=PASSWORD("密码") WHERE `user` = "root";5. FLUSH PRIVILEGES;
用户信息表：mysql.user
刷新权限
FLUSH PRIVILEGES;
增加用户
CREATE USER 用户名 IDENTIFIED BY [PASSWORD] 密码(字符串)
必须拥有mysql数据库的全局CREATE USER权限，或拥有INSERT权限。
只能创建用户，不能赋予权限。
用户名，注意引号：如 'user_name'@'192.168.1.1'
密码也需引号，纯数字密码也要加引号
- 要在纯文本中指定密码，需忽略PASSWORD关键词。要把密码指定为由PASSWORD()函数返回的混编值，需包含关键字PASSWORD
重命名用户
RENAME USER old_user TO new_user
-- 设置密码SET PASSWORD = PASSWORD('密码') 
-- 为当前用户设置密码SET PASSWORD FOR 用户名 = PASSWORD('密码') 
-- 为指定用户设置密码
-- 删除用户DROP USER 用户名
-- 分配权限/添加用户GRANT 权限列表 ON 表名 TO 用户名 [IDENTIFIED BY [PASSWORD] 'password']
all privileges 表示所有权限
*.* 表示所有库的所有表
库名.表名 表示某库下面的某表
GRANT ALL PRIVILEGES ON `pms`.* TO 'pms'@'%' IDENTIFIED BY 'pms0817'；
查看权限
SHOW GRANTS FOR 用户名
查看当前用户权限
SHOW GRANTS; 或 SHOW GRANTS FOR CURRENT_USER; 或 SHOW GRANTS FOR CURRENT_USER();
-- 撤消权限REVOKE 权限列表 ON 表名 FROM 用户名REVOKE ALL PRIVILEGES, GRANT OPTION FROM 用户名 
-- 撤销所有权限
权限层级
-- 要使用GRANT或REVOKE，您必须拥有GRANT OPTION权限，并且您必须用于您正在授予或撤销的权限。
全局层级：全局权限适用于一个给定服务器中的所有数据库，mysql.user
GRANT ALL ON *.*和 REVOKE ALL ON *.*只授予和撤销全局权限。
数据库层级：数据库权限适用于一个给定数据库中的所有目标，mysql.db, mysql.host
GRANT ALL ON db_name.*和REVOKE ALL ON db_name.*只授予和撤销数据库权限。
表层级：表权限适用于一个给定表中的所有列，mysql.talbes_priv
GRANT ALL ON db_name.tbl_name和REVOKE ALL ON db_name.tbl_name只授予和撤销表权限。
列层级：列权限适用于一个给定表中的单一列，mysql.columns_priv
当使用REVOKE时，您必须指定与被授权列相同的列。
权限列表
ALL [PRIVILEGES] -- 设置除GRANT OPTION之外的所有简单权限
ALTER -- 允许使用ALTER TABLE
ALTER ROUTINE -- 更改或取消已存储的子程序
CREATE -- 允许使用CREATE TABLE
CREATE ROUTINE -- 创建已存储的子程序
CREATE TEMPORARY TABLES -- 允许使用CREATE TEMPORARY TABLE
CREATE USER -- 允许使用CREATE USER, DROP USER, RENAME USER和REVOKE ALL PRIVILEGES。
CREATE VIEW -- 允许使用CREATE VIEWDELETE -- 允许使用DELETE
DROP -- 允许使用DROP TABLE
EXECUTE -- 允许用户运行已存储的子程序
FILE -- 允许使用SELECT...INTO OUTFILE和LOAD DATA INFILE
INDEX -- 允许使用CREATE INDEX和DROP INDEX
INSERT -- 允许使用INSERT
LOCK TABLES -- 允许对您拥有SELECT权限的表使用LOCK TABLES
PROCESS -- 允许使用SHOW FULL PROCESSLISTREFERENCES -- 未被实施
RELOAD -- 允许使用FLUSH
REPLICATION CLIENT -- 允许用户询问从属服务器或主服务器的地址
REPLICATION SLAVE -- 用于复制型从属服务器（从主服务器中读取二进制日志事件）SELECT -- 允许使用SELECT
SHOW DATABASES -- 显示所有数据库
SHOW VIEW -- 允许使用SHOW CREATE VIEW
SHUTDOWN -- 允许使用mysqladmin shutdown
SUPER -- 允许使用CHANGE MASTER, KILL, PURGE MASTER LOGS和SET GLOBAL语句，mysqladmin debug命令；允许您连接（一次），即使已达到max_connections。UPDATE -- 允许使用UPDATE
USAGE -- “无权限”的同义词GRANT OPTION -- 允许授予权限
表维护
分析和存储表的关键字分布
ANALYZE [LOCAL | NO_WRITE_TO_BINLOG] TABLE 表名 ...-- 检查一个或多个表是否有错误CHECK TABLE tbl_name [, tbl_name] ... [option] ...
option = {QUICK | FAST | MEDIUM | EXTENDED | CHANGED}
整理数据文件的碎片
OPTIMIZE [LOCAL | NO_WRITE_TO_BINLOG] TABLE tbl_name [, tbl_name] ...

创建event运行存储过程
指定时间删除过期数据
要求在每天的凌晨一点定时删除sys_msg_offline表上的上一个月数据，防止表中数据过多。
注意：creationDate中存放的是当前计算机时间和GMT时间(格林威治时间)1970年1月1号0时0分0秒所差的毫秒数。
一、设置开启事件设置
1、查看是否开启定时器
SHOW VARIABLES LIKE 'event_scheduler';     /*查看定时器状态*/
1
2、开启定时器 0：off 1：on
SET GLOBAL event_scheduler = 1;             /*开启事件设置*/
1
当你设定事件计划为0 或OFF，即关闭事件计划进程的时候，不会有新的事件执行，但现有的正在运行的事件会执行到完毕
对于我们线上环境来说，使用event时，注意在主库上开启定时器，从库上关闭定时器，event触发所有操作均会记录binlog进行主从同步，从库上开启定时器很可能造成卡库。切换主库后之后记得将新主库上的定时器打开。
请特别注意！
二、创建储存过程
DELIMITER $
CREATE PROCEDURE  pro_clear_data()
BEGIN    
    SET @news_date=(select UNIX_TIMESTAMP((select date_sub(NOW(),interval 1 MONTH))) * 1000); 
    /*设定删除数据的时间*/
    SET @max_id=(SELECT MAX(messageID) from sys_msg_offline where creationDate <= @news_date); 
    /*设定需要删除数据的最大messageID*/
    SET @news_count=(SELECT COUNT(messageID) FROM sys_msg_offline where messageID <= @max_id);  
    /*设定删除数据数量*/
    WHILE @news_count >0 DO
    /*删除需要删除的数据，一次最多1000*/
    SET @news_count=(SELECT COUNT(messageID) FROM sys_msg_offline where messageID <= @max_id); 
    /*刷新删除数据数量*/
    END WHILE; 
END $
三、创建事件
CREATE EVENT IF NOT EXISTS event_time_clear_data  
ON SCHEDULE EVERY 1 DAY STARTS date_add(date( ADDDATE(curdate(),1)),interval 1 hour) 
ON COMPLETION PRESERVE    
DO CALL pro_clear_data();
四、开启事件
ALTER EVENT event_time_clear_data ON COMPLETION PRESERVE ENABLE;
ALTER EVENT event_time_clear_data ON COMPLETION PRESERVE DISABLE;  

-- 字符串相关查询
SELECT pay_id,zptransid,FROM_UNIXTIME(ts_order),FROM_UNIXTIME(ts_payed) from user_order WHERE pay_id like '200908%';

SELECT left(pay_id,6),count(*) from user_order WHERE ts_payed>0 GROUP BY left(pay_id,6);


SELECT `game_order_id`,`server_id`, `uid`,  `product_id`,  `order`.`channel`, `channel_uid`,`order_id`,
                `order`.`money`, `order`.`currency`, `deliver_status`,  from_unixtime(`deliver_time`) as `deliver`,
                `extra`, from_unixtime(`create_time`) as `create` FROM `orders` 
                JOIN `order` ON orders.id=REPLACE(`order`.game_order_id,'p31prod_','') WHERE `uid`=101153;
								
								
						
SELECT SUM(`order`.`money`)/100 as `累计付费金额（元）`,  `uid`, `server_id`,`order`.`channel` FROM `orders` 
                JOIN `order` ON orders.id=REPLACE(`order`.game_order_id,'p31prod_','') and `deliver_status`=1 WHERE `order`.`order_id` not like 'dummy%'
								GROUP BY `order`.`channel`,`server_id`, `uid`;
								
								