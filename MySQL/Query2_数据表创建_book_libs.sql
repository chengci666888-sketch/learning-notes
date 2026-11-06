-- 从 SQLyog 备份恢复的标签内容
-- 原标签: Query 2, 位置: 1

#DDL之数据表操作
/*2.1建表语法
建表语法总结
create table [if not exist] 表名（
# 列的信息
列名 类型[列的约束][列的注释]，
列名 类型[列的约束][列的注释]，
...
列名 类型[列的约束][列的注释]
）[描述][注释]

建表事项
1.表名，列名，列类型必须填写。
2.推荐使用if not exists.
3.注释不是必须的，但是很有必要的.、
4.列之间使用逗号隔开，但最后一列没有
*/

create database if not exists book_libs character set utf8mb4 collate utf8mb4_0900_as_cs;
use book_libs;

create table if not exists books(
#列的信息
book_name varchar(20) comment'图书名',
book_price double(4,1) comment'图书价格',
book_num int comment'图书数量'
)charset = utf8mb4 comment '图书表';

show tables from book_libs;

DROP DATABASE IF EXISTS book_libs;


