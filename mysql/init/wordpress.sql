CREATE DATABASE IF NOT EXISTS wordpress CHARACTER SET utf8;
GRANT ALL ON `wordpress`.* TO 'wordpress'@'%' IDENTIFIED BY 'wordpress';
