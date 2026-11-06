-- 从 SQLyog 备份恢复的标签内容
-- 原标签: Query 3, 位置: 2

/*2.3 整型
有符号:列名 整数类型->有符号|有符号有负值和正值
列名 整数类型 unsigned ->无符号|无符号没有负值，都是正值，将负值部分，绝对值后，加入正值部分!

创建一个dd1d1库中，创建一个t1表，包含:年龄和学号(范围不确定，但是没有负值)
*/
create table tl(
t1_age tinyint unsigned comment '年龄，无符号，范围0-255'
t1_number bigint unsigned comment '学号，最大的，且无负号'
)
/* 2.4 建表类型[浮点/定值]
浮点类型（类型，M,D）(M = 整数加小数位长度 D = 小数位长度)
flout（m，d）    4字节   m 24  d 8
double（m，d）   8字节   m 53  d 30
定值类型（类型，M,D）
decimal(m,d) 动态占有 m 65  d = 30
使用对比:
    精度要求不高，如：身高，体重 flout/double
    精度要求高，如：钱，工资，价格 decimal
*/

/*2.5 字符串
字符串类型
  char 固定长度类型 一旦声明固定占有对应的空间M最大255[性能较好]
  varchar 可变长度类型一旦声明，可以插入小于的长度，白动进行伸缩M占有的空间不能超过一行的最大显示65535字节[性能一股]
  tex 大文本类型，声明不要指定长度，有固定的大小限制，tex[65535]，不占有一行的最大限制空间
细节理解
  1.char声明的时候可以不写m char = char(1)
  2.char声明了最大长度限制,输入的文本小于长度限制，会在右侧补全空格 char(5)->‘abc’->‘abc
  3.char类型在读取的时候，会自动去掉右侧的空格'abc  '->'abc'
  4.varchar声明的时候,必须添加m限制 varchar(m)
  5.mysq14.0以下版本 varchar(20)->20字节限制  mb3-> 6
  6.mysq15.0以上版本 varchar(20)->20字符限制
  7.varchar类型中识别空格，插入空格 读取也是有空格
演示varchar最大限制
前提:mysq1中一行数据最大的占有空间是65535字节，除了TEXTor BLOBs类型的列(不占有65535限制 法外狂徒)
    一行->name1列 ->name1列占有的最大空间65535字节
    varchar类型默认会使用1字节标识是否为nul1->65535-1 = 65534字节
    字符集utf8mb4 1个字符=4个字节65534 / 4 = 16383
    解决方案：
        1.缩小字符大小限制m变小[不合理]
        2.可以修改字符集[不合理1
        3.可以将字符串类型变成TEXT，不占有一行的限制
*/
create table t2(
tx text
)
/*2.6 建表类型[时间类型]
时间类型
year  1  YYYY | YY '09' 09
time  3  HH:MM:SS '10:10:10'
date  3  YY-MM-DD '2000:10:10'
datetime 8 YY-MM-DD HH:MM:SS
timestamp 4 YY-MM-DD HH:MM:SS
注意事项
   1.year类型有两位或者四位的表达形式,两位 00 - 69 =2000 - 2069 70-99 = 1970 - 1999
   2.时间类型就是一个特殊格式的字符串,插入数据的时候 '',时间类型需要自动赋值,需要手动添加相关的设置!
扩展自动填写时间:
   1.插入默认添加时间
     datetime | timestamp default current_timestamp ;
   2.修改默认更改时间(插入的默认时间)
     datetime | timestamp default current_timestamp on update current_timestamp;
演示: 创建t2表,
注册日期 字段插入自动添加时间,更新数据不变
更新日期 字段插入自动添加时间,更新数据时间改变
*/
create table t3(
name varchar(20),
register_time default current_timestamp comment '插入自动维护时间';
update_time timestamp default current_timestamp on update current_timestamp;
)
/* 2.7 创建表实战
student -> 字符集 -> 默认
姓名 -> stu_name       varchar(10)
性别 -> stu_sex        char
年龄 -> stu_age        tinyint unsigned
身高 -> stu_height     double(4,1)
生日 -> stu_birthday   date
注册 -> stu_regtime    timestamp default current_timestamp
更新 -> stu_uptime     timestamp default current_timestamp on update timestamp
*/
create database book_libs character set utf8mb4 collate utf8mb4_0900_as_cs;
use book_libs;
create table syudent( 
stu_name VARCHAR (10) COMMENT'学生的姓名',
stu_sex CHAR COMMENT '学生的性别',
stu age TINYINT UNSIGNED COMMENT '年龄',
stu height DOUBLE (4,1) COMMENT '身高',
stu birthday DATE COMMENT '生日',
stu_register TIMESTAMP DEFAULT CURRENT TIMESTAMP COMMENT '注册日期，插入的时候自动维护',
stu_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_tIMESTAMP COMMENT '更新日期，插入和更新自动维护时间'
)
/*2.8 修改和删除表
修改表中列
  添加列
    alter table 表名 add 列名 类型 {first / after 原列名}
  修改列名
    alter table 表名 change 原列名 新列名 新类型 {first / after 原列名}
  修改列类型
    alter table 表名 modify 列名 新类型 {first / after 原列名}
  删除列
    alter table 表名 drop 列名;
  修改表名
    alter table 表名 rename [to] 新表名；
  删除表
    drop table [if exists] 表名；
  清空表数据
    truncate table 表名;表中数据 + 删除表的相关记录
*/
#总结练习
CREATE TABLE employess(
  emp_num INT ,
  last_name VARCHAR(50),
  first_name VARCHAR(50),
  mobile VARCHAR(25),
  `code` INT ,
  job_title VARCHAR(50),
  birth DATE,
  note VARCHAR(255),
  sex VARCHAR(5)
)

DESC employess;

# 要求2：将表employess的mobile字段修改到code字段后面。
ALTER TABLE employess MODIFY mobile VARCHAR(25) AFTER CODE;
# 要求3：将表employess的birth字段改名为birthday;
ALTER TABLE employess CHANGE birth birthday DATE;
# 要求4：修改sex字段，数据类型为char（1）。
ALTER TABLE employess MODIFY sex char(1);
# 要求5：删除字段note;
alter table employess drop note;
# 要求6：增加字段名favoriate_activity，数据类型为varchar（100）；
alter table employess add favoriate_activity varchar(100);
# 要求7：将表employess的名称修改为 employees_info
alter table employess rename employees_info;
show tables;
SELECT * FROM employees_info;


