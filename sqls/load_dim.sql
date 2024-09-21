-- 8.1 部门维度表
insert overwrite table dim_department_full
    partition (dt = '2023-05-09')
select department3_id,
       department3_name,
       department2_id,
       department2_name,
       department1_id,
       department1_name
from (select id              department3_id,
             department_name department3_name,
             superior_department_id
      from ods_department_full
      where dt = '2023-05-09'
        and department_level = '3') dp3
         left join (
    select id              department2_id,
           department_name department2_name,
           superior_department_id
    from ods_department_full
    where dt = '2023-05-09'
      and department_level = '2'
) dp2 on dp3.superior_department_id = department2_id
         left join (
    select id              department1_id,
           department_name department1_name
    from ods_department_full
    where dt = '2023-05-09'
      and department_level = '1'
) dp1 on dp2.superior_department_id = department1_id;

-- 8.2 员工维度表
insert overwrite table dim_employee_full
    partition (dt = '2023-05-09')
select id,
       name,
       type,
       department_id department3_id
from ods_employee_full
where dt = '2023-05-09';

-- 8.3 行业维度表
insert overwrite table dim_industry_full
    partition (dt = '2023-05-09')
select industry3_id,
       industry3_name,
       industry2_id,
       industry2_name,
       industry1_id,
       industry1_name
from (select id            industry3_id,
             industry_name industry3_name,
             superior_industry_id
      from ods_industry_full
      where dt = '2023-05-09'
        and industry_level = '3') ind3
         left join
     (select id            industry2_id,
             industry_name industry2_name,
             superior_industry_id
      from ods_industry_full
      where dt = '2023-05-09'
        and industry_level = '2') ind2
     on ind3.superior_industry_id = industry2_id
         left join
     (select id            industry1_id,
             industry_name industry1_name,
             superior_industry_id
      from ods_industry_full
      where dt = '2023-05-09'
        and industry_level = '1') ind1
     on ind2.superior_industry_id = industry1_id;

