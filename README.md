

## 1. 실행 명령어


$ docker run -it -d -p [연결로컬포트]:[연결도커포트] -v ~/Airflow:/shared -e LC_ALL=C.UTF-8 --name [설정할이름] [dockerhubid]/[imagename]:[tag]


$ docker run -it -d -p 8090:8080 -v ~/Airflow:/shared -e LC_ALL=C.UTF-8 --name airflow4 jo1013/airflowex:0.02



## 2. 배쉬 접속하기

$ docker exec -it [설정이름] bash
$ docker exec -it airflow4 bash

## 3. postsql 시작하기

$ service postgresql start

## 4. postgresql 접속 후 db접속

$ sudo su - postgres
$ psql



airflow 수정하기 
 ### 1. 연결 DB 변경    

 ### 2. postgresql 비밀번호 설정
 $ alter user postgres with password [유저가 원하는 password];
 $ alter user postgres with password 'password';

 ### 3. DB 생성


    $ sudo su - postgres
    $ psql

#### 'postgres#' 에서 작업
  
    $ CREATE DATABASE airflow;
    $ CREATE USER timmy with ENCRYPTED password '0000';
    $ GRANT all privileges on DATABASE airflow to timmy;
    ## postgres 유저의 airflow db접속
    $ \c airflow
    $ GRANT all privileges on all tables in schema public to timmy;
    $ airflow=# \q        
    $ exit

 ### 4. postgre cluster 설정

    $ pg_createcluster 13 main 
    $ pg_ctlcluster 13 main start
    $ cd /etc/postgresql/13/main
    $ nano pg_hba.conf 
      아래처럼 수정
        IPv4 local connections:                                                          
        host		all             all             0.0.0.0/0               md5 


    $ service postgresql restart

# postgreql 공식문서 
18.2. Creating a Database Cluster
* In file system terms, a database cluster is a single directory under which all data will be stored. We call this the data directory or data area. It is completely up to you where you choose to store your data. There is no default, although locations such as /usr/local/pgsql/data or /var/lib/pgsql/data are popular. The data directory must be initialized before being used, using the program initdb which is installed with PostgreSQL.
# 보통 위의 글중에 나온 경로와 같이 경로 설정을 하지만 꼭 그럴 필요는 없다는 내용~
