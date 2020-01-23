SELECT expiration_date FROM card WHERE DATE_FORMAT(expiration_date, '%d-%m-%Y') LIKE '0%-%-%';

