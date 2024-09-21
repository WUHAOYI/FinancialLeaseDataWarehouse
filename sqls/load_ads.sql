-- 1. 待审/在审项目主题
-- 1.1 综合统计
insert overwrite table ads_unfinished_audit_stats
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
from ads_unfinished_audit_stats
union
select '2023-05-09'                                                                            dt,
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
from dwd_financial_lease_flow_acc
where dt = '9999-12-31';

-- 1.2 各业务方向统计
insert overwrite table ads_lease_org_unfinished_audit_stats
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
from ads_lease_org_unfinished_audit_stats
union
select '2023-05-09'                                                                            dt,
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
from dwd_financial_lease_flow_acc
where dt = '9999-12-31'
group by lease_organization;

-- 1.3 各部门统计
insert overwrite table ads_department_unfinished_audit_stats
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
from ads_department_unfinished_audit_stats
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
from (select '2023-05-09'                                                                          dt,
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
            from dwd_financial_lease_flow_acc
            where dt = '9999-12-31') acc
               left join (select id,
                                 department3_id
                          from dim_employee_full
                          where dt = '2023-05-09') emp
                         on acc.salesman_id = emp.id
      group by department3_id) agg
         left join
     (select department3_id,
             department3_name,
             department2_id,
             department2_name,
             department1_id,
             department1_name
      from dim_department_full
      where dt = '2023-05-09') department
     on agg.department3_id = department.department3_id;
msck repair table dim_department_full;

-- 1.4 各业务经办统计
insert overwrite table ads_salesman_unfinished_audit_stats
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
from ads_salesman_unfinished_audit_stats
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
from (select '2023-05-09'                                                                          dt,
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
      from dwd_financial_lease_flow_acc
      where dt = '9999-12-31'
      group by salesman_id) agg
         left join (
    select id,
           name
    from dim_employee_full
    where dt = '2023-05-09'
) emp on agg.salesman_id = emp.id;

-- 1.5 各信审经办统计
insert overwrite table ads_credit_audit_unfinished_audit_stats
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
from ads_credit_audit_unfinished_audit_stats
union
select '2023-05-09' dt,
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
from (select '2023-05-09'                                                                          dt,
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
      from dwd_financial_lease_flow_acc
      where dt = '9999-12-31'
        and credit_audit_id is not null
      group by credit_audit_id) acc
         left join
     (select id,
             name
      from dim_employee_full
      where dt = '2023-05-09') emp
     on acc.credit_audit_id = emp.id;

-- 1.6 各行业统计
insert overwrite table ads_industry_unfinished_audit_stats
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
from ads_industry_unfinished_audit_stats
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
from (select '2023-05-09'                                                                          dt,
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
      from dwd_financial_lease_flow_acc
      where dt = '9999-12-31'
      group by industry3_id) agg
         left join
     (select industry3_id,
             industry3_name,
             industry2_id,
             industry2_name,
             industry1_id,
             industry1_name
      from dim_industry_full
      where dt = '2023-05-09') ind
     on agg.industry3_id = ind.industry3_id;

-- 2. 已审项目主题
-- 2.1 综合统计
insert overwrite table ads_finished_audit_stats
select dt,
       audit_approved_count,
       audit_approved_apply_amount,
       audit_approved_reply_amount,
       apply_cancel_count,
       apply_cancel_apply_amount,
       audit_refused_count,
       audit_refused_apply_amount
from ads_finished_audit_stats
union
select '2023-05-09'                                                             dt,
       sum(if(reply_review_approving_time is not null, 1, 0))                   audit_approved_count,
       sum(if(reply_review_approving_time is not null, credit_amount, 0))       audit_approved_apply_amount,
       sum(if(reply_review_approving_time is not null, credit_reply_amount, 0)) audit_approved_reply_amount,
       sum(if(cancel_time is not null, 1, 0))                                   apply_cancel_count,
       sum(if(cancel_time is not null, credit_amount, 0))                       apply_cancel_apply_amount,
       sum(if(rejected_time is not null, 1, 0))                                 audit_refused_count,
       sum(if(rejected_time is not null, credit_amount, 0))                     audit_refused_apply_amount
from dwd_financial_lease_flow_acc;

-- 2.2 各业务方向统计
insert overwrite table ads_lease_org_finished_audit_stats
select dt,
       lease_organization,
       audit_approved_count,
       audit_approved_apply_amount,
       audit_approved_reply_amount,
       apply_cancel_count,
       apply_cancel_apply_amount,
       audit_refused_count,
       audit_refused_apply_amount
from ads_lease_org_finished_audit_stats
union
select '2023-05-09'                                                             dt,
       lease_organization,
       sum(if(reply_review_approving_time is not null, 1, 0))                   audit_approved_count,
       sum(if(reply_review_approving_time is not null, credit_amount, 0))       audit_approved_apply_amount,
       sum(if(reply_review_approving_time is not null, credit_reply_amount, 0)) audit_approved_reply_amount,
       sum(if(cancel_time is not null, 1, 0))                                   apply_cancel_count,
       sum(if(cancel_time is not null, credit_amount, 0))                       apply_cancel_apply_amount,
       sum(if(rejected_time is not null, 1, 0))                                 audit_refused_count,
       sum(if(rejected_time is not null, credit_amount, 0))                     audit_refused_apply_amount
from dwd_financial_lease_flow_acc
group by lease_organization;

-- 2.3 各部门统计
insert overwrite table ads_department_finished_audit_stats
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
from ads_department_finished_audit_stats
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
from (select '2023-05-09'                                                             dt,
             department3_id,
             sum(if(reply_review_approving_time is not null, 1, 0))                   audit_approved_count,
             sum(if(reply_review_approving_time is not null, credit_amount, 0))       audit_approved_apply_amount,
             sum(if(reply_review_approving_time is not null, credit_reply_amount, 0)) audit_approved_reply_amount,
             sum(if(cancel_time is not null, 1, 0))                                   apply_cancel_count,
             sum(if(cancel_time is not null, credit_amount, 0))                       apply_cancel_apply_amount,
             sum(if(rejected_time is not null, 1, 0))                                 audit_refused_count,
             sum(if(rejected_time is not null, credit_amount, 0))                     audit_refused_apply_amount
      from dwd_financial_lease_flow_acc
               left join (select id,
                                 department3_id
                          from dim_employee_full
                          where dt = '2023-05-09') emp
                         on salesman_id = emp.id
      group by department3_id) agg
         left join (
    select department3_id,
           department3_name,
           department2_id,
           department2_name,
           department1_id,
           department1_name
    from dim_department_full
    where dt = '2023-05-09') department
                   on agg.department3_id = department.department3_id;

-- 2.4 各业务经办统计
insert overwrite table ads_salesman_finished_audit_stats
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
from ads_salesman_finished_audit_stats
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
from (select '2023-05-09'                                                             dt,
             salesman_id,
             sum(if(reply_review_approving_time is not null, 1, 0))                   audit_approved_count,
             sum(if(reply_review_approving_time is not null, credit_amount, 0))       audit_approved_apply_amount,
             sum(if(reply_review_approving_time is not null, credit_reply_amount, 0)) audit_approved_reply_amount,
             sum(if(cancel_time is not null, 1, 0))                                   apply_cancel_count,
             sum(if(cancel_time is not null, credit_amount, 0))                       apply_cancel_apply_amount,
             sum(if(rejected_time is not null, 1, 0))                                 audit_refused_count,
             sum(if(rejected_time is not null, credit_amount, 0))                     audit_refused_apply_amount
      from dwd_financial_lease_flow_acc
      group by salesman_id) agg
         left join (
    select id,
           name
    from dim_employee_full
    where dt = '2023-05-09'
) emp on agg.salesman_id = emp.id;

-- 2.5 各信审经办统计
insert overwrite table ads_credit_audit_finished_audit_stats
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
from ads_credit_audit_finished_audit_stats
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
from (select '2023-05-09'                                                             dt,
             credit_audit_id,
             sum(if(reply_review_approving_time is not null, 1, 0))                   audit_approved_count,
             sum(if(reply_review_approving_time is not null, credit_amount, 0))       audit_approved_apply_amount,
             sum(if(reply_review_approving_time is not null, credit_reply_amount, 0)) audit_approved_reply_amount,
             sum(if(cancel_time is not null, 1, 0))                                   apply_cancel_count,
             sum(if(cancel_time is not null, credit_amount, 0))                       apply_cancel_apply_amount,
             sum(if(rejected_time is not null, 1, 0))                                 audit_refused_count,
             sum(if(rejected_time is not null, credit_amount, 0))                     audit_refused_apply_amount
      from dwd_financial_lease_flow_acc
      where credit_audit_id is not null
      group by credit_audit_id) agg
         left join
     (select id,
             name
      from dim_employee_full
      where dt = '2023-05-09') emp on credit_audit_id = emp.id;

-- 2.6 各行业统计
insert overwrite table ads_industry_finished_audit_stats
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
from ads_industry_finished_audit_stats
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
from (select '2023-05-09'                                                             dt,
             industry3_id,
             sum(if(reply_review_approving_time is not null, 1, 0))                   audit_approved_count,
             sum(if(reply_review_approving_time is not null, credit_amount, 0))       audit_approved_apply_amount,
             sum(if(reply_review_approving_time is not null, credit_reply_amount, 0)) audit_approved_reply_amount,
             sum(if(cancel_time is not null, 1, 0))                                   apply_cancel_count,
             sum(if(cancel_time is not null, credit_amount, 0))                       apply_cancel_apply_amount,
             sum(if(rejected_time is not null, 1, 0))                                 audit_refused_count,
             sum(if(rejected_time is not null, credit_amount, 0))                     audit_refused_apply_amount
      from dwd_financial_lease_flow_acc
      group by industry3_id) agg
         left join (
    select industry3_id,
           industry3_name,
           industry2_id,
           industry2_name,
           industry1_id,
           industry1_name
    from dim_industry_full
    where dt = '2023-05-09') industry on agg.industry3_id = industry.industry3_id;

-- 3. 已审项目转化主题
insert overwrite table ads_credit_audit_finished_transform_stats
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
from ads_credit_audit_finished_transform_stats
union
select '2023-05-09' dt,
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
from dwd_financial_lease_flow_acc;