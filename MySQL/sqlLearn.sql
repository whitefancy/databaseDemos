第一章 检索记录



SELECT * FROM EMP 

SELECT * FROM EMP WHERE deptNO=10

查找满足多个查询条件的行
SELECT * FROM EMP WHERE deptNO=10 or comm is NULL or sal<=2000 AND DEPTNO=20  
SELECT * FROM EMP WHERE (deptNO=10 or comm is NULL or sal<=2000) AND DEPTNO=20  
TODO 并列多个条件且没有括号的情况下的优先级？

筛选列

SELECT ename,deptno,sal from EMP
在整个网络范围内检索数据时，指定具体的列名尤为重要，避免把时间浪费在检索不需要的数据上。

创建有意义的列名
SELECT sal as salary, comm as commission FROM EMP

在where子句中引用别名列
select * from (SELECT sal as salary, comm as commission FROM EMP )x WHERE salary<5000
内嵌视图的别名为x，mysql必须给内嵌视图起别名

串联多个列的值
SELECT concat(ename,' works as a ',job) as msg FROM EMP WHERE deptno=10

在select语句中使用条件逻辑
SELECT ename,sal, CASE 
	WHEN sal<=2000 THEN
		'UNDERPAID'
	WHEN sal>=4000 THEN
		'OVERPAID'
	ELSE
		'OK'
END as status FROM EMP;

为case表达式的执行结果取一个别名，使结果集更有可读性，本例中为status。ELSE子句是可选的。

限定返回的行数

SELECT * FROM EMP LIMIT 3,5


随机返回若干行记录
SELECT ename,job from EMP ORDER BY RAND() LIMIT 5
不要误认为order by子句的函数是数值常量。实际上是一个函数，用来计算每一行的结果来比较

查找null值
SELECT * FROM EMP WHERE comm is null
SELECT * FROM EMP WHERE comm is not null

把null值转换为实际值
SELECT COALESCE(comm,0) FROM EMP
尽管case也能把null值转换成实际值，但COALESCE函数更方便简洁

查找匹配项
SELECT ename,job from EMP WHERE deptno in (10,20)
从编号10和20的两个部门找到名字含有字母I或者职位以ER结尾的人
SELECT ename,job FROM EMP WHERE deptno in (10,20) and (ename like '%I%' or job like '%ER')
结合使用LIKE运算符和通配符%
下划线_运算符匹配单个字符

查询结果排序
SELECT ename,job,sal FROM EMP WHERE deptno=10 order by sal asc
asc升序，desc降序
指定一个数值代替列名，从1开始，从左到右匹配SELECT列表里的列
SELECT ename,job,sal FROM EMP WHERE deptno=10 order by 3 desc
多字段排序，逗号分隔
SELECT empno,deptno,sal,ename,job
FROM EMP order by deptno,sal desc
如果你的查询语句中有group by 或 distinct，就不能按照select列表之外的列进行排序
