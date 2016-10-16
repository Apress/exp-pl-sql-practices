create table emp_phone_numbers(
   employee_id    number(6)                   not null,
   phone_number   varchar2(20)                not null,
   preferred      varchar2(1)   default 'N'   not null,
   phone_type     varchar2(10)                not null,
constraint  emp_phone_numbers_pk 
   primary key (employee_id, phone_number)) ;

alter table emp_phone_numbers add constraint emp_phone_numbers_fk1
   foreign key (employee_id)
references employees (employee_id) ;

insert into emp_phone_numbers (
select employee_id, phone_number, 'Y', 'Office'
  from employees) ;

commit;

alter table employees drop column phone_number;