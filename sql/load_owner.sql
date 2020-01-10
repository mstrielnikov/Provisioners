USE bank;
SET GLOBAL local_infile = 1;
DROP TABLE IF EXISTS owner;
CREATE TABLE owner(
        id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        name INTEGER UNSIGNED NOT NULL,
        family INTEGER UNSIGNED NOT NULL,
        registration_date DATE
);
LOAD DATA LOCAL INFILE 'csv/owner.csv'
INTO TABLE owner
FIELDS TERMINATED BY ';'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
~                         
