-- 1. 首日装载
set hive.exec.dynamic.partition.mode=nonstrict;
insert overwrite table dwd_financial_lease_flow_acc
    partition (dt)
select duplicats.id,
       max(duplicats.lease_organization),
       max(duplicats.business_partner_id),
       max(duplicats.business_partner_name),
       max(duplicats.industry3_id),
       max(duplicats.salesman_id),
       max(duplicats.credit_audit_id),
       max(duplicats.create_time),
       max(duplicats.undistributed_time),
       max(duplicats.risk_manage_refused_time),
       max(duplicats.credit_audit_distributed_time),
       max(duplicats.credit_audit_approving_time),
       max(duplicats.feed_back_time),
       max(duplicats.first_level_review_approving_time),
       max(duplicats.second_level_review_approving_time),
       max(duplicats.project_review_meeting_approving_time),
       max(duplicats.general_manager_review_approving_time),
       max(duplicats.reply_review_approving_time),
       max(duplicats.credit_create_time),
       max(duplicats.credit_occupy_time),
       max(duplicats.contract_produce_time),
       max(duplicats.signed_time),
       max(duplicats.execution_time),
       max(duplicats.rejected_time),
       max(duplicats.cancel_time),
       max(duplicats.credit_amount),
       max(duplicats.credit_reply_amount),
       max(duplicats.credit_real_amount),
       date_format(
           if(max(duplicats.execution_time) is not null, max(duplicats.execution_time),
               if(max(duplicats.rejected_time) is not null, max(duplicats.rejected_time),
                   if(max(duplicats.cancel_time) is not null, max(duplicats.cancel_time),
                       '9999-12-31'))), 'yyyy-MM-dd')
from
(select credit_main.id,
       lease_organization,
       business_partner_id,
       partner_name business_partner_name,
       industry3_id,
       salesman_id,
       if(credit_log.status = '5' and credit_log.action_taken = '1', credit_log.employee_id, null) credit_audit_id,
       credit_main.create_time,
       if(credit_log.status = '3' and credit_log.action_taken = '1', credit_log.create_time, null) undistributed_time,
       if(credit_log.status = '2' and credit_log.action_taken = '2', credit_log.create_time, null) risk_manage_refused_time,
       if(credit_log.status = '4', credit_log.create_time, null) credit_audit_distributed_time,
       if(credit_log.status = '5' and credit_log.action_taken = '1', credit_log.create_time, null) credit_audit_approving_time,
       if(credit_log.status = '7', credit_log.create_time, null) feed_back_time,
       if(credit_log.status = '8' and credit_log.action_taken = '1', credit_log.create_time, null) first_level_review_approving_time,
       if(credit_log.status = '10' and credit_log.action_taken = '1', credit_log.create_time, null) second_level_review_approving_time,
       if(credit_log.status = '12' and credit_log.action_taken = '1', credit_log.create_time, null) project_review_meeting_approving_time,
       if(credit_log.status = '14' and credit_log.action_taken = '1', credit_log.create_time, null) general_manager_review_approving_time,
       if(credit_log.status = '16' and credit_log.action_taken = '1', credit_log.create_time, null) reply_review_approving_time,
       credit_create_time,
       credit_occupy_time,
       contract_produce_time,
       signed_time,
       execution_time,
       if(credit_log.status = '20', credit_log.create_time, null) rejected_time,
       if(credit_log.status = '21', credit_log.create_time,
           if(credit.cancel_time is not null, credit.cancel_time, contract.cancel_time)) cancel_time,
       credit_main.credit_amount,
       reply.credit_reply_amount,
       credit.credit_real_amount
from (select data.id,
             data.lease_organization,
             data.business_partner_id,
             data.industry_id industry3_id,
             data.salesman_id,
             data.create_time,
             data.credit_id,
             data.reply_id,
             data.credit_amount
     from ods_credit_facility_inc
     where dt = '2023-05-09'
       and type = 'bootstrap-insert') credit_main
        left join (
        select id partner_id,
               name partner_name
        from ods_business_partner_full
        where dt = '2023-05-09'
    ) business_partner on credit_main.business_partner_id = partner_id
    left join
    (select data.credit_facility_id,
            data.create_time,
            data.action_taken,
            data.status,
            data.employee_id
        from ods_credit_facility_status_inc
        where dt = '2023-05-09'
          and type = 'bootstrap-insert') credit_log
    on credit_main.id = credit_log.credit_facility_id
    left join
    (select data.id,
            data.credit_amount credit_reply_amount
        from ods_reply_inc
        where dt = '2023-05-09'
        and type = 'bootstrap-insert') reply
    on credit_main.reply_id = reply.id
    left join
    (select data.id,
            data.create_time credit_create_time,
            data.credit_occupy_time,
            data.contract_produce_time,
            data.contract_id,
            data.cancel_time,
            data.credit_amount credit_real_amount
    from ods_credit_inc
    where dt = '2023-05-09'
    and type = 'bootstrap-insert') credit
    on credit_main.credit_id = credit.id
    left join
    (select data.id,
            data.signed_time,
            data.execution_time,
            if(data.status = '4', data.update_time, null) cancel_time
        from ods_contract_inc
        where dt = '2023-05-09'
        and type = 'bootstrap-insert') contract
    on credit.contract_id = contract.id) duplicats
group by duplicats.id;

-- 2. 每日装载
set hive.exec.dynamic.partition.mode=nonstrict;
insert overwrite table dwd_financial_lease_flow_acc
    partition (dt)
select duplicats.id,
       max(duplicats.lease_organization),
       max(duplicats.business_partner_id),
       max(duplicats.business_partner_name),
       max(duplicats.industry3_id),
       max(duplicats.salesman_id),
       max(duplicats.credit_audit_id),
       max(duplicats.create_time),
       max(duplicats.undistributed_time),
       max(duplicats.risk_manage_refused_time),
       max(duplicats.credit_audit_distributed_time),
       max(duplicats.credit_audit_approving_time),
       max(duplicats.feed_back_time),
       max(duplicats.first_level_review_approving_time),
       max(duplicats.second_level_review_approving_time),
       max(duplicats.project_review_meeting_approving_time),
       max(duplicats.general_manager_review_approving_time),
       max(duplicats.reply_review_approving_time),
       max(duplicats.credit_create_time),
       max(duplicats.credit_occupy_time),
       max(duplicats.contract_produce_time),
       max(duplicats.signed_time),
       max(duplicats.execution_time),
       max(duplicats.rejected_time),
       max(duplicats.cancel_time),
       max(duplicats.credit_amount),
       max(duplicats.credit_reply_amount),
       max(duplicats.credit_real_amount),
       date_format(
           if(max(duplicats.execution_time) is not null, max(duplicats.execution_time),
               if(max(duplicats.rejected_time) is not null, max(duplicats.rejected_time),
                   if(max(duplicats.cancel_time) is not null, max(duplicats.cancel_time),
                       '9999-12-31'))), 'yyyy-MM-dd')
from
(select credit_main.id,
        lease_organization,
        business_partner_id,
        partner_name business_partner_name,
        industry3_id,
        salesman_id,
        if(credit_main.credit_audit_id is not null, credit_main.credit_audit_id,
            if(credit_log.status = '5' and credit_log.action_taken = '1', credit_log.employee_id, null)) credit_audit_id,
        credit_main.create_time,
        if(credit_main.undistributed_time is not null, credit_main.undistributed_time,
            if(credit_log.status = '3' and credit_log.action_taken = '1', credit_log.create_time, null)) undistributed_time,
        if(credit_main.risk_manage_refused_time is not null, credit_main.risk_manage_refused_time,
            if(credit_log.status = '2' and credit_log.action_taken = '2', credit_log.create_time, null)) risk_manage_refused_time,
        if(credit_main.credit_audit_distributed_time is not null, credit_main.credit_audit_distributed_time,
            if(credit_log.status = '4', credit_log.create_time, null)) credit_audit_distributed_time,
        if(credit_main.credit_audit_approving_time is not null, credit_main.credit_audit_approving_time,
            if(credit_log.status = '5' and credit_log.action_taken = '1', credit_log.create_time, null)) credit_audit_approving_time,
        if(credit_main.feed_back_time is not null, credit_main.feed_back_time,
            if(credit_log.status = '7', credit_log.create_time, null)) feed_back_time,
        if(credit_main.first_level_review_approving_time is not null, credit_main.first_level_review_approving_time,
            if(credit_log.status = '8' and credit_log.action_taken = '1', credit_log.create_time, null)) first_level_review_approving_time,
        if(credit_main.second_level_review_approving_time is not null, credit_main.second_level_review_approving_time,
            if(credit_log.status = '10' and credit_log.action_taken = '1', credit_log.create_time, null)) second_level_review_approving_time,
        if(credit_main.project_review_meeting_approving_time is not null, credit_main.project_review_meeting_approving_time,
            if(credit_log.status = '12' and credit_log.action_taken = '1', credit_log.create_time, null)) project_review_meeting_approving_time,
        if(credit_main.general_manager_review_approving_time is not null, credit_main.general_manager_review_approving_time,
            if(credit_log.status = '14' and credit_log.action_taken = '1', credit_log.create_time, null)) general_manager_review_approving_time,
        if(credit_main.reply_review_approving_time is not null, credit_main.reply_review_approving_time,
            if(credit_log.status = '16' and credit_log.action_taken = '1', credit_log.create_time, null)) reply_review_approving_time,
        if(credit_main.credit_create_time is not null, credit_main.credit_create_time, credit.credit_create_time) credit_create_time,
        if(credit_main.credit_occupy_time is not null, credit_main.credit_occupy_time, credit.credit_occupy_time) credit_occupy_time,
        if(credit_main.contract_produce_time is not null, credit_main.contract_produce_time, credit.contract_produce_time) contract_produce_time,
        if(credit_main.signed_time is not null, credit_main.signed_time, contract.signed_time) signed_time,
        if(credit_main.execution_time is not null, credit_main.execution_time, contract.execution_time) execution_time,
        if(credit_main.rejected_time is not null, credit_main.rejected_time,
            if(credit_log.status = '20', credit_log.create_time, null)) rejected_time,
        if(credit_main.cancel_time is not null, credit_main.cancel_time,
            if(credit_log.status = '21', credit_log.create_time,
                if(credit.cancel_time is not null, credit.cancel_time, contract.cancel_time))) cancel_time,
        credit_main.credit_amount,
        if(credit_main.credit_reply_amount is not null, credit_main.credit_reply_amount,
            reply.credit_reply_amount) credit_reply_amount,
        if(credit_main.credit_real_amount is not null, credit_main.credit_real_amount,
            credit.credit_real_amount) credit_real_amount
from
(select id,
        lease_organization,
        business_partner_id,
        business_partner_name,
        industry3_id,
        salesman_id,
        credit_audit_id,
        create_time,
        undistributed_time,
        risk_manage_refused_time,
        credit_audit_distributed_time,
        credit_audit_approving_time,
        feed_back_time,
        first_level_review_approving_time,
        second_level_review_approving_time,
        project_review_meeting_approving_time,
        general_manager_review_approving_time,
        reply_review_approving_time,
        credit_create_time,
        credit_occupy_time,
        contract_produce_time,
        signed_time,
        execution_time,
        rejected_time,
        cancel_time,
        credit_amount,
        credit_reply_amount,
        credit_real_amount,
        reply_id,
        credit_id
from
(select id,
        lease_organization,
        business_partner_id,
        business_partner_name,
        industry3_id,
        salesman_id,
        credit_audit_id,
        create_time,
        undistributed_time,
        risk_manage_refused_time,
        credit_audit_distributed_time,
        credit_audit_approving_time,
        feed_back_time,
        first_level_review_approving_time,
        second_level_review_approving_time,
        project_review_meeting_approving_time,
        general_manager_review_approving_time,
        reply_review_approving_time,
        credit_create_time,
        credit_occupy_time,
        contract_produce_time,
        signed_time,
        execution_time,
        rejected_time,
        cancel_time,
        credit_amount,
        credit_reply_amount,
        credit_real_amount,
        null reply_id,
        null credit_id
from dwd_financial_lease_flow_acc
where dt = '9999-12-31') old
         union all
     (select data.id,
             data.lease_organization,
             data.business_partner_id,
             null,
             data.industry_id industry3_id,
             data.salesman_id,
             null,
             data.create_time,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             data.credit_amount,
             null,
             null,
             data.reply_id,
             data.credit_id
     from ods_credit_facility_inc
     where dt = '2023-05-10'
       and type = 'insert'))credit_main
        left join (
        select id partner_id,
               name partner_name
        from ods_business_partner_full
        where dt = '2023-05-10'
    ) business_partner on credit_main.business_partner_id = partner_id
    left join
    (select data.credit_facility_id,
            data.create_time,
            data.action_taken,
            data.status,
            data.employee_id
        from ods_credit_facility_status_inc
        where dt = '2023-05-10'
          and type = 'insert') credit_log
    on credit_main.id = credit_log.credit_facility_id
    left join
    (select data.id,
            data.credit_amount credit_reply_amount
        from ods_reply_inc
        where dt = '2023-05-10'
        and type = 'insert') reply
    on credit_main.reply_id = reply.id
    left join
    (select data.id,
            data.create_time credit_create_time,
            data.credit_occupy_time,
            data.contract_produce_time,
            data.contract_id,
            data.cancel_time,
            data.credit_amount credit_real_amount
    from ods_credit_inc
    where dt = '2023-05-10') credit
    on credit_main.credit_id = credit.id
    left join
    (select data.id,
            data.signed_time,
            data.execution_time,
            if(data.status = '4', data.update_time, null) cancel_time
        from ods_contract_inc
        where dt = '2023-05-10'
        and type = 'update') contract
    on credit.contract_id = contract.id) duplicats
group by duplicats.id;