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
RUN apt-get upgrade -y
RUN apt-get install wget -y
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get install mysql-server -y
RUN apt-get dist-upgrade -y
RUN apt-get update
RUN apt-get install postgresql -y
RUN apt-get install postgresql-contrib -y
RUN apt install postgresql-client-13
RUN apt-get install libmysqlclient-dev -y
RUN apt-get install python-pip -y
RUN apt-get install python3-pip -y
RUN pip3 install mysqlclient
RUN pip3 install mysql-connector-python
RUN apt-get install python-dev -y
RUN pip3 install apache-airflow
RUN pip3 install 'apache-airflow[kubernetes]'
RUN pip3 install 'apache-airflow[postgres]'


RUN service postgresql restart
RUN apt install python 3.7 -y
RUN pip3 install configparser 
RUN apt-get install mysql-server
RUN pip3 install --upgrade pip
RUN pip3 install notebook
RUN pip3 install --ignore-installed jupyter
RUN apt-get install nano
RUN apt-get install gcc
RUN jupyter notebook --generate-config --allow-root
RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /root/.jupyter/jupyter_notebook_config.py






EXPOSE 8888
ENTRYPOINT jupyter notebook --allow-root --ip=0.0.0.0 --port=8888 --no-browser



