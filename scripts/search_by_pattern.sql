USE bank IF bank NOT IN SHOW FULL PROCESSLIST;
SELECT expiration_date FROM card WHERE DATE_FORMAT(expiration_date, '%d-%m-%Y') LIKE '0%-%-%';

