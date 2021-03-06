## 0\. 환경셋팅

```
$ git clone https://github.com/jo1013/Airflowex.git 
$ cd Airflow
$ docker build -t jo1013/Airflowex:0.02
```

## 1\. 실행 명령어

```
$ docker run -it -d -p 8090:8080 -v ~/Airflow:/shared -e LC_ALL=C.UTF-8 --name airflow4 jo1013/airflowex:0.02

$ docker run -it -d -p [연결로컬포트]:[연결도커포트] -v [로컬디렉터리]:[컨테이너디렉터리] -e LC_ALL=C.[인코딩방식] --name [설정할이름] [dockerhubid]/[imagename]:[tag]
```

## 2\. 배쉬 접속하기

```
$ docker exec -it airflow4 bash

$ docker exec -it [설정이름] bash
```

## 2.5. DB 생성

```
$ sudo su - postgres
$ psql
$ CREATE DATABASE airflow;
$ CREATE USER timmy with ENCRYPTED password '0000';
$ GRANT all privileges on DATABASE airflow to timmy;

```

#### postgres 유저의 airflow db접속

```
$ \c airflow
$ GRANT all privileges on all tables in schema public to timmy;
$ \q        
$ exit
```

## 3\. postgre cluster 설정

```
$ pg_createcluster 13 main 
$ pg_ctlcluster 13 main start
```

## 4\. postgresql 설정

```
# $ cd /etc/postgresql/12/main
# $ nano pg_hba.conf
```

#### 아래와 같이 수정

```
# IPv4 local connections:                                                          
host        all             all             0.0.0.0/0               md5 
```

#### 재시작

```
$ service postgresql restart
```

# airflow 수정하기

## 1\. 연결 DB 변경

```
$ nano /root/airflow/airflow.cfg

```

아래와 같이 수정한다.

```
# dags_folder = /root/airflow/dags 
dags_folder = /shared/dags 

# base_log_folder = /root/airflow/logs 
base_log_folder = /shared/logs 

# default_timezone = utc 
default_timezone = Asia/Seoul 

# executor = SequentialExecutor 
executor = LocalExecutor 

# sql_alchemy_conn = sqlite:////root/airflow/airflow.db 
sql_alchemy_conn = postgresql+psycopg2://timmy:0000@172.17.0.2/airflow

```

sql\_alchemy\_conn에 localhost를 적으면 해당 컨테이너를 찾아가지 못하기 때문에 host의 ip 혹은 postgres컨테이너의 ip를 넣어줘야한다.

#### ip 확인

```
$ ifconfig

```

## 2\. 외부접속 허용

```
$ cd /etc/postgresql/13/main
$ nano pg_hba.conf 
```

#### 아래처럼 수정

```
IPv4 local connections:                                                          
host        all             all             0.0.0.0/0               md5 
```

```
$ service postgresql restart
```

## 3\. 폴더 만들기

```
$ cd Airflow
$ mkdir dags
$ mkdir logs
```

## 4\. airflow db 초기화

```
$ airflow db init

```

## 5\. 변경 내용 저장

```
$ docker commit postgres postgres:airflow
```

## 6\. 계정 생성 py 파일 실행

```
$ cd shared

$ nano makeuser.py  
```

makeuser.py를 airflow\_home 위치로 수정

#### 아래 복사 (아이디,비밀번호 수정)

```
import airflow
from airflow import models, settings
from airflow.contrib.auth.backends.password_auth import PasswordUser

user = PasswordUser(models.User())
user.username = 'sunny'
user.email = 'sunny@test.com'
user.password = 'sunny'
user.superuser = True
session = settings.Session()
session.add(user)
session.commit()
session.close()
exit()

```

---

#### 계정생성 (터미널에서 직접)

```
$ airflow users create \\

  --username admin \\

  --firstname aaa \\

  --lastname bbb \\

  --role Admin \\

  --email tkdah0@gmail.com

```

#### airflow 시작

```
$ airflow webserver
```

## 참고 자료

### Creating a Database Cluster

```
-   In file system terms, a database cluster is a single directory under which all data will be stored. We call this the data directory or data area. It is completely up to you where you choose to store your data. There is no default, although locations such as /usr/local/pgsql/data or /var/lib/pgsql/data are popular. The data directory must be initialized before being used, using the program initdb which is installed with PostgreSQL.
-   보통 위의 글중에 나온 경로와 같이 경로 설정을 하지만 꼭 그럴 필요는 없다는 내용~

---
```
