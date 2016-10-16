select object_type, object_name, status
  from user_objects 
 where status = 'INVALID'
 order by object_type, object_name ;

select text
  from user_source 
 where name = 'UPDATE_JOB_HISTORY'
   and type = 'TRIGGER' 
 order by line ;

alter trigger update_job_history compile ;

select text
  from user_source
 where name = 'SECURE_EMPLOYEES' 
   and type = 'TRIGGER'
 order by line ;

select object_type, object_name, status
  from user_objects
 where object_name = 'SECURE_DML' ;

select text 
  from user_source
 where name = 'SECURE_DML'
 order by line ;

alter trigger secure_employees compile;

select object_type, object_name, status
  from user_objects
 where status = 'INVALID'
 order by object_type, object_name ;
