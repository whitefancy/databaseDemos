-- 定义主键
create table if not exists book_copy
(
    图书编号 char(10) not null primary key ,
    封面图片 blob
);

create table if not exists book_copy1
(
    图书编号 char(10) not null  ,
    图书类别 varchar(20) not null default '未知',
    单价 float(10) not null ,
    数量 int(2),
    封面图片 blob,
    primary key (图书编号,图书类别)
);

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

-- 增加约束
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

-- 外键约束
