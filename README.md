## 1.脚本文件说明
### 1.1 Scripts in DolphinScheduler
1. `financial_mysql_to_hdfs_full.sh`：DataX全量同步数据的脚本文件
2. `financial_hdfs_to_ods.sh`：将hdfs中存储的数据加载到hive表中
3. `financial_ods_to_dim.sh`：更新dim层各表内容
4. `financial_ods_to_dwd.sh`：更新dwd层各表内容
5. `financial_dwd_to_ads.sh`：更新ads层各表内容
6. `financial_hdfs_to_mysql.sh`：将ads层各表中的数据从hdfs中读取出来并导入到MySQL中（DataX）

### 1.2 Other Scripts
1. `financial_mysql_to_kafka_inc_init.sh`：增量表的首日全量同步（只需首日执行一次即可）
2. `financial_ods_to_dwd_init.sh`：dwd层各表的初始化操作（因为dwd层通过累积型快照事实表进行审批流程状态的存储，在初始化时需要对以往的所有数据进行汇总，后续无需执行初始化操作）
3. `financial_mock.sh`：数据模拟脚本文件
4. `myhadoop.sh`：hadoop启停脚本
5. `kf.sh`：kafka启停脚本
6. `mxw.sh`：Maxwell启停脚本
7. `flume.sh`：flume启停脚本
8. `zk.sh`：zookeeper启停脚本
9. `jpsall`：jps查看所有机器上的进程
10. `xsync`：文件传输脚本

## 2.文档说明
文档“**项目开发记录**”记录了整个开发过程
文件夹“**charts**”记录了部分图表

## 3.SQL文件说明
1. `create_ods.sql`：ods层建表语句
2. `create_dim.sql`：dim层建表语句
3. `create_dwd.sql`：dwd层建表语句
4. `create_ads.sql`：ads层建表语句
5. `create_report.sql`：MySQL报表建表语句
6. `load_dim.sql`：dim层数据装载语句
7. `load_dwd.sql`：dwd层数据装载语句
8. `load_ads.sql`：ads层数据状态语句

> 数据装载语句不需要手动执行，已经在脚本中封装好了
>



