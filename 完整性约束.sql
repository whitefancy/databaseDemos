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
