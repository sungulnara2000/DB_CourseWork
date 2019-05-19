/* вывести всех мужчин и их отношение к военной
обязанности по возрасту, а также возраст*/
select (middle_nm || ' ' || first_nm || ' ' || last_nm) as Имя,
       date_part('year', age(current_date, birth_date)) as Возраст,
          case
              when date_part('year', age(current_date, birth_date)) < 27
              then 'да'
              else 'нет'
          end Военнообязанный
from person
where gender_cd = 0;

/* зарплата с учетом всех надбавок */
with allow as (
  select e.employee_id, sum(a.allowance_amt) allowance_sum
  from allowance a, employee e
    right join employee_x_allowance exa
      on e.employee_id = exa.employee_id
where a.allowance_id = exa.allowance_id
group by (e.employee_id)
order by(e.employee_id)
)
select (p.middle_nm || ' ' || p.first_nm || ' ' || p.last_nm) as ФИО,
       (b.salary_amt + allow.allowance_sum) as Зарплата
  from allow, employee e
    left join base_salary b
      on e.org_unit_id = b.org_unit_id
      and e.position_id = b.position_id
    left join person p
    on e.person_id = p.person_id
  where allow.employee_id = e.employee_id;


select base_salary.salary_amt Зарплата, org_unit.org_unit_nm Отдел, position.position_nm Должность
  from base_salary, org_unit, position
    where org_unit.org_unit_id = base_salary.org_unit_id
    and position.position_id = base_salary.position_id
order by (base_salary.salary_amt) desc


/* ваканси, на которые никто не подается */
select vacancy.vacancy_id
  from vacancy
    where vacancy_id not in (
      select vacancy_id
        from applicant
      );

select v.vacancy_id, v.vacancy_cnt, a.person_id
  from vacancy v
  left join applicant a
    on v.vacancy_id = a.vacancy_id;

select count(person_id)
      from applicant
    group by(vacancy_id)

select v.vacancy_id, v.vacancy_cnt
  from vacancy v
  left join applicant a
    on v.vacancy_id = a.vacancy_id
  where v.vacancy_cnt > (
    select count(person_id)
      from applicant
    group by(v.vacancy_id)
    );

select count(person_id)
from applicant
group by(vacancy_id)