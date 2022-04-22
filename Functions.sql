CREATE OR REPLACE FUNCTION GEN_CARD_NO
RETURN VARCHAR2 IS 
    V_CARD VARCHAR2(20):= NULL;

BEGIN
    SELECT CARD_NO INTO V_CARD 
    FROM(SELECT DISTINCT CARD_NO FROM PROJECT1_BORROWER
    WHERE ROWNUM < 201
    ORDER BY DBMS_RANDOM.VALUE)
    WHERE ROWNUM = 1; 

    RETURN V_CARD;
END;


CREATE OR REPLACE FUNCTION GEN_BOOK_ID
RETURN VARCHAR2 IS 
    V_BOOK VARCHAR2(20):= NULL;

BEGIN
    SELECT BOOK_ID INTO V_BOOK 
    FROM(SELECT DISTINCT BOOK_ID FROM PROJECT1_BOOK_COPIES
    WHERE ROWNUM < 101
    ORDER BY DBMS_RANDOM.VALUE)
    WHERE ROWNUM = 1; 

    RETURN V_BOOK;
END;

CREATE OR REPLACE FUNCTION GEN_DT_OUT
RETURN DATE IS 
    V_DATE DATE;
    
BEGIN
    SELECT (TRUNC(TO_DATE('31/10/2020','DD/MM/RRRR') + DBMS_RANDOM.VALUE * 364)) 
    INTO V_DATE 
    FROM DUAL;
    
    RETURN V_DATE;
END;




