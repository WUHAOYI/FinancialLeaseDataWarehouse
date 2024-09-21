#!/bin/bash

# 该脚本的作用是初始化所有的增量表，只需执行一次
MAXWELL_HOME=/opt/module/maxwell-1.29

import_data() {
 $MAXWELL_HOME/bin/maxwell-bootstrap --database financial_lease --table $1 --config $MAXWELL_HOME/config.properties
}

case $1 in
"contract" | "credit" | "credit_facility" | "credit_facility_status" | "reply")
  import_data $1
  ;;
"all")
  for table in "contract"  "credit"  "credit_facility"  "credit_facility_status"  "reply";
  do
    #statements
    import_data $table
  done
  ;;
esac
