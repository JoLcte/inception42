#! /bin/sh

# Launching MariaDB server
service mysql start;

# Creating Database SQL_DATABASE
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# Creating user SQL_USER
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Giving all privileges to SQL_USER
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Replacing root password by SQL_ROOT_PASSWORD
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# Reloading caches used by MariaDB
mysql -e "FLUSH PRIVILEGES;"

# Shuting down MariaDB using root privileges
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

# Relaunching MariaDB
exec mysqld_safe
