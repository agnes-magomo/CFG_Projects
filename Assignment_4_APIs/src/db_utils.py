#sql
import mysql.connector
from config import USER, PASSWORD, HOST, DATABASE


class DbConnectionError(Exception):
    pass


def _connect_to_db():
    cnx = mysql.connector.connect(
        host=HOST,
        user=USER,
        password=PASSWORD,
        #auth_plugin='mysql_native_password',
        database=DATABASE
    )
    return cnx



def get_all_movies():
    try:
        db_connection = _connect_to_db()
        cur = db_connection.cursor()
        print("Connected to DB: %s" % DATABASE)

        query = """SELECT * FROM movies"""  #this is what the API returns to the client
        cur.execute(query)
        result = cur.fetchall() # this is a list with db records where each record is a tuple

        return result
        cur.close()

    except Exception:
        raise DbConnectionError("Failed to read data from DB")

    finally:      #finally always runs
        if db_connection:
            db_connection.close()
            print("DB connection is closed")



def delete_movie_by_id(movie_id):
    try:
        db_connection = _connect_to_db()
        cur = db_connection.cursor()
        print("Connected to DB: %s" % DATABASE)

        del_query = """DELETE FROM movies WHERE movie_id = {}""".format(movie_id)
        cur.execute(del_query)

        db_connection.commit()

        print(f"Record with movie_id {movie_id} deleted successfully.")

        select_query = "SELECT * FROM movies"
        cur.execute(select_query)
        remaining_records = cur.fetchall()  # Get all remaining records
        cur.close()

        return remaining_records


    except Exception:
        raise DbConnectionError("Failed to read data from DB")

    finally:
        if db_connection:
            db_connection.close()
            print("DB connection is closed")

def add_movie(title, genre, year):
    db_connection = None
    try:
        # Specify the database name
        db_connection = _connect_to_db()
        cur = db_connection.cursor()
        print(f"Connected to DB: %s" % DATABASE)

        # SQL query to insert the movie, using string formatting
        query = """
            INSERT INTO movies (tile, genre, year)
            VALUES ('{title}', '{genre}', {year})
        """.format(title=title, genre=genre, year=year)

        # Execute the query
        cur.execute(query)
        db_connection.commit()
        print('Movie added successfully!')

        query = """ SELECT * FROM movies"""
        cur.execute(query)
        result = cur.fetchall()

        cur.close()

        return result

    except Exception:
        raise DbConnectionError("Failed to read data from DB")


    finally:
        if db_connection:
            db_connection.close()
            print('DB connection is closed')



if __name__ == '__main__':
    print(get_all_movies())
    # delete_movie_by_id()