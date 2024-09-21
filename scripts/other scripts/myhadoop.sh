#!/bin/bash
if [ $# -lt 1 ]
then
 echo "No Args Input..."
 exit ;
fi
case $1 in
"start")
 echo " =================== 启动 hadoop-3.3.4 集群 ==================="
 echo " --------------- 启动 hdfs ---------------"
 ssh hadoop108 "/opt/module/hadoop-3.3.4/sbin/start-dfs.sh"
 echo " --------------- 启动 yarn ---------------"
ssh hadoop109 "/opt/module/hadoop-3.3.4/sbin/start-yarn.sh"
 echo " --------------- 启动 historyserver ---------------"
 ssh hadoop110 "/opt/module/hadoop-3.3.4/bin/mapred --daemon start historyserver"
;;
"stop")
 echo " =================== 关闭 hadoop-3.3.4 集群 ==================="
 echo " --------------- 关闭 historyserver ---------------"
 ssh hadoop108 "/opt/module/hadoop-3.3.4/bin/mapred --daemon stop historyserver"
 echo " --------------- 关闭 yarn ---------------"
 ssh hadoop109 "/opt/module/hadoop-3.3.4/sbin/stop-yarn.sh"
 echo " --------------- 关闭 hdfs ---------------"
 ssh hadoop110 "/opt/module/hadoop-3.3.4/sbin/stop-dfs.sh"
;;
*)
 echo "Input Args Error..."
;;
esac
