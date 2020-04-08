/* вывести всех мужчин и их отношение к военной
обязанности(по возрасту), а также возраст*/
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

/* Зарплата в порядке убывания, а также должность и подразделение,
 где таковую получают */
select base_salary.salary_amt Зарплата, org_unit.org_unit_nm Отдел, position.position_nm Должность
  from base_salary, org_unit, position
    where org_unit.org_unit_id = base_salary.org_unit_id
    and position.position_id = base_salary.position_id
order by (base_salary.salary_amt) desc;


/* ваканси, на которые никто не подается */
with ins as (
  select v.vacancy_id, v.position_id, v.org_unit_id, v.vacancy_cnt, a.person_id
  from vacancy v
  left join applicant a
    on v.vacancy_id = a.vacancy_id)
select vacancy_id, position.position_nm, org_unit.org_unit_nm
  from ins
    left join position
      on ins.position_id = position.position_id
    left join org_unit
      on ins.org_unit_id = org_unit.org_unit_id
  where person_id isnull;


select first_nm from person;
analyse person;
explain (analyse ) select first_nm from person where middle_nm = 'Кучер';

create index on person(lower(middle_nm));
select first_nm from person where lower(middle_nm) = 'кучер';
explain (analyse ) select * from person where lower(middle_nm) like 'а%';

create table test (id serial primary key, i int4);

insert into test (i) select random() * 1000000000 from generate_series(1,100000);

vacuum analyze test;
explain analyze select id from test order by id asc limit 10;
explain analyze select id from test;
create index on test(i);
explain analyze select * from test where i < 100000;

drop index test_i_idx;
EXPLAIN (ANALYZE) SELECT * FROM test ORDER BY i;

CREATE TABLE foo (c1 integer, c2 text);
INSERT INTO foo
SELECT
i
, md5(random()::text)
FROM
generate_series(1, 1000000) AS i;

select *from foo;

CREATE TABLE bar (c1 integer, c2 boolean);
INSERT INTO bar
SELECT
i
, i % 2 = 1
FROM
generate_series(1, 500000) AS i;
ANALYZE bar;
select * from bar;
analyse foo;

EXPLAIN (ANALYZE) SELECT * FROM foo JOIN bar ON foo.c1 = bar.c1;

CREATE VIEW v_test
AS SELECT 'Hello World';

select * from v_test1;

CREATE or replace VIEW v_test1 AS SELECT 'Hello World'::text AS hello;

WITH RECURSIVE t(n) AS (
VALUES (1)
UNION ALL
SELECT n+1 FROM t WHERE n < 100
)
SELECT * FROM t;