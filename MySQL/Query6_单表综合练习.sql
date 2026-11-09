# 单表综合练习
#1、创建数据库test01_library
CREATE DATABASE IF NOT EXISTS test01_library CHARACTER SET 'utf8';
#指定使用数据库
USE test01_library;

#2、创建表 books
CREATE TABLE books(
    id INT,
    `name` VARCHAR(50),
    `authors` VARCHAR(100),
    price FLOAT,
    pubdate YEAR,
    note VARCHAR(100),
    num INT
);

#3、向books表中插入记录
# 1）不指定字段名称，插入第一条记录
INSERT INTO books
VALUES(1, 'Tal of AAA', 'Dickes', 23, 1995, 'novel', 11);

# 2）指定所有字段名称，插入第二记录
INSERT INTO books (id,NAME,`authors`,price,pubdate,note,num)
VALUES (2,'EmmaT','Jane lura',35,1993,'Joke',22);

# 3）同时插入多条记录
INSERT INTO books (id,NAME,`authors`,price,pubdate,note,num) VALUES
(3,'Story of Jane','Jane Tim',40,2001,'novel',0),
(4,'Lovey Day','George Byron',20,2005,'novel',30),
(5,'Old land','Honore Blade',30,2010,'Law',0),
(6,'The Battle','Upton Sara',30,1999,'medicine',40),
(7,'Rose Hood','Richard haggard',28,2008,'cartoon',28);

# 4、将小说类型(novel)的书的价格都增加5。
UPDATE books SET price = price + 5 WHERE note = 'novel';

# 5、将名称为EmmaT的书的价格改为40，并将说明改为drama。
UPDATE books SET price = 40, note = 'drama' WHERE NAME = 'EmmaT';

# 6、删除库存为0的记录。
DELETE FROM books WHERE num = 0;

# 7、统计书名中包含a字母的书
SELECT * FROM books WHERE NAME LIKE '%a%';

# 8、统计书名中包含a字母的书的数量和库存总量 [多行函数 | 聚合函数 count sum]
SELECT COUNT(1),SUM(num) FROM books WHERE NAME LIKE '%a%';

# 9、找出“novel”类型的书，按照价格降序排列
# order by | where
# 书写顺序：select 列名 from where group by having order by asc desc limit
SELECT * FROM books WHERE note ='novel' ORDER BY price DESC;

# 10、查询图书信息，按照库存量降序排列，如果库存量相同的按照note升序排列
SELECT * FROM books ORDER BY num DESC , note;

# 11、按照note分类统计书的数量 [分组问题]
# 分组 select 分组字段,聚合函数
SELECT note,COUNT(1) FROM books GROUP BY note;

# 12、按照note分类统计书的库存量，显示库存量超过30本的 [分组,统计每一组的num的和 和>30 having]
SELECT note,SUM(num) AS nm FROM books GROUP BY note HAVING nm > 30;

# 13、查询所有图书，每页显示4本，显示第二页 分页查询
# limit offset , number; 分页公式：limit (page-1)*size , size
SELECT * FROM books LIMIT 4,4;

# 14、按照note分类统计书的库存量，显示库存量最多的 [nm库存和排序,倒序+limit 1]
SELECT note,SUM(num) AS nm FROM books GROUP BY note ORDER BY nm DESC LIMIT 1;

# 15、查询书名达到10个字符的书，不包括里面的空格（函数 | string的函数 char_length | replace）
SELECT * FROM books WHERE CHAR_LENGTH(REPLACE(NAME,' ','')) >= 10;

#16、查询书名和类型，两种CASE写法
-- 写法1：搜索CASE（CASE WHEN 条件表达式，灵活，支持> <等判断）
SELECT NAME,note,
CASE
    WHEN note = 'novel' THEN '小说'
    WHEN note = 'law' THEN '法律'
    WHEN note = 'medicine' THEN '医药'
    WHEN note = 'cartoon' THEN '卡通'
    WHEN note = 'joke' THEN '笑话'
    ELSE '其他'
END AS TYPE
FROM books ;

-- 写法2：简单CASE（CASE 列名 WHEN 值，仅等值匹配，简洁）
SELECT NAME,note,
CASE note
    WHEN 'novel' THEN '小说'
    WHEN 'law' THEN '法律'
    WHEN 'medicine' THEN '医药'
    WHEN 'cartoon' THEN '卡通'
    WHEN 'joke' THEN '笑话'
    ELSE '其他'
END AS TYPE
FROM books ;

# 17、查询书名、库存状态，其中num值超过30本的，显示滞销，30-10代表正常，大于0并低于10的，显示畅销，为0的显示无货
SELECT NAME, num,
CASE
    WHEN num > 30 THEN '滞销'
    WHEN num >= 10 AND num <= 30 THEN '正常'
    WHEN num > 0 AND num < 10 THEN '畅销'
    WHEN num = 0 THEN '无货'
END AS 库存状态
FROM books;

# 18、统计每一种note的库存量，并合计总量
SELECT IFNULL(note,'合计总量') note, SUM(num) FROM books GROUP BY note WITH ROLLUP;

# 19、统计每一种note的数量，并合计总量
SELECT IFNULL(note,'合计总量') note, COUNT(*) FROM books GROUP BY note WITH ROLLUP;

# 20、统计库存量前三名的图书
SELECT NAME, num FROM books ORDER BY num DESC LIMIT 3;

# 21、找出最早出版的一本书
SELECT * FROM books ORDER BY pubdate ASC LIMIT 1;

# 22、找出novel中价格最高的一本书
SELECT * FROM books WHERE note = 'novel' ORDER BY price DESC LIMIT 1;

# 23、找出书名中字数最多的一本书，不含空格
SELECT *, CHAR_LENGTH(REPLACE(NAME,' ','')) len FROM books ORDER BY len DESC LIMIT 1;











