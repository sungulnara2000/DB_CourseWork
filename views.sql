create or replace view view_person as (
  select (middle_nm || ' ' || first_nm || ' ' || last_nm) as ФИО,
          case gender_cd
            when 0 then 'мужчина'
            when 1 then 'женщина'
          end as Пол,
          case marital_status_cd
            when 0 then 'не состоит'
            when 1 then 'состоит'
            when 2 then 'разведен'
          end as "Отношение к браку",
         english_proficiency_cd as "Знание английского",
         case education_degree_cd
            when 0 then 'профессиональная переподготовка'
            when 1 then 'начальное профессиональное'
            when 2 then 'cреднее профессиональное'
            when 3 then 'среднее общее'
            when 4 then 'высшее'
          end as Образование,
         education as "Учебное заведение"
  from person
);

select * from view_person;

create or replace view view_employee as (
  select (p.middle_nm || ' ' || p.first_nm || ' ' || p.last_nm) as ФИО,
         ou.org_unit_nm as Отдел,
         pos.position_nm as Должность,
         case e.nature_of_work_cd
            when 0 then 'постоянно'
            when 1 then 'временно'
         end as "Характер работы",
         case e.type_of_work_cd
            when 0 then 'основная'
            when 1 then 'по совместительству'
         end as "Тип работы",
         e.receipt_dt as "Дата приема"
  from employee e
  inner join person p
    on e.person_id = p.person_id
  inner join org_unit ou
    on e.org_unit_id = ou.org_unit_id
  inner join position pos
    on e.position_id = pos.position_id
);

select * from view_employee;

create or replace view view_vacancy as (
  select ou.org_unit_nm as Отдел,
         p.position_nm as Должность,
         v.vacancy_cnt as Количество
  from vacancy v
  inner join org_unit ou
    on v.org_unit_id = ou.org_unit_id
  inner join position p
    on v.position_id = p.position_id
);

select * from view_vacancy;

create or replace view view_org_unit as (
  select org_unit_nm as Название,
         case type_cd
            when 0 then 'цех'
            when 1 then 'НГДУ'
            when 2 then 'управление'
         end as Тип,
         split_part(address, ',', 1) as Город
  from org_unit
);

select * from view_org_unit;

