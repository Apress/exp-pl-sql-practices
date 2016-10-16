set serveroutput on

         var p_main_cursor REFCURSOR

DECLARE
         v_dept_id         departments.department_id%TYPE;
         v_status_code     NUMBER;
         v_status_message  VARCHAR2(200);

         t0 timestamp;
         t1 timestamp;

BEGIN
         t0:= systimestamp;

         v_dept_id := &Department_ID;

  GetEmployeeData
          (v_dept_id, :p_main_cursor, v_status_code, v_status_message);

  t1:= systimestamp;
 
 DBMS_OUTPUT.PUT_LINE('Code=' || v_status_code || 'Message=' || v_status_message);
 DBMS_OUTPUT.PUT_LINE('ela=' || (t0 - t1) );

END;
/

print :p_main_cursor
