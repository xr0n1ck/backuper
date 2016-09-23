FROM ubuntu:14.04
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install mysql-client python-requests python-configobj python-argparse
RUN apt-get -y install cron

#postgres
RUN apt-get -y install wget
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
RUN apt-get update
RUN apt-get -y install postgresql-client-9.5

#mongo
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
RUN apt-get update
RUN apt-get install mongodb-org-shell mongodb-org-tools

# COPY our crontab file
COPY cronjob_backup /config/cronjob_backup
COPY backupUploader /config/backupUploader
RUN chmod +x /config/cronjob_backup
RUN touch /config/backup.cfg

COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]