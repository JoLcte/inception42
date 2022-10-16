#! /bin/sh

# Launching MariaDB server
service mysql start;
echo "mysql service has started"

# Creating Database SQL_DATABASE
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
echo "inception DATABASE created"

# Creating user SQL_USER
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
echo "jlecomte user created"

# Giving all privileges to SQL_USER
mysql -e "GRANT ALL PRIVILEGES ON \'${SQL_DATABASE}\'.* TO \`{SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
echo "jlecomte user has privileges on inception"

# Replacing root password by SQL_ROOT_PASSWORD
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
echo "root password updated"

# Reloading caches used by MariaDB
mysql -e "FLUSH PRIVILEGES;"
echo "Mariadb updated"

# Shuting down MariaDB using root privileges
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
echo "Mariadb down"

# Relaunching MariaDB
exec mysqld_safe
echo "Mariadb relaunched"
