#!/bin/bash

APP=financial_lease
# 如果是输入的日期按照取输入日期；如果没输入日期取当前时间的前一天
if [ -n "$2" ] ;then
    do_date=$2
else 
    do_date=`date -d "-1 day" +%F`
fi

ads_unfinished_audit_stats="
insert overwrite table ${APP}.ads_unfinished_audit_stats
select dt,
       created_project_count,
       created_project_amount,
       risk_control_not_approved_count,
       risk_control_not_approved_amount,
       credit_audit_approved_count,
       credit_audit_approved_amount,
       feedback_submitted_count,
       feedback_submitted_amount,
       level1_review_approved_count,
       level1_review_approved_amount,
       level2_review_approved_count,
       level2_review_approved_amount,
       review_meeting_approved_count,
       review_meeting_approved_amount,
       general_manager_approved_count,
       general_manager_approved_amount,
       reply_issued_count,
       reply_issued_apply_amount,
       reply_issued_reply_amount
from ${APP}.ads_unfinished_audit_stats
union
select '$do_date'                                                                            dt,
       sum(if(undistributed_time is null and risk_manage_refused_time is null, 1, 0))          created_project_count,
       sum(if(undistributed_time is null and risk_manage_refused_time is null, credit_amount,
              0))                                                                              created_project_amount,
       sum(if(risk_manage_refused_time is not null and undistributed_time is null, 1,
              0))                                                                              risk_control_not_approved_count,
       sum(if(risk_manage_refused_time is not null and undistributed_time is null, credit_amount,
              0))                                                                              risk_control_not_approved_amount,
       sum(if(credit_audit_approving_time is not null and feed_back_time is null, 1,
              0))                                                                              credit_audit_approved_count,
       sum(if(credit_audit_approving_time is not null and feed_back_time is null, credit_amount,
              0))                                                                              credit_audit_approved_amount,
       sum(if(feed_back_time is not null and first_level_review_approving_time is null, 1, 0)) feedback_submitted_count,
       sum(if(feed_back_time is not null and first_level_review_approving_time is null, credit_amount,
              0))                                                                              feedback_submitted_amount,
       sum(if(first_level_review_approving_time is not null and second_level_review_approving_time is null, 1,
              0))                                                                              level1_review_approved_count,
       sum(if(first_level_review_approving_time is not null and second_level_review_approving_time is null,
              credit_amount,
              0))                                                                              level1_review_approved_amount,
       sum(if(second_level_review_approving_time is not null and project_review_meeting_approving_time is null, 1,
              0))                                                                              level2_review_approved_count,
       sum(if(second_level_review_approving_time is not null and project_review_meeting_approving_time is null,
              credit_amount,
              0))                                                                              level2_review_approved_amount,
       sum(if(project_review_meeting_approving_time is not null and general_manager_review_approving_time is null, 1,
              0))                                                                              review_meeting_approved_count,
       sum(if(project_review_meeting_approving_time is not null and general_manager_review_approving_time is null,
              credit_amount,
              0))                                                                              review_meeting_approved_amount,
       sum(if(general_manager_review_approving_time is not null and reply_review_approving_time is null, 1,
              0))                                                                              general_manager_approved_count,
       sum(if(general_manager_review_approving_time is not null and reply_review_approving_time is null, credit_amount,
              0))                                                                              general_manager_approved_amount,
       sum(if(reply_review_approving_time is not null and credit_create_time is null, 1, 0))   reply_issued_count,
       sum(if(reply_review_approving_time is not null and credit_create_time is null, credit_amount,
              0))                                                                              reply_issued_apply_amount,
       sum(if(reply_review_approving_time is not null and credit_create_time is null, credit_reply_amount,
              0))                                                                              reply_issued_reply_amount
from ${APP}.dwd_financial_lease_flow_acc
where dt = '9999-12-31';"

ads_lease_org_unfinished_audit_stats="
insert overwrite table ${APP}.ads_lease_org_unfinished_audit_stats
select dt,
       lease_organization,
       created_project_count,
       created_project_amount,
       risk_control_not_approved_count,
       risk_control_not_approved_amount,
       credit_audit_approved_count,
       credit_audit_approved_amount,
       feedback_submitted_count,
       feedback_submitted_amount,
       level1_review_approved_count,
       level1_review_approved_amount,
       level2_review_approved_count,
       level2_review_approved_amount,
       review_meeting_approved_count,
       review_meeting_approved_amount,
       general_manager_approved_count,
       general_manager_approved_amount,
       reply_issued_count,
       reply_issued_apply_amount,
       reply_issued_reply_amount
from ${APP}.ads_lease_org_unfinished_audit_stats
union
select '$do_date'                                                                            dt,
       lease_organization,
       sum(if(undistributed_time is null and risk_manage_refused_time is null, 1, 0))          created_project_count,
       sum(if(undistributed_time is null and risk_manage_refused_time is null, credit_amount,
              0))                                                                              created_project_amount,
       sum(if(risk_manage_refused_time is not null and undistributed_time is null, 1,
              0))                                                                              risk_control_not_approved_count,
       sum(if(risk_manage_refused_time is not null and undistributed_time is null, credit_amount,
              0))                                                                              risk_control_not_approved_amount,
       sum(if(credit_audit_approving_time is not null and feed_back_time is null, 1,
              0))                                                                              credit_audit_approved_count,
       sum(if(credit_audit_approving_time is not null and feed_back_time is null, credit_amount,
              0))                                                                              credit_audit_approved_amount,
       sum(if(feed_back_time is not null and first_level_review_approving_time is null, 1, 0)) feedback_submitted_count,
       sum(if(feed_back_time is not null and first_level_review_approving_time is null, credit_amount,
              0))                                                                              feedback_submitted_amount,
       sum(if(first_level_review_approving_time is not null and second_level_review_approving_time is null, 1,
              0))                                                                              level1_review_approved_count,
       sum(if(first_level_review_approving_time is not null and second_level_review_approving_time is null,
              credit_amount,
              0))                                                                              level1_review_approved_amount,
       sum(if(second_level_review_approving_time is not null and project_review_meeting_approving_time is null, 1,
              0))                                                                              level2_review_approved_count,
       sum(if(second_level_review_approving_time is not null and project_review_meeting_approving_time is null,
              credit_amount,
              0))                                                                              level2_review_approved_amount,
       sum(if(project_review_meeting_approving_time is not null and general_manager_review_approving_time is null, 1,
              0))                                                                              review_meeting_approved_count,
       sum(if(project_review_meeting_approving_time is not null and general_manager_review_approving_time is null,
              credit_amount,
              0))                                                                              review_meeting_approved_amount,
       sum(if(general_manager_review_approving_time is not null and reply_review_approving_time is null, 1,
              0))                                                                              general_manager_approved_count,
       sum(if(general_manager_review_approving_time is not null and reply_review_approving_time is null, credit_amount,
              0))                                                                              general_manager_approved_amount,
       sum(if(reply_review_approving_time is not null and credit_create_time is null, 1, 0))   reply_issued_count,
       sum(if(reply_review_approving_time is not null and credit_create_time is null, credit_amount,
              0))                                                                              reply_issued_apply_amount,
       sum(if(reply_review_approving_time is not null and credit_create_time is null, credit_reply_amount,
              0))                                                                              reply_issued_reply_amount
from ${APP}.dwd_financial_lease_flow_acc
where dt = '9999-12-31'
group by lease_organization;"

ads_department_unfinished_audit_stats="
insert overwrite table ${APP}.ads_department_unfinished_audit_stats
select dt,
       department3_id,
       department3_name,
       department2_id,
       department2_name,
       department1_id,
       department1_name,
       created_project_count,
       created_project_amount,
       risk_control_not_approved_count,
       risk_control_not_approved_amount,
       credit_audit_approved_count,
       credit_audit_approved_amount,
       feedback_submitted_count,
       feedback_submitted_amount,
       level1_review_approved_count,
       level1_review_approved_amount,
       level2_review_approved_count,
       level2_review_approved_amount,
       review_meeting_approved_count,
       review_meeting_approved_amount,
       general_manager_approved_count,
       general_manager_approved_amount,
       reply_issued_count,
       reply_issued_apply_amount,
       reply_issued_reply_amount
from ${APP}.ads_department_unfinished_audit_stats
union
select dt,
       agg.department3_id,
       department3_name,
       department2_id,
       department2_name,
       department1_id,
       department1_name,
       created_project_count,
       created_project_amount,
       risk_control_not_approved_count,
       risk_control_not_approved_amount,
       credit_audit_approved_count,
       credit_audit_approved_amount,
       feedback_submitted_count,
       feedback_submitted_amount,
       level1_review_approved_count,
       level1_review_approved_amount,
       level2_review_approved_count,
       level2_review_approved_amount,
       review_meeting_approved_count,
       review_meeting_approved_amount,
       general_manager_approved_count,
       general_manager_approved_amount,
       reply_issued_count,
       reply_issued_apply_amount,
       reply_issued_reply_amount
from (select '$do_date'                                                                          dt,
             department3_id,
             sum(if(undistributed_time is null and risk_manage_refused_time is null, 1,
                    0))                                                                            created_project_count,
             sum(if(undistributed_time is null and risk_manage_refused_time is null, credit_amount,
                    0))                                                                            created_project_amount,
             sum(if(risk_manage_refused_time is not null and undistributed_time is null, 1,
                    0))                                                                            risk_control_not_approved_count,
             sum(if(risk_manage_refused_time is not null and undistributed_time is null, credit_amount,
                    0))                                                                            risk_control_not_approved_amount,
             sum(if(credit_audit_approving_time is not null and feed_back_time is null, 1,
                    0))                                                                            credit_audit_approved_count,
             sum(if(credit_audit_approving_time is not null and feed_back_time is null, credit_amount,
                    0))                                                                            credit_audit_approved_amount,
             sum(if(feed_back_time is not null and first_level_review_approving_time is null, 1,
                    0))                                                                            feedback_submitted_count,
             sum(if(feed_back_time is not null and first_level_review_approving_time is null, credit_amount,
                    0))                                                                            feedback_submitted_amount,
             sum(if(first_level_review_approving_time is not null and second_level_review_approving_time is null, 1,
                    0))                                                                            level1_review_approved_count,
             sum(if(first_level_review_approving_time is not null and second_level_review_approving_time is null,
                    credit_amount,
                    0))                                                                            level1_review_approved_amount,
             sum(if(second_level_review_approving_time is not null and project_review_meeting_approving_time is null, 1,
                    0))                                                                            level2_review_approved_count,
             sum(if(second_level_review_approving_time is not null and project_review_meeting_approving_time is null,
                    credit_amount,
                    0))                                                                            level2_review_approved_amount,
             sum(if(project_review_meeting_approving_time is not null and general_manager_review_approving_time is null,
                    1,
                    0))                                                                            review_meeting_approved_count,
             sum(if(project_review_meeting_approving_time is not null and general_manager_review_approving_time is null,
                    credit_amount,
                    0))                                                                            review_meeting_approved_amount,
             sum(if(general_manager_review_approving_time is not null and reply_review_approving_time is null, 1,
                    0))                                                                            general_manager_approved_count,
             sum(if(general_manager_review_approving_time is not null and reply_review_approving_time is null,
                    credit_amount,
                    0))                                                                            general_manager_approved_amount,
             sum(if(reply_review_approving_time is not null and credit_create_time is null, 1, 0)) reply_issued_count,
             sum(if(reply_review_approving_time is not null and credit_create_time is null, credit_amount,
                    0))                                                                            reply_issued_apply_amount,
             sum(if(reply_review_approving_time is not null and credit_create_time is null, credit_reply_amount,
                    0))                                                                            reply_issued_reply_amount
      from (select *
            from ${APP}.dwd_financial_lease_flow_acc
            where dt = '9999-12-31') acc
               left join (select id,
                                 department3_id
                          from ${APP}.dim_employee_full
                          where dt = '$do_date') emp
                         on acc.salesman_id = emp.id
      group by department3_id) agg
         left join
     (select department3_id,
             department3_name,
             department2_id,
             department2_name,
             department1_id,
             department1_name
      from ${APP}.dim_department_full
      where dt = '$do_date') department
     on agg.department3_id = department.department3_id;
msck repair table ${APP}.dim_department_full;"

ads_salesman_unfinished_audit_stats="
insert overwrite table ${APP}.ads_salesman_unfinished_audit_stats
select dt,
       salesman_id,
       salesman_name,
       created_project_count,
       created_project_amount,
       risk_control_not_approved_count,
       risk_control_not_approved_amount,
       credit_audit_approved_count,
       credit_audit_approved_amount,
       feedback_submitted_count,
       feedback_submitted_amount,
       level1_review_approved_count,
       level1_review_approved_amount,
       level2_review_approved_count,
       level2_review_approved_amount,
       review_meeting_approved_count,
       review_meeting_approved_amount,
       general_manager_approved_count,
       general_manager_approved_amount,
       reply_issued_count,
       reply_issued_apply_amount,
       reply_issued_reply_amount
from ${APP}.ads_salesman_unfinished_audit_stats
union
select dt,
       salesman_id,
       emp.name salesman_name,
       created_project_count,
       created_project_amount,
       risk_control_not_approved_count,
       risk_control_not_approved_amount,
       credit_audit_approved_count,
       credit_audit_approved_amount,
       feedback_submitted_count,
       feedback_submitted_amount,
       level1_review_approved_count,
       level1_review_approved_amount,
       level2_review_approved_count,
       level2_review_approved_amount,
       review_meeting_approved_count,
       review_meeting_approved_amount,
       general_manager_approved_count,
       general_manager_approved_amount,
       reply_issued_count,
       reply_issued_apply_amount,
       reply_issued_reply_amount
from (select '$do_date'                                                                          dt,
             salesman_id,
             sum(if(undistributed_time is null and risk_manage_refused_time is null, 1,
                    0))                                                                            created_project_count,
             sum(if(undistributed_time is null and risk_manage_refused_time is null, credit_amount,
                    0))                                                                            created_project_amount,
             sum(if(risk_manage_refused_time is not null and undistributed_time is null, 1,
                    0))                                                                            risk_control_not_approved_count,
             sum(if(risk_manage_refused_time is not null and undistributed_time is null, credit_amount,
                    0))                                                                            risk_control_not_approved_amount,
             sum(if(credit_audit_approving_time is not null and feed_back_time is null, 1,
                    0))                                                                            credit_audit_approved_count,
             sum(if(credit_audit_approving_time is not null and feed_back_time is null, credit_amount,
                    0))                                                                            credit_audit_approved_amount,
             sum(if(feed_back_time is not null and first_level_review_approving_time is null, 1,
                    0))                                                                            feedback_submitted_count,
             sum(if(feed_back_time is not null and first_level_review_approving_time is null, credit_amount,
                    0))                                                                            feedback_submitted_amount,
             sum(if(first_level_review_approving_time is not null and second_level_review_approving_time is null, 1,
                    0))                                                                            level1_review_approved_count,
             sum(if(first_level_review_approving_time is not null and second_level_review_approving_time is null,
                    credit_amount,
                    0))                                                                            level1_review_approved_amount,
             sum(if(second_level_review_approving_time is not null and project_review_meeting_approving_time is null, 1,
                    0))                                                                            level2_review_approved_count,
             sum(if(second_level_review_approving_time is not null and project_review_meeting_approving_time is null,
                    credit_amount,
                    0))                                                                            level2_review_approved_amount,
             sum(if(project_review_meeting_approving_time is not null and general_manager_review_approving_time is null,
                    1,
                    0))                                                                            review_meeting_approved_count,
             sum(if(project_review_meeting_approving_time is not null and general_manager_review_approving_time is null,
                    credit_amount,
                    0))                                                                            review_meeting_approved_amount,
             sum(if(general_manager_review_approving_time is not null and reply_review_approving_time is null, 1,
                    0))                                                                            general_manager_approved_count,
             sum(if(general_manager_review_approving_time is not null and reply_review_approving_time is null,
                    credit_amount,
                    0))                                                                            general_manager_approved_amount,
             sum(if(reply_review_approving_time is not null and credit_create_time is null, 1, 0)) reply_issued_count,
             sum(if(reply_review_approving_time is not null and credit_create_time is null, credit_amount,
                    0))                                                                            reply_issued_apply_amount,
             sum(if(reply_review_approving_time is not null and credit_create_time is null, credit_reply_amount,
                    0))                                                                            reply_issued_reply_amount
      from ${APP}.dwd_financial_lease_flow_acc
      where dt = '9999-12-31'
      group by salesman_id) agg
         left join (
    select id,
           name
    from ${APP}.dim_employee_full
    where dt = '$do_date'
) emp on agg.salesman_id = emp.id;"

ads_credit_audit_unfinished_audit_stats="
insert overwrite table ${APP}.ads_credit_audit_unfinished_audit_stats
select dt,
       credit_audit_id,
       credit_audit_name,
       credit_audit_approved_count,
       credit_audit_approved_amount,
       feedback_submitted_count,
       feedback_submitted_amount,
       level1_review_approved_count,
       level1_review_approved_amount,
       level2_review_approved_count,
       level2_review_approved_amount,
       review_meeting_approved_count,
       review_meeting_approved_amount,
       general_manager_approved_count,
       general_manager_approved_amount,
       reply_issued_count,
       reply_issued_apply_amount,
       reply_issued_reply_amount
from ${APP}.ads_credit_audit_unfinished_audit_stats
union
select '$do_date' dt,
       credit_audit_id,
       name         credit_audit_name,
       credit_audit_approved_count,
       credit_audit_approved_amount,
       feedback_submitted_count,
       feedback_submitted_amount,
       level1_review_approved_count,
       level1_review_approved_amount,
       level2_review_approved_count,
       level2_review_approved_amount,
       review_meeting_approved_count,
       review_meeting_approved_amount,
       general_manager_approved_count,
       general_manager_approved_amount,
       reply_issued_count,
       reply_issued_apply_amount,
       reply_issued_reply_amount
from (select '$do_date'                                                                          dt,
             credit_audit_id,
             sum(if(credit_audit_approving_time is not null and feed_back_time is null, 1,
                    0))                                                                            credit_audit_approved_count,
             sum(if(credit_audit_approving_time is not null and feed_back_time is null, credit_amount,
                    0))                                                                            credit_audit_approved_amount,
             sum(if(feed_back_time is not null and first_level_review_approving_time is null, 1,
                    0))                                                                            feedback_submitted_count,
             sum(if(feed_back_time is not null and first_level_review_approving_time is null, credit_amount,
                    0))                                                                            feedback_submitted_amount,
             sum(if(first_level_review_approving_time is not null and second_level_review_approving_time is null, 1,
                    0))                                                                            level1_review_approved_count,
             sum(if(first_level_review_approving_time is not null and second_level_review_approving_time is null,
                    credit_amount,
                    0))                                                                            level1_review_approved_amount,
             sum(if(second_level_review_approving_time is not null and project_review_meeting_approving_time is null, 1,
                    0))                                                                            level2_review_approved_count,
             sum(if(second_level_review_approving_time is not null and project_review_meeting_approving_time is null,
                    credit_amount,
                    0))                                                                            level2_review_approved_amount,
             sum(if(project_review_meeting_approving_time is not null and general_manager_review_approving_time is null,
                    1,
                    0))                                                                            review_meeting_approved_count,
             sum(if(project_review_meeting_approving_time is not null and general_manager_review_approving_time is null,
                    credit_amount,
                    0))                                                                            review_meeting_approved_amount,
             sum(if(general_manager_review_approving_time is not null and reply_review_approving_time is null, 1,
                    0))                                                                            general_manager_approved_count,
             sum(if(general_manager_review_approving_time is not null and reply_review_approving_time is null,
                    credit_amount,
                    0))                                                                            general_manager_approved_amount,
             sum(if(reply_review_approving_time is not null and credit_create_time is null, 1, 0)) reply_issued_count,
             sum(if(reply_review_approving_time is not null and credit_create_time is null, credit_amount,
                    0))                                                                            reply_issued_apply_amount,
             sum(if(reply_review_approving_time is not null and credit_create_time is null, credit_reply_amount,
                    0))                                                                            reply_issued_reply_amount
      from ${APP}.dwd_financial_lease_flow_acc
      where dt = '9999-12-31'
        and credit_audit_id is not null
      group by credit_audit_id) acc
         left join
     (select id,
             name
      from ${APP}.dim_employee_full
      where dt = '$do_date') emp
     on acc.credit_audit_id = emp.id;"

ads_industry_unfinished_audit_stats="
insert overwrite table ${APP}.ads_industry_unfinished_audit_stats
select dt,
       industry3_id,
       industry3_name,
       industry2_id,
       industry2_name,
       industry1_id,
       industry1_name,
       created_project_count,
       created_project_amount,
       risk_control_not_approved_count,
       risk_control_not_approved_amount,
       credit_audit_approved_count,
       credit_audit_approved_amount,
       feedback_submitted_count,
       feedback_submitted_amount,
       level1_review_approved_count,
       level1_review_approved_amount,
       level2_review_approved_count,
       level2_review_approved_amount,
       review_meeting_approved_count,
       review_meeting_approved_amount,
       general_manager_approved_count,
       general_manager_approved_amount,
       reply_issued_count,
       reply_issued_apply_amount,
       reply_issued_reply_amount
from ${APP}.ads_industry_unfinished_audit_stats
union
select dt,
       agg.industry3_id,
       industry3_name,
       industry2_id,
       industry2_name,
       industry1_id,
       industry1_name,
       created_project_count,
       created_project_amount,
       risk_control_not_approved_count,
       risk_control_not_approved_amount,
       credit_audit_approved_count,
       credit_audit_approved_amount,
       feedback_submitted_count,
       feedback_submitted_amount,
       level1_review_approved_count,
       level1_review_approved_amount,
       level2_review_approved_count,
       level2_review_approved_amount,
       review_meeting_approved_count,
       review_meeting_approved_amount,
       general_manager_approved_count,
       general_manager_approved_amount,
       reply_issued_count,
       reply_issued_apply_amount,
       reply_issued_reply_amount
from (select '$do_date'                                                                          dt,
             industry3_id,
             sum(if(undistributed_time is null and risk_manage_refused_time is null, 1,
                    0))                                                                            created_project_count,
             sum(if(undistributed_time is null and risk_manage_refused_time is null, credit_amount,
                    0))                                                                            created_project_amount,
             sum(if(risk_manage_refused_time is not null and undistributed_time is null, 1,
                    0))                                                                            risk_control_not_approved_count,
             sum(if(risk_manage_refused_time is not null and undistributed_time is null, credit_amount,
                    0))                                                                            risk_control_not_approved_amount,
             sum(if(credit_audit_approving_time is not null and feed_back_time is null, 1,
                    0))                                                                            credit_audit_approved_count,
             sum(if(credit_audit_approving_time is not null and feed_back_time is null, credit_amount,
                    0))                                                                            credit_audit_approved_amount,
             sum(if(feed_back_time is not null and first_level_review_approving_time is null, 1,
                    0))                                                                            feedback_submitted_count,
             sum(if(feed_back_time is not null and first_level_review_approving_time is null, credit_amount,
                    0))                                                                            feedback_submitted_amount,
             sum(if(first_level_review_approving_time is not null and second_level_review_approving_time is null, 1,
                    0))                                                                            level1_review_approved_count,
             sum(if(first_level_review_approving_time is not null and second_level_review_approving_time is null,
                    credit_amount,
                    0))                                                                            level1_review_approved_amount,
             sum(if(second_level_review_approving_time is not null and project_review_meeting_approving_time is null, 1,
                    0))                                                                            level2_review_approved_count,
             sum(if(second_level_review_approving_time is not null and project_review_meeting_approving_time is null,
                    credit_amount,
                    0))                                                                            level2_review_approved_amount,
             sum(if(project_review_meeting_approving_time is not null and general_manager_review_approving_time is null,
                    1,
                    0))                                                                            review_meeting_approved_count,
             sum(if(project_review_meeting_approving_time is not null and general_manager_review_approving_time is null,
                    credit_amount,
                    0))                                                                            review_meeting_approved_amount,
             sum(if(general_manager_review_approving_time is not null and reply_review_approving_time is null, 1,
                    0))                                                                            general_manager_approved_count,
             sum(if(general_manager_review_approving_time is not null and reply_review_approving_time is null,
                    credit_amount,
                    0))                                                                            general_manager_approved_amount,
             sum(if(reply_review_approving_time is not null and credit_create_time is null, 1, 0)) reply_issued_count,
             sum(if(reply_review_approving_time is not null and credit_create_time is null, credit_amount,
                    0))                                                                            reply_issued_apply_amount,
             sum(if(reply_review_approving_time is not null and credit_create_time is null, credit_reply_amount,
                    0))                                                                            reply_issued_reply_amount
      from ${APP}.dwd_financial_lease_flow_acc
      where dt = '9999-12-31'
      group by industry3_id) agg
         left join
     (select industry3_id,
             industry3_name,
             industry2_id,
             industry2_name,
             industry1_id,
             industry1_name
      from ${APP}.dim_industry_full
      where dt = '$do_date') ind
     on agg.industry3_id = ind.industry3_id;"

ads_finished_audit_stats="
insert overwrite table ${APP}.ads_finished_audit_stats
select dt,
       audit_approved_count,
       audit_approved_apply_amount,
       audit_approved_reply_amount,
       apply_cancel_count,
       apply_cancel_apply_amount,
       audit_refused_count,
       audit_refused_apply_amount
from ${APP}.ads_finished_audit_stats
union
select '$do_date'                                                             dt,
       sum(if(reply_review_approving_time is not null, 1, 0))                   audit_approved_count,
       sum(if(reply_review_approving_time is not null, credit_amount, 0))       audit_approved_apply_amount,
       sum(if(reply_review_approving_time is not null, credit_reply_amount, 0)) audit_approved_reply_amount,
       sum(if(cancel_time is not null, 1, 0))                                   apply_cancel_count,
       sum(if(cancel_time is not null, credit_amount, 0))                       apply_cancel_apply_amount,
       sum(if(rejected_time is not null, 1, 0))                                 audit_refused_count,
       sum(if(rejected_time is not null, credit_amount, 0))                     audit_refused_apply_amount
from ${APP}.dwd_financial_lease_flow_acc;"

ads_lease_org_finished_audit_stats="
insert overwrite table ${APP}.ads_lease_org_finished_audit_stats
select dt,
       lease_organization,
       audit_approved_count,
       audit_approved_apply_amount,
       audit_approved_reply_amount,
       apply_cancel_count,
       apply_cancel_apply_amount,
       audit_refused_count,
       audit_refused_apply_amount
from ${APP}.ads_lease_org_finished_audit_stats
union
select '$do_date'                                                             dt,
       lease_organization,
       sum(if(reply_review_approving_time is not null, 1, 0))                   audit_approved_count,
       sum(if(reply_review_approving_time is not null, credit_amount, 0))       audit_approved_apply_amount,
       sum(if(reply_review_approving_time is not null, credit_reply_amount, 0)) audit_approved_reply_amount,
       sum(if(cancel_time is not null, 1, 0))                                   apply_cancel_count,
       sum(if(cancel_time is not null, credit_amount, 0))                       apply_cancel_apply_amount,
       sum(if(rejected_time is not null, 1, 0))                                 audit_refused_count,
       sum(if(rejected_time is not null, credit_amount, 0))                     audit_refused_apply_amount
from ${APP}.dwd_financial_lease_flow_acc
group by lease_organization;"

ads_department_finished_audit_stats="
insert overwrite table ${APP}.ads_department_finished_audit_stats
select dt,
       department3_id,
       department3_name,
       department2_id,
       department2_name,
       department1_id,
       department1_name,
       audit_approved_count,
       audit_approved_apply_amount,
       audit_approved_reply_amount,
       apply_cancel_count,
       apply_cancel_apply_amount,
       audit_refused_count,
       audit_refused_apply_amount
from ${APP}.ads_department_finished_audit_stats
union
select dt,
       agg.department3_id,
       department3_name,
       department2_id,
       department2_name,
       department1_id,
       department1_name,
       audit_approved_count,
       audit_approved_apply_amount,
       audit_approved_reply_amount,
       apply_cancel_count,
       apply_cancel_apply_amount,
       audit_refused_count,
       audit_refused_apply_amount
from (select '$do_date'                                                             dt,
             department3_id,
             sum(if(reply_review_approving_time is not null, 1, 0))                   audit_approved_count,
             sum(if(reply_review_approving_time is not null, credit_amount, 0))       audit_approved_apply_amount,
             sum(if(reply_review_approving_time is not null, credit_reply_amount, 0)) audit_approved_reply_amount,
             sum(if(cancel_time is not null, 1, 0))                                   apply_cancel_count,
             sum(if(cancel_time is not null, credit_amount, 0))                       apply_cancel_apply_amount,
             sum(if(rejected_time is not null, 1, 0))                                 audit_refused_count,
             sum(if(rejected_time is not null, credit_amount, 0))                     audit_refused_apply_amount
      from ${APP}.dwd_financial_lease_flow_acc
               left join (select id,
                                 department3_id
                          from ${APP}.dim_employee_full
                          where dt = '$do_date') emp
                         on salesman_id = emp.id
      group by department3_id) agg
         left join (
    select department3_id,
           department3_name,
           department2_id,
           department2_name,
           department1_id,
           department1_name
    from ${APP}.dim_department_full
    where dt = '$do_date') department
                   on agg.department3_id = department.department3_id;"

ads_salesman_finished_audit_stats="
insert overwrite table ${APP}.ads_salesman_finished_audit_stats
select dt,
       salesman_id,
       salesman_name,
       audit_approved_count,
       audit_approved_apply_amount,
       audit_approved_reply_amount,
       apply_cancel_count,
       apply_cancel_apply_amount,
       audit_refused_count,
       audit_refused_apply_amount
from ${APP}.ads_salesman_finished_audit_stats
union
select dt,
       salesman_id,
       name salesman_name,
       audit_approved_count,
       audit_approved_apply_amount,
       audit_approved_reply_amount,
       apply_cancel_count,
       apply_cancel_apply_amount,
       audit_refused_count,
       audit_refused_apply_amount
from (select '$do_date'                                                             dt,
             salesman_id,
             sum(if(reply_review_approving_time is not null, 1, 0))                   audit_approved_count,
             sum(if(reply_review_approving_time is not null, credit_amount, 0))       audit_approved_apply_amount,
             sum(if(reply_review_approving_time is not null, credit_reply_amount, 0)) audit_approved_reply_amount,
             sum(if(cancel_time is not null, 1, 0))                                   apply_cancel_count,
             sum(if(cancel_time is not null, credit_amount, 0))                       apply_cancel_apply_amount,
             sum(if(rejected_time is not null, 1, 0))                                 audit_refused_count,
             sum(if(rejected_time is not null, credit_amount, 0))                     audit_refused_apply_amount
      from ${APP}.dwd_financial_lease_flow_acc
      group by salesman_id) agg
         left join (
    select id,
           name
    from ${APP}.dim_employee_full
    where dt = '$do_date'
) emp on agg.salesman_id = emp.id;"

ads_credit_audit_finished_audit_stats="
insert overwrite table ${APP}.ads_credit_audit_finished_audit_stats
select dt,
       credit_audit_id,
       credit_audit_name,
       audit_approved_count,
       audit_approved_apply_amount,
       audit_approved_reply_amount,
       apply_cancel_count,
       apply_cancel_apply_amount,
       audit_refused_count,
       audit_refused_apply_amount
from ${APP}.ads_credit_audit_finished_audit_stats
union
select dt,
       credit_audit_id,
       name credit_audit_name,
       audit_approved_count,
       audit_approved_apply_amount,
       audit_approved_reply_amount,
       apply_cancel_count,
       apply_cancel_apply_amount,
       audit_refused_count,
       audit_refused_apply_amount
from (select '$do_date'                                                             dt,
             credit_audit_id,
             sum(if(reply_review_approving_time is not null, 1, 0))                   audit_approved_count,
             sum(if(reply_review_approving_time is not null, credit_amount, 0))       audit_approved_apply_amount,
             sum(if(reply_review_approving_time is not null, credit_reply_amount, 0)) audit_approved_reply_amount,
             sum(if(cancel_time is not null, 1, 0))                                   apply_cancel_count,
             sum(if(cancel_time is not null, credit_amount, 0))                       apply_cancel_apply_amount,
             sum(if(rejected_time is not null, 1, 0))                                 audit_refused_count,
             sum(if(rejected_time is not null, credit_amount, 0))                     audit_refused_apply_amount
      from ${APP}.dwd_financial_lease_flow_acc
      where credit_audit_id is not null
      group by credit_audit_id) agg
         left join
     (select id,
             name
      from ${APP}.dim_employee_full
      where dt = '$do_date') emp on credit_audit_id = emp.id;"

ads_industry_finished_audit_stats="
insert overwrite table ${APP}.ads_industry_finished_audit_stats
select dt,
       industry3_id,
       industry3_name,
       industry2_id,
       industry2_name,
       industry1_id,
       industry1_name,
       audit_approved_count,
       audit_approved_apply_amount,
       audit_approved_reply_amount,
       apply_cancel_count,
       apply_cancel_apply_amount,
       audit_refused_count,
       audit_refused_apply_amount
from ${APP}.ads_industry_finished_audit_stats
union
select dt,
       agg.industry3_id,
       industry3_name,
       industry2_id,
       industry2_name,
       industry1_id,
       industry1_name,
       audit_approved_count,
       audit_approved_apply_amount,
       audit_approved_reply_amount,
       apply_cancel_count,
       apply_cancel_apply_amount,
       audit_refused_count,
       audit_refused_apply_amount
from (select '$do_date'                                                             dt,
             industry3_id,
             sum(if(reply_review_approving_time is not null, 1, 0))                   audit_approved_count,
             sum(if(reply_review_approving_time is not null, credit_amount, 0))       audit_approved_apply_amount,
             sum(if(reply_review_approving_time is not null, credit_reply_amount, 0)) audit_approved_reply_amount,
             sum(if(cancel_time is not null, 1, 0))                                   apply_cancel_count,
             sum(if(cancel_time is not null, credit_amount, 0))                       apply_cancel_apply_amount,
             sum(if(rejected_time is not null, 1, 0))                                 audit_refused_count,
             sum(if(rejected_time is not null, credit_amount, 0))                     audit_refused_apply_amount
      from ${APP}.dwd_financial_lease_flow_acc
      group by industry3_id) agg
         left join (
    select industry3_id,
           industry3_name,
           industry2_id,
           industry2_name,
           industry1_id,
           industry1_name
    from ${APP}.dim_industry_full
    where dt = '$do_date') industry on agg.industry3_id = industry.industry3_id;"

ads_credit_audit_finished_transform_stats="
insert overwrite table ${APP}.ads_credit_audit_finished_transform_stats
select dt,
       credit_audit_finished_count,
       credit_audit_finished_apply_amount,
       credit_audit_approved_count,
       credit_audit_approved_apply_amount,
       credit_audit_approved_reply_amount,
       credit_created_count,
       credit_created_apply_amount,
       credit_created_reply_amount,
       credit_created_credit_amount,
       credit_occupied_count,
       credit_occupied_apply_amount,
       credit_occupied_reply_amount,
       credit_occupied_credit_amount,
       contract_produced_count,
       contract_produced_apply_amount,
       contract_produced_reply_amount,
       contract_produced_credit_amount,
       credit_signed_count,
       credit_signed_apply_amount,
       credit_signed_reply_amount,
       credit_signed_credit_amount,
       leased_count,
       leased_apply_amount,
       leased_reply_amount,
       leased_credit_amount
from ${APP}.ads_credit_audit_finished_transform_stats
union
select '$do_date' dt,
       sum(if(dt <> '9999-12-31', 1, 0)) credit_audit_finished_count,
       sum(if(dt <> '9999-12-31', credit_amount, 0)) credit_audit_finished_apply_amount,
       sum(if(reply_review_approving_time is not null, 1, 0)) credit_audit_approved_count,
       sum(if(reply_review_approving_time is not null, credit_amount, 0)) credit_audit_approved_apply_amount,
       sum(if(reply_review_approving_time is not null, credit_reply_amount, 0)) credit_audit_approved_reply_amount,
       sum(if(credit_create_time is not null, 1, 0)) credit_created_count,
       sum(if(credit_create_time is not null, credit_amount, 0)) credit_created_apply_amount,
       sum(if(credit_create_time is not null, credit_reply_amount, 0)) credit_created_reply_amount,
       sum(if(credit_create_time is not null, credit_real_amount, 0)) credit_created_credit_amount,
       sum(if(credit_occupy_time is not null, 1, 0)) credit_occupied_count,
       sum(if(credit_occupy_time is not null, credit_amount, 0)) credit_occupied_apply_amount,
       sum(if(credit_occupy_time is not null, credit_reply_amount, 0)) credit_occupied_reply_amount,
       sum(if(credit_occupy_time is not null, credit_real_amount, 0)) credit_occupied_credit_amount,
       sum(if(contract_produce_time is not null, 1, 0)) contract_produced_count,
       sum(if(contract_produce_time is not null, credit_amount, 0)) contract_produced_apply_amount,
       sum(if(contract_produce_time is not null, credit_reply_amount, 0)) contract_produced_reply_amount,
       sum(if(contract_produce_time is not null, credit_real_amount, 0)) contract_produced_credit_amount,
       sum(if(signed_time is not null, 1, 0)) credit_signed_count,
       sum(if(signed_time is not null, credit_amount, 0)) credit_signed_apply_amount,
       sum(if(signed_time is not null, credit_reply_amount, 0)) credit_signed_reply_amount,
       sum(if(signed_time is not null, credit_real_amount, 0)) credit_signed_credit_amount,
       sum(if(execution_time is not null, 1, 0)) leased_count,
       sum(if(execution_time is not null, credit_amount, 0)) leased_apply_amount,
       sum(if(execution_time is not null, credit_reply_amount, 0)) leased_reply_amount,
       sum(if(execution_time is not null, credit_real_amount, 0)) leased_credit_amount
from ${APP}.dwd_financial_lease_flow_acc;"

case $1 in
    "ads_unfinished_audit_stats" )
        hive -e "$ads_unfinished_audit_stats"
    ;;
    "ads_lease_org_unfinished_audit_stats" )
        hive -e "$ads_lease_org_unfinished_audit_stats"
    ;;
    "ads_department_unfinished_audit_stats" )
        hive -e "$ads_department_unfinished_audit_stats"
    ;;
    "ads_salesman_unfinished_audit_stats" )
        hive -e "$ads_salesman_unfinished_audit_stats"
    ;;
    "ads_credit_audit_unfinished_audit_stats" )
        hive -e "$ads_credit_audit_unfinished_audit_stats"
    ;;
    "ads_industry_unfinished_audit_stats" )
        hive -e "$ads_industry_unfinished_audit_stats"
    ;;
    "ads_finished_audit_stats" )
        hive -e "$ads_finished_audit_stats"
    ;;
    "ads_lease_org_finished_audit_stats" )
        hive -e "$ads_lease_org_finished_audit_stats"
    ;;
    "ads_department_finished_audit_stats" )
        hive -e "$ads_department_finished_audit_stats"
    ;;
    "ads_salesman_finished_audit_stats" )
        hive -e "$ads_salesman_finished_audit_stats"
    ;;
    "ads_credit_audit_finished_audit_stats" )
        hive -e "$ads_credit_audit_finished_audit_stats"
    ;;
    "ads_industry_finished_audit_stats" )
        hive -e "$ads_industry_finished_audit_stats"
    ;;
    "ads_credit_audit_finished_transform_stats" )
        hive -e "$ads_credit_audit_finished_transform_stats"
    ;;

    "all" )
        hive -e "$ads_unfinished_audit_stats$ads_lease_org_unfinished_audit_stats$ads_department_unfinished_audit_stats$ads_salesman_unfinished_audit_stats$ads_credit_audit_unfinished_audit_stats$ads_industry_unfinished_audit_stats$ads_finished_audit_stats$ads_lease_org_finished_audit_stats$ads_department_finished_audit_stats$ads_salesman_finished_audit_stats$ads_credit_audit_finished_audit_stats$ads_industry_finished_audit_stats$ads_credit_audit_finished_transform_stats"
    ;;
esac
