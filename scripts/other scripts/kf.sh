#! /bin/bash

case $1 in
"start"){
    for i in hadoop108 hadoop109 hadoop110
    do
        echo " --------启动 $i Kafka-------"
        ssh $i "/opt/module/kafka-2.12/bin/kafka-server-start.sh -daemon /opt/module/kafka-2.12/config/server.properties"
    done
};;
"stop"){
    for i in hadoop108 hadoop109 hadoop110
    do
        echo " --------停止 $i Kafka-------"
        ssh $i "/opt/module/kafka-2.12/bin/kafka-server-stop.sh "
    done
};;
esac
