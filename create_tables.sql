create table person (
  person_id int PRIMARY KEY ,
  first_nm varchar(30) NOT NULL,
  middle_nm varchar(30) NOT NULL,
  last_nm varchar(30),
  gender_cd int CHECK ( gender_cd >= 0 and  gender_cd <=1), -- мужчина/женщина
  birth_date date,
  marital_status_cd int CHECK ( marital_status_cd >= 0 and  marital_status_cd <=2), -- в браке/не в браке/разведен
  english_proficiency_cd varchar(2) CHECK ( english_proficiency_cd like '__'), -- A1, A2, B1, B2, C1, C2
  education_degree_cd int CHECK ( education_degree_cd >= 0 and  education_degree_cd <=4),
  -- профессиональная переподготовка, начальное профессиональное, среднее профессиональное, среднее общее, высшее
  education varchar(100)
);

create table org_unit (
  org_unit_id int PRIMARY KEY,
  org_unit_nm varchar(30),
  type_cd int, CHECK ( type_cd>=0 and type_cd<=5 ), -- бухгалтерия, цех, бригада, отдел кадров, управление
  address varchar(50),
  hierarchy_level int, CHECK ( hierarchy_level>=0 )
);

create table position (
  position_id int PRIMARY KEY,
  position_nm varchar(20)
);


create table employee (
  employee_id int PRIMARY KEY,
  person_id int, FOREIGN KEY (person_id) REFERENCES person(person_id),
  org_unit_id int, FOREIGN KEY (org_unit_id) REFERENCES org_unit(org_unit_id),
  position_id int, FOREIGN KEY (position_id) REFERENCES position(position_id),
  nature_of_work_cd int CHECK ( nature_of_work_cd>=0 and nature_of_work_cd<=1 ), -- постоянно/временно
  type_of_work_cd int CHECK ( type_of_work_cd>=0 and type_of_work_cd<=1 ), -- основная/по совместительству
  receipt_dt date
);

create table vacancy (
  vacancy_id int PRIMARY KEY,
  org_unit_id int, FOREIGN KEY (org_unit_id) REFERENCES org_unit(org_unit_id),
  position_id int, FOREIGN KEY (position_id) REFERENCES position(position_id),
  vacancy_cnt int DEFAULT 0
);

create table applicant (
  person_id int, FOREIGN KEY (person_id) REFERENCES person(person_id),
  vacancy_id int, FOREIGN KEY (vacancy_id) REFERENCES vacancy(vacancy_id),
  PRIMARY KEY (person_id, vacancy_id)
);

create table org_unit_x_org_unit (
  parent_id int, FOREIGN KEY (parent_id) REFERENCES org_unit(org_unit_id),
  child_id int, FOREIGN KEY (parent_id) REFERENCES org_unit(org_unit_id),
  PRIMARY KEY (parent_id, child_id)
);

create table base_salary (
  org_unit_id int, FOREIGN KEY (org_unit_id) REFERENCES org_unit(org_unit_id),
  position_id int, FOREIGN KEY (position_id) REFERENCES position(position_id),
  salary_amt int, CHECK ( salary_amt>=11163 ) -- больше прожиточного минимума
);

create table allowance (
  allowance_id int PRIMARY KEY,
  allowance_nm varchar(30),
  allowance_amt int, CHECK ( allowance_amt>=0 )
);

create table employee_x_allowance (
  employee_id int, FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
  allowance_id int, FOREIGN KEY (allowance_id) REFERENCES allowance(allowance_id),
  PRIMARY KEY (employee_id, allowance_id)
);