FROM mysql/mysql-server:8.0
COPY init.sql /docker-entrypoint-initdb.d/
RUN sed -i "s/skip-name-resolve/# skip-name-resolve/" /etc/my.cnf
