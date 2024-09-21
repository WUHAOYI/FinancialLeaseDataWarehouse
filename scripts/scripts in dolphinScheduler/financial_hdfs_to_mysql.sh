#! /bin/bash

DATAX_HOME=/opt/module/datax/
DATAX_DATA=/opt/module/datax/job/financial_lease

#DataX导出路径不允许存在空文件，该函数作用为清理空文件
handle_export_path(){
  for i in `hadoop fs -ls -R $1 | awk '{print $8}'`; do
    hadoop fs -test -z $i
    if [[ $? -eq 0 ]]; then
      echo "$i文件大小为0，正在删除"
      hadoop fs -rm -r -f $i
    fi
  done
}

#数据导出
export_data() {
  export_dir=$1
  datax_config=$2
  echo "正在处理 $2 ......"
  handle_export_path $export_dir
  $DATAX_HOME/bin/datax.py -p"-Dexportdir=$export_dir" $datax_config >/tmp/datax_run.log 2>&1
  if [ $? -ne 0 ]
	then
	  echo "处理失败，日志如下："
	  cat /tmp/datax_run.log
  fi
}

case $1 in
  ads_unfinished_audit_stats | ads_lease_org_unfinished_audit_stats | ads_department_unfinished_audit_stats | ads_salesman_unfinished_audit_stats | ads_credit_audit_unfinished_audit_stats | ads_industry_unfinished_audit_stats | ads_finished_audit_stats | ads_lease_org_finished_audit_stats | ads_department_finished_audit_stats | ads_salesman_finished_audit_stats | ads_credit_audit_finished_audit_stats | ads_industry_finished_audit_stats | ads_credit_audit_finished_transform_stats)
    export_data /warehouse/financial_lease/ads/$1 ${DATAX_DATA}/export/financial_report.$1.json 
  ;;
  
  "all")
    for tab in ads_unfinished_audit_stats ads_lease_org_unfinished_audit_stats ads_department_unfinished_audit_stats ads_salesman_unfinished_audit_stats ads_credit_audit_unfinished_audit_stats ads_industry_unfinished_audit_stats ads_finished_audit_stats ads_lease_org_finished_audit_stats ads_department_finished_audit_stats ads_salesman_finished_audit_stats ads_credit_audit_finished_audit_stats ads_industry_finished_audit_stats ads_credit_audit_finished_transform_stats
    do 
      export_data  /warehouse/financial_lease/ads/${tab} ${DATAX_DATA}/export/financial_report.${tab}.json
    done
    ;;
esac
