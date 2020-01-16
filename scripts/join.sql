USE bank IF bank NOT IN SHOW FULL PROCESSLIST;
SELECT c.user_id,c.user_id FROM card c OUTER JOIN card c
ON o.id = c.user_id;
