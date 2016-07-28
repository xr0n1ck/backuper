FROM ubuntu:14.04
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install mysql-client python-requests python-configobj python-argparse
RUN apt-get -y install cron

ENV MYSQL_HOST=MYSQL_HOST
ENV MYSQL_DATABASE=MYSQL_DATABASE
ENV MYSQL_USER=MYSQL_DATABASE
ENV MYSQL_PASSWORD=MYSQL_DATABASE
ENV MYSQL_BACKUP_AGE=MYSQL_BACKUP_AGE
ENV UPLOAD_URL=UPLOAD_URL
ENV UPLOAD_USER=UPLOAD_USER
ENV UPLOAD_KEY=UPLOAD_KEY
ENV UPLOAD_CONTAINER=UPLOAD_CONTAINER
ENV CRONJOB_SCHEDULE=CRONJOB_SCHEDULE

# COPY our crontab file
COPY cronjob_backup /config/cronjob_backup
COPY backupUploader /config/backupUploader
RUN chmod +x /config/cronjob_backup
RUN touch /config/backup.cfg

COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]