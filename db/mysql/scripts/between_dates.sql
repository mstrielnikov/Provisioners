SELECT user_id, expiration_date FROM card WHERE expiration_date >= '2000-01-01' AND expiration_date <= curdate() ORDER BY expiration_date;
