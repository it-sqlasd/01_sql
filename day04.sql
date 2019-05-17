SELECT e.empno
     , e.ename
     , e.sal
  FROM emp e
 WHERE e.sal IN (800,3000,5000)
 ;
 /*
 EMPNO, ENAME,  SAL
 ------------------
 7369	SMITH	800
 7839	KING	5000
 7902	FORD	3000
 */
-----------------------
-- LIKE 연산자  : 유사 값을 검색할 떄 사용.
--       정확한 값을 알지 못할 떄 사용.
-- LIKE 연산자의 패턴 문자 :유사 값 검색을 위해 
--                           연산자와 함께 사용하는 기호 
-- % : 이 기호의 자리에 0자릿수 이상의 모든 문자가 올 수 있음 
-- _ : 이 기호의 자리에 1자리의 모든 문자가 올 수 있음

--26) 이름이 J로 시작하는 직원의
--    사번, 이름 조회 
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename LIKE 'J%'
;
/*
EMPNO,  ENAME
7566	JONES
7900	JAMES
*/

--이름이 M으로 시작하는 직원의 사번, 이름 조회 
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename LIKE 'M%'
;
/*
EMPNO,  ENAME
7654	MARTIN
7934	MILLER
*/

-- 아름에 M이 들어가는 직원의 사번, 이름 조회 
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename LIKE '%M%'
;
/*
EMPNO,  ENAME
7369	SMITH
7654	MARTIN
7900	JAMES
7934	MILLER
*/

--이름의 세번쨰 자리에 M이 들어가는 직원의 사번, 이름 조회 
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename LIKE '__M%' -- 패턴인식문자 _를 두번 사용하여
                           -- M 앞자리를 2글자로 제한  
;
/*
EMPNO,  ENAME
-------------
7900	JAMES
*/

-- 이름의 둘쨰 자리부터 LA가 들어가는 이름을 가진 직원의
-- 사번,이름 조회 

SELECT e.empno
     , e.ename
     
  FROM emp e
 WHERE e.ename LIKE '_LA%'
;
/*
EMPNO,  ENAME
7698	BLAKE
7782	CLARK
*/

-- 다음의 입력을 실행 
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME, JOB) 
VALUES ('9999', 'J_JAMES', 'CLERK')
;
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME, JOB) 
VALUES ('8888', 'J%JAMES', 'CLERK')
;
COMMIT;

-- 이름이 J_로 시작하는 직원의 사번, 이름을 조회 
-- : 조회 하려는 값에 패턴인식 문자(%, _)가 들어있는 데이터는
-- 어떻게 조회할 것인가?
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename LIKE 'J\_%' ESCAPE '\'
;
-- ==> 위처럼 LIKE 조건을 작성하면 J뒤에 적어도 1글자가 있는 
--     이름을 가진 직원이 모두 검색됨. 원하는 결과가 아니다
--     패턴 인식 문자를 조회하려면 ESCAPE 를 사용해야 한다.
--   =>패턴 인식 문자를 무효화하려면 ESCAPE 를 사용해야한다.

SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename LIKE 'J\%%' ESCAPE '\'
;

-- NULL  에 관련된 SQL 연산자 
-- : IS NULL , IS NOT NULL
-- IS NULL : 비교하려 하는 컬럼의 값이 NULL 일 떄 TRUE (참)
--           비교하려 하는 컬럼의 값이 NULL 이 아니면 FLASE (거짓)
-- IS NOT NULL 비교하려 하는 컬럼의 값이 NULL이 아니면 TRUE (참) 
--             비교하려 하는 컬럼의 값이 NULL 일 떄 FALSE (거짓)
-- NULL값을 가진 컬럼은 비교연산자(=, !=, <>) 와 같은 연산이 불가능하므로
-- NULL값 비교를 위한 연산자가 따라 존재함에 주의!

-- col = NULL ==> NULL에 대해서는 동일비교 연산자(=)를 사용 못함.
-- col != NULL
-- col <> NULL ==> NULL에 대해서는 
--                 다름을 비교하는 연산자(!=,<>)를 사용 못함

-- 27)  상사(mgr)가 지정되지 않은 직원의 사번, 이름, 상사사번 (mgr) 조회 
SELECT e.empno
    ,  e.ename
    ,  e.mgr
 FROM  emp e
WHERE  e.mgr = NULL -- NULL 데이터는 비교연산자로 
                    -- 연산할 수 없는 값
;

SELECT e.empno
    ,  e.ename
    ,  e.mgr
 FROM  emp e
WHERE  e.mgr IS NULL -- NULL 데이터는 IS로 비교 
;
/*
EMPNO,  ENAME,   MGR
-----------------
9999	J_JAMES	
8888	J%JAMES	
7839	KING	
*/

SELECT e.empno
    ,  e.ename
    ,  e.mgr
 FROM  emp e
WHERE  e.mgr IS NOT NULL
;
-- e.mgr != NULL / e.mgr <> NULL 구문 오류가 없어도 실행이 되는 것에 주의!
-- 비교 연산자 !=, <> 사용시 실행 결과는
-- 인출된 모든 행 : 0
-- 이런 경우 실행이 되기떄문에 오류를 찾기 어려우므로
-- NULL 데이터를 다룰 떄 항상 주의해야 한다.

/*
EMPNO,  ENAME,   MGR
--------------------
7369	SMITH	7902
7499	ALLEN	7698
7521	WARD	7698
7566	JONES	7839
7654	MARTIN	7698
7698	BLAKE	7839
7782	CLARK	7839
7844	TURNER	7698
7900	JAMES	7698
7902	FORD	7566
7934	MILLER	7782
*/

----------------------
--BETWWN a AND b : 범위 포함 비교 연산자 
-- a <= sal <= b : 이러한 범위 연산과 동일한 결과 

-- 28)급여가 500 ~ 1200 사이인 직원의 
--    사번, 이름 급여 조회 
SELECT e.empno
     , e.ename
     , e.sal
  FROM emp e
 WHERE e.sal BETWEEN 500 AND 1200
;
/*
EMPNO,  ENAME,   SAL
7369	SMITH	800
7900	JAMES	950
*/

-- BETWEEN 500 AND 1200 같은 결과를 내주는 비교연산자 변경 
SELECT e.empno
     , e.ename
     , e.sal
  FROM emp e
 WHERE e.sal <= 1200
   AND e.sal >= 500
;
/*
EMPNO,  ENAME,   SAL
7369	SMITH	800
7900	JAMES	950
*/
---------------------
-- EXISTS 연산자 : 어떤 쿼리(SELECT 구문)을 실행한 결과가 
--                 1행 이상일 때 참으로 판단
--                 인출된 모든 행:0인 경우 거짓으로 판단
--                 따라서 서브쿼리와 함께 사용됨.
-- 29)
--  (1) 급여가 3000이 넘는 직원을 조회 
SELECT e.empno
     , e.ename
     , e.sal
  FROM emp e
 WHERE e.sal > 3000
 ;
 -- 7839	KING	5000
 -- 29-(1) 문제의 결과는 1행이 존재(EXISTS)
 
 --  (2) 급여가 3000이 넘는 직원이 1명이라도 있으면 
 --      화면에 "급여가 3000이 넘는 직원이 존재함"
 --      이라는 메시지를 출력하고 싶다.
 
SELECT '급여가 3000이 넘는 직원이 존재' AS "시스템 메시지"
  FROM dual -- 1행만 데이터가 잇으면 참이다 . 
 WHERE EXISTS (SELECT e.empno
                    , e.ename
                    , e.sal
                 FROM emp e
                WHERE e.sal > 3000)
;
/*
시스템 메시지
-------------------------------
급여가 3000이 넘는 직원이 존재함 
*/

--oracle 에만 존재하는 dual 테이블 
-- : 1행 1열의 데이터가 들어있는 공용 테이블 
-- 1) dual 테이블의 테이블 구조를 확인
DESC dual; 
-- 위의 DESC 는 정렬의 키워드가 아닌 오라클의 명령어 
-- 테이블의 구조를 확인하는 명령
-- Describe 의 약자 
/*
이름    널? 유형          
----- -- ----------- 
DUMMY    VARCHAR2(1) 
*/
SELECT dummy
  FROM dual
;

-- 급여가 10000이 넘는 직원이 없으면 
-- 화면에 "급여가 10000이 넘는 직원이 존재하지않음" 이라고 출력
-- (1)급여가 10000이 넘는 직원의 정보 조회 
SELECT e.empno
     , e.ename
     , e.sal
  FROM emp e
 WHERE e.sal > 10000
 ;
 
 -- (2) 시스템 메시지를 출력할 수 있도록 쿼리 조합 
 SELECT '급여가 10000이 넘는 직원이 존재하지않음' AS "시스템 메시지"
   FROM dual
  WHERE NOT EXISTS  (SELECT e.empno
                           , e.ename
                           , e.sal
                           FROM emp e
                           WHERE e.sal > 10000)
;
/*
시스템 메시지
급여가 10000이 넘는 직원이 존재하지않음
*/