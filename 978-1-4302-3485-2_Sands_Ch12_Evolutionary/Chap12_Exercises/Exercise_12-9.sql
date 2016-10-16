CREATE OR REPLACE PROCEDURE GetEmployeeData_MultiPhoneNo(
             p_dept_id         IN NUMBER,
             p_emp_cursor     OUT SYS_REFCURSOR,
             p_status_code    OUT NUMBER,
             p_status_message OUT VARCHAR2) IS

            /***************************************************************************************
     NAME: GetEmployeeData_MultiPhoneNo
  PURPOSE: This procedure returns contact information for employees by department

    NOTES:

   p_status_code  status_message
   =============  ===========================================================
               0  Success
          -20102  Input parameter p_dept_id must not be null.

            ***************************************************************************************/
BEGIN -- GetEmployeeData_MultiPhoneNo

       --validate parameters
 IF ((p_dept_id) IS NULL ) THEN
   RAISE_APPLICATION_ERROR(-20102, 'Input parameter p_dept_id must not be null.', TRUE);

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
                    eph.preferred,
                    eph.phone_type,
                    eph.phone_number
               from employees emp , emp_phone_numbers eph
              where emp.department_id = dept.department_id
                and emp.employee_id = eph.employee_id
              order by emp.employee_id) emp_cursor
       FROM 
            departments dept, locations loc, countries cty
      WHERE dept.department_id = p_dept_id
        AND dept.location_id = loc.location_id
        AND loc.country_id = cty.country_id ;

 p_status_code:= 0;
 p_status_message:= NULL;

 EXCEPTION
   WHEN OTHERS THEN
     p_status_code:= SQLCODE;
     p_status_message:= SQLERRM;

END GetEmployeeData_MultiPhoneNo;
/

---- Create new test script to execute this procedure 
---- only the procedure name is changed

set serveroutput on

  var p_main_cursor     REFCURSOR

DECLARE
  v_dept_id        departments.department_id%TYPE;

  v_status_code    NUMBER;
  v_status_message VARCHAR2(200);

  t0 timestamp;
  t1 timestamp;

BEGIN
  t0:= systimestamp;

  v_dept_id := &Department_ID;

  GetEmployeeData_MultiPhoneNo
     (v_dept_id, :p_main_cursor, v_status_code, v_status_message);

  t1:= systimestamp;
  DBMS_OUTPUT.PUT_LINE('code=' || v_status_code || 'message=' || v_status_message);
  DBMS_OUTPUT.PUT_LINE('ela=' || (t0 - t1) );

END;
/
   print :p_main_cursor
