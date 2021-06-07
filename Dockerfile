FROM ubuntu:18.04

MAINTAINER Sawyer "tkdah0@gmail.com"


ARG DEBIAN_FRONTEND=noninteractiv


RUN apt update


RUN export AIRFLOW_HOME=~/Airflow


RUN apt install software-properties-common -y
RUN add-apt-repository ppa:deadsnakes/ppa

RUN apt-get install -y --no-install-recommends \
freetds-bin \
krb5-user \
ldap-utils \
libffi6 \
libsasl2-2 \
libsasl2-modules \
libssl1.1 \
locales  \
lsb-release \
sasl2-bin \
sqlite3 \
unixodbc

RUN apt-get update
RUN apt-get install mysql-server -y
RUN apt-get upgrade -y
RUN apt-get dist-upgrade -y
RUN apt-get install python3-pip -y
RUN apt-get install postgresql postgresql-contrib -y
RUN apt-get install libmysqlclient-dev -y
RUN apt-get install python-pip -y
RUN pip3 install mysqlclient
RUN pip3 install mysql-connector-python

RUN apt-get install python-dev -y

RUN pip3 install apache-airflow

RUN pip3 install 'apache-airflow[kubernetes]'
RUN pip3 install 'apache-airflow[postgres]'
RUN apt -y install postgresql postgresql-contrib
RUN apt install python 3.7 -y
RUN pip3 install configparser 
RUN apt-get install mysql-server

