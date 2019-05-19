with ins as (
  with good_drillers as (
  select employee.employee_id
  from employee
    join org_unit
      on employee.org_unit_id = org_unit.org_unit_id
      and org_unit.org_unit_nm like 'Цех бурения № 1')
  select *
  from good_drillers
  join (
    select allowance_id
    from allowance
    where allowance_nm like 'за увеличение объема выполняемых работ'
    ) as a
  on 1 = 1)
insert into employee_x_allowance select * from ins;


select allowance_nm, allowance_amt
  from allowance
where allowance_amt = (select max(allowance_amt)from allowance);


update allowance set allowance_amt = 3400 where allowance_nm = 'за высокую квалификацию';


delete from allowance
where allowance.allowance_id <> all (
  select allowance_id
  from employee_x_allowance
  )


insert into person values (14, 'Осокин', 'Егор', 'Маратович', 0, '2000-04-26', 0, 'B2', 1,
                           'Лицей Иннополис');

select (middle_nm || ' ' || first_nm) as Женщина_я_не_танцую
  from person
    where gender_cd = 1;

update person set first_nm = 'Егор', middle_nm = 'Осокин',
                  birth_date = '2001-12-26'
where person_id = 14;

delete from person
where date_part('year', age(current_date, birth_date)) < 18;

