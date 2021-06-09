import airflow
from airflow import models, settings
from airflow.contrib.auth.backends.password_auth import PasswordUser

user = PasswordUser(models.User())
user.username = 'sawyer'
user.email = 'tkdah0@gmail.com'
user.password = '0000'
user.superuser = True
session = settings.Session()
session.add(user)
session.commit()
session.close()
exit()
