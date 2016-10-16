select dept.department_name,
        loc.street_address, 
        loc.city, 
        loc.state_province, 
        loc.postal_code,
        cty.country_name ,
        emp.employee_id , 
        emp.last_name, 
        emp.first_name, 
        emp.email, 
        emp.phone_number
   from departments dept, 
        locations loc, 
        countries cty, 
        employees emp
  where dept.department_id = &DepartmentID
    and dept.location_id = loc.location_id
    and loc.country_id = cty.country_id
    and dept.department_id = emp.department_id
  order by dept.department_name, emp.last_name, emp.first_name ;

select dept.department_name,
        loc.street_address, 
        loc.city, 
        loc.state_province, 
        loc.postal_code,
        cty.country_name ,
        emp.employee_id EMP_ID, 
        emp.last_name, 
        emp.first_name, 
        emp.email, 
        epn.phone_number
  from departments dept, 
       locations loc, 
       countries cty, 
       employees emp, 
       emp_phone_numbers epn
 where dept.department_id = &DepartmentID
   and dept.location_id = loc.location_id
   and loc.country_id = cty.country_id
   and dept.department_id = emp.department_id
   and emp.employee_id = epn.employee_id
 order by dept.department_name, emp.last_name, emp.first_name ;
