#!/bin/bash
installdir='/var/www/blogs/';
dbuser=`grep DB_USER ${installdir}wp-config.php | awk -F "'" '{print $4}'`;
dbpass=`grep DB_PASSWORD ${installdir}wp-config.php | awk -F "'" '{print $4}'`;
dbname=`grep DB_NAME ${installdir}wp-config.php | awk -F "'" '{print $4}'`;

newemaildomain="@github.com";

while read -a row
do
  if [[ ${row[0]} == *guthub.com ]]; then
    userid=${row[1]};
    email="$(echo ${row[0]} | cut -d'@' -f1)";
    newemail=$email$newemaildomain;
    echo "UPDATE wp_users SET user_email='$newemail' WHERE ID='$userid'" | mysql -u$dbuser -p$dbpass $dbname;
  fi
done  < <(mysql -u$dbuser -p$dbpass $dbname -Bse "SELECT user_email, ID FROM wp_users")
