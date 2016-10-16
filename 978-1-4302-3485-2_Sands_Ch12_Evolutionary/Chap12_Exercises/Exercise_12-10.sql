select * from emp_phone_numbers
 where employee_id = 100;

insert into emp_phone_numbers 
values (100,'555.312.9876','N','Mobile');

insert into emp_phone_numbers 
values (100,'555.321.7345','N','Home');

select * from emp_phone_numbers
 where employee_id = 100;

update emp_phone_numbers set preferred = 'N' 
 where employee_id = 100
   and phone_type = 'Office';

update emp_phone_numbers set preferred = 'Y' 
 where employee_id = 100
   and phone_type = 'Mobile';

commit ;

select * from emp_phone_numbers
 where employee_id = 100;


