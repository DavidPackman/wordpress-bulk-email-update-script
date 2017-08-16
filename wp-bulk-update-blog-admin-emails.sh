#!/bin/bash
installdir='/var/www/blogs/';
dbuser=`grep DB_USER ${installdir}wp-config.php | awk -F "'" '{print $4}'`;
dbpass=`grep DB_PASSWORD ${installdir}wp-config.php | awk -F "'" '{print $4}'`;
dbname=`grep DB_NAME ${installdir}wp-config.php | awk -F "'" '{print $4}'`;

newemaildomain="@github.com";

while read -a row
do
  blogid=${row[0]};
  blogtable="wp_"$blogid"_options";
  if [[ $blogid != 1 ]]; then
  email=$(echo "SELECT option_value FROM $blogtable WHERE option_name = 'admin_email'" | mysql -s -r -N -u$dbuser -p$dbpass $dbname );
  if [[ $email == *github.com ]]; then
    user="$(echo $email | cut -d'@' -f1)";
    newemail=$user$newemaildomain;
    echo "UPDATE $blogtable SET option_value='$newemail' WHERE option_name = 'admin_email' and option_value = '$email'" | mysql -u$dbuser -p$dbpass $dbname;
  fi
fi
done  < <(mysql -u$dbuser -p$dbpass $dbname -Bse "SELECT blog_id FROM wp_blogs")
