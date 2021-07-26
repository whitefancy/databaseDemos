-- 新建表
CREATE DATABASE IF NOT EXISTS company;

CREATE SCHEMA PETSTORE;
-- 指定字符集与校对规则
CREATE DATABASE IF NOT EXISTS yggl character set gb2312 collate gb2312_chinese_ci;

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

-- 修改数据库
ALTER DATABASE PETSTORE character set gb2312 collate gb2312_chinese_ci;

-- 删除数据库
DROP DATABASE yggl;
DROP DATABASE IF EXISTS yggl;

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


-- 时区更改后，时间戳表示正确的时间，而不是日期时间。
-- 显示时区
 show variables like '%time_zone%';
--  设置时区
set time_zone="america/new_york";
select * from datetime_type;
-- 主要区别在于DATETIME是常数，而TIMESTAMP受time_zone设置影响。仅当您拥有（或将来可能拥有）跨时区的同步集群时，它才有意义。
--  您的应用程序不应依赖于服务器的时区。在发出任何查询之前，应用程序应始终在其使用的数据库连接会话中选择时区。
-- 如果多个用户（例如：webapp）之间共享连接，请使用UTC并在呈现端进行时区转换。
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


 -- 修改表的存储引擎
ALTER TABLE  enum_set_type ENGINE =INNODB;

-- 创建库
-- CREATE DATABASE[ IF NOT EXISTS] 数据库名 数据库选项
-- 数据库选项：
-- COLLATE collation_name-- 查看已有库
-- SHOW DATABASES[ LIKE 'PATTERN']-- 查看当前库信息
-- SHOW CREATE DATABASE 数据库名-- 修改库的选项信息
-- ALTER DATABASE 库名 选项信息-- 删除库
-- DROP DATABASE[ IF EXISTS] 数据库名
-- 同时删除该数据库相关的目录及其目录内容
CREATE DATABASE IF NOT EXISTS test1;

-- CREATE [TEMPORARY] TABLE[ IF NOT EXISTS] [库名.]表名 ( 表的结构定义 )[ 表选项]
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
-- 字段名 数据类型 [NOT NULL | NULL] [DEFAULT default_value] [AUTO_INCREMENT] [UNIQUE [KEY] | [PRIMARY] KEY] [COMMENT 'string']-- 表选项
-- -- 字符集
-- CHARSET = charset_name
-- 如果表没有设定，则使用数据库字符集


-- 创建视图create view
-- CREATE VIEW 视图名(列1，列2...) AS SELECT (列1，列2...) FROM ...;
-- 修改和创建视图
-- CREATE OR REPLACE VIEW 视图名 AS SELECT [...] FROM [...];
-- 查看表详情一样使用desc 视图名，另外一种方法是show fields from 视图名


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

-- 复制表
create table if not exists book1 like book;

create table if not exists book2  as select * from book where book.价格<3;

-- 删除表
drop table if exists book2;

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


-- 没有参与索引和视图的表，可以用truncate快速删除表的所有记录 该方法无法恢复
TRUNCATE book_copy1;

-- default则用默认值 ignore违背唯一约束时，不执行该语句
insert ignore into library.book
values (2,default,22,4,null,"三毛","文艺出版社");

-- 指定列名
insert ignore into library.book(图书编号,图书类别, 价格, 数量, 作者1, 出版商)
values (3,default,22,4,"三毛","文艺出版社");

-- 指定参数
insert into book set 图书编号=4,价格=12,图书类别=default,作者1="菲茨杰拉德";
-- replace可以替换记录，不用考虑主键冲突 影响两行，插入一行，删除一行。
replace into library.book
values (2,default,16,4,null,"三毛","文艺出版社");

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


-- 增加外键约束
ALTER TABLE book_ref
add foreign key (图书编号)
    references book_copy5(图书编号)
    on DELETE CASCADE
    on UPDATE CASCADE;

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

-- 删除完整性约束
ALTER TABLE book_copy5 DROP primary key ;

ALTER TABLE book_ref DROP FOREIGN KEY book_ref_ibfk_2;

/* Windows服务 */-- 启动MySQL
net start mysql-- 创建Windows服务

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

SHOW ENGINES -- 显示存储引擎的状态信息
SHOW ENGINE 引擎名 {LOGS|STATUS} -- 显示存储引擎的日志或状态信息
-- 自增起始数
AUTO_INCREMENT = 行数
-- 数据文件目录
DATA DIRECTORY = '目录'
-- 索引文件目录
INDEX DIRECTORY = '目录'
-- 表注释
COMMENT = 'string'
-- 分区选项
PARTITION BY ... (详细见手册)-- 查看所有表
SHOW TABLES[ LIKE 'pattern']
SHOW TABLES FROM 库名-- 查看表结构
SHOW CREATE TABLE 表名 （信息更详细）
DESC 表名 / DESCRIBE 表名 / EXPLAIN 表名 / SHOW COLUMNS FROM 表名 [LIKE 'PATTERN']
SHOW TABLE STATUS [FROM db_name] [LIKE 'pattern']-- 修改表
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

INSERT [INTO] 表名 [(字段列表)] VALUES (值列表)[, (值列表), ...]
-- 如果要插入的值列表包含所有字段并且顺序一致，则可以省略字段列表。
-- 可同时插入多条数据记录！
REPLACE 与 INSERT 完全一样，可互换。
INSERT [INTO] 表名 SET 字段名=值[, 字段名=值, ...]-- 查
SELECT 字段列表 FROM 表名[ 其他子句]
-- 可来自多个表的多个字段
-- 其他子句可以不使用
-- 字段列表可以用*代替，表示所有字段-- 删
DELETE FROM 表名[ 删除条件子句]
没有条件子句，则会删除全部-- 改
UPDATE 表名 SET 字段名=新值[, 字段名=新值] [更新条件]

字符集编码
/* 字符集编码 */ -------------------- MySQL、数据库、表、字段均可设置编码-- 数据编码与客户端编码不需一致
SHOW VARIABLES LIKE 'character_set_%' -- 查看所有字符集编码项
character_set_client 客户端向服务器发送数据时使用的编码
character_set_results 服务器端将结果返回给客户端所使用的编码
character_set_connection 连接层编码SET 变量名 = 变量值
SET character_set_client = gbk;
SET character_set_results = gbk;
SET character_set_connection = gbk;SET NAMES GBK; -- 相当于完成以上三个设置-- 校对集
校对集用以排序
SHOW CHARACTER SET [LIKE 'pattern']/SHOW CHARSET [LIKE 'pattern'] 查看所有字符集
SHOW COLLATION [LIKE 'pattern'] 查看所有校对集
CHARSET 字符集编码 设置字符集编码
COLLATE 校对集编码 设置校对集编码

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

FROM 子查询
用于标识查询来源。
-- 可以为表起别名。使用as关键字。
SELECT * FROM tb1 AS tt, tb2 AS bb;
-- from子句后，可以同时出现多个表。
-- 多个表会横向叠加到一起，而数据会形成一个笛卡尔积。
SELECT * FROM tb1, tb2;
-- 向优化符提示如何选择索引
USE INDEX、IGNORE INDEX、FORCE INDEX


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
