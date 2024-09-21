#!/bin/bash

APP=financial_lease

if [ -n "$2" ] ;then
   do_date=$2
else 
   do_date=`date -d '-1 day' +%F`
fi

load_data(){
    sql=""
    for i in $*; do
        #判断路径是否存在
        hadoop fs -test -e /origin_data/$APP/${i:4}/$do_date
        #路径存在方可装载数据
        if [[ $? = 0 ]]; then
            sql=$sql"load data inpath '/origin_data/$APP/${i:4}/$do_date/' OVERWRITE into table ${APP}.$i partition(dt='$do_date');"
        fi
    done
    hive -e "$sql"
}

case $1 in
    ods_business_partner_full | ods_department_full | ods_employee_full | ods_industry_full | ods_credit_facility_inc | ods_credit_facility_status_inc | ods_reply_inc | ods_credit_inc | ods_contract_inc)
        load_data $1
    ;;

    "all")
        load_data "ods_business_partner_full" "ods_department_full" "ods_employee_full" "ods_industry_full" "ods_credit_facility_inc" "ods_credit_facility_status_inc" "ods_reply_inc" "ods_credit_inc" "ods_contract_inc"
    ;;
esac
