CREATE TABLE PROJECT1_BOOKS(ISBN10 VARCHAR2(15), 
                             TITLE VARCHAR2(300), 
                             CONSTRAINT PK_ISBN_10 PRIMARY KEY (ISBN10));
     
CREATE TABLE PROJECT1_BOOK_AUTHORS(AUTHOR_ID NUMBER, 
                                    ISBN  VARCHAR2(20), 
                                 CONSTRAINT FK_AUTHOR_ID FOREIGN KEY (AUTHOR_ID)
                                  REFERENCES PROJECT1_AUTHORS (AUTHOR_ID), 
                                 CONSTRAINT FK_ISBN FOREIGN KEY (ISBN)
                                  REFERENCES PROJECT1_BOOKS_LOAD (ISBN10));
      
CREATE TABLE PROJECT1_AUTHORS(AUTHOR_ID NUMBER, 
                              NAME  VARCHAR2(200) NOT NULL, 
                              CONSTRAINT PK_AUTHOR_ID PRIMARY KEY (AUTHOR_ID));
     
CREATE TABLE PROJECT1_LIBRARY_BRANCH(BRANCH_ID VARCHAR2(10), 
                                     BRANCH_NAME VARCHAR2(100) NOT NULL , 
                                     ADDRESS VARCHAR2(300), 
                                     CONSTRAINT PK_BRANCH_ID PRIMARY KEY (BRANCH_ID));
     

CREATE TABLE PROJECT1_BORROWER(CARD_NO VARCHAR2(15), 
                                 SSN VARCHAR2(20), 
                                 FNAME VARCHAR2(100), 
                                 LNAME VARCHAR2(100), 
                                 ADDRESS VARCHAR2(300), 
                                 PHONE VARCHAR2(15), 
                                CONSTRAINT PK_CARD_NO PRIMARY KEY (CARD_NO));


CREATE TABLE PROJECT1_BOOK_COPIES(BOOK_ID VARCHAR2(10),
                                  ISBN10 VARCHAR2(15) NOT NULL,
                                  BRANCH_ID VARCHAR2(10) NOT NULL,
                                  CONSTRAINT PK_BOOK_ID PRIMARY KEY (BOOK_ID));
                    

CREATE TABLE PROJECT1_BOOK_LOANS(LOAN_ID VARCHAR2(10), 
                               BOOK_ID VARCHAR2(20), 
                               CARD_NO VARCHAR2(20), 
                               DATE_OUT VARCHAR2(15), 
                               DATE_DUE VARCHAR2(15),
                               DATE_IN VARCHAR2(15),
                               CONSTRAINT PK_LOAN_ID PRIMARY KEY (LOAN_ID),
                               CONSTRAINT FK_BOOK_ID FOREIGN KEY (BOOK_ID) REFERENCES PROJECT1_BOOK_COPIES(BOOK_ID),
                               CONSTRAINT FK_CARD_NO FOREIGN KEY (CARD_NO) REFERENCES PROJECT1_BORROWER(CARD_NO));
                               
CREATE TABLE PROJECT1_FINES(LOAN_ID VARCHAR2(10) NOT NULL,
                            FINE_AMT FLOAT NOT NULL,
                            PAID CHAR(1),
                            CONSTRAINT FK_LOAN_ID FOREIGN KEY (LOAN_ID) REFERENCES PROJECT1_BOOK_LOANS(LOAN_ID));
                            
                            
                  