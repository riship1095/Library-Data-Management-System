
/*CREATE OR REPLACE PROCEDURE SEARCH_LIBRARY(P_ISBN   IN VARCHAR2, 
                                           P_TITLE  IN VARCHAR2,
                                           P_AUTHOR IN VARCHAR2)
AS

V_ISBN       VARCHAR2(100);
V_TTTLE      VARCHAR2(400); 
V_AUTHOR     VARCHAR2(400);
V_STR_QUERY  VARCHAR2(800);
V_RC         SYS_REFCURSOR;

BEGIN
   
    IF P_ISBN IS NOT NULL THEN
        V_ISBN := ' AND LOWER(BA.ISBN) LIKE ''%' || LOWER(P_ISBN) || '%''';
    ELSE
        V_ISBN := ' ';
    END IF;

    IF P_TITLE IS NOT NULL THEN
        V_TTTLE := ' AND LOWER(B.TITLE) LIKE ''%' || LOWER(P_TITLE) || '%''';
    ELSE
        V_TTTLE := ' ';
    END IF;
    
    IF P_AUTHOR IS NOT NULL THEN
        V_AUTHOR := ' AND LOWER(A.NAME) LIKE ''%' || LOWER(P_AUTHOR) || '%''';
    ELSE
        V_AUTHOR := ' ';
    END IF;
    
    
    V_STR_QUERY:= 'SELECT DISTINCT BA.ISBN, B.TITLE, A.NAME AUTHOR_NAME ' || chr(10) ||
                   'FROM PROJECT1_BOOKS B ' || chr(10) ||
                   'INNER JOIN PROJECT1_BOOK_AUTHORS BA ON B.ISBN10 = BA.ISBN ' || chr(10) ||
                   'INNER JOIN PROJECT1_AUTHORS A ON A.AUTHOR_ID = BA.AUTHOR_ID ' || chr(10) ||
                   'INNER JOIN PROJECT1_BOOK_COPIES C ON B.ISBN10 = C.ISBN10 ' || chr(10) ||
                   'WHERE 1=1 ' || chr(10) ||
                   '' || V_ISBN || V_TTTLE || V_AUTHOR || chr(10) ||
                   ' ORDER BY 2';
        
    OPEN V_RC FOR V_STR_QUERY;
    DBMS_SQL.RETURN_RESULT(V_RC);

END;
/

*/

column title format a30;
column author_name format a30;
set linesize 300;

SET AUTOPRINT ON;

BEGIN
SEARCH_LIBRARY('0002215810','Lord Of The Far Island','Holt');
END;

