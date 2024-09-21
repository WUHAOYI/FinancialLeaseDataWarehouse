-- 8.1 部门维度表
DROP TABLE IF EXISTS dim_department_full;
CREATE EXTERNAL TABLE IF NOT EXISTS dim_department_full
(
    `department3_id`   STRING COMMENT '三级部门ID',
    `department3_name` STRING COMMENT '三级部门名称',
    `department2_id`   STRING COMMENT '二级部门ID',
    `department2_name` STRING COMMENT '二级部门名称',
    `department1_id`   STRING COMMENT '一级部门ID',
    `department1_name` STRING COMMENT '一级部门名称'
) COMMENT '部门维度表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/financial_lease/dim/dim_department_full/'
    TBLPROPERTIES ('orc.compress' = 'snappy');

-- 8.2 员工维度表
DROP TABLE IF EXISTS dim_employee_full;
CREATE EXTERNAL TABLE IF NOT EXISTS dim_employee_full
(
    `id`             STRING COMMENT '员工ID',
    `name`           STRING COMMENT '员工姓名',
    `type`           STRING comment '员工类型：1.业务经办 2.风控员 3.风控经理 4.信审经办 5.一级评审员/一级评审加签人 6.二级评审员 7.总经理/分管总',
    `department3_id` STRING comment '三级部门ID'
) COMMENT '员工维度表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/financial_lease/dim/dim_employee_full/'
    TBLPROPERTIES ('orc.compress' = 'snappy');

-- 8.3 行业维度表
DROP TABLE IF EXISTS dim_industry_full;
CREATE EXTERNAL TABLE IF NOT EXISTS dim_industry_full
(
    `industry3_id`   STRING COMMENT '三级行业ID',
    `industry3_name` STRING COMMENT '三级行业名称',
    `industry2_id`   STRING COMMENT '二级行业ID',
    `industry2_name` STRING COMMENT '二级行业名称',
    `industry1_id`   STRING COMMENT '一级行业ID',
    `industry1_name` STRING COMMENT '一级行业名称'
) COMMENT '行业维度表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/financial_lease/dim/dim_industry_full/'
    TBLPROPERTIES ('orc.compress' = 'snappy');