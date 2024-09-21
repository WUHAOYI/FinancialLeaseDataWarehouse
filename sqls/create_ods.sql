-- 7.1.1 客户表（全量表）
DROP TABLE IF EXISTS ods_business_partner_full;
CREATE EXTERNAL TABLE IF NOT EXISTS ods_business_partner_full
(
    `id`          STRING COMMENT '客户ID',
    `create_time` STRING COMMENT '创建时间',
    `update_time` STRING COMMENT '更新时间',
    `name`        STRING COMMENT '客户姓名'
) COMMENT '客户全量表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
        NULL DEFINED AS ''
    LOCATION '/warehouse/financial_lease/ods/ods_business_partner_full/'
    TBLPROPERTIES ('compression.codec' = 'org.apache.hadoop.io.compress.GzipCodec');

-- 7.1.2 部门表（全量表）
DROP TABLE IF EXISTS ods_department_full;
CREATE EXTERNAL TABLE IF NOT EXISTS ods_department_full
(
    `id`                     STRING COMMENT '部门ID',
    `create_time`            STRING COMMENT '创建时间',
    `update_time`            STRING COMMENT '更新时间',
    `department_level`       STRING COMMENT '部门级别',
    `department_name`        STRING COMMENT '部门名称',
    `superior_department_id` STRING COMMENT '上级部门ID'
) COMMENT '部门全量表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
        NULL DEFINED AS ''
    LOCATION '/warehouse/financial_lease/ods/ods_department_full/'
    TBLPROPERTIES ('compression.codec' = 'org.apache.hadoop.io.compress.GzipCodec');

-- 7.1.3 员工表（全量表）
DROP TABLE IF EXISTS ods_employee_full;
CREATE EXTERNAL TABLE IF NOT EXISTS ods_employee_full
(
    `id`            STRING COMMENT '员工ID',
    `create_time`   STRING COMMENT '创建时间',
    `update_time`   STRING COMMENT '更新时间',
    `name`          STRING COMMENT '员工姓名',
    `type`          STRING comment '员工类型：1.业务员 2.风控员',
    `department_id` STRING comment '部门ID'
) COMMENT '员工全量表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
        NULL DEFINED AS ''
    LOCATION '/warehouse/financial_lease/ods/ods_employee_full/'
    TBLPROPERTIES ('compression.codec' = 'org.apache.hadoop.io.compress.GzipCodec');

-- 7.1.4 行业表（全量表）
DROP TABLE IF EXISTS ods_industry_full;
CREATE EXTERNAL TABLE IF NOT EXISTS ods_industry_full
(
    `id`                   STRING COMMENT '行业ID',
    `create_time`          STRING COMMENT '创建时间',
    `update_time`          STRING COMMENT '更新时间',
    `industry_level`       STRING COMMENT '行业级别',
    `industry_name`        STRING COMMENT '行业名称',
    `superior_industry_id` STRING COMMENT '上级行业ID'
) COMMENT '行业全量表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
        NULL DEFINED AS ''
    LOCATION '/warehouse/financial_lease/ods/ods_industry_full/'
    TBLPROPERTIES ('compression.codec' = 'org.apache.hadoop.io.compress.GzipCodec');

-- 7.1.5 授信申请表（增量表）
DROP TABLE IF EXISTS ods_credit_facility_inc;
CREATE EXTERNAL TABLE IF NOT EXISTS ods_credit_facility_inc
(
    `type` STRING COMMENT '变动类型',
    `ts`   BIGINT COMMENT '变动时间',
    `data` STRUCT<id :STRING,
                create_time :STRING,
                update_time :STRING,
                credit_amount :DECIMAL(16, 2),
                lease_organization : STRING,
                status :STRING ,
                business_partner_id :STRING,
                credit_id : STRING,
                industry_id :STRING,
                reply_id :STRING,
                salesman_id :STRING> COMMENT '数据',
    `old` MAP<STRING,STRING> COMMENT '旧值'
) COMMENT '授信申请增量表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.JsonSerDe'
    LOCATION '/warehouse/financial_lease/ods/ods_credit_facility_inc/'
    TBLPROPERTIES ('compression.codec' = 'org.apache.hadoop.io.compress.GzipCodec');

-- 7.1.6 审核记录表（增量表）
DROP TABLE IF EXISTS ods_credit_facility_status_inc;
CREATE EXTERNAL TABLE IF NOT EXISTS ods_credit_facility_status_inc
(
    `type` STRING COMMENT '变动类型',
    `ts`   BIGINT COMMENT '变动时间',
    `data` STRUCT<id :STRING,
                create_time :STRING,
                update_time :STRING,
                action_taken :STRING,
                status :STRING,
                credit_facility_id :STRING,
                employee_id :STRING,
                signatory_id :STRING> COMMENT '数据',
    `old` MAP<STRING,STRING> COMMENT '旧值'
) COMMENT '审核记录增量表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.JsonSerDe'
    LOCATION '/warehouse/financial_lease/ods/ods_credit_facility_status_inc/'
    TBLPROPERTIES ('compression.codec' = 'org.apache.hadoop.io.compress.GzipCodec');

-- 7.1.7 批复表（增量表）
DROP TABLE IF EXISTS ods_reply_inc;
CREATE EXTERNAL TABLE IF NOT EXISTS ods_reply_inc
(
    `type` STRING COMMENT '变动类型',
    `ts`   BIGINT COMMENT '变动时间',
    `data` STRUCT<id :STRING,
                create_time :STRING,
                update_time:STRING,
                credit_amount :DECIMAL(16, 2),
                irr: DECIMAL(16, 2),
                period: BIGINT,
                credit_facility_id :STRING> COMMENT '数据',
    `old` MAP<STRING,STRING> COMMENT '旧值'
) COMMENT '批复增量表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.JsonSerDe'
    LOCATION '/warehouse/financial_lease/ods/ods_reply_inc/'
    TBLPROPERTIES ('compression.codec' = 'org.apache.hadoop.io.compress.GzipCodec');

-- 7.1.8 授信表（增量表）
DROP TABLE IF EXISTS ods_credit_inc;
CREATE EXTERNAL TABLE IF NOT EXISTS ods_credit_inc
(
    `type` STRING COMMENT '变动类型',
    `ts`   BIGINT COMMENT '变动时间',
    `data` STRUCT<id :STRING,
                create_time :STRING,
                update_time :STRING,
                cancel_time: STRING,
                contract_produce_time:STRING,
                credit_amount:decimal(16,2),
                credit_occupy_time: STRING,
                status: STRING,
                contract_id: STRING,
                credit_facility_id :STRING> COMMENT '数据',
    `old` MAP<STRING,STRING> COMMENT '旧值'
) COMMENT '授信增量表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.JsonSerDe'
    LOCATION '/warehouse/financial_lease/ods/ods_credit_inc/'
    TBLPROPERTIES ('compression.codec' = 'org.apache.hadoop.io.compress.GzipCodec');

-- 7.1.9 合同表（增量表）
DROP TABLE IF EXISTS ods_contract_inc;
CREATE EXTERNAL TABLE IF NOT EXISTS ods_contract_inc
(
    `type` STRING COMMENT '变动类型',
    `ts`   BIGINT COMMENT '变动时间',
    `data` STRUCT<id :STRING,
                create_time :STRING,
                update_time:STRING,
                execution_time :STRING,
                signed_time: STRING,
                status: STRING,
                credit_id :STRING> COMMENT '数据',
    `old` MAP<STRING,STRING> COMMENT '旧值'
) COMMENT '合同增量表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.JsonSerDe'
    LOCATION '/warehouse/financial_lease/ods/ods_contract_inc/'
    TBLPROPERTIES ('compression.codec' = 'org.apache.hadoop.io.compress.GzipCodec');