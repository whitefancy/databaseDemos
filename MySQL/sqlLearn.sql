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


根据子串进行排序
按照职位字段的最后两个字符对检索结果进行排序
SELECT ename,job from emp order by substr(job,length(job)-2)

mysql不支持对含有字母和数字的列排序
排序时对null值的处理
对为null的列都放在后面
SELECT ename,sal,comm from (SELECT ename,sal,comm,case when comm is null then 0 else 1 end as is_null from emp)x 
order by is_null desc,comm
除非数据库管理系统提供了在无需修改null值数据的情况下方便排序null，否则要自己添加辅助列

依据条件逻辑动态调整排序项
如果job等于salesman，就按comm来排序，否则按sal排序
SELECT ename,sal,job,comm from emp order by case when job='SALESMAN' then comm else sal end 
可以利用case表达式动态调整结果的排序方式
SELECT ename,sal,job,comm,case when job='SALESMAN' then comm else sal end as ordered from emp order by 5

多表查询
叠加两个行集
列的数据类型相同.数目相同，可以将一个结果集叠加在另一个之上。
SELECT ename as ename_and_dname, deptno from emp WHERE deptno =10
union all
select '----------',null from t1 
union all
SELECT dname,deptno from dept

合并相关行
SELECT e.ename,d.loc from emp e, dept d WHERE e.deptno=d.deptno and e.deptno=10
这是内连接中的相等连接 理论上会先做笛卡尔积
SELECT e.ename,d.loc,e.deptno,d.deptno from emp e, dept d WHERE e.deptno=10
然后通过where子句做连接操作，限定返回的行
显式写法
SELECT e.ename,d.loc from emp e inner join dept d on (e.deptno=d.deptno) WHERE e.deptno=10

查找两个表中相同的行
CREATE VIEW V as SELECT ename,job,sal from emp WHERE job='CLERK'
SELECT * from V
想从EMP表中获取与视图V相匹配的全部员工的empno,ename,job,sal,deptno
使用集合运算INTERSECT 代替连接查询，并返回两个表的交集（相同的行）
SELECT e.empno,e.ename,e.job,e.sal,e.deptno from emp e,V WHERE e.ename=v.ename
and e.job=v.job and e.sal =v.sal
注意，当执行集合运算时，默认不会返回重复项

查找只存在于一个表中的数据
找出在dept表中存在而在emp表中不存在的部门编号（如果有的话）
mysql没有提供差集函数
SELECT deptno from dept WHERE deptno not in (select deptno from emp)

在使用not in时，要注意null值
CREATE TABLE new_dept(deptno integer)
INSERT into new_dept VALUES(10)
INSERT into new_dept VALUES(50)
INSERT into new_dept VALUES(null)
此时会查不到任何值 因为在sql中， true or null 的运算结果是true
而false or null的运算结果是null，混入null，结果会保持null
SELECT deptno from dept WHERE deptno not in (select deptno from new_dept)
为了避免该问题，需要结合使用not exists和关联子查询
SELECT d.deptno from dept d WHERE not exists( select null from emp e WHERE d.deptno =e.deptno)
SELECT d.deptno from dept d WHERE not exists( select null from new_dept e WHERE d.deptno =e.deptno)
先通过内连接去除null值，然后再从连结的表中进行计算（可能是这样）

从一个表检索另一个表的不相关行
找出哪个部门没有员工
SELECT d.* from dept d left join emp e 
on (d.deptno=e.deptno) WHERE e.deptno is null
这种操作有时被称为反连接（anti-join）
没有过滤掉null的结果集
SELECT e.ename,e.deptno as emp_deptno,d.* from dept d left join emp e on (d.deptno=e.deptno)

新增连接查询而不影响其他连接查询
CREATE TABLE emp_bonus(empno integer,received date,type integer)
INSERT into emp_bonus(empno,received,type) VALUES(7369,'2005-05-14',1)
INSERT into emp_bonus(empno,received,type)  VALUES(7900,'2005-05-14',2)
INSERT into emp_bonus(empno,received,type)  VALUES(7788,'2005-05-14',3)
原查询
SELECT E.ENAME,D.LOC FROM EMP E, DEPT D WHERE E.DEPTNO=D.DEPTNO
新增员工奖金的查询 
为了避免影响原有的结果，使用了左外连接
SELECT e.ename,d.loc,eb.received from emp e join dept d on ( e.deptno=d.deptno) 
left join emp_bonus eb on ( e.empno=eb.empno) 
order by 2
也可以使用标量子查询
SELECT e.ename,d.loc,(SELECT eb.received from emp_bonus eb WHERE eb.empno= e.empno) as received
FROM emp e,dept d WHERE e.deptno=d.deptno order by 2
标量子查询的敲门之处在于不破坏当前结果集的情况下，为现有查询语句添加额外数据
但应确保返回的是标量，如果返回多行，查询会报错

确定两个表里是否有相同的数据
CREATE view V1 as SELECT * FROM emp WHERE deptno !=10
union all
SELECT * FROM emp WHERE ename = 'WARD'
SELECT * FROM V1
不仅要找到相同的数据，还要找到重复的数据。
SELECT d.* from dept d WHERE not exists( select null from V1 e WHERE d.deptno =e.deptno,全部字段连接)
union all
SELECT v.* from V1 v WHERE not exists( select null from dept e WHERE d.deptno =e.deptno,全部字段连接)
解决方案的原理：
首先找出存在于表1而不存在与表2的行
然后找出存在于表2而不存在于表1的行
合并结果集

比较行数
SELECT count(*) from emp  union SELECT count(*) FROM dept
