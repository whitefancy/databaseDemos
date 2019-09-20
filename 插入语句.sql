insert into employee values (211,"BU","Ellie",40000);

insert into library.book values(1,"小说",23,2,null,"毛姆","三联书店") ;
insert into library.book_copy5 values(1,"月亮与六便士","小说",23,null) ;

insert into library.book_ref
values (2,"撒哈拉的故事",date("1990-02-23")),
       (4,"万水千山走遍",date("1990-02-23")),
       (5,"白手起家",date("1990-02-23")),
       (7,"梦里落花知多少",date("1990-02-23"));

-- default则用默认值 ignore违背唯一约束时，不执行该语句
insert ignore into library.book
values (2,default,22,4,null,"三毛","文艺出版社");

-- 指定列名
insert ignore into library.book(图书编号,图书类别, 价格, 数量, 作者1, 出版商)
values (3,default,22,4,"三毛","文艺出版社");

-- 指定参数
insert into book set 图书编号=4,价格=12,图书类别=default,作者1="菲茨杰拉德";

insert into library.sell set 图书编号=2,数量=3,单价=4.4,订单号=2,是否发货='已发货';
-- replace可以替换记录，不用考虑主键冲突 影响两行，插入一行，删除一行。
replace  into library.book
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