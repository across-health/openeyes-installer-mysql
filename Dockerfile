FROM ubuntu:trusty
MAINTAINER Dave Thompson "davethompson21@gmail.com"

ADD scripts/base.sh /src/base.sh
ADD scripts/mysql.sh /src/mysql.sh
ADD config/openeyes_testdata.sql /src/openeyes_testdata.sql

RUN /src/base.sh

COPY config/common.php /src/common.php
RUN /src/mysql.sh
COPY config/mysql.cnf /etc/mysql/conf.d/conf.cnf

EXPOSE 3306
CMD ["mysqld"]
