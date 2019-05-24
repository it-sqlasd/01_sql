1 -- day06 
2 ----- 2) 문자함수 
3 -------- 1. INITCAP(str) : str 의 첫 글자를 대문자화(영문) 
4 SELECT initcap('the watch') -- The Watch 
5   FROM dual 
6 ; 
7 SELECT initcap('안녕하세요. 하하하') -- 안녕하세요. 하하하 
8   FROM dual 
9 ; 
10 
 
11 -------- 2. LOWER(str) : str의 모든 글자를 소문자화(영문) 
12 SELECT lower('MR. SCOTT MCMILLAN') "소문자로 변경" 
13   FROM dual 
14 ; 
15 -- mr. scott mcmillan 
16 
 
17 -------- 3. UPPER(str) : str의 모든 글자를 대문자화(영문) 
18 SELECT upper('lee') "성을 대문자로 변경" 
19   FROM dual 
20 ;   
21 
 
22 SELECT upper('sql is cooooooooooooooool~!!!') "재밌어요!" 
23   FROM dual 
24 ;  
25 
 
26 -- smith 를 찾는데 입력이 소문자로 된 경우에 
27 -- SMITH 와 다른 글자로 인식되므로 찾을 수 없다. 
28 SELECT e.empno 
29      , e.ename 
30   FROM emp e 
31  WHERE e.ename = 'smith'   
32 ;   
33 -- 인출된 모든 행:0 
34 SELECT e.empno 
35      , e.ename 
36   FROM emp e 
37  WHERE e.ename = 'SMITH'   
38 ; 
39 -- ename 과 비교하는 값이 대문자 이므로 정보가 조회 됨. 
40 SELECT e.empno 
41      , e.ename 
42   FROM emp e 
43  WHERE e.ename = upper('smith') 
44 ;   
45 /* 
46 EMPNO,  ENAME 
47 ---------------- 
48 7369	SMITH 
49 */ 
50 
 
51 -------- 4. LENGTH(str), LENGTHB(str) :  
52 --         str의 글자길이, 글자의 byte 를 계산하여 숫자로 출력 
53 SELECT length('hello, sql') as "글자 길이" 
54   FROM dual 
55 ;   
56 --결과: 10 ==> 특수기호, 공백도 글자 길이로 계산 
57 SELECT 'hello, sql의 글자 길이는 ' || length('hello, sql')  
58                                    || '입니다.' "글자 길이" 
59   FROM dual 
60 ; 
61 /* 
62 글자 길이 
63 ---------------------------------- 
64 hello, sql의 글자 길이는 10입니다. 
65 */ 
66 
 
67 ---- oracle에서 한글을 3byte 로 계산 
68 SELECT lengthb('hello, sql') "글자 byte" 
69   FROM dual 
70 ;   
71 -- 결과 : 10 ==> 영문자는 1byte 할당 
72 SELECT lengthb('오라클') "글자 byte" 
73   FROM dual 
74 ;   
75 -- 결과 : 9 ==> 한글은 3byte 할당 

------------5. CONCAT (str1, st2) : str1과 str2를 문자열 집합 
--                                  || 연산자와 동일한 결과 
SELECT concat('안녕하세요.','SQL!')"인사"
  FROM dual
;
/*
인사
--------------
안녕하세요.SQL!
--concat('안녕하세요.','SQL')과 같은 결과를 내는 || 연산 사용 
*/
SELECT ('안녕하세요.'|| 'SQL!') "인사"
  FROM dual
;

--------6. SUBSTR(str,i,n) : 
--         str 에서 i번쨰 위치에부터 n개의 글자를 추출
--         SQL 에서 문자열의 인덱스(순서)는 1부터 시작
SELECT substr('SQL is cooooooooooooool~!!',3,4)--3번쨰 글자부터 시작하는 4개 까지 출력 
  FROM dual
;
/*
L is
*/
---------  SUBSTR(str, i) :
--         str에서 i번쨰 위치에서 끝까지 글자를 추출
SELECT substr('SQL is cooooooooooooool~!!',3)
  FROM dual
;
/*
L is cooooooooooooool~!!
*/
-- 문제 SQL is cooooooooooooool~! SQL만 추출
SELECT substr('SQL is cooooooooooooool~!!',1,3)
  FROM dual
;

-- 문제 SQL is cooooooooooooool~! is만 추출
SELECT substr('SQL is cooooooooooooool~!!',5,2)
  FROM dual
;
-- 문제 SQL is cooooooooooooool~! ~!만 추출
SELECT substr('SQL is cooooooooooooool~!!',24)
  FROM dual
;
--문제 : EMP 테이블에서 직원의 이름을 앞 두글자까지만 추출하여
--       사번과 함께 조회하시오.
SELECT substr(e.ename,1,2) "앞 두글자"
     , e.empno
  FROM emp e
;
/*
앞 두글자, EMPNO
---------------
J_	       9999
J%	       8888
SM	       7369
AL	       7499
WA	       7521
JO	       7566
MA	       7654
BL	       7698
CL	       7782
KI	       7839
TU	       7844
JA	       7900
FO	       7902
MI	       7934
*/  

----------- 7. INSTR(str1,str2) : 
--          두번쨰 문자열인 str2가 
--          첫번쨰 문자열인 str1의 어디에 위치하는지 
--          등장하는 위치를 계산하여 숫자로 출력 
SELECT instr('SQL is cooooooooooooool~!!','is')  "is 위치"
  FROM dual
;
/*
is 위치
5
*/
SELECT instr('SQL is cooooooooooooool~!!','io')  "io 위치"
  FROM dual
;
/* 두번쨰 문자열이 첫번쨰 문자열에 없으면 0를 출력한다.
io의 위치
---------
        0
*/
------------------8. LPAD, RPAD(str, n, c) : 
--                   입력된 str에 대해서 전체 글자가 차지할 자릿수를 n으로 잡고 
--                   전체 글자수 대비 왼쪽 / 오른쪽에 남는 자릿수에 
--                   c의 문자를 채워넣는다.
SELECT lpad('SQL is cool!',20,'*') "20칸 까지 *로 채운다 왼쪽에"
  FROM dual
;
/*
20칸 까지 *로 채운다
--------------------
********SQL is cool!
*/
SELECT rpad('SQL is cool!',20,'*') "20칸 까지 *로 채운다 오른쪽에"
  FROM dual
;
/*
20칸 까지 *로 채운다
--------------------
SQL is cool!********
*/

----------9. LTRIM , RTRIM,  TRIM : 입력된 문자열의
--           왼쪽,   오른쪽  양쪽 공백을 제거
SELECT '>' || '     sql is cool     ' || '<'
  FROM dual
;
/*
>     sql is cool     <
*/
SELECT '>' || ltrim('     sql is cool     ') || '<'
  FROM dual
;
/*
>sql is cool     <
*/
SELECT '>' || rtrim('     sql is cool     ') || '<'
  FROM dual
;
/*
>     sql is cool<
*/
SELECT '>' || trim('     sql is cool     ') || '<'
  FROM dual
;
/*
>sql is cool<
*/
--
SELECT e.empno
    ,  e.ename
  FROM emp e
 WHERE e.ename = '        SMITH';
--인출된 모든 행 : 0 ==> 공백이 들어간 값은 'SMITH'와 다르므로 조회되지 않습니다.
SELECT e.empno
    ,  e.ename
  FROM emp e
 WHERE e.ename = trim('        SMITH')
;
/*
EMPNO,  ENAME
--------------
7369	SMITH
*/
-- trim 함수를 적용하여 조회 성공

-- 문제 : 비교값이 '    smith ' 일 떄 SMITH 의 정보를 조회하시오.
SELECT e.ename
  FROM emp e
 WHERE e.ename = upper(trim('    smith ') )
;
/*
ENAME
-----
SMITH
*/
-------------- 10 . NVL(expr1, expr2)
--                  NVL2(expr1, expr2, expr3)
--                  NULLIF(expr1, expr2)
-- NVL(expr1, expr2): 첫번쨰 식의 값이 NULL 이면
--                    두번쨰 식으로 대체하여 출력

-- 매너지(mgr)가 배정되지 않은 직원의 경우 
-- 0으로 대체하여 출력'매니저 없음'
SELECT e.empno
    ,  e.ename
    , nvl(e.mgr, 0) "매니저 사번"
  FROM emp e
;
/*
EMPNO,  ENAME,  매니저 사번
9999	J_JAMES	0
8888	J%JAMES	0
7369	SMITH	7902
7499	ALLEN	7698
7521	WARD	7698
7566	JONES	7839
7654	MARTIN	7698
7698	BLAKE	7839
7782	CLARK	7839
7839	KING	0
7844	TURNER	7698
7900	JAMES	7698
7902	FORD	7566
7934	MILLER	7782
*/

-- 매니저(mgr)이 배정되지 않은 직원은 
-- '매니저 없음' 라고 출력하시오
SELECT e.empno
    ,  e.ename
    , nvl(e.mgr, '매니저 없음') "매니저 사번"
 FROM emp e
;
/*
ORA-01722: 수치가 부적합합니다
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.


=> nvl 처리 대상 컬럼인 e.mgr 은 숫자타입의 데이터 쓴 것은 문자타입이라서 
-- NULL 값을 대체할 떄 해당컬럼의 타입과 불일치 하기 떄문에
-- 실행시 구문오류가 발생합니다.
*/

-- ==> 해결방법 e.mgr 을 문자타입으로 변경
SELECT e.empno
    ,  e.ename
    , nvl(e.mgr || '', '매니저 없음') "매니저 사번"
 FROM emp e
;
-- || 결합 연산자도 mgr 에 빈문자를 붙여서 문자타입으로 변경
/*
EMPNO,  ENAME,  매니저 사번
---------------------------
9999	J_JAMES	매니저 없음
8888	J%JAMES	매니저 없음
7369	SMITH	7902
7499	ALLEN	7698
7521	WARD	7698
7566	JONES	7839
7654	MARTIN	7698
7698	BLAKE	7839
7782	CLARK	7839
7839	KING	매니저 없음
7844	TURNER	7698
7900	JAMES	7698
7902	FORD	7566
7934	MILLER	7782
*/
-- 문제 : || 연산자 대신 concat() 함수를 사용하여 같은 결과를 내시오
SELECT e.empno
    ,  e.ename
    ,  nvl(concat(e.mgr,''), '매니저 없음') "매니저 사번" 
 FROM  emp e
;
-- 오라클 에서는 빈 문자열('')를 NULL 로 취급

-- NUL2(expr1,expr2,expr3 ) : 
--     첫번쨰 식의 값이 NOT NULL 이면 두번쨰 식의 값으로 출력
--                      NULL 이면 세번쨰 식의 값으로 출력

-- 매니저(mrg)가 배정된 경우에는 '매니저 있음'으로
-- 매니저가 배정되지 않은 경우네는 '매니저 없음'으로 출력
SELECT e.empno
    ,  e.ename
    ,  nvl2(e.mgr, '매니저 있음','매니저 없음') "매니저 유/무" 
 FROM  emp e
;
/*
EMPNO,  ENAME,  매니저 유/무
---------------------------
9999	J_JAMES	매니저 없음
8888	J%JAMES	매니저 없음
7369	SMITH	매니저 있음
7499	ALLEN	매니저 있음
7521	WARD	매니저 있음
7566	JONES	매니저 있음
7654	MARTIN	매니저 있음
7698	BLAKE	매니저 있음
7782	CLARK	매니저 있음
7839	KING	매니저 없음
7844	TURNER	매니저 있음
7900	JAMES	매니저 있음
7902	FORD	매니저 있음
7934	MILLER	매니저 있음
*/

--오라클에서 빈 문자열('')을 NULL 로 취급하는 것을 
--확인하기 위한 구문 
SELECT e.empno
    ,  e.ename
    ,  nvl2(e.mgr, '매니저 있음','매니저 없음') "매니저 유/무" 
 FROM  emp e;
/*
NULL 값 여부
-----------
IS NULL
*/
-- 입력이 1칸 짜리 문자
SELECT nvl2(' ','IS NOT NULL','IS NULL') "NULL 값 여부"
  FROM dual
;
/*
NULL 값 여부 
-----------
IS NOT NULL
*/

-- NULLIF(expr1, expr2) : 
-- 첫번쨰 식, 두번쨰 식의 값이 동일하면 NULL 을 출력
-- 두 값이 다르면 첫번쨰 식의 값을 출력
SELECT nullif('AAA','bbb') as "NULLIF 결과" ---AAA
  FROM dual
;
/*
NULLIF 결과 
AAA
*/
SELECT nullif('AAA','AAA') as "NULLIF 결과" ---AAA
  FROM dual
;
/*
NULLIF 결과
-----------
(null)
*/
-- 조회된 결과 행이 1개가 존재하고 그값이 NULL 인 상태 
-- 1행이라도 조회가 된 것은 "인출된 모든 행 : 0" 와 다르다는 것에 주의

-----------------3) 날짜함수 : 날짜와 관련된 출력/ 날짜의 더하기 뺴기 등의 연산을 
--                             할 수 있는 기능을 제공 

-- 현재의 시스템 시간을 얻는 sysdate 함수 
SELECT sysdate
  FROM dual
;
/*
SYSDATE
-------
19/05/24 ==>  오라클의 날자 기본 형식 YY/MM/DD
*/

-- TO_CHAR(arg) : arg는 숫자, 날짜 타입의 데이터가 될 수 있다.
--                입력된 arg를 문자타입으로 변경해주는 함수
SELECT to_char(sysdate,'YYYY') "년도" --2019
  FROM dual
;
SELECT to_char(sysdate,'YY') "년도" --19
  FROM dual
;
SELECT to_char(sysdate,'MM') "월"  -- 05월
  FROM dual
;
SELECT to_char(sysdate,'MONTH') "월"  -- 5월
  FROM dual
;
SELECT to_char(sysdate,'MON') "월"  -- 5월
  FROM dual
;
SELECT to_char(sysdate,'DD') "일"  -- 24일
  FROM dual  
;
  SELECT to_char(sysdate,'D') "요일"  -- 6 : 금요일의 숫자는 6
  FROM dual
;
  SELECT to_char(sysdate,'DY') "요일"  -- 금요일
  FROM dual
;

  SELECT to_char(sysdate,'YYYY-MM-DD') "오늘 날짜" -- 2019/05/24  
  FROM dual
;

  SELECT to_char(sysdate,'YY-MON-DD') "오늘 날짜" -- 19/5월 - 24일
  FROM dual
;

  SELECT to_char(sysdate,'YY-MON-DD DY') "오늘 날짜" -- 19-5월 -24 금  
  FROM dual
;

/*
시간 패턴 :
 HH : 시간을 두자리 표기 
 MI : 분을 두자리로 표기 
 SS : 초를 두자리로 표기 
 HH24 : 시간을 24시간 체계로 표기 
 AM : 오전인지 오후인지 표기 
*/

  SELECT to_char(sysdate,'YY-MON-DD DY HH24:MI:SS') "오늘 날짜 시분초" -- 19-5월 -24 금 15:30:22
  FROM dual
;

 SELECT to_char(sysdate,'YY-MON-DD DY AM:HH:MI:SS') "오늘 날짜 시분초" -- 19-5월 -24 금 15:30:22
  FROM dual
;
--19-5월 -24 금 오후:03:42:59

  SELECT to_char(sysdate,'YY-MON-DD DY AM:HH24:MI:SS') "오늘 날짜 시분초" -- 19-5월 -24 금 15:30:22
  FROM dual
;
--19-5월 -24 금 오후:15:42:10 <= AM 패턴문자를 조합하면 오전/오후 구별됨

-- 날짜 값과 숫자의 연산 : +,- 연산자를 사용 
-- 지금으로부터 10일 후 
SELECT sysdate + 10
  FROM dual
;
/*
19/06/03(현재 날짜 : 19/05/24 일떄)
*/
SELECT sysdate - 10
  FROM dual
;
--19/05/14 
SELECT sysdate + 10/24
  FROM dual
;
--19/05/25 10시간후

--10시간 후를 시/분/초 까지 출력
  SELECT to_char(sysdate+ 10/24,'YY-MON-DD DY AM:HH24:MI:SS') "10시간 뒤" -- 19-5월 -25 토 오전:01:47:45
  FROM dual
;

----------------1. MONTHS_BETWEEN(날짜1, 날짜2) : 
--                 두 날짜 사이의 달의 차이 

--각 직원이 입사한 날로부터 현재까지 몇개월을 근무했는지 조회하시오.
SELECT e.empno
     , e.ename
     ,  MONTHS_BETWEEN(sysdate, e.hiredate) "근속 개월 수 " 
  FROM emp e
;
/*
EMPNO,  ENAME,  근속 개월 수 
9999	J_JAMES	
8888	J%JAMES	
7369	SMITH	461.247178166069295101553166069295101553
7499	ALLEN	459.150403972520908004778972520908004779
7521	WARD	459.085887843488649940262843488649940263
7566	JONES	457.731049133811230585424133811230585424
7654	MARTIN	451.892339456391875746714456391875746714
7698	BLAKE	456.763307198327359617682198327359617682
7782	CLARK	455.505242682198327359617682198327359618
7839	KING	450.247178166069295101553166069295101553
7844	TURNER	452.537500746714456391875746714456391876
7900	JAMES	449.698791069295101553166069295101553166
7902	FORD	449.698791069295101553166069295101553166
7934	MILLER	448.053629778972520908004778972520908005
*/

--각 직원의 근속 개월수를 구하되
--소수점 1의 자리까지만 출력하시오.
--이떄, 소수점 2의 자리에서 반올림
SELECT e.empno
     , e.ename
     , ROUND(MONTHS_BETWEEN(sysdate, e.hiredate),1) "근속 개월 수 " 
  FROM emp e
;

---------------2. ADD_MONTHS(날짜, 숫자) : 
--                날짜에 숫자를 더한만큼 후의 날짜를 구함 
SELECT add_months(sysdate, 3)
  FROM dual
;
-- 날짜 + 숫자 : 숫자 만큼의 날 수를 더하여 날짜를 구함 
-- 날짜 + 숫자/24 : 숫자 만큼의 시간을 더하여 날짜를 구함 
-- ADD_MONTHS(날짜, 숫자) : 숫자 만큼의 달을 더하여 날짜를 구함 

----------------3. NEXT_DAY , LAST_DAY
--                 다음 요일에 해당하는 날짜를 구함 
--                 이달의 마지막 날짜를 구함 

-- 현재 날짜에서 돌아오는 수(4)요일의 날짜를 구함 
SELECT next_day(sysdate, 4) "돌아오는 수요일"
  FROM dual
;

SELECT next_day(sysdate, '수요일')"돌아오는 수요일"
  FROM dual
;

SELECT last_day(sysdate)"이 달의 마지막 날"
  FROM dual
;

----------- 4. ROUDN, TRUNC : 날짜에 대한 반올림, 버림 연산 
SELECT round(sysdate) "현재 시간에서 반올림"
  FROM dual
;

-- 문제 : 현재 시간에서 반올림 된 날짜를 시/분/초 까지 출력
SELECT to_char(round(sysdate),'YYYY-MM-DD HH24:MI:SS')
  FROM dual
;

SELECT trunc(sysdate))  "현재 시간에서 시분초 버림" 
 FROM dual
;

SELECT to_char(trunc(sysdate),'YYYY-MM-DD HH24:MI:SS' )  "현재 시간에서 시분초 버림" 
 FROM dual
;