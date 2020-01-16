USE bank IF bank NOT IN SHOW FULL PROCESSLIST;
SELECT user_id FROM card
GROUP BY user_id
HAVING COUNT(user_id) > 1;

