USE bank IF bank NOT IN SHOW PROCESSLIST;
SELECT name,family FROM owner WHERE id IN (SELECT DISTINCT user_id FROM card);
