# Install MySQL
export DEBIAN_FRONTEND="noninteractive"

sudo apt-get update -y

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password password"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password password"

sudo apt-get install -y debconf-utils
sudo apt-get install -y mysql-server

service mysql start

mysql -r root -ppassword 
CREATE database example;
GRANT ALL PRIVILEGES ON *.* TO root@'%';
\q

# Install Apache
sudo apt-get install apache2 -y
service apache2 start
sudo a2enmod rewrite
sudo a2enmod ssl
#sudo systemctl restart apache2

# Install PHP 7
sudo apt-get install python-software-properties -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update
sudo apt install -y php7.2 php7.2-mysql php7.2-mbstring

# Install Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer

# Install NodeJS
sudo apt update -y

sudo apt-get install nodejs -y
sudo apt-get install npm -y
npm install -g yarn

# PHPMyAdmin
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password password"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password password"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password password"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"

sudo apt-get install -y phpmyadmin

# Setup Virtual Hosts

sudo chown -R $USER:$USER /var/www/example.local/public_html
sudo chmod -R 755 /var/www

sudo cp /var/www/example.local/provision/example.local.conf /etc/apache2/sites-available/example.local.conf
sudo a2ensite example.local.conf
sudo a2dissite 000-default.conf
sudo systemctl restart apache2
