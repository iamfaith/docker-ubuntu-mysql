FROM xianzixiang/xenial
MAINTAINER faith

# Install packages: mysql adds a root user with no password
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get -yq install mysql-server && \
  mkdir -p /var/lib/mysql && \
  mkdir -p /var/run/mysqld && \
  mkdir -p /var/log/mysql && \
  chown -R mysql:mysql /var/lib/mysql && \
  chown -R mysql:mysql /var/run/mysqld && \
  chown -R mysql:mysql /var/log/mysql && \
  rm -rf /var/lib/apt/lists/*

# Change mysql to listen on 0.0.0.0
ADD bind_0.cnf /etc/mysql/conf.d/bind_0.cnf

# setup our entry point
ADD init.sh /init.sh
RUN chmod 755 /*.sh
ENTRYPOINT ["/init.sh"]

EXPOSE 3306
CMD ["mysqld_safe"]

