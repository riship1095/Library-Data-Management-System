Select t.author,
regexp_substr(t.author,'[^,]+',1,1) part1,
regexp_substr(t.author,'[^,]+',1,2) part2,
regexp_substr(t.author,'[^,]+',1,3) part3,
regexp_substr(t.author,'[^,]+',1,4) part4,
regexp_substr(t.author,'[^,]+',1,5) part5
from project1_books_load t;

create table temp1(nam varchar2(100));

insert into temp1
Select regexp_substr(t.author,'[^,]+',1,1) part1
from project1_books_load t
where regexp_substr(t.author,'[^,]+',1,1) is not null;

insert into project1_authors
select authors_seq.nextval, nam from(
select unique nam from temp1
order by 1);

-------------------------------------------------------------------------------------------------------------------------------------


create table temp2(isbn10 varchar2(20),
                   name varchar2(100));

insert into temp2
select isbn10, 
regexp_substr(t.author,'[^,]+',1,1) part1
from project1_books_load t
where regexp_substr(t.author,'[^,]+',1,1) is not null;

insert into project1_book_authors
select unique a.author_id, t.isbn10
from project1_authors a, temp2 t
where a.name = t.name
order by 1;

-------------------------------------------------------------------------------------------------------------------------------------------




