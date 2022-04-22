alter table project1_books_load 
add cover varchar2(200);

alter table project1_books_load
rename column ISBN to ISBN10;

alter table project1_books_load
modify (author varchar2(300));

select * from project1_books_load;

delete from project1_books_load;
create table project1_authors_load(AUTHOR_ID INTEGER, 
                                  NAME VARCHAR2(50) not null, 
                                  CONSTRAINT pk_author_id primary key (AUTHOR_ID));

Create table project1_book_authors_load(Author_id integer, 
                                        ISBN varchar2(20), 
                                        constraint fk_author_id foreign key (author_id) REFERENCES project1_authors_load(author_id) , 
                                        constraint fk_isbn foreign key (ISBN) references project1_books_load(ISBN)); 
                                        
 Alter table project1_books_load 
 modify (title not null);
 
 alter table project1_authors_load
 modify (name not null);
 
 
create table project1_library_branch_load(Branch_id varchar2(20),
                                         Branch_name varchar2(50) not null,
                                         Address varchar2(200) not null,
                                         constraint pk_branch_id primary key (branch_id));
                                    
create table project1_borrower_load(card_no varchar2(20),
                                    SSN varchar2(20) not null,
                                    Fname varchar2(50) not null,
                                    Lname varchar2(50) not null, 
                                    Address varchar2(200),
                                    Phone varchar2(20),
                                    Constraint pk_card_no primary key (card_no));
                                    
create table project1_book_copies_load(Book_id varchar2(20),
                                       ISBN varchar2(20) not null,
                                       branch_id varchar2(20) not null,
                                       constraint pk_book_id primary key (book_id),
                                       constraint fk_isbn_2 foreign key (ISBN) references project1_books_load(ISBN),
                                       constraint fk_branch_id foreign key(branch_id) references project1_library_branch_load(branch_id));
                                       

create table project1_book_copies(book_id varchar2(10),
                                  ISBN10 varchar2(15) not null,
                                  branch_id varchar2(10) not null,
                                  constraint pk_book_id primary key (book_id));
                    

create table project1_book_loans(loan_id varchar2(10), 
                               book_id varchar2(20), 
                               card_no varchar2(20), 
                               date_out varchar2(15), 
                               date_due varchar2(15),
                               date_in varchar2(15),
                               constraint pk_loan_id primary key (loan_id),
                               constraint fk_book_id foreign key (book_id) references project1_book_copies(book_id),
                               constraint fk_card_no foreign key (card_no) references project1_borrower(card_no));
                               
CREATE TABLE PROJECT1_FINES(LOAN_ID VARCHAR2(10) not null,
                            FINE_AMT FLOAT not null,
                            PAID FLOAT,
                            CONSTRAINT fk_loan_id foreign key (loan_id) references project1_book_loans(Loan_id));
                            