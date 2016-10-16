CREATE OR REPLACE PROCEDURE GetEmployeeData(
       p_dept_id        IN  NUMBER,
       p_emp_cursor     OUT SYS_REFCURSOR,
       p_status_code	OUT NUMBER,
       p_status_message OUT VARCHAR2) IS

/********************************************************************************
    NAME: GetEmployeeData
 PURPOSE: This procedure returns contact information for employees by department

  NOTES:

      p_status_code  status_message
      =============  ======================================================
                  0  Success
             -20102  Input parameter p_dept_id must not be null.

***************************************************************************************/
BEGIN -- GetEmployeeData

--validate parameters
IF ((p_department_id) IS NULL ) THEN
   RAISE_APPLICATION_ERROR(-20102, Input parameter p_dept_id must not be null.',TRUE);
END IF;

OPEN p_emp_cursor FOR
   SELECT
         dept.department_id, 
         dept.department_name,
         loc.street_address,
         loc.city, 
         loc.state_province, 
         loc.postal_code,
         cty.country_name,
  CURSOR (select emp.employee_id,
                 emp.last_name,
                 emp.first_name,
                 emp.email,
                 emp.phone_number
            from employees emp
           where emp.department_id = dept.department_id) emp_cursor
      FROM
           departments dept, locations loc, countries cty
     WHERE 
           dept.department_id = p_dept_id
       AND dept.location_id = loc.location_id
       AND loc.country_id = cty.country_id
     ORDER BY 2,3;

  p_status_code:= 0;
  p_status_message:= NULL;

EXCEPTION
  WHEN OTHERS THEN
    p_status_code:= SQLCODE;
    p_status_message:= SQLERRM;

END GetEmployeeData;
/
