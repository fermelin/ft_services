CREATE DATABASE wordpress;
CREATE USER 'fermelin'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'fermelin'@'localhost';
FLUSH PRIVILEGES;