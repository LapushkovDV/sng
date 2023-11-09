#!flask/bin/python
from flask import Flask, jsonify, abort, make_response, request, send_file,render_template
import base64, uuid, os, os.path
import psycopg2, shutil
import threading
from datetime import datetime, timedelta
import time
# import init_db
from waitress import serve
from cryptography.fernet import Fernet

app = Flask(__name__)

# init_db.init_db

dirpath = '/opt/fileservice/vault/'
dirpathtmp = '/opt/fileservice/temp/'
httpfileserver = 'http://172.30.55.106:8081'
pg_server = "localhost"
pg_user = "postgres"
pg_password = "Galaktika2000"
pg_database = "filestorage"
cryptokeypath = '/opt/fileservice/crypto.key'

def load_key():
# Загружаем ключ 'crypto.key' из каталога cryptokeypath
    return open(cryptokeypath, 'rb').read()

def encrypt(filename, key):
# Зашифруем файл и записываем его
    f = Fernet(key)
    with open(filename, 'rb') as file:
        # прочитать все данные файла
        file_data = file.read()
        encrypted_data = f.encrypt(file_data)
        with open(filename, 'wb') as file:
            file.write(encrypted_data)


def decrypt(filename, key):
# Расшифруем файл и записываем его
    f = Fernet(key)
    with open(filename, 'rb') as file:
        # читать зашифрованные данные
        encrypted_data = file.read()
    # расшифровать данные
    decrypted_data = f.decrypt(encrypted_data)
    # записать оригинальный файл
    with open(filename, 'wb') as file:
        file.write(decrypted_data)


def cleartempdir():
    # очищаем все файлы из временной папки старше 15 минут
	while 1:
		for fname in os.listdir(dirpathtmp):
			timetodelete = datetime.now() + timedelta(minutes=-15)
			if fname.endswith(''):
				f = os.path.join(dirpathtmp, fname)
				modtime = datetime.fromtimestamp(os.stat(f).st_mtime)
				if modtime < timetodelete:
					os.remove(f)
		time.sleep(10)


def get_db_connection():
    # получить подключение к БД
    conn = psycopg2.connect(host=pg_server,
                            database=pg_database,
                            user=pg_user,
                            password=pg_password)
    return conn

# @app.route('/fileservice/api/v1.0/tasks', methods=['GET'])
# def get_tasks():
#     return jsonify({'tasks': tasks})


# @app.route('/fileservice/api/v1.0/tasks/<int:task_id>', methods=['GET'])
# def get_task(task_id):
#     task = list(filter(lambda t: t['id'] == task_id, tasks))
#     if len(task) == 0:
#         abort(404)
#     return jsonify({'task': task[0]})

@app.errorhandler(404)
def not_found(error):
    # функция API - возвращает ошибку 404 при обращении к несуществующей странице
    return make_response(jsonify({'error': 'Page not found'}), 404)

@app.route('/fileservice/api/v1.0/loadfile', methods=['POST'])
def load_file():
    # init_db.init_db
    if not request.json:
    #or not 'filename' in request.json or not 'extention' in  request.json or not 'data' in request.json:
        abort(400)

    try:
        filename = request.json['filename']
        filename = filename.replace(' ','_')
        extention = request.json.get('extention', "")
        description = request.json.get('description',"")
        b64 = request.json.get('data', "")
    except:
        return jsonify({'message': 'Wrong JSON structure in body', 'status': '0', 'UUID': ''}), 401

    if filename == '':
        return jsonify({'message': 'Empty filename', 'status': '0', 'UUID': ''}), 401

    if b64:
        f = 1
    else:
        return jsonify({'message': 'Empty data in file', 'status': '0', 'UUID': ''}), 401

    bytes = base64.b64decode(b64)

    guid = str(uuid.uuid4())
    try:
        filepath = dirpath + guid
        f = open(filepath, 'wb')
        f.write(bytes)
    except:
        return jsonify({'message': 'Errror write data to disk', 'status': '0', 'UUID': ''}), 401
    finally:
        f.close()

    try:
        key = load_key()
        file = dirpath + guid
        encrypt(file, key)
    except:
        return jsonify({'message': 'Errror encrypt file on disk', 'status': '0', 'UUID': ''}), 401

    conn = get_db_connection()
    cur = conn.cursor()
    values=[guid, filename, extention, description]
    try:
        str_insert = "INSERT INTO files (guid, name, extention, description ) VALUES (%s,%s,%s,%s)"
        cur.execute(str_insert,tuple(values))
        #cur.execute("INSERT INTO files (guid, name, extention, description ) VALUES ('6ceec737-5d63-47b5-bea5-77b900c37b96', 'name', 'ext', '')")
        #books = cur.fetchall()
        conn.commit()
    except (Exception, psycopg2.DatabaseError) as error:
        return jsonify({'message': 'DB exception','status': '0','UUID':''}), 401
    finally:
        cur.close()
        if conn is not None:
            conn.close()

    return jsonify({'message': 'OK','status': '1','UUID': guid}), 200


@app.route('/fileservice/api/v1.0/getfile/<file_uuid>', methods=['GET'])
def get_file(file_uuid):

    if file_uuid == "":
        return jsonify({'error': 'empty guid'}), 401

    conn = get_db_connection()
    cur = conn.cursor()

    select_Query = "select name, extention from files where guid = %s limit 1"
    values = [file_uuid]

    try:
        cur.execute(select_Query,tuple(values))
        #cur.execute("select name, extention from files limit 1")
        file_record = cur.fetchone()
    except (Exception, psycopg2.DatabaseError) as error:
        return jsonify({'status': '0','message':'DB Exception','URL':''}) , 401
    finally:
        if conn:
            cur.close()
            conn.close()

    file_path_src= dirpath + file_uuid

    if os.path.exists(file_path_src) == False:
        return jsonify({'status': '0','message':'file not exists','url':''}) , 401

    file_name = file_record[0]
    file_ext = file_record[1]
    tmp_file_name = str(uuid.uuid4())+'_'+file_name+'.'+file_ext
    file_path_dst = dirpathtmp+tmp_file_name
    try:
        shutil.copyfile(file_path_src, file_path_dst)
        key = load_key()
        decrypt(file_path_dst, key)
    except (Exception, os.IOError) as error:
        return jsonify({'status': '0','message':'OS IO error','URL':''}) , 401

    # 2nd option   shutil.copy(src, dst)  # dst can be a folder; use shutil.copy2() to preserve timestamp

    return jsonify({'status': '1','message':'','url':httpfileserver+ '/fileservice/api/v1.0/tmpfiles/'+tmp_file_name}), 200


@app.route("/fileservice/api/v1.0/tmpfiles/<path>")
def DownloadFile (path = None):
    if path is None:
        self.Error(400)
    try:
        path = dirpathtmp + path
        return send_file(path, as_attachment=True)
    except Exception as e:
        self.log.exception(e)
        self.Error(400)
    return {'error': 'File not exists'}


@app.route('/fileservice/api/v1.0/deletefile/<file_uuid>', methods=['DELETE'])
def delete_file(file_uuid):
    conn = get_db_connection()
    cur = conn.cursor()

    select_Query = "delete from files where guid = %s"
    values = [file_uuid]

    try:
        cur.execute(select_Query,tuple(values))
        #cur.execute("select name, extention from files limit 1")
    except (Exception, psycopg2.DatabaseError) as error:
        return jsonify({'status': '0','message':'DB exception'}),401 #error #{'error': 'DB exception'}

    finally:
        if conn:
            cur.close()
            conn.close()

    file_path_src= dirpath + file_uuid
    if os.path.exists(file_path_src) == False:
        return jsonify({'status': '0','message':'File not exists'}),401
    try:
        os.remove(file_path_src)
    except:
        return jsonify({'status': '0', 'message': 'OS IO error'}), 401

    return jsonify({'status': '1','message':''}),200

# if __name__ == '__main__':
#     # app.run(debug=True)
#     app.run(debug=True)
#

@app.route('/')
def index():
    return render_template('hello.html')

if __name__ == "__main__":
    t1 = threading.Thread(target=cleartempdir)
    t1.daemon = True
    t1.start()
    serve(app, host="0.0.0.0", port=8081)

