create or replace function count_paycheck(working_days integer, holiday_days integer, e_id integer)
returns int
AS $$
  declare
    base INT := 0;
    al INT := 0;
    begin
        SELECT INTO base salary_amt FROM (base_salary
          right join employee
            on base_salary.position_id = employee.position_id
                 and base_salary.org_unit_id = employee.org_unit_id)
        where employee_id = e_id;
        SELECT INTO al allowance_amt FROM (
                                           allowance
                                           right join employee_x_allowance
                                             on allowance.allowance_id = employee_x_allowance.allowance_id)
        where employee_id = e_id;
        return ((base+al)/working_days * holiday_days)*0.87;
end;
$$ LANGUAGE plpgsql;

select count_paycheck(23, 20, 2);