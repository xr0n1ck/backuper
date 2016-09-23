#!/bin/bash

#mysql settings
echo "mysql_host=$MYSQL_HOST" >> /config/backup.cfg 
echo "mysql_db_name=$MYSQL_DATABASE" >> /config/backup.cfg 
echo "mysql_db_user=$MYSQL_USER" >> /config/backup.cfg 
echo "mysql_db_password=$MYSQL_PASSWORD" >> /config/backup.cfg

#postgres settings
echo "psql_host=$PSQL_HOST" >> /config/backup.cfg 
echo "psql_database=$PSQL_DATABASE" >> /config/backup.cfg 
echo "psql_user=$PSQL_USER" >> /config/backup.cfg 
echo "psql_password=$PSQL_PASSWORD" >> /config/backup.cfg

#mongodb settings
echo "mongo_host=$MONGO_HOST" >> /config/backup.cfg 
echo "mongo_database=$MONGO_DATABASE" >> /config/backup.cfg 

#common settings
echo "backup_age=$BACKUP_AGE" >> /config/backup.cfg
echo "backup_prefix=$BACKUP_PREFIX" >> /config/backup.cfg
echo "upload_url=$UPLOAD_URL" >> /config/backup.cfg 
echo "upload_user=$UPLOAD_USER" >> /config/backup.cfg 
echo "upload_key=$UPLOAD_KEY" >> /config/backup.cfg
echo "upload_container=$UPLOAD_CONTAINER" >> /config/backup.cfg
echo "$CRONJOB_SCHEDULE /config/cronjob_backup > /backup/last.log 2>&1" > /config/crontab_backup.txt
crontab /config/crontab_backup.txt
cron -f -L 15 
