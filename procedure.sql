create table paycheck (
  employee_id int, FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE CASCADE,
  paychek INT
);

create procedure count_paycheck(working_days integer, holiday_days integer, e_id integer)
LANGUAGE plpgsql
AS $$
  declare
    base INT := 0;
    al INT := 0;
    begin
        SELECT INTO base salary_amt FROM base_salary where employee_id = e_id;
        SELECT INTO al allowance_amt FROM (
                                           allowance
                                           right join employee_x_allowance
                                             on 1 = 1)
        where employee_id = e_id;
        insert into paycheck values (employee_id, ((base+al)/(working_days-holiday_days))*0.87);
end $$;

CALL insert_data(23, 20, 1);
