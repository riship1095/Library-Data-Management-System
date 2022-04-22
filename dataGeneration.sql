SELECT M.RA, M.BOOK_ID, M.CARD_NO, M.DT_OUT, M.DT_OUT+7 DT_DUE,  
            CASE WHEN MOD(M.RA,4)=0 THEN NULL
             WHEN MOD(M.RA,3)=0 THEN M.DT_OUT+5
             WHEN MOD(M.RA,5)=0 THEN M.DT_OUT+2
             ELSE M.DT_OUT+7 END DT_IN
FROM (SELECT A.RA RA, A.BOOK_ID, B.CARD_NO, C.DT_OUT
FROM (SELECT ROWNUM RA, BOOK_ID FROM(    
                        SELECT BOOK_ID FROM PROJECT1_BOOK_COPIES
                        ORDER BY DBMS_RANDOM.VALUE)
        WHERE ROWNUM <= 100) A,
        (SELECT ROWNUM RB, CARD_NO FROM(    
                SELECT CARD_NO FROM PROJECT1_BORROWER
                ORDER BY DBMS_RANDOM.VALUE)
               WHERE ROWNUM <= 200) B,
         (SELECT (trunc(TO_DATE('31/10/2020','DD/MM/RRRR') + dbms_random.value * 364)) DT_OUT FROM DUAL) C
WHERE A.RA = B.RB
ORDER BY DBMS_RANDOM.VALUE) M;