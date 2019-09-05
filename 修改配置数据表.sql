-- 创建表
create table if not exists book
(
    图书编号 char(10) not null primary key ,
    图书类别 varchar(20) not null default '未知',
    单价 float(10) not null ,
    数量 int(2),
    封面图片 blob

)engine =InnoDB;


 -- 创建取消索引更改表评注和表类型

-- 增加列
Alter table book
add column 作者 char(10) null;

Alter table book
    add column 作者1 char(10) null,
    add column 作者2 char(10) null,
    add column 出版商 varchar(20) null ;

-- 重命名表
Alter table book
rename to books ;

rename table books to book;

-- 重命名列
Alter table book
    change 单价 价格 float(9);

-- 修改指定列的类型
ALTER table book
    modify 数量 bigint not null default 0;

    ALTER table book
        modify 数量 bigint not null default 0,
        drop column 作者2;

-- 删除列或约束
Alter table book
    drop column 作者;

-- 复制表
create table if not exists book1
like book;

create table if not exists book2
    as select * from book where book.价格<3;

-- 删除表
drop table if exists book2;

-- 显示表信息
show tables;

-- 显示表结构
desc book;
describe book1;
describe book1 图书编号;
