import os
import psycopg2

def init_db():
    conn = psycopg2.connect(
            host="localhost",
            database="filestorage",
            user=os.environ['postgres'],
            password=os.environ['Zraeqw123'])

    # Open a cursor to perform database operations
    cur = conn.cursor()

    # Execute a command: this creates a new table
    #cur.execute('DROP TABLE IF EXISTS books;')

    cur.execute('CREATE TABLE IF NOT EXISTS files (guid uuid PRIMARY KEY,'
                                    'name varchar (150) NOT NULL,'
                                    'extension varchar (10) NOT NULL,'
                                    'description text,'
                                    'date_added date DEFAULT CURRENT_TIMESTAMP);'
                                    )



    conn.commit()

    cur.close()
    conn.close()
