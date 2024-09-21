#!/bin/bash

case $1 in
"start")
        echo " --------启动 hadoop110 业务数据flume-------"
        ssh hadoop110 "nohup /opt/module/flume-1.10/bin/flume-ng agent -n a1 -c /opt/module/flume-1.10/conf -f /opt/module/flume-1.10/job/financial_kafka_to_hdfs_db.conf >/dev/null 2>&1 &"
;;
"stop")

        echo " --------停止 hadoop110 业务数据flume-------"
        ssh hadoop110 "ps -ef | grep financial_kafka_to_hdfs_db | grep -v grep |awk '{print \$2}' | xargs -n1 kill"
;;
esac
