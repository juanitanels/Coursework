# This file includes the core functionality of the Flask application, such as the API endpoints.
from flask import Flask, jsonify, request
from db_utils import connect_to_db, close_db_connection

app = Flask(__name__)

# API HEALTH CHECK
@app.route("/")
def index():
    try:
        db_name = "library_management"
        db_connection = connect_to_db(db_name)
        if db_connection:
            close_db_connection(db_connection)
            return "The Library Management System is running!", 200
    
    except Exception:
        return jsonify({"error": "Failed to connect to DB"})


# GET ALL BOOKS
@app.route("/books", methods=["GET"])
def get_all_books():
    try:
        db_name = "library_management"
        db_connection = connect_to_db(db_name)
        
        cursor = db_connection.cursor(dictionary=True)
        print(f"Successfully connected to DB: {db_name}")
        
        query = "SELECT * FROM books"
        cursor.execute(query)
        books = cursor.fetchall()
        cursor.close()
        return jsonify(books), 200
    
    except Exception:
        return jsonify({"error": "Failed to fetch books"}), 500
    
    finally:
        if db_connection:
            close_db_connection(db_connection)

# http://127.0.0.1:5000/books


# ADD A NEW BOOK
@app.route("/books", methods=["POST"])
def add_new_book():
    try:
        data = request.json
        title = data["title"]
        author = data["author"]
        genre = data["genre"]
        year_published = data["year_published"]

        if not title or not author or not genre or not year_published:
            return jsonify({"error": "All fields (title, author, genre, year_published) are required."}), 400

        db_name = "library_management"
        db_connection = connect_to_db(db_name)
        cursor = db_connection.cursor(dictionary=True)
        print(f"Successfully connected to DB: {db_name}")
        
        query = f"""INSERT INTO books (title, author, genre, year_published)
                VALUES (%s, %s, %s, %s)
                """
        cursor.execute(query, (title, author, genre, year_published))
        db_connection.commit()
        cursor.close()
        return jsonify({"message": "New book successfully added!"}), 201
    
    except Exception:
        return jsonify({"error": "Failed to add new book"}), 500
    
    finally:
        if db_connection:
            close_db_connection(db_connection)


# GET ALL MEMBERS
@app.route('/members', methods=["GET"])
def get_members():
    try:
        db_name = "library_management"
        db_connection = connect_to_db(db_name)
        cursor = db_connection.cursor(dictionary=True)         # Returns rows as dictionaries, do not need to create dictionaries later.
        print(f"Successfully connected to DB: {db_name}")
        
        query = "SELECT * FROM members"
        cursor.execute(query)
        members = cursor.fetchall()
        cursor.close()
        return jsonify(members), 200
    
    except Exception:
        return jsonify({"error": "Failed to fetch members"}), 500
    
    finally:
        if db_connection:
            close_db_connection(db_connection)

# http://127.0.0.1:5000/members


# GET BORROWED BOOKS
@app.route('/borrowedbooks', methods=["GET"])
def get_borrowed_books():
    try:
        db_name = "library_management"
        db_connection = connect_to_db(db_name)
        cursor = db_connection.cursor(dictionary=True)            # Returns rows as dictionaries, do not need to create dictionaries later.
        print(f"Successfully connected to DB: {db_name}")
        
        query = "SELECT * FROM borrowed_books"
        cursor.execute(query)
        members = cursor.fetchall()
        cursor.close()
        return jsonify(members), 200
    
    except Exception:
        return jsonify({"error": "Failed to fetch borrowed books"}), 500
    
    finally:
        if db_connection:
            close_db_connection(db_connection)

# http://127.0.0.1:5000/borrowedbooks


# ADD NEW BOOKING
@app.route("/borrowedbooks", methods=["POST"])
def add_new_borrowed():
    try:
        data = request.json
        book_id = data["book_id"]
        member_id = data["member_id"]
        borrow_date = data["borrow_date"]

        if not book_id or not member_id or not borrow_date:
            return print("Error: All fields (book_id, member_id, borrow_date) are required")
        
        db_name = "library_management"
        db_connection = connect_to_db(db_name)
        cursor = db_connection.cursor(dictionary=True)
        print(f"Successfully connected to DB: {db_name}")

        query = f"""INSERT INTO borrowed_books (book_id, member_id, borrow_date)
                    VALUES (%s, %s, %s)
            """
        cursor.execute(query, (book_id, member_id, borrow_date))
        db_connection.commit()
        cursor.close()
        return jsonify({"message": "New booking successfully added!"}), 201
    
    except Exception:
        return jsonify({"error": "Failed to add new borrowed book"}), 500
    
    finally:
        if db_connection:
            close_db_connection(db_connection)



if __name__ == "__main__":
    app.run(debug=True)
