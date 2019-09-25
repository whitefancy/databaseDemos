delete from library.book where 图书编号=1;

delete from library.book_copy5 where 图书编号=1;

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