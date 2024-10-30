CREATE DATABASE IF NOT EXISTS library_management;

USE library_management;


-- ========================================================
--                   TABLE CREATIONS
-- ========================================================

-- MEMBERS
CREATE TABLE members (
	member_id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE
    );

-- BOOKS
CREATE TABLE books (
	book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(50) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    year_published YEAR
);

ALTER TABLE books AUTO_INCREMENT=101;

 -- BORROWED BOOKS
CREATE TABLE borrowed_books (
	borrowed_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    member_id INT,
    borrow_date DATE,
    return_date DATE DEFAULT NULL,
    CONSTRAINT fk_bb_book_id FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE SET NULL,
    CONSTRAINT fk_bb_member_id FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE SET NULL
);

ALTER TABLE borrowed_books AUTO_INCREMENT=1001;

-- ========================================================
--                      SAMPLE DATA
-- ========================================================

INSERT INTO members (first_name, last_name, email)
VALUES
('Aisha', 'Khan', 'aisha.khan@icloud.com'),
('Luca', 'Rossi', 'luca.rossi@gmail.com') ;

INSERT INTO books (title, author, year_published, genre)
VALUES
('To Kill a Mockingbird', 'Harper Lee', 1960, 'Fiction'),
('1984', 'George Orwell', 1949, 'Dystopian') ;

INSERT INTO borrowed_books (book_id, member_id, borrow_date)
VALUES
(101, 2, '2024-10-02'), -- Luca borrow To Kill a Mockingbird
(102, 1, '2024-10-03') ; -- Aisha borrows 1984

SELECT * FROM members;

SELECT * FROM books;

SELECT * FROM borrowed_books;




    