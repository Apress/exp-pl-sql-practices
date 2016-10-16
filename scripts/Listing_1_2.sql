PROMPT 
PROMPT row-by-row processing - rewritten
PROMPT

    
    --
    -- Insert in to target table
    --
    
     insert into top_sales_customers  
       ( prod_id, cust_id, time_id, 
         cust_first_name, cust_last_name,amount_sold)
     select s.prod_id,s.cust_id,s.time_id,
            c.cust_first_name, c.cust_last_name,
            s.amount_sold 
     from sales s, customers c
     where s.cust_id = c.cust_id and s.amount_sold> 1000;

    commit;

