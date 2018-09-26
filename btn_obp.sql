ALTER TABLE BTN_CUST_CONTACT MODIFY (ORD NULL);

select nullable
     from user_tab_columns
    where table_name = 'BTN_CUST_CONTACT'
      and column_name = 'ORD';