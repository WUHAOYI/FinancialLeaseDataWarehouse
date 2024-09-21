
-- 1）综合统计
DROP TABLE IF EXISTS ads_unfinished_audit_stats;
CREATE TABLE `ads_unfinished_audit_stats`
(
    `dt`                               date           DEFAULT NULL COMMENT ' 统计日期 ',
    `created_project_count`            bigint         DEFAULT NULL COMMENT ' 新建状态项目数 ',
    `created_project_amount`           decimal(16, 2) DEFAULT NULL COMMENT ' 新建状态项目申请金额 ',
    `risk_control_not_approved_count`  bigint         DEFAULT NULL COMMENT ' 未达风控状态项目数 ',
    `risk_control_not_approved_amount` decimal(16, 2) DEFAULT NULL COMMENT ' 未达风控状态项目申请金额 ',
    `credit_audit_approved_count`      bigint         DEFAULT NULL COMMENT ' 信审经办审核通过状态项目数 ',
    `credit_audit_approved_amount`     decimal(16, 2) DEFAULT NULL COMMENT ' 信审经办审核通过状态项目申请金额 ',
    `feedback_submitted_count`         bigint         DEFAULT NULL COMMENT ' 已提交业务反馈状态项目数 ',
    `feedback_submitted_amount`        decimal(16, 2) DEFAULT NULL COMMENT ' 已提交业务反馈状态项目申请金额 ',
    `level1_review_approved_count`     bigint         DEFAULT NULL COMMENT ' 一级评审通过状态项目数 ',
    `level1_review_approved_amount`    decimal(16, 2) DEFAULT NULL COMMENT ' 一级评审通过状态项目申请金额 ',
    `level2_review_approved_count`     bigint         DEFAULT NULL COMMENT ' 二级评审通过状态项目数 ',
    `level2_review_approved_amount`    decimal(16, 2) DEFAULT NULL COMMENT ' 二级评审通过状态项目申请金额 ',
    `review_meeting_approved_count`    bigint         DEFAULT NULL COMMENT ' 项目评审会审核通过状态项目数 ',
    `review_meeting_approved_amount`   decimal(16, 2) DEFAULT NULL COMMENT ' 项目评审会审核通过状态项目申请金额 ',
    `general_manager_approved_count`   bigint         DEFAULT NULL COMMENT ' 总经理/分管总审核通过状态项目数 ',
    `general_manager_approved_amount`  decimal(16, 2) DEFAULT NULL COMMENT ' 总经理/分管总审核通过状态项目申请金额 ',
    `reply_issued_count`               bigint         DEFAULT NULL COMMENT ' 出具批复状态项目数 ',
    `reply_issued_apply_amount`        decimal(16, 2) DEFAULT NULL COMMENT ' 出具批复状态项目申请金额 ',
    `reply_issued_reply_amount`        decimal(16, 2) DEFAULT NULL COMMENT ' 出具批复状态项目批复金额 '
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='待审/在审项目综合统计';

-- 2）各业务方向统计
DROP TABLE IF EXISTS ads_lease_org_unfinished_audit_stats;
CREATE TABLE `ads_lease_org_unfinished_audit_stats`
(
    `dt`                               date                                    DEFAULT NULL COMMENT ' 统计日期 ',
    `lease_organization`               varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 业务方向 ',
    `created_project_count`            bigint                                  DEFAULT NULL COMMENT ' 新建状态项目数 ',
    `created_project_amount`           decimal(16, 2)                          DEFAULT NULL COMMENT ' 新建状态项目申请金额 ',
    `risk_control_not_approved_count`  bigint                                  DEFAULT NULL COMMENT ' 未达风控状态项目数 ',
    `risk_control_not_approved_amount` decimal(16, 2)                          DEFAULT NULL COMMENT ' 未达风控状态项目申请金额 ',
    `credit_audit_approved_count`      bigint                                  DEFAULT NULL COMMENT ' 信审经办审核通过状态项目数 ',
    `credit_audit_approved_amount`     decimal(16, 2)                          DEFAULT NULL COMMENT ' 信审经办审核通过状态项目申请金额 ',
    `feedback_submitted_count`         bigint                                  DEFAULT NULL COMMENT ' 已提交业务反馈状态项目数 ',
    `feedback_submitted_amount`        decimal(16, 2)                          DEFAULT NULL COMMENT ' 已提交业务反馈状态项目申请金额 ',
    `level1_review_approved_count`     bigint                                  DEFAULT NULL COMMENT ' 一级评审通过状态项目数 ',
    `level1_review_approved_amount`    decimal(16, 2)                          DEFAULT NULL COMMENT ' 一级评审通过状态项目申请金额 ',
    `level2_review_approved_count`     bigint                                  DEFAULT NULL COMMENT ' 二级评审通过状态项目数 ',
    `level2_review_approved_amount`    decimal(16, 2)                          DEFAULT NULL COMMENT ' 二级评审通过状态项目申请金额 ',
    `review_meeting_approved_count`    bigint                                  DEFAULT NULL COMMENT ' 项目评审会审核通过状态项目数 ',
    `review_meeting_approved_amount`   decimal(16, 2)                          DEFAULT NULL COMMENT ' 项目评审会审核通过状态项目申请金额 ',
    `general_manager_approved_count`   bigint                                  DEFAULT NULL COMMENT ' 总经理/分管总审核通过状态项目数 ',
    `general_manager_approved_amount`  decimal(16, 2)                          DEFAULT NULL COMMENT ' 总经理/分管总审核通过状态项目申请金额 ',
    `reply_issued_count`               bigint                                  DEFAULT NULL COMMENT ' 出具批复状态项目数 ',
    `reply_issued_apply_amount`        decimal(16, 2)                          DEFAULT NULL COMMENT ' 出具批复状态项目申请金额 ',
    `reply_issued_reply_amount`        decimal(16, 2)                          DEFAULT NULL COMMENT ' 出具批复状态项目批复金额 '
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='各业务方向待审/在审项目统计';

-- 3）各部门统计
DROP TABLE IF EXISTS ads_department_unfinished_audit_stats;
CREATE TABLE `ads_department_unfinished_audit_stats`
(
    `dt`                               date                                    DEFAULT NULL COMMENT ' 统计日期 ',
    `department3_id`                   varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 三级部门ID ',
    `department3_name`                 varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 三级部门名称 ',
    `department2_id`                   varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 二级部门ID ',
    `department2_name`                 varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 二级部门名称 ',
    `department1_id`                   varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 一级部门ID ',
    `department1_name`                 varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 一级部门名称 ',
    `created_project_count`            bigint                                  DEFAULT NULL COMMENT ' 新建状态项目数 ',
    `created_project_amount`           decimal(16, 2)                          DEFAULT NULL COMMENT ' 新建状态项目申请金额 ',
    `risk_control_not_approved_count`  bigint                                  DEFAULT NULL COMMENT ' 未达风控状态项目数 ',
    `risk_control_not_approved_amount` decimal(16, 2)                          DEFAULT NULL COMMENT ' 未达风控状态项目申请金额 ',
    `credit_audit_approved_count`      bigint                                  DEFAULT NULL COMMENT ' 信审经办审核通过状态项目数 ',
    `credit_audit_approved_amount`     decimal(16, 2)                          DEFAULT NULL COMMENT ' 信审经办审核通过状态项目申请金额 ',
    `feedback_submitted_count`         bigint                                  DEFAULT NULL COMMENT ' 已提交业务反馈状态项目数 ',
    `feedback_submitted_amount`        decimal(16, 2)                          DEFAULT NULL COMMENT ' 已提交业务反馈状态项目申请金额 ',
    `level1_review_approved_count`     bigint                                  DEFAULT NULL COMMENT ' 一级评审通过状态项目数 ',
    `level1_review_approved_amount`    decimal(16, 2)                          DEFAULT NULL COMMENT ' 一级评审通过状态项目申请金额 ',
    `level2_review_approved_count`     bigint                                  DEFAULT NULL COMMENT ' 二级评审通过状态项目数 ',
    `level2_review_approved_amount`    decimal(16, 2)                          DEFAULT NULL COMMENT ' 二级评审通过状态项目申请金额 ',
    `review_meeting_approved_count`    bigint                                  DEFAULT NULL COMMENT ' 项目评审会审核通过状态项目数 ',
    `review_meeting_approved_amount`   decimal(16, 2)                          DEFAULT NULL COMMENT ' 项目评审会审核通过状态项目申请金额 ',
    `general_manager_approved_count`   bigint                                  DEFAULT NULL COMMENT ' 总经理/分管总审核通过状态项目数 ',
    `general_manager_approved_amount`  decimal(16, 2)                          DEFAULT NULL COMMENT ' 总经理/分管总审核通过状态项目申请金额 ',
    `reply_issued_count`               bigint                                  DEFAULT NULL COMMENT ' 出具批复状态项目数 ',
    `reply_issued_apply_amount`        decimal(16, 2)                          DEFAULT NULL COMMENT ' 出具批复状态项目申请金额 ',
    `reply_issued_reply_amount`        decimal(16, 2)                          DEFAULT NULL COMMENT ' 出具批复状态项目批复金额 '
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='各部门待审/在审项目统计';

-- 4）各业务经办统计
DROP TABLE IF EXISTS ads_salesman_unfinished_audit_stats;
CREATE TABLE `ads_salesman_unfinished_audit_stats`
(
    `dt`                               date                                    DEFAULT NULL COMMENT ' 统计日期 ',
    `salesman_id`                      varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 业务经办员工ID ',
    `salesman_name`                    varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 业务经办员工姓名 ',
    `created_project_count`            bigint                                  DEFAULT NULL COMMENT ' 新建状态项目数 ',
    `created_project_amount`           decimal(16, 2)                          DEFAULT NULL COMMENT ' 新建状态项目申请金额 ',
    `risk_control_not_approved_count`  bigint                                  DEFAULT NULL COMMENT ' 未达风控状态项目数 ',
    `risk_control_not_approved_amount` decimal(16, 2)                          DEFAULT NULL COMMENT ' 未达风控状态项目申请金额 ',
    `credit_audit_approved_count`      bigint                                  DEFAULT NULL COMMENT ' 信审经办审核通过状态项目数 ',
    `credit_audit_approved_amount`     decimal(16, 2)                          DEFAULT NULL COMMENT ' 信审经办审核通过状态项目申请金额 ',
    `feedback_submitted_count`         bigint                                  DEFAULT NULL COMMENT ' 已提交业务反馈状态项目数 ',
    `feedback_submitted_amount`        decimal(16, 2)                          DEFAULT NULL COMMENT ' 已提交业务反馈状态项目申请金额 ',
    `level1_review_approved_count`     bigint                                  DEFAULT NULL COMMENT ' 一级评审通过状态项目数 ',
    `level1_review_approved_amount`    decimal(16, 2)                          DEFAULT NULL COMMENT ' 一级评审通过状态项目申请金额 ',
    `level2_review_approved_count`     bigint                                  DEFAULT NULL COMMENT ' 二级评审通过状态项目数 ',
    `level2_review_approved_amount`    decimal(16, 2)                          DEFAULT NULL COMMENT ' 二级评审通过状态项目申请金额 ',
    `review_meeting_approved_count`    bigint                                  DEFAULT NULL COMMENT ' 项目评审会审核通过状态项目数 ',
    `review_meeting_approved_amount`   decimal(16, 2)                          DEFAULT NULL COMMENT ' 项目评审会审核通过状态项目申请金额 ',
    `general_manager_approved_count`   bigint                                  DEFAULT NULL COMMENT ' 总经理/分管总审核通过状态项目数 ',
    `general_manager_approved_amount`  decimal(16, 2)                          DEFAULT NULL COMMENT ' 总经理/分管总审核通过状态项目申请金额 ',
    `reply_issued_count`               bigint                                  DEFAULT NULL COMMENT ' 出具批复状态项目数 ',
    `reply_issued_apply_amount`        decimal(16, 2)                          DEFAULT NULL COMMENT ' 出具批复状态项目申请金额 ',
    `reply_issued_reply_amount`        decimal(16, 2)                          DEFAULT NULL COMMENT ' 出具批复状态项目批复金额 '
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='各业务经办待审/在审项目统计';

-- 5）各信审经办统计
DROP TABLE IF EXISTS ads_credit_audit_unfinished_audit_stats;
CREATE TABLE `ads_credit_audit_unfinished_audit_stats`
(
    `dt`                              date                                    DEFAULT NULL COMMENT ' 统计日期 ',
    `credit_audit_id`                 varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 信审经办ID ',
    `credit_audit_name`               varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 信审经办姓名 ',
    `credit_audit_approved_count`     bigint                                  DEFAULT NULL COMMENT ' 信审经办审核通过状态项目数 ',
    `credit_audit_approved_amount`    decimal(16, 2)                          DEFAULT NULL COMMENT ' 信审经办审核通过状态项目申请金额 ',
    `feedback_submitted_count`        bigint                                  DEFAULT NULL COMMENT ' 已提交业务反馈状态项目数 ',
    `feedback_submitted_amount`       decimal(16, 2)                          DEFAULT NULL COMMENT ' 已提交业务反馈状态项目申请金额 ',
    `level1_review_approved_count`    bigint                                  DEFAULT NULL COMMENT ' 一级评审通过状态项目数 ',
    `level1_review_approved_amount`   decimal(16, 2)                          DEFAULT NULL COMMENT ' 一级评审通过状态项目申请金额 ',
    `level2_review_approved_count`    bigint                                  DEFAULT NULL COMMENT ' 二级评审通过状态项目数 ',
    `level2_review_approved_amount`   decimal(16, 2)                          DEFAULT NULL COMMENT ' 二级评审通过状态项目申请金额 ',
    `review_meeting_approved_count`   bigint                                  DEFAULT NULL COMMENT ' 项目评审会审核通过状态项目数 ',
    `review_meeting_approved_amount`  decimal(16, 2)                          DEFAULT NULL COMMENT ' 项目评审会审核通过状态项目申请金额 ',
    `general_manager_approved_count`  bigint                                  DEFAULT NULL COMMENT ' 总经理/分管总审核通过状态项目数 ',
    `general_manager_approved_amount` decimal(16, 2)                          DEFAULT NULL COMMENT ' 总经理/分管总审核通过状态项目申请金额 ',
    `reply_issued_count`              bigint                                  DEFAULT NULL COMMENT ' 出具批复状态项目数 ',
    `reply_issued_apply_amount`       decimal(16, 2)                          DEFAULT NULL COMMENT ' 出具批复状态项目申请金额 ',
    `reply_issued_reply_amount`       decimal(16, 2)                          DEFAULT NULL COMMENT ' 出具批复状态项目批复金额 '
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='各信审经办待审/在审项目统计';

-- 6）各行业统计
DROP TABLE IF EXISTS ads_industry_unfinished_audit_stats;
CREATE TABLE `ads_industry_unfinished_audit_stats`
(
    `dt`                               date                                    DEFAULT NULL COMMENT ' 统计日期 ',
    `industry3_id`                     varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 三级行业ID ',
    `industry3_name`                   varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 三级行业名称 ',
    `industry2_id`                     varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 二级行业ID ',
    `industry2_name`                   varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 二级行业名称 ',
    `industry1_id`                     varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 一级行业ID ',
    `industry1_name`                   varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 一级行业名称 ',
    `created_project_count`            bigint                                  DEFAULT NULL COMMENT ' 新建状态项目数 ',
    `created_project_amount`           decimal(16, 2)                          DEFAULT NULL COMMENT ' 新建状态项目申请金额 ',
    `risk_control_not_approved_count`  bigint                                  DEFAULT NULL COMMENT ' 未达风控状态项目数 ',
    `risk_control_not_approved_amount` decimal(16, 2)                          DEFAULT NULL COMMENT ' 未达风控状态项目申请金额 ',
    `credit_audit_approved_count`      bigint                                  DEFAULT NULL COMMENT ' 信审经办审核通过状态项目数 ',
    `credit_audit_approved_amount`     decimal(16, 2)                          DEFAULT NULL COMMENT ' 信审经办审核通过状态项目申请金额 ',
    `feedback_submitted_count`         bigint                                  DEFAULT NULL COMMENT ' 已提交业务反馈状态项目数 ',
    `feedback_submitted_amount`        decimal(16, 2)                          DEFAULT NULL COMMENT ' 已提交业务反馈状态项目申请金额 ',
    `level1_review_approved_count`     bigint                                  DEFAULT NULL COMMENT ' 一级评审通过状态项目数 ',
    `level1_review_approved_amount`    decimal(16, 2)                          DEFAULT NULL COMMENT ' 一级评审通过状态项目申请金额 ',
    `level2_review_approved_count`     bigint                                  DEFAULT NULL COMMENT ' 二级评审通过状态项目数 ',
    `level2_review_approved_amount`    decimal(16, 2)                          DEFAULT NULL COMMENT ' 二级评审通过状态项目申请金额 ',
    `review_meeting_approved_count`    bigint                                  DEFAULT NULL COMMENT ' 项目评审会审核通过状态项目数 ',
    `review_meeting_approved_amount`   decimal(16, 2)                          DEFAULT NULL COMMENT ' 项目评审会审核通过状态项目申请金额 ',
    `general_manager_approved_count`   bigint                                  DEFAULT NULL COMMENT ' 总经理/分管总审核通过状态项目数 ',
    `general_manager_approved_amount`  decimal(16, 2)                          DEFAULT NULL COMMENT ' 总经理/分管总审核通过状态项目申请金额 ',
    `reply_issued_count`               bigint                                  DEFAULT NULL COMMENT ' 出具批复状态项目数 ',
    `reply_issued_apply_amount`        decimal(16, 2)                          DEFAULT NULL COMMENT ' 出具批复状态项目申请金额 ',
    `reply_issued_reply_amount`        decimal(16, 2)                          DEFAULT NULL COMMENT ' 出具批复状态项目批复金额 '
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='各行业待审/在审项目统计';

-- 7）综合统计
DROP TABLE IF EXISTS ads_finished_audit_stats;
CREATE TABLE `ads_finished_audit_stats`
(
    `dt`                          date           DEFAULT NULL COMMENT ' 统计日期 ',
    `audit_approved_count`        bigint         DEFAULT NULL COMMENT ' 审批通过项目数 ',
    `audit_approved_apply_amount` decimal(16, 2) DEFAULT NULL COMMENT ' 审批通过项目申请金额 ',
    `audit_approved_reply_amount` decimal(16, 2) DEFAULT NULL COMMENT ' 审批通过项目批复金额 ',
    `apply_cancel_count`          bigint         DEFAULT NULL COMMENT ' 取消项目数 ',
    `apply_cancel_apply_amount`   decimal(16, 2) DEFAULT NULL COMMENT ' 取消项目申请金额 ',
    `audit_refused_count`         bigint         DEFAULT NULL COMMENT ' 审批拒绝项目数 ',
    `audit_refused_apply_amount`  decimal(16, 2) DEFAULT NULL COMMENT ' 审批拒绝项目申请金额 '
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='已审项目综合统计';

-- 8）各业务方向统计
DROP TABLE IF EXISTS ads_lease_org_finished_audit_stats;
CREATE TABLE `ads_lease_org_finished_audit_stats`
(
    `dt`                          date                                    DEFAULT NULL COMMENT ' 统计日期 ',
    `lease_organization`          varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 业务反向 ',
    `audit_approved_count`        bigint                                  DEFAULT NULL COMMENT ' 审批通过项目数 ',
    `audit_approved_apply_amount` decimal(16, 2)                          DEFAULT NULL COMMENT ' 审批通过项目申请金额 ',
    `audit_approved_reply_amount` decimal(16, 2)                          DEFAULT NULL COMMENT ' 审批通过项目批复金额 ',
    `apply_cancel_count`          bigint                                  DEFAULT NULL COMMENT ' 取消项目数 ',
    `apply_cancel_apply_amount`   decimal(16, 2)                          DEFAULT NULL COMMENT ' 取消项目申请金额 ',
    `audit_refused_count`         bigint                                  DEFAULT NULL COMMENT ' 审批拒绝项目数 ',
    `audit_refused_apply_amount`  decimal(16, 2)                          DEFAULT NULL COMMENT ' 审批拒绝项目申请金额 '
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='各业务方向已审项目统计';

-- 9）各部门统计
DROP TABLE IF EXISTS ads_department_finished_audit_stats;
CREATE TABLE `ads_department_finished_audit_stats`
(
    `dt`                          date                                    DEFAULT NULL COMMENT ' 统计日期 ',
    `department3_id`              varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 三级部门ID ',
    `department3_name`            varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 三级部门名称 ',
    `department2_id`              varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 二级部门ID ',
    `department2_name`            varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 二级部门名称 ',
    `department1_id`              varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 一级部门ID ',
    `department1_name`            varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 一级部门名称 ',
    `audit_approved_count`        bigint                                  DEFAULT NULL COMMENT ' 审批通过项目数 ',
    `audit_approved_apply_amount` decimal(16, 2)                          DEFAULT NULL COMMENT ' 审批通过项目申请金额 ',
    `audit_approved_reply_amount` decimal(16, 2)                          DEFAULT NULL COMMENT ' 审批通过项目批复金额 ',
    `apply_cancel_count`          bigint                                  DEFAULT NULL COMMENT ' 取消项目数 ',
    `apply_cancel_apply_amount`   decimal(16, 2)                          DEFAULT NULL COMMENT ' 取消项目申请金额 ',
    `audit_refused_count`         bigint                                  DEFAULT NULL COMMENT ' 审批拒绝项目数 ',
    `audit_refused_apply_amount`  decimal(16, 2)                          DEFAULT NULL COMMENT ' 审批拒绝项目申请金额 '
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='各部门已审项目统计';

-- 10）各业务经办统计
DROP TABLE IF EXISTS ads_salesman_finished_audit_stats;
CREATE TABLE `ads_salesman_finished_audit_stats`
(
    `dt`                          date                                    DEFAULT NULL COMMENT ' 统计日期 ',
    `salesman_id`                 varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 业务经办ID ',
    `salesman_name`               varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 业务经办姓名 ',
    `audit_approved_count`        bigint                                  DEFAULT NULL COMMENT ' 审批通过项目数 ',
    `audit_approved_apply_amount` decimal(16, 2)                          DEFAULT NULL COMMENT ' 审批通过项目申请金额 ',
    `audit_approved_reply_amount` decimal(16, 2)                          DEFAULT NULL COMMENT ' 审批通过项目批复金额 ',
    `apply_cancel_count`          bigint                                  DEFAULT NULL COMMENT ' 取消项目数 ',
    `apply_cancel_apply_amount`   decimal(16, 2)                          DEFAULT NULL COMMENT ' 取消项目申请金额 ',
    `audit_refused_count`         bigint                                  DEFAULT NULL COMMENT ' 审批拒绝项目数 ',
    `audit_refused_apply_amount`  decimal(16, 2)                          DEFAULT NULL COMMENT ' 审批拒绝项目申请金额 '
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='各业务经办已审项目统计';

-- 11）各信审经办统计
DROP TABLE IF EXISTS ads_credit_audit_finished_audit_stats;
CREATE TABLE `ads_credit_audit_finished_audit_stats`
(
    `dt`                          date                                    DEFAULT NULL COMMENT ' 统计日期 ',
    `credit_audit_id`             varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 信审经办ID ',
    `credit_audit_name`           varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 信审经办姓名 ',
    `audit_approved_count`        bigint                                  DEFAULT NULL COMMENT ' 审批通过项目数 ',
    `audit_approved_apply_amount` decimal(16, 2)                          DEFAULT NULL COMMENT ' 审批通过项目申请金额 ',
    `audit_approved_reply_amount` decimal(16, 2)                          DEFAULT NULL COMMENT ' 审批通过项目批复金额 ',
    `apply_cancel_count`          bigint                                  DEFAULT NULL COMMENT ' 取消项目数 ',
    `apply_cancel_apply_amount`   decimal(16, 2)                          DEFAULT NULL COMMENT ' 取消项目申请金额 ',
    `audit_refused_count`         bigint                                  DEFAULT NULL COMMENT ' 审批拒绝项目数 ',
    `audit_refused_apply_amount`  decimal(16, 2)                          DEFAULT NULL COMMENT ' 审批拒绝项目申请金额 '
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='各信审经办已审项目统计';

-- 12）各行业统计
DROP TABLE IF EXISTS ads_industry_finished_audit_stats;
CREATE TABLE `ads_industry_finished_audit_stats`
(
    `dt`                          date                                    DEFAULT NULL COMMENT ' 统计日期 ',
    `industry3_id`                varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 三级行业ID ',
    `industry3_name`              varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 三级行业名称 ',
    `industry2_id`                varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 二级行业ID ',
    `industry2_name`              varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 二级行业名称 ',
    `industry1_id`                varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 一级行业ID ',
    `industry1_name`              varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT ' 一级行业名称 ',
    `audit_approved_count`        bigint                                  DEFAULT NULL COMMENT ' 审批通过项目数 ',
    `audit_approved_apply_amount` decimal(16, 2)                          DEFAULT NULL COMMENT ' 审批通过项目申请金额 ',
    `audit_approved_reply_amount` decimal(16, 2)                          DEFAULT NULL COMMENT ' 审批通过项目批复金额 ',
    `apply_cancel_count`          bigint                                  DEFAULT NULL COMMENT ' 取消项目数 ',
    `apply_cancel_apply_amount`   decimal(16, 2)                          DEFAULT NULL COMMENT ' 取消项目申请金额 ',
    `audit_refused_count`         bigint                                  DEFAULT NULL COMMENT ' 审批拒绝项目数 ',
    `audit_refused_apply_amount`  decimal(16, 2)                          DEFAULT NULL COMMENT ' 审批拒绝项目申请金额 '
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='各行业已审项目统计';

-- 13）已审项目转化主题
DROP TABLE IF EXISTS ads_credit_audit_finished_transform_stats;
CREATE TABLE `ads_credit_audit_finished_transform_stats`
(
    `dt`                                 date           DEFAULT NULL COMMENT ' 统计日期 ',
    `credit_audit_finished_count`        bigint         DEFAULT NULL COMMENT ' 审批结束项目数 ',
    `credit_audit_finished_apply_amount` decimal(16, 2) DEFAULT NULL COMMENT ' 审批结束项目申请金额 ',
    `credit_audit_approved_count`        bigint         DEFAULT NULL COMMENT ' 审批通过项目数 ',
    `credit_audit_approved_apply_amount` decimal(16, 2) DEFAULT NULL COMMENT ' 审批通过项目申请金额 ',
    `credit_audit_approved_reply_amount` decimal(16, 2) DEFAULT NULL COMMENT ' 审批通过项目批复金额 ',
    `credit_created_count`               bigint         DEFAULT NULL COMMENT ' 新增授信项目数 ',
    `credit_created_apply_amount`        decimal(16, 2) DEFAULT NULL COMMENT ' 新增授信项目申请金额 ',
    `credit_created_reply_amount`        decimal(16, 2) DEFAULT NULL COMMENT ' 新增授信项目批复金额 ',
    `credit_created_credit_amount`       decimal(16, 2) DEFAULT NULL COMMENT ' 新增授信项目授信金额 ',
    `credit_occupied_count`              bigint         DEFAULT NULL COMMENT ' 完成授信占用项目数 ',
    `credit_occupied_apply_amount`       decimal(16, 2) DEFAULT NULL COMMENT ' 完成授信占用项目申请金额 ',
    `credit_occupied_reply_amount`       decimal(16, 2) DEFAULT NULL COMMENT ' 完成授信占用项目批复金额 ',
    `credit_occupied_credit_amount`      decimal(16, 2) DEFAULT NULL COMMENT ' 完成授信占用项目授信金额 ',
    `contract_produced_count`            bigint         DEFAULT NULL COMMENT ' 完成合同制作项目数 ',
    `contract_produced_apply_amount`     decimal(16, 2) DEFAULT NULL COMMENT ' 完成合同制作项目申请金额 ',
    `contract_produced_reply_amount`     decimal(16, 2) DEFAULT NULL COMMENT ' 完成合同制作项目批复金额 ',
    `contract_produced_credit_amount`    decimal(16, 2) DEFAULT NULL COMMENT ' 完成合同制作项目授信金额 ',
    `credit_signed_count`                bigint         DEFAULT NULL COMMENT ' 签约项目数 ',
    `credit_signed_apply_amount`         decimal(16, 2) DEFAULT NULL COMMENT ' 签约项目申请金额 ',
    `credit_signed_reply_amount`         decimal(16, 2) DEFAULT NULL COMMENT ' 签约项目批复金额 ',
    `credit_signed_credit_amount`        decimal(16, 2) DEFAULT NULL COMMENT ' 签约项目授信金额 ',
    `leased_count`                       bigint         DEFAULT NULL COMMENT ' 起租项目数 ',
    `leased_apply_amount`                decimal(16, 2) DEFAULT NULL COMMENT ' 起租项目申请金额 ',
    `leased_reply_amount`                decimal(16, 2) DEFAULT NULL COMMENT ' 起租项目批复金额 ',
    `leased_credit_amount`               decimal(16, 2) DEFAULT NULL COMMENT ' 起租项目授信金额 '
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='已审项目转化情况统计'