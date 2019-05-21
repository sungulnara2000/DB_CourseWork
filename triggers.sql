/* Если раюотник назначается на должность уже имея другую, то в обоих строках
 тип работы становится по совместительству*/
create or replace function insert_employee() returns trigger as $insert_employee$
  begin
    update employee set type_of_work_cd = 1
    where person_id = new.person_id;
    RETURN NULL;
  end;
$insert_employee$ language plpgsql;

create trigger insert_employee
  after insert
    on employee
  for each row execute procedure insert_employee();

/* При увольнении работника появляется вакасия на эту должность */

create or replace function new_vacancy() returns trigger as $new_vacancy$
  begin
    insert into vacancy values (10, old.org_unit_id, old.position_id, 1);
    RETURN NULL;
  end;
$new_vacancy$ language plpgsql;

create trigger delete_employee
  after delete
    on employee
  for each row execute procedure new_vacancy();

insert into employee values (100, 13, 1, 1, 0, 0, '2019-05-19');

delete from employee where employee_id = 100
