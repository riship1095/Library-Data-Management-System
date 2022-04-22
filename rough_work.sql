select * from project1_authors
order by 1;

select unique regexp_substr(t.author,'[^,]+') from project1_books_load t
order by 1;

drop sequence authors_seq;

create sequence authors_seq
start with 0
increment by 1
minvalue 0
cache 20
nocycle;

select authors_seq.nextval from dual;

insert into project1_authors
select authors_seq.nextval, nam from (
select unique regexp_substr(t.author,'[^,]+') nam from project1_books_load t
where regexp_substr(t.author,'[^,]+') is not null
order by 1);

select * from project1_books_load
order by 1;

select * from project1_book_authors
where isbn = '0006278841';

insert into project1_book_authors
select ath.author_id, bk.isbn10
from project1_books_load bk inner join project1_authors ath
on bk.author = ath.name
order by 1; 

select * from project1_books_load
where isbn10 in ('0679833692','0394825985','0394832205','0679890998');


select ath.author_id, bk.isbn10
from project1_books_load bk, project1_authors ath
where ath.name in (select author from project1_books_load where regexp_like(author,'[^?]+'))
order by 1;


select * from project1_books_load
where author like '%Laurel Aziz%';


select * from (
select isbn10, regexp_substr(author,'[^,]+')
from project1_books_load
where regexp_substr(author,'[^,]+') is not null)
where isbn10 = '0006278841';


select * from (
select unique regexp_substr(t.author,'[^,]+') nam from project1_books_load t
where regexp_substr(t.author,'[^,]+') is not null
order by 1)
where nam like '%Laurel Aziz%';


select t.author, substr(t.author,',',instr(t.author,',',1,1),1) from project1_books_load t;


insert into temp1
select substr(t.author, instr(t.author,',',1,3)+1,instr(t.author,',',1,4) -instr(t.author,',',1,3) -1) 
from project1_books_load t
where substr(t.author, instr(t.author,',',1,3)+1,instr(t.author,',',1,4) -instr(t.author,',',1,3) -1) is not null;

select * from project1_books_load;


select * from project1_authors
where name like '%Laurel Aziz%'
order by 1;

delete from project1_authors;

insert into project1_authors
select authors_seq.nextval, nam from(
select unique nam from temp1
order by 1);

select t.author,
substr(t.author,1,instr(t.author,',',1,1)-1) part_1,
substr(t.author,instr(t.author,',',1,1)+1, nvl(nullif(instr(t.author,',',1,2),0),length(t.author))- instr(t.author,',',1,1)) part_2,
substr(t.author,instr(t.author,',',1,2)+1, nvl(nullif(instr(t.author,',',1,3),0),length(t.author))- instr(t.author,',',1,2)) part_3,
substr(t.author,instr(t.author,',',1,3)+1, nvl(nullif(instr(t.author,',',1,4),0),length(t.author))- instr(t.author,',',1,3)) part_4,
substr(t.author,instr(t.author,',',1,4)+1, nvl(nullif(instr(t.author,',',1,5),0),length(t.author))- instr(t.author,',',1,4)) part_5
from project1_books_load t;
--where t.author like '%Laurel Aziz%';




select t.author, 
replace(substr(t.author,1,nvl(nullif(instr(t.author,',',1,1),0),length(t.author))),',','') part_1,
regexp_substr(t.author,'[^,]+',1,regexp_instr(t.author,'[^,]+',1,1)+1) part_2,
regexp_substr(t.author,'[^,]+',regexp_instr(t.author,'[^,]+',1,2)+1,regexp_instr(t.author,'[^,]+',1,3)) part_3
--regexp_substr(t.author,'[^,]+',regexp_instr(t.author,'[^,]+',1,3),regexp_instr(t.author,'[^,]+',1,4)-regexp_instr(t.author,'[^,]+',1,3)+1) part_4,
--regexp_substr(t.author,'[^,]+',regexp_instr(t.author,'[^,]+',1,4),regexp_instr(t.author,'[^,]+',1,5)-regexp_instr(t.author,'[^,]+',1,4)+1) part_5
from project1_books_load t;

select regexp_substr(t.author,'[^,]+',1,level) from project1_books_load t
connect by regexp_substr(t.author,'[^,]+',level) is not null;




-------------------------------------------------------------------------------------------------------------------------------------------------------------------


select * from project1_book_copies;


drop table project1_book_copies;


create table project1_book_copies(copy_id varchar2(10),
                                  book_id varchar2(10),
                                  ISBN10 varchar2(15) not null,
                                  branch_id varchar2(10) not null,
                                  constraint pk_copy_id primary key (copy_id));
                                  
                                  
select * from project1_book_copies
order by 1;

drop table project1_book_loans;
drop table project1_fines;


create table project1_book_loan(loan_id varchar2(10), 
                               copy_id varchar2(10), 
                               book_id varchar2(20), 
                               card_no varchar2(20), 
                               date_out varchar2(15), 
                               date_due varchar2(15),
                               date_in varchar2(15),
                               constraint pk_loan_id primary key (loan_id),
                               constraint fk_copy_id foreign key (copy_id) references project1_book_copies(copy_id),
                               constraint fk_card_no foreign key (card_no) references project1_borrower(card_no));
                               
CREATE TABLE PROJECT1_FINES(LOAN_ID VARCHAR2(10) not null,
                            FINE_AMT FLOAT not null,
                            PAID FLOAT,
                            CONSTRAINT fk_loan_id foreign key (loan_id) references project1_book_loans(Loan_id));
                            
alter table PROJECT1_BOOK_COPIES_LOAD                     
rename COLUMN BOOK_ID to ISBN10;

select ISBN10, branch_id, copies_no from project1_book_copies_load
order by 1,2;
             
select ISBN10, branch_id, copies_no from project1_book_copies_load
WHERE ISBN10 = '0140252800'
order by 1,2;


SELECT DISTINCT ISBN10 FROM project1_book_copies_load
WHERE COPIES_NO > 0
ORDER BY 1;

select * from project1_borrower
order by 1;


SELECT CARD_NO  
FROM(SELECT DISTINCT CARD_NO FROM PROJECT1_BORROWER
WHERE ROWNUM < 201
ORDER BY DBMS_RANDOM.VALUE)
WHERE ROWNUM = 1; 

SELECT TO_CHAR(SYSDATE - DBMS_RANDOM.VALUE()*365, 'DD/MM/RRRR') FROM DUAL;



SELECT A.COPY_ID, B.CARD_NO
FROM(SELECT CARD_NO FROM PROJECT1_BORROWER
     WHERE ROWNUM <= 200
     ORDER BY DBMS_RANDOM.VALUE) B,
    (SELECT UNIQUE COPY_ID FROM PROJECT1_BOOK_COPIES
    WHERE ROWNUM <= 100
    ORDER BY DBMS_RANDOM.VALUE) A
WHERE ROWNUM <= 400
ORDER BY DBMS_RANDOM.VALUE;


SELECT DBMS_RANDOM.VALUE(TO_DATE('01/01/2021','DD/MM/RRRR'),TO_DATE('31/12/2021','DD/MM/RRRR')) FROM DUAL;


---- DATE----
SELECT DT_OUT, DT_OUT+7 DT_DUE FROM (
SELECT (trunc(TO_DATE('31/10/2020','DD/MM/RRRR') + dbms_random.value * 364)) DT_OUT FROM DUAL);



--- BOOK_ID---
 
SELECT UNIQUE BOOK_ID 
FROM(SELECT BOOK_ID FROM PROJECT1_BOOK_COPIES
    WHERE ROWNUM <= 100
    ORDER BY DBMS_RANDOM.VALUE)
    WHERE ROWNUM < 2;

--- CARD_ID ---

SELECT UNIQUE CARD_NO FROM(    
                SELECT CARD_NO FROM PROJECT1_BORROWER
                WHERE ROWNUM <= 200
                ORDER BY DBMS_RANDOM.VALUE)
                WHERE ROWNUM < 2;
    

--- MAIN QUERY ---
SELECT * FROM (
SELECT A.BOOK_ID, B.CARD_NO, C.DT_OUT
FROM (SELECT UNIQUE BOOK_ID 
      FROM(SELECT BOOK_ID FROM PROJECT1_BOOK_COPIES
           WHERE ROWNUM <= 100
            ORDER BY DBMS_RANDOM.VALUE)
    --WHERE ROWNUM < 2
    ) A,
    (SELECT UNIQUE CARD_NO FROM(    
            SELECT CARD_NO FROM PROJECT1_BORROWER
            WHERE ROWNUM <= 200
            ORDER BY DBMS_RANDOM.VALUE)
            --WHERE ROWNUM < 2
            ) B,
     (SELECT (trunc(TO_DATE('31/10/2020','DD/MM/RRRR') + dbms_random.value * 364)) DT_OUT FROM DUAL) C)
ORDER BY DBMS_RANDOM.VALUE;
     
--- eXPERIMENT ---

SELECT A.COPY_ID, B.CARD_NO, C.DT_OUT
FROM (SELECT UNIQUE COPY_ID FROM PROJECT1_BOOK_COPIES
        WHERE BOOK_ID = (SELECT UNIQUE BOOK_ID FROM(    
                        SELECT BOOK_ID FROM PROJECT1_BOOK_COPIES
                        WHERE ROWNUM <= 100
                        ORDER BY DBMS_RANDOM.VALUE)
                        WHERE ROWNUM < 2)
        ORDER BY DBMS_RANDOM.VALUE) A,
        (SELECT UNIQUE CARD_NO FROM(    
                SELECT CARD_NO FROM PROJECT1_BORROWER
                WHERE ROWNUM <= 200
                ORDER BY DBMS_RANDOM.VALUE)) B,
         (SELECT (trunc(TO_DATE('31/10/2020','DD/MM/RRRR') + dbms_random.value * 364)) DT_OUT FROM DUAL) C
ORDER BY DBMS_RANDOM.VALUE;
                
INSERT INTO PROJECT1_BOOK_LOANS 
SELECT BOOK_LOANS_SEQ.NEXTVAL, COPY_ID
FROM (SELECT COPY_ID FROM PROJECT1_BOOK_COPIES
                                WHERE BOOK_ID IN (SELECT UNIQUE BOOK_ID FROM(    
                                SELECT BOOK_ID FROM PROJECT1_BOOK_COPIES
                                WHERE ROWNUM <= 100
                                ORDER BY DBMS_RANDOM.VALUE)));
                                
                                
--------------------------------------------------------------------

SELECT * FROM PROJECT1_BORROWER;


SELECT ISBN10, BRANCH_ID, COPIES_NO
FROM PROJECT1_BOOK_COPIES_LOAD
WHERE COPIES_NO > 0;
-----------------------------------------------------------------------

SELECT BOOK_ID, CARD_NO, DT_OUT, DT_OUT+7 DT_DUE,  
            CASE WHEN MOD(A.RA,4)=0 THEN NULL
             WHEN MOD(A.RA,3)=0 THEN DT_OUT+5
             WHEN MOD(A.RA,5)=0 THEN DT_OUT+2
             ELSE DT_OUT+7 END DT_IN
FROM (SELECT ROWNUM RA, BOOK_ID FROM (
SELECT BOOK_ID FROM PROJECT1_BOOK_COPIES
ORDER BY DBMS_RANDOM.VALUE)
WHERE ROWNUM <= 100) A,
(SELECT ROWNUM RB, CARD_NO FROM (
SELECT CARD_NO FROM PROJECT1_BORROWER
ORDER BY DBMS_RANDOM.VALUE)
WHERE ROWNUM <= 200) B,
(SELECT ROWNUM RC, DT_OUT 
FROM (SELECT trunc(TO_DATE('31/10/2020','DD/MM/RRRR') + dbms_random.value * 364) DT_OUT FROM DUAL)) C
WHERE A.RA = B.RB;

-------------------------------------------------------------------------------------------
SELECT M.RA, 
       M.BOOK_ID, 
       M.CARD_NO, 
       M.DT_OUT, 
       M.DT_OUT+7 DT_DUE,  
       CASE WHEN MOD(M.RA,4)=0 THEN NULL
        WHEN MOD(M.RA,3)=0 THEN M.DT_OUT+5
        WHEN MOD(M.RA,5)=0 THEN M.DT_OUT+2
        ELSE M.DT_OUT+7 END DT_IN
FROM (SELECT A.RA RA, 
             A.BOOK_ID, 
             B.CARD_NO, 
             C.DT_OUT
      FROM (SELECT ROWNUM RA, 
                   BOOK_ID 
            FROM(SELECT BOOK_ID 
                 FROM PROJECT1_BOOK_COPIES
                 ORDER BY DBMS_RANDOM.VALUE)
            WHERE ROWNUM <= 100) A,
           (SELECT ROWNUM RB, 
                   CARD_NO 
            FROM(SELECT CARD_NO 
                 FROM PROJECT1_BORROWER
                 ORDER BY DBMS_RANDOM.VALUE)
            WHERE ROWNUM <= 200) B,
           (SELECT TRUNC(TO_DATE('31/10/2020','DD/MM/RRRR') + DBMS_RANDOM.VALUE * 364) DT_OUT 
            FROM DUAL) C
WHERE A.RA = B.RB
ORDER BY DBMS_RANDOM.VALUE) M;