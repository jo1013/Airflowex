

## 1. 실행 명령어

$ docker run -it -d -p 8090:8080 -v ~/Airflow:/shared -e LC_ALL=C.UTF-8 --name airflowex airflowex:0.03

## 2. 배쉬 접속하기

$ docker exec -it airflowex bash
