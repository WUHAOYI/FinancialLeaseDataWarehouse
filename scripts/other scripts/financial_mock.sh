#!/bin/bash

for((i=0;i<$1;i++)){
    echo "========== 正在执行第 $(($i+1)) 次数据模拟 =========="
    nohup ssh hadoop108 "cd /opt/module/financial_mock_app/; java -jar mock-finance-1.3.0.jar" >/opt/module/financial_mock_app/mock_log.txt 2>&1
}
