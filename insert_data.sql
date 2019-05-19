insert into person values (1, 'Владимир', 'Абыдёнков', 'Алексеевич', 0, '1963-02-03', 0, 'A1', 2,
                          'Специальное профессионально-техническое училище №14 г.Лениногорск'),
                          (2, 'Андрей', 'Алексеев',  'Владимирович', 0, '1974-12-27', 1, 'B1', 4,
                           'Московский государственный открытый университет'),
                          (3, 'Руслан', 'Аликаев', 'Раилевич', 0, '1970-12-15', 2, 'C3', 0,
                           'Специальное профессионально-техническое училище №14 г.Лениногорск'),
                          (4, 'Артем','Алмакаев', 'Владимирович', 0, '1971-07-23', 1, 'C1', 2,
                           'Лениногорский политехнический колледж'),
                          (5, 'Василий','Качелаев', 'Васильевич', 0, '1988-01-04', 0, 'A1', 1,
                           'Специальное профессионально-техническое училище №171'),
                          (6, 'Александр','Портнов', 'Юрьевич', 0, '1963-02-03', 0, 'B1', 2,
                           'Октябрьский нефтяной колледж им. С.И. Кувыкина'),
                          (7, 'Татьяна','Кучер', 'Петровна', 1, '1965-10-17', 1, 'B2', 4,
                           'Лениногорский нефтяной техникум'),
                          (8, 'Булат','Ягфаров', 'Рифович', 0, '1996-07-29', 0, 'C1', 4,
                           'Уфимский государственный нефтяной технический университет'),
                          (9, 'Андрей','Юртаев', 'Викторович', 0, '1983-05-02', 1, 'B2', 4,
                           'Казанский государственный  технический университет им. А.Н.Туполева'),
                          (10, 'Сергей', 'Елшин', 'Викторович', 0, '1994-12-19', 1, 'B2', 1,
                           'Профессионально-техническое училище №1 г.Бугульма'),
                          (11, 'Рустем', 'Закиев', 'Варисович', 0, '1979-08-08', 1, 'C1', 1,
                           'Октябрьский нефтяной колледж им. С.И. Кувыкина'),
                          (12, 'Ильмир', 'Нургалиев', 'Зуфарович', 0, '1992-02-24', 0, 'A2', 3,
                           null),
                          (13, 'Рим', 'Яримов', 'Марсович', 0, '1974-10-26', 1, 'B1', 4,
                           'Казанский государственный финансово-экономический институт');


insert into position values (1, 'Буровой мастер'),
                            (2, 'Бурильщик'),
                            (3, 'Инженер'),
                            (4, 'Главный механик'),
                            (5, 'Главный бухгалтер'),
                            (6, 'Бухгалтер'),
                            (7, 'Генеральный директор'),
                            (8, 'Слесарь');


insert into org_unit values (1, 'Лениногорскнефть', 0, 'г. Лениногорск, ул. Ленинградская, д. 12', 1),
                            (2, 'Бавлынефть', 0, 'г. Бавлы, ул. Гоголя, д. 20, ', 1),
                            (3, 'Совет директоров', 1, 'г. Альметьевск, ул. Ленина, д. 75', 0),
                            (4, 'Цех бурения № 1', 2, null, 3),
                            (5, 'Цех бурения № 2', 2, null, 3);

insert into employee values (1, 2, 1, 3, 0, 0, '2011-05-12'),
                            (2, 3, 2, 3, 0, 0, '2003-10-03'),
                            (3, 4, 4, 1, 0, 0, '2017-06-28'),
                            (4, 5, 4, 2, 1, 0, '2019-02-17'),
                            (5, 6, 5, 4, 0, 0, '2018-03-13'),
                            (6, 7, 1, 5, 0, 0, '2007-11-04'),
                            (7, 8, 3, 7, 0, 0, '2015-01-01'),
                            (8, 12, 5, 8, 0, 1, '2016-09-01');



insert into vacancy values (1, 5, 1, 1),
                           (2, 5, 2, 2),
                           (3, 2, 6, 1),
                           (4, 1, 6, 2),
                           (5, 4, 4, 1),
                           (6, 1, 3, 1);

insert into applicant values (1, 5),
                             (9, 6),
                             (10, 2),
                             (11, 1);

insert into allowance values (1, 'за разъездной характер работы', 7650),
                             (2, 'в связи с отклонением от нормальных условий труда', 4700),
                             (3, 'за профессиональное мастерство', 3800),
                             (4, 'за высокую квалификацию', 5750),
                             (5, 'за увеличение объема выполняемых работ', 8000);

insert into base_salary values (1, 3, 45000),
                               (1, 5, 60000),
                               (1, 6, 35000),
                               (2, 3, 40000),
                               (2, 5, 53000),
                               (2, 6, 32000),
                               (3, 7, 150000),
                               (4, 1, 65000),
                               (4, 2, 47000),
                               (4, 4, 27000),
                               (5, 1, 59000),
                               (5, 2, 37000),
                               (5, 4, 25000),
                               (5, 8, 21000);

insert into org_unit_x_org_unit values (3, 1),
                                       (3, 2),
                                       (1, 3),
                                       (1, 5);

/* всем работникам цеха за разъездной характер работы*/
with ins as (
  with drillers as (
  select employee.employee_id
  from employee
    join org_unit
      on employee.org_unit_id = org_unit.org_unit_id
      and org_unit.org_unit_nm like 'Цех бурения%')
  select *
  from drillers
  join (
    select allowance_id
    from allowance
    where allowance_nm like 'за разъездной характер работы'
    ) as a
  on 1 = 1)
insert into employee_x_allowance select * from ins;


/* работникам с высшим образованием */
with ins as (
  with hight_educated as (
  select employee.employee_id
  from employee
    join person
      on employee.person_id = person.person_id
      and person.education_degree_cd = 4)
  select *
  from hight_educated
  join (
    select allowance_id
    from allowance
    where allowance_nm like 'за высокую квалификацию'
    ) as a
  on 1 = 1)
insert into employee_x_allowance select * from ins;


/* работникам с высшим образованием */
with ins as (
  with masters as (
  select employee.employee_id
  from employee
    join person
      on employee.person_id = person.person_id
      and person.education_degree_cd = 0)
  select *
  from masters
  join (
    select allowance_id
    from allowance
    where allowance_nm like 'за профессиональное мастерство'
    ) as a
  on 1 = 1)
insert into employee_x_allowance select * from ins;

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

