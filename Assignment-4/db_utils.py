# This file contains the functionality for the database operations, such as establishing the DB connection

# Import necessary libraries/ modules
import mysql.connector
from config import HOST, USER, PASSWORD


def connect_to_db(db_name):
    """Establishes connection to database"""
    try:
        print(f"Attempting to connect to db: {db_name}...")
        connection = mysql.connector.connect(
            host=HOST,
            user=USER,
            password=PASSWORD,
            auth_plugin="mysql_native_password",
            database=db_name
        )
        if connection.is_connected():
            print(f"Successfully connected to DB: {db_name}")
            return connection
    
    except mysql.connector.Error as e:
        print("Error connecting to DB")
        raise Exception(f"Failed to connect to the MySQL DB: {e}") from e
    
    except Exception as exc:
        print(f"An unexpected error occured")
        raise Exception(f"Failed to connect to MySQL DB: {exc}") from exc


def close_db_connection(connection):
    """Closes the db connection"""
    if connection and connection.is_connected():
        connection.close()
        print("Database connection closed")