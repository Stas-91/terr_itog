from flask import Flask
from flask import request
import os
import MySQLdb
from datetime import datetime

app = Flask(__name__)

# Получение переменных окружения
db_host = os.environ.get('DB_HOST', 'rc1a-hv3mv3crugmb6m9e.mdb.yandexcloud.net')
db_user = os.environ.get('DB_USER', 'app')
db_password = os.environ.get('DB_PASSWORD', 'Qwerty123')
db_database = os.environ.get('DB_NAME', 'test')

# Подключение к базе данных MySQL
db = MySQLdb.connect(
    host=db_host,
    port=3306,
    db=db_database,
    user=db_user,
    passwd=db_password,
    ssl={'ca': '/app/root.crt'}
)
cursor = db.cursor()

# SQL-запрос для создания таблицы в БД
create_table_query = f"""
CREATE TABLE IF NOT EXISTS requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    request_date DATETIME,
    request_ip VARCHAR(255)
)
"""
cursor.execute(create_table_query)

@app.route('/')
def index():
    # Получение IP-адреса пользователя
    ip_address = request.headers.get('X-Forwarded-For')

    # Запись в базу данных
    now = datetime.now()
    current_time = now.strftime("%Y-%m-%d %H:%M:%S")
    query = "INSERT INTO requests (request_date, request_ip) VALUES (%s, %s)"
    values = (current_time, ip_address)
    cursor.execute(query, values)
    db.commit()

    return f'TIME: {current_time}, IP: {ip_address}'


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')