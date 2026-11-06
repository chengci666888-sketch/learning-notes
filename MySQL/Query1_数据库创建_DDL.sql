/*1.1 创建数据库

创建数据库

create database (name);

先判断再创建数据库

create database if not exists (name);

创建数据库指定字符集

create database (name) character set 字符集；

创建数据库指定排序方式

create database (name) collate 排序方式；

创建数据库指定字符集和排序方式

create database (name)character set 字符集 collate 排序方式；

查询数据库的字符集和排序方式

mysql8: 默认 utf8mb4 utf8mb4_0900_ai_ci

show variables like 'character_set_database';

show variables like 'collation_database';

练习：

*/

SHOW COLLATION LIKE 'utf8mb4_0900%';



CREATE DATABASE ddl_dl CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_cs;



/*1.2 数据库查看

查看所有库

show databases;

查看当前使用库

select database();

查看库下所有表

show tables from 数据库名；

查看创建库的信息和语句

show create database 数据库名；

选中和切换库

use 数据库名；

注意：对数据库进行操作之前，必须要选中库，use 数据库；use 数据库名；

*/

show databases;

/*1.3 数据库修改

修改字符集

alter database 数据库名 character set 字符集;

修改排序方式

alter database 数据库名 character set 字符集 collate 排序方式；

注意：数据库中没有修改数据库的指令如果想改名字，备份数据，删除旧库，创建新库，恢复数据即可！

*/



/*1.4 数据库删除

直接删除

drop database 数据库名；

判断删除

drop database if exists

注意：删除是危险操作！

*/

/*1.5 练习*/

create database blog_platform character set utf8mb4;

use blog_platform;

show variables like'character_set_database';

show variables like'collation_database';

alter database blog_platform collate utf8mb4_0900_as_cs;

drop database if exists blog_platform;

show databases;
