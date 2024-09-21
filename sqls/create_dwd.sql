-- 审批域授信审批流程累积型快照事实表
DROP TABLE IF EXISTS dwd_financial_lease_flow_acc;
CREATE EXTERNAL TABLE IF NOT EXISTS dwd_financial_lease_flow_acc
(
    `id` STRING COMMENT '授信表记录编号',
    `lease_organization` STRING COMMENT '业务方向',
    `business_partner_id` STRING COMMENT '客户ID（申请人）',
    `business_partner_name` STRING COMMENT '客户姓名',
    `industry3_id` STRING COMMENT '三级行业ID',
    `salesman_id` STRING COMMENT '业务经办ID',
    `credit_audit_id` STRING COMMENT '信审经办ID',
    `create_time` STRING COMMENT '申请发起时间',
    `undistributed_time` STRING COMMENT '风控审核通过时间',
    `risk_manage_refused_time` STRING COMMENT	'风控审核拒绝时间',
    `credit_audit_distributed_time` STRING  COMMENT '信审经办分配时间',
    `credit_audit_approving_time` STRING  COMMENT '信审经办审核通过时间',
    `feed_back_time` STRING COMMENT '业务反馈提交时间',
    `first_level_review_approving_time` STRING COMMENT '一级评审人/加签人审核通过时间',
    `second_level_review_approving_time` STRING COMMENT '二级评审人审核通过时间',
    `project_review_meeting_approving_time` STRING COMMENT '项目评审会审核通过时间',
    `general_manager_review_approving_time` STRING COMMENT '总经理/分管总审核通过时间',
    `reply_review_approving_time` STRING COMMENT '批复通过时间',
    `credit_create_time` STRING COMMENT '新增授信时间',
    `credit_occupy_time` STRING COMMENT '完成授信占用时间',
    `contract_produce_time` STRING COMMENT '完成合同制作时间',
    `signed_time` STRING COMMENT '完成签约时间',
    `execution_time` STRING COMMENT '起租时间',
    `rejected_time` STRING COMMENT '拒绝时间',
    `cancel_time` STRING COMMENT '客户取消申请时间',
	`credit_amount` decimal(16,2) COMMENT '申请授信金额',
	`credit_reply_amount` decimal(16,2) COMMENT '批复授信金额',
    `credit_real_amount` decimal(16,2) COMMENT '实际授信金额'
) COMMENT '审批域授信审批流程累积型快照事实表'
	PARTITIONED BY (`dt` STRING)
	STORED AS ORC
	LOCATION '/warehouse/financial_lease/dwd/dwd_financial_lease_flow_acc/'
	TBLPROPERTIES('orc.compress' = 'snappy');