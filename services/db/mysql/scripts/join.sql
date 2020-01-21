SELECT c.user_id,o.name, o.family, c.balance, o.registration_date, c.expiration_date FROM card c INNER JOIN owner o ON o.id = c.user_id;
