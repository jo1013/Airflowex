

## 1. 실행 명령어


$ docker run -it -d -p [연결로컬포트]:[연결도커포트] -v ~/Airflow:/shared -e LC_ALL=C.UTF-8 --name airflowex [dockerhubid]/[imagename]:[tag]
$ docker run -it -d -p 8090:8080 -v ~/Airflow:/shared -e LC_ALL=C.UTF-8 --name airflowex jo1013/airflowex:0.01



## 2. 배쉬 접속하기

$ docker exec -it airflowex bash

## 3. postsql 시작하기

$ service postgresql start

## 4. postgresql 접속하기

$ sudo su - postgres

postgres 사용자로 접속

$ psql



airflow 수정하기 
 ### 1. 연결 DB 변경    
 ### 2. postgresql 비밀번호 설정
 $ alter user postgres with password [유저가 원하는 password]
 $ alter user postgres with password 'password

 ### 3. DB 생성
 ### 4. 