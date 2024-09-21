#!/bin/bash
DATAX_HOME=/opt/module/datax
DATAX_DATA=/opt/module/datax/job/financial_lease/import

#如果传参 使用传参的日期 如果不传参数 使用默认值昨天
if [[ -n "$2" ]]; then
  #statements
  do_date=$2
else
  do_date=${date -d "-1 day" +%F}
fi


handle_targetdir(){
  hadoop fs -rm -r $1 >/dev/null 2>&1
  hadoop fs -mkdir -p $1
}

#数据同步
import_data(){
  target_dir=$1
  datax_config=$2
  handle_targetdir $target_dir
  echo "导入表格数据$datax_config"
  python ${DATAX_HOME}/bin/datax.py -p"-Dtargetdir=$target_dir" $datax_config >/tmp/datax_run.log 2>&1
  if [[ $? -ne 0 ]]; then
    #statements
    echo "导入数据失败 日志如下"
    cat /tmp/datax_run.log
  fi
}

case $1 in
  "business_partner" | "department" | "employee" | "industry"  )
  import_data "/origin_data/financial_lease/${1}_full/$do_date" $DATAX_DATA/financial_lease.$1.json 

    ;;
  "all" )
  for table in "business_partner"   "department"  "employee"  "industry";
  do
  import_data "/origin_data/financial_lease/${table}_full/$do_date" $DATAX_DATA/financial_lease.${table}.json 
  done

    ;;
esac
