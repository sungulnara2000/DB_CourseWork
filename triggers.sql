/* Если работник назначается на должность уже имея другую, то в обоих строках
 тип работы становится 1 (т. е. по совместительству) */
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
    insert into vacancy values (DEFAULT, old.org_unit_id, old.position_id, 1);
    RETURN NULL;
  end;
$new_vacancy$ language plpgsql;

create trigger delete_employee
  after delete
    on employee
  for each row execute procedure new_vacancy();

