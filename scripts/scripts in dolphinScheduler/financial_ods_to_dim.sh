APP=financial_lease

if [ -n "$2" ] ;then
   do_date=$2
else 
   echo "请传入日期参数"
   exit
fi 

dim_department_full="
insert overwrite table ${APP}.dim_department_full
    partition (dt = '$do_date')
select department3_id,
       department3_name,
       department2_id,
       department2_name,
       department1_id,
       department1_name
from (select id              department3_id,
             department_name department3_name,
             superior_department_id
      from ${APP}.ods_department_full
      where dt = '$do_date'
        and department_level = '3') dp3
         left join (
    select id              department2_id,
           department_name department2_name,
           superior_department_id
    from ${APP}.ods_department_full
    where dt = '$do_date'
      and department_level = '2'
) dp2 on dp3.superior_department_id = department2_id
         left join (
    select id              department1_id,
           department_name department1_name
    from ${APP}.ods_department_full
    where dt = '$do_date'
      and department_level = '1'
) dp1 on dp2.superior_department_id = department1_id;
"

dim_employee_full="
insert overwrite table ${APP}.dim_employee_full
    partition (dt = '$do_date')
select id,
       name,
       type,
       department_id department3_id
from ${APP}.ods_employee_full
where dt = '$do_date';
"

dim_industry_full="
insert overwrite table ${APP}.dim_industry_full
    partition (dt = '$do_date')
select industry3_id,
       industry3_name,
       industry2_id,
       industry2_name,
       industry1_id,
       industry1_name
from (select id            industry3_id,
             industry_name industry3_name,
             superior_industry_id
      from ${APP}.ods_industry_full
      where dt = '$do_date'
        and industry_level = '3') ind3
         left join
     (select id            industry2_id,
             industry_name industry2_name,
             superior_industry_id
      from ${APP}.ods_industry_full
      where dt = '$do_date'
        and industry_level = '2') ind2
     on ind3.superior_industry_id = industry2_id
         left join
     (select id            industry1_id,
             industry_name industry1_name,
             superior_industry_id
      from ${APP}.ods_industry_full
      where dt = '$do_date'
        and industry_level = '1') ind1
     on ind2.superior_industry_id = industry1_id;
"



case $1 in
dim_department_full | dim_employee_full | dim_industry_full)
    hive -e "$i"
    ;;
"all")
    hive -e " $dim_employee_full$dim_department_full$dim_industry_full"
    ;;
esac
