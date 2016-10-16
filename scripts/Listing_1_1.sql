PROMPT 
PROMPT row-by-row processing
PROMPT

declare
 cursor c1 is select prod_id,cust_id,time_id,amount_sold 
  from sales where amount_sold > 1000;
 c1_rec c1%rowtype;
 l_cust_first_name  customers.cust_first_name%TYPE;
 l_cust_lasT_name   customers.cust_last_name%TYPE;

begin
 for c1_rec in c1
  loop
    -- Query customer details
     select cust_first_name, cust_last_name into 
           l_cust_first_name, l_cust_last_name
      from customers where cust_id=c1_rec.cust_id;
    
    --
    -- Insert in to target table
    --
    
     insert into top_sales_customers  
       ( prod_id, cust_id, time_id, 
         cust_first_name, cust_last_name,amount_sold)
      values
        (c1_rec.prod_id, c1_rec.cust_id, c1_rec.time_id,
         l_cust_first_name, l_cust_last_name, c1_rec.amount_sold);
   end loop;
   commit;
end;
/

