#!/bin/bash

APP=financial_lease
if [[ -n "$2" ]]; then
	do_date=$2
else
	do_date=`date -d '-1 day' +%F`
fi

dwd_financial_lease_flow_acc="
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.cbo.enable=false;
set hive.vectorized.execution.enabled=false;

insert overwrite table ${APP}.dwd_financial_lease_flow_acc partition(dt)
select
     id,
    max(lease_organization),
    max(business_partner_id),
    max(business_partner_name),
    max(industry3_id),
    max(salesman_id),
    max(credit_audit_id),
    max(create_time),
    max(undistributed_time),
    max(risk_manage_refused_time),
    max(credit_audit_distributed_time),
    max(credit_audit_approving_time),
    max(feed_back_time),
    max(first_level_review_approving_time),
    max(second_level_review_approving_time),
    max(project_review_meeting_approving_time),
    max(general_manager_review_approving_time),
    max(reply_review_approving_time),
    max(credit_create_time),
    max(credit_occupy_time),
    max(contract_produce_time),
    max(signed_time),
    max(execution_time),
    max(rejected_time),
    max(cancel_time),
    max(credit_amount),
    max(credit_reply_amount),
    max(credit_real_amount),
    date_format(if(max(execution_time) is not null , max(execution_time),
        if(max(rejected_time) is not null, max(rejected_time) ,
            if(max(cancel_time) is not null, max(cancel_time),'9999-12-31'))),'yyyy-MM-dd') dt
from (
     select
        cf.id,
        lease_organization,
        cf.business_partner_id business_partner_id,
        bp.business_partner_name business_partner_name,
        cf.industry3_id industry3_id,
        salesman_id,
        if(cfs.status='5' and cfs.action_taken='1',cfs.employee_id,credit_audit_id) credit_audit_id,
        cf.create_time create_time,
        if(cfs.status='3' and cfs.action_taken='1',cfs.create_time,undistributed_time) undistributed_time,
        if(cfs.status='2' and cfs.action_taken='2',cfs.create_time,risk_manage_refused_time) risk_manage_refused_time,
        if(cfs.status='4',cfs.create_time,credit_audit_distributed_time) credit_audit_distributed_time,
        if(cfs.status='5' and cfs.action_taken='1',cfs.create_time,credit_audit_approving_time) credit_audit_approving_time,
        if(cfs.status='7' ,cfs.create_time,feed_back_time) feed_back_time,
        if(cfs.status='8' and cfs.action_taken='1',cfs.create_time,first_level_review_approving_time) first_level_review_approving_time,
        if(cfs.status='10' and cfs.action_taken='1',cfs.create_time,second_level_review_approving_time) second_level_review_approving_time,
        if(cfs.status='12' and cfs.action_taken='1',cfs.create_time,project_review_meeting_approving_time) project_review_meeting_approving_time,
        if(cfs.status='14' and cfs.action_taken='1',cfs.create_time,general_manager_review_approving_time) general_manager_review_approving_time,
        if(cfs.status='16' and cfs.action_taken='1',cfs.create_time,reply_review_approving_time) reply_review_approving_time,
        nvl(credit_create_time,cre.create_time ) credit_create_time,
        nvl(cf.credit_occupy_time,cre.credit_occupy_time) credit_occupy_time,
        nvl(cf.contract_produce_time,cre.contract_produce_time) contract_produce_time,
        nvl(cf.signed_time,con.signed_time) signed_time,
        con.execution_time execution_time,
        if(cfs.status='20' ,cfs.create_time,null) rejected_time,
        if(cfs.status='21' ,cfs.create_time,if(cre.cancel_time is not null,cre.cancel_time,con.cancel_time)) cancel_time,
        cf.credit_amount,
        rep.credit_amount credit_reply_amount,
        cre.credit_amount credit_real_amount
    from (
        select
            id,
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
        from ${APP}.dwd_financial_lease_flow_acc
        where dt='9999-12-31'
        union
        select
            data.id id,
            data.lease_organization,
            data.business_partner_id,
            null business_partner_name,
            data.industry_id industry3_id,
            data.salesman_id,
            null credit_audit_id,
            null create_time,
            null undistributed_time,
            null risk_manage_refused_time,
            null credit_audit_distributed_time,
            null credit_audit_approving_time,
            null feed_back_time,
            null first_level_review_approving_time,
            null second_level_review_approving_time,
            null project_review_meeting_approving_time,
            null general_manager_review_approving_time,
            null reply_review_approving_time,
            null credit_create_time,
            null credit_occupy_time,
            null contract_produce_time,
            null signed_time,
            null execution_time,
            null rejected_time,
            null cancel_time,
            data.credit_amount,
            null credit_reply_amount,
            null credit_real_amount,
            data.reply_id reply_id,
            data.credit_id credit_id
        from ${APP}.ods_credit_facility_inc
        where dt='${do_date}'
        and type='insert'
    )cf
        left join (
            select
                id business_partner_id,
                name business_partner_name
            from ${APP}.ods_business_partner_full
            where dt='${do_date}'
        )bp
        on cf.business_partner_id=bp.business_partner_id
        left join (
            select
                data.create_time,
                data.action_taken,
                data.status,
                data.credit_facility_id,
                data.employee_id,
                data.signatory_id
            from ${APP}.ods_credit_facility_status_inc
            where dt='${do_date}'
            and type='insert'
        )cfs
        on cf.id=cfs.credit_facility_id
        left join (
            select
                data.create_time,
                data.update_time,
                data.credit_amount,
                data.irr,
                data.period,
                data.credit_facility_id
            from ${APP}.ods_reply_inc
            where dt='${do_date}'
            and type='insert'
        )rep
        on cf.id=rep.credit_facility_id
        left join (
            select
                data.id,
                data.create_time,
                data.update_time,
                data.cancel_time,
                data.contract_produce_time,
                data.credit_amount,
                data.credit_occupy_time,
                data.status,
                data.contract_id,
                data.credit_facility_id
            from ${APP}.ods_credit_inc
            where dt='${do_date}'
        )cre
        on cf.credit_id=cre.id
        left join (
            select
                data.id,
                data.execution_time,
                data.signed_time,
                if(data.status='4',data.update_time,null) cancel_time,
                data.credit_id
            from ${APP}.ods_contract_inc
            where dt='${do_date}'
        )con
        on cre.contract_id=con.id
)t1
group by id;
"

case $1 in
	"dwd_financial_lease_flow_acc" )
	hive -e "$dwd_financial_lease_flow_acc"
		;;
	"all" )
	hive -e "$dwd_financial_lease_flow_acc"
		;;
esac
