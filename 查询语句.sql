
-- 如果book_ref的外键是book的图书编号，这个语句不会返回结果
SELECT * FROM book_ref
where 图书编号 NOT IN
      (SELECT 图书编号 FROM book);


select id,firstname,lastname,salary from  employee;

SELECT * FROM shell;

SELECT * FROM student2;

SELECT * FROM book;

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
select * from book_ref where 出版日期
                                 not in ('1990-2-23' );