#!flask/bin/python
from cryptography.fernet import Fernet

# Создаем ключ и сохраняем его в файл
key = Fernet.generate_key()
with open('crypto.key', 'wb') as key_file:
    key_file.write(key)
