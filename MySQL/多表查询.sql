-- 多表查询可以跨数据库
select * from library.book_ref as bookref,company.employee as user;

-- 全连接后筛选
select book.出版商,sell.订购者,sell.是否发货
from book,sell
where book.图书编号=sell.图书编号;