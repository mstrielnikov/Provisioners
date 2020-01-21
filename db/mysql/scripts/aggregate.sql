SELECT user_id FROM card
GROUP BY user_id
HAVING COUNT(user_id) > 1;

