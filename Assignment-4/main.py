# This file deals with the API interface on the client side, with a welcome message and a various ways to interact with the API
import requests
from datetime import datetime


base_url = "http://127.0.0.1:5000"


def welcome():
    print(''' 
          --------------------------------------------------------\n
               Welcome to the API Library Management System!\n
          --------------------------------------------------------
          ''')


def actions():
    print("\nYou may perform the following actions: ")
    print("1. View all books")
    print("2. Add a new book")
    print("3. View all members")
    print("4. View borrowed books")
    print("5. Add a new booking")
    print("6. Exit")


def view_books():
    try:
        response = requests.get(f"{base_url}/books")
        books = response.json()
        if response.status_code == 200:
            print("\nBooks in the library: ")
            for book in books:
                print(f"{book['book_id']}: {book['title']} by {book['author']} ({book['year_published']})")
        else:
            print(f"Error fetching books: {response.status_code} - {response.text}")
    except Exception as e:
        print(f"Error fetching books: {e}")


def add_book():
    try:
        title = input("Enter the book title: ")
        author = input("Enter the book author: ")
        genre = input("Enter the book genre: ")
        year_published = input("Enter year published: ")

        book_data = {
            "title": title,
            "author": author,
            "genre": genre,
            "year_published": year_published
        }

        response = requests.post(f"{base_url}/books", json=book_data)
        if response.status_code == 201:               # 201 = Created status code
            print("New book successfully added!")
        else:
            (f"Error adding new book: {response.status_code} - {response.text}")
    
    except Exception as e:
        print(f"Failed to add new book: {e}")


def view_members():
    try:
        response = requests.get(f"{base_url}/members")
        members = response.json()
        if response.status_code == 200:
            print("\nLibrary Members: ")
            for member in members:
                print(f"{member['member_id']}: {member['first_name']} {member['last_name']}")
        else:
            print(f"Error fetching members: {response.status_code} - {response.text}")
    
    except Exception as e:
        print(f"Error fetching members: {e}")


def view_borrowed():
    try:
        response = requests.get(f"{base_url}/borrowedbooks")
        borrowed_books = response.json()
        if response.status_code == 200:
            print("\nCurrent bookings: ")
            for booking in borrowed_books:
                print(f"Book ID: {booking['book_id']} Borrowed by: {booking['member_id']} on {booking['borrow_date']}")
        else:
            print(f"Error fetching bookings: {response.status_code} - {response.text}")
    
    except Exception as e:
        print(f"Error fetching books: {e}")


def add_borrowed():
    try:
        book_id = int(input("Enter the book id: "))
        member_id = int(input("Enter the member id: "))
        borrow_date = input("Enter the borrow date (YYYY-MM-DD): ")
        if not valid_date(borrow_date):
            raise ValueError("Borrow date must be in the format YYYY-MM-DD")

        booking_data = {
            "book_id": book_id,
            "member_id": member_id,
            "borrow_date": borrow_date
        }

        response = requests.post(f"{base_url}/borrowedbooks", json=booking_data)
        if response.status_code == 201:
            print(f"Borrowing a book for Member ID: {member_id} (Book ID: {book_id}) on {borrow_date}")
            print("\nNew booking successfully added!")
        else:
            (f"Error adding new booking: {response.status_code} - {response.text}")
        
    except Exception as e:
        print(f"Error adding new booking: {e}")


def valid_date(date_input):
    """Check for the validity of the user's date input in the YYYY-MM-DD format"""
    try:
        datetime.strptime(date_input, "%Y-%m-%d")
        return True
    except ValueError:
        return False
    

def run():
    welcome()
    while True:
        actions()
        choice = input("Choose option 1-6: ")
        
        if choice == '1':
            print("Fetching all books...")
            view_books()
        elif choice == '2':
            print("Adding a new book...")
            add_book()
        elif choice == '3':
            print("Fetching all members...")
            view_members()
        elif choice == '4':
            print("Fetching all borrowed books...")
            view_borrowed()
        elif choice == '5':
            print("Adding new booking...")
            add_borrowed()
        elif choice == '6':
            print("Goodbye. Thank you for using this service.")
            break
        else:
            print("Invalid option, please try again.")
            break



if __name__ == "__main__":
    run()