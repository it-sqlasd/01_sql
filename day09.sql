--문제 ) 회사에 매니저가 배정된 직원이 몇명인가 
--       별칭 : 상사가 있는 직원의 수
SELECT COUNT(e.mgr)
  FROM emp e
;

-- 문제) 매니저직을 맡고 있는 직원이 몇명인가?
-- 1.    emp 테이블의 mgr 칼럼의 데이터 형태를 파악 
-- 2.    mrg 칼럼의 중복 데이터 제거 
SELECT DISTINCT e.mgr
  FROM emp e
;
/*
MGR
7782
7698
7902
7566
NULL
7839
*/
-- 3.    중복 데이터가 제거된 결과를 카운트 
SELECT COUNT(DISTINCT e.mgr) "매니저 수 "
  FROM emp e
;
/*
매니저 수 
5
*/

--문제) 부서가 배정된 직원이 몇명이나 있는가?
SELECT count(e.deptno) "부서가 배정된 직원" 
  FROM emp e
;
/*
부서가 배정된 직원
------------------
12
*/

-- COUNT(*) 가 아닌 COUNT(expr)을 사용한 경우에는
SELECT e.deptno
  FROM emp e
 WHERE e.deptno IS NOT NULL
;
--을 수행한 결과를 카운트 한 것으로 생각할 수 있음.

--문제 ) 전체인원, 부서 배정인원, 부서 미배정 인원을 구하시오 

SELECT count(*)
     , count(e.deptno)
     , COUNT(*) - COUNT(e.deptno)
  FROM emp e
;


--SUM(expr) : NULL 항목 제외하고 
--            합산 가능한 행을 모두 더한 결과를 출력 
--SALESMAN 들의 수당 총합을 구해보자.
SELECT SUM(e.comm) "수당 총합" 
  FROM emp e
;

SELECT SUM(e.comm) "수당 총합" 
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
/*



300
500

1400



0           


     --> 자동으로 NULL 컬럼 제외 합
*/

-- 수당 총합 결과에 숫자 출력 패턴을 적용 $, 세자리 끊어 읽기 적용 
SELECT TO_CHAR(SUM(e.comm), '$9,999') "수당 총합" 
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
/*
수당 총합
--------
 $2,200
*/

--3) AVG(expr) : NULL 값 제외하고 연산 가능한 항목의 산술 평균을 구함 
--   SALESMAN의 수당 평균을 구해보자.
--   수당 평균 결과에 숫자 출력 패턴 $, 세자리 끊어 읽기 적용

SELECT AVG(e.comm) "수당 평균" 
  FROM emp e
 WHERE e.job = 'SALESMAN'
;

SELECT TO_CHAR(AVG(e.comm), '$9,999') "수당 평균" 
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
/*
수당 총합
--------
   $550
*/

--4) MAX(expr) : expr에 등장한 값 중 최댓값을 구함 
--               expr이 문자인 경우는 알파벳순 뒷쪽에 위치한 글자를
--               최댓값으로 계산
SELECT MAX(e.ename)
  FROM emp e
;
/*
MAX(E.ENAME)
-----------
WARD
*/

SELECT MIN(e.ename) "이름이 가장 앞인 직원"
  FROM emp e
;
/*
이름이 가장 앞인 직원
=====================
ALLEN
*/

---------3. GROUP BY 절의 사용 
-- 문제) 각 부서별 급여의 총합,평균,최대,최소 

--1. 각 부서별로 급여의 총합을 조회하려면 
--   총합 SUM()을 사용 
--   그룹화 기준을 부서번호(deptno)를 사용 
--   GROUP BY 절이 등장해야 함 

-- a) 먼저 emp 테이블에서 급여 총합을 구하는 구문 작성 
SELECT SUM(e.sal) "급여 총합"
  FROM emp e
;

-- b) 부서 번호를 기준으로 그룹화 진행
--    SUM()은 그룹함수다
--    GROUP BY 절을 조합하면 그룹화 가능하다.
--    그룹화를 하려면 기준컬럼이 GROUP BY 절에 등장해야 함.

SELECT e.deptno  부서번호 -- 그룹화 기준컬럼으로 SELECT 절에 등장
     , SUM(e.sal)  "부서 급여 총합" -- 그룹함수가 사용된 컬럼     
  FROM emp e          
 GROUP BY e.deptno -- 그룹화 기준컬럼으로 GROUP BY 절에 등장
 ORDER BY e.deptno -- 부서번호 정렬
;

-- GROUP BY 절에 그룹화 기준 컬럼으로 등장한 컬럼이 아닌것이
-- SELECT 절에 등장하면 오류 , 실행불가


SELECT e.deptno   부서번호 -- 그룹화 기준컬럼으로 SELECT 절에 등장  
     , e.job       --그룹화 기준컬럼이 아닌데 SELECT 절에 등장 -> 오류의 원인
     , SUM(e.sal)  "부서 급여 총합" -- 그룹함수가 사용된 컬럼     
  FROM emp e          
 GROUP BY e.deptno -- 그룹화 기준컬럼으로 GROUP BY 절에 등장
 ORDER BY e.deptno -- 부서번호 정렬
;
/*
ORA-00979: GROUP BY 표현식이 아닙니다.
00979. 00000 -  "not a GROUP BY expression"
*/

--문제) 부서별 급여의 총합, 평균 ,최대 ,최소
SELECT e.deptno  부서번호
     , TO_CHAR(SUM(e.sal), '$9,999')    "부서 급여 총합"
     , TO_CHAR(AVG(e.sal), '$9,999')    "부서 급여 평균"
     , TO_CHAR(MAX(e.sal), '$9,999')    "부서 급여 최대"
     , TO_CHAR(MIN(e.sal), '$9,999')    "부서 급여 최소"
  FROM emp e          
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;
/*
부서번호, 부서 급여 총합, 부서 급여 평균, 부서 급여 최대, 부서 급여 최소
10	     $8,750	         $2,917	            $5,000	      $1,300
20	     $6,775	         $2,258	            $3,000	      $800
30	    $9,400	         $1,567	             $2,850	      $950	
*/

--부서 번호를 삭제한 쿼리
SELECT TO_CHAR(SUM(e.sal), '$9,999')    "부서 급여 총합"
     , TO_CHAR(AVG(e.sal), '$9,999.99')    "부서 급여 평균"
     , TO_CHAR(MAX(e.sal), '$9,999')    "부서 급여 최대"
     , TO_CHAR(MIN(e.sal), '$9,999')    "부서 급여 최소"
  FROM emp e          
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

/*
위의 쿼리는 수행되지만 정확하게 어느부서의 결과인지 알 수 없다는 단점이 존재 
그래서 , GROUP BY 절에 등장하는 기존컬럼은 SELECT 절에 똑같이 등장하는 편이 
결과 해석에 편리하다.

SELECT 절에 나열된 컬럼중에서 그룹함수가 사용되지 않는 컬럼이 없기 떄문에 
위의 쿼리는 수행되는 것이다.
*/

-- 문제 ) 부서별, 직무별 급여의 총합, 평균,최대, 최소 를 구해보자
SELECT e.deptno 부서번호
     , e.job 직무
     , SUM(e.sal) "급여 총합"
     , AVG(e.sal) "급여 평균"
     , MAX(e.sal) "급여 최대"
     , MIN(e.sal) "급여 최소"
  FROM emp e          
 GROUP BY e.deptno , e.job 
 ORDER BY e.deptno 
;
/*
부서번호, 직무,   급여 총합, 급여평균, 급여 최대, 급여 최소
10  	CLERK	    1300	1300	    1300	    1300
10	    MANAGER	    2450	2450	    2450	    2450
10  	PRESIDENT	5000	5000	    5000	    5000
20  	ANALYST	    3000	3000	    3000	    3000
20	    CLERK	    800	    800	        800     	800
20	    MANAGER 	2975	2975	    2975	    2975
30	    CLERK	    950	    950	        950	        950
30	    MANAGER	    2850	2850	    2850	    2850
30	    SALESMAN	5600	1400	    1600	    1250
        CLERK				
*/

--a) GROUP BY 절에 그룹화 기준이 누락된 경우 
SELECT e.deptno 부서번호
     , e.job 직무
     , SUM(e.sal) "급여 총합"
     , AVG(e.sal) "급여 평균"
     , MAX(e.sal) "급여 최대"
     , MIN(e.sal) "급여 최소"
  FROM emp e          
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

--b) SELECT 절에 그룹함수와 일반 컬럼이 섞여 등장
--   GROUP BT 절 전체가 누락된 경우 
SELECT e.deptno 부서번호
     , e.job 직무             -- SELECT 에는 등장 
     , SUM(e.sal) "급여 총합"
     , AVG(e.sal) "급여 평균"
     , MAX(e.sal) "급여 최대"
     , MIN(e.sal) "급여 최소"
  FROM emp e          
-- GROUP BY e.deptno  e.job 
 ORDER BY e.deptno 
;
/*
ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
00937. 00000 -  "not a single-group group function"
*/

-- 문제) 직무(job) 별 급여의 총합, 평균, 최대, 최소를 구해보자 
--       별칭 : 직무, 급여총합, 급여평균, 최대급여 , 최소급여
SELECT e.job 직무              
     , SUM(e.sal) "급여 총합"
     , AVG(e.sal) "급여 평균"
     , MAX(e.sal) "급여 최대"
     , MIN(e.sal) "급여 최소"
  FROM emp e
 GROUP BY e.job  
;

-- 직무가 null 사람들은 직무명 대신 '직무 미배정'으로 출력 
SELECT NVL(e.deptno,  '부서 미배정') 부서번호
     , TO_CHAR(SUM(e.sal), '$9,999')    "부서 급여 총합"
     , TO_CHAR(AVG(e.sal), '$9,999')    "부서 급여 평균"
     , TO_CHAR(MAX(e.sal), '$9,999')    "부서 급여 최대"
     , TO_CHAR(MIN(e.sal), '$9,999')    "부서 급여 최소"
  FROM emp e          
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;
/* deptno 는 숫자 , '부서 미배정은' 문자 데이터이므로 타입 불일치로 
    NVL()아 작동하지 못한다.
ORA-01722: 수치가 부적합합니다
01722. 00000 -  "invalid number"
*/

-- 해결방법 : DEPT 문자화 
SELECT NVL(TO_CHAR(e.deptno,  '부서 미배정') 부서번호
     , TO_CHAR(SUM(e.sal), '$9,999')    "부서 급여 총합"
     , TO_CHAR(AVG(e.sal), '$9,999')    "부서 급여 평균"
     , TO_CHAR(MAX(e.sal), '$9,999')    "부서 급여 최대"
     , TO_CHAR(MIN(e.sal), '$9,999')    "부서 급여 최소"
  FROM emp e          
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

-- 숫자를 문자로 변경 : 결합연산자(||)를 사용 
SELECT NVL(e.deptno || '' ,  '부서 미배정') 부서번호
     , TO_CHAR(SUM(e.sal), '$9,999')    "부서 급여 총합"
     , TO_CHAR(AVG(e.sal), '$9,999')    "부서 급여 평균"
     , TO_CHAR(MAX(e.sal), '$9,999')    "부서 급여 최대"
     , TO_CHAR(MIN(e.sal), '$9,999')    "부서 급여 최소"
  FROM emp e          
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

SELECT DECODE(NVL(e.deptno ,  0), e.deptno, TO_CHAR(e.deptno)
                                , 0       , '부서 미배정')  부서번호
     , TO_CHAR(SUM(e.sal), '$9,999')    "부서 급여 총합"
     , TO_CHAR(AVG(e.sal), '$9,999')    "부서 급여 평균"
     , TO_CHAR(MAX(e.sal), '$9,999')    "부서 급여 최대"
     , TO_CHAR(MIN(e.sal), '$9,999')    "부서 급여 최소"
  FROM emp e          
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

-------------4. HAVING 절의 사용 

-- GROUP BY 결과에 조건을 걸어서 
-- 그 결과를 제한할 목적으로 사용되는 절 .

-- HAVING 절은 WHERE 절과 비슷하지만
-- SELECT 구문의 실행 순서 때문에 
-- GROUP BY 절 보다 먼저 실행되는 WHERE 절로는 
-- GROUP BY 결과를 제한할 수 없다 

-- 따라서 GROUP BY 다음 수행순서를 가지는
-- HAVING 에서 제한한다.

-- 문제) 부셔별 급여 평균이 2000이상인 부서를 조회하여라.

-- a) 우선 부서별 급여 평균을 구한다.
SELECT e.deptno "부서번호"
     , AVG(e.sal) "급여평균"
  FROM emp e
 GROUP BY e.deptno
;

-- b) a의 결과에서 급여 평균이 2000이상인 값만 남긴다.
--    HAVING 으로 결과 제한
SELECT e.deptno "부서번호"
     , AVG(e.sal) "급여평균"
  FROM emp e
 GROUP BY e.deptno
HAVING AVG(e.sal) >= 2000
;
-- 결과 숫자 패턴
SELECT e.deptno "부서번호"
     , TO_CHAR(AVG(e.sal), '$9,999.99') "급여평균"
  FROM emp e
 GROUP BY e.deptno
HAVING AVG(e.sal) >= 2000
;

-- 주의 : HAVING 에는 별칭을 사용할 수 없다.
SELECT e.deptno "부서번호"
     , TO_CHAR(AVG(e.sal), '$9,999.99') "급여평균"
  FROM emp e
 GROUP BY e.deptno
HAVING "급여평균" >= 2000 -- HAVING에 별칭은 사용할 수 없음
;
/*
ORA-00904: "급여평균": 부적합한 식별자
00904. 00000 -  "%s: invalid identifier"
*/

--HAVING 절이 존재하는 경우 SELECT 구문의 실행 순서 정리 
/*
1. FROM     절의 테이블 각 행 모두를 대상으로 
2. WHERE    절의 조건에 맞는 행만 선택하고 
3. GROUP BY 절에 나온 컬럼, 식(함수 식)으로 그룹화 진행
4. HAVING   절의 조건에 만족시키는 그룹행만 선택
5.          4까지 선택된 그룹정보를 가진 행에 대해서 
6.SELECT    절에 명시된 컬럼, 식(함수 식)만 출력
7.ORDER BY  가 있다면 정렬 조건에 맞추어 최종 정렬하여 결과 출력
*/

-- 수업중 실습 

 
 -- 1. 매니저별, 부하직원의 수를 구하고, 많은 순으로 정렬 
 --   : mgr 컬럼이 그룹화 기준 컬럼 
 SELECT e.deptno "부서번호"
      , COUNT(e.deptno) "부하직원"
   FROM emp e
  GROUP BY e.deptno
 ORDER BY "부하직원"
;

-- 2.1 부서별 인원을 구하고, 인원수 많은 순으로 정렬 
 --    : deptno 컬럼이 그룹화 기준 컬럼 540
SELECT e.deptno "부서번호"
      , COUNT(e.deptno) "부하직원"
   FROM emp e
  GROUP BY e.deptno
 ORDER BY "부하직원";

 -- 2.2 부서 배치 미배정 인원 처리 
 SELECT e.deptno "부서 배치 미배정" 
   FROM emp e
  WHERE e.deptno is null 
;
 
 -- 3.1 직무별 급여 평균 구하고, 급여평균 높은 순으로 정렬 
 --   : job 이 그룹화 기준 컬럼 
 SELECT e.job "직무별"
      , AVG(e.sal) "급여평균"
   FROM emp e
  GROUP BY e.job, e.sal
  ORDER BY "급여평균" DESC   
 ;
 
-- 3.2 job 이 null 인 데이터 처리 
 SELECT NVL(TO_CHAR(e.job), '부서 미배정') "직무별"
      , AVG(e.sal) "급여평균"
   FROM emp e
  GROUP BY e.job, e.sal
  ORDER BY "급여평균" DESC   
 ;

 

 
-- 4. 직무별 급여 총합 구하고, 총합 높은 순으로 정렬 
--   : job 이 그룹화 기준 컬럼 
 SELECT e.job
      , SUM(e.sal) "급여 합"
   FROM emp e
  GROUP BY e.job, e.sal
  ORDER BY "급여 합" DESC   
 ;


-- 5. 급여의 앞단위가 1000미만, 1000, 2000, 3000, 5000 별로 인원수를 구하시오 
--    급여 단위 오름차순으로 정렬 
 SELECT TO_CHAR(e.hiredate, 'YY') "입사년도" 
      , COUNT(*) "인원"
   FROM emp e
 GROUP BY TO_CHAR(e.hiredate, 'YY')
;

 

 
-- 6. 직무별 급여 합의 단위를 구하고, 급여 합의 단위가 큰 순으로 정렬 
 SELECT e.job
      , TO_CHAR(SUM(e.sal), '$9,999') "급여 합"
   FROM emp e
  GROUP BY e.job, e.sal
  ORDER BY "급여 합" DESC   
 ;

-- 7. 직무별 급여 평균이 2000이하인 경우를 구하고 평균이 높은 순으로 정렬 
 SELECT e.job
      , TO_CHAR(SUM(e.sal), '$9,999') "급여 합"
      , avg(e.sal) "평균"
   FROM emp e
 HAVING AVG(e.sal) < 2000
  GROUP BY e.job, e.sal
  ORDER BY "평균" DESC   
 ;
 -- 8. 년도별 입사 인원을 구하시오 
SELECT sum(count(e.hiredate)) "81년도"
  FROM emp e
 GROUP BY e.hiredate
 HAVING e.hiredate LIKE '81%'
    
 ;
 
 
 
 SELECT e.hiredate 
   FROM emp e
;



 SELECT TO_CHAR(e.hiredate, 'YY')  
   FROM emp e
;

 SELECT TO_CHAR(e.hiredate, 'YY') "입사년도" 
      , COUNT(*) "인원"
   FROM emp e
 GROUP BY TO_CHAR(e.hiredate, 'YY')
;

-- 9. 년도별, 월별 입사 인원을 구하시오 
--  : (1) hiredate를 활용 
--    (2) hiredate 에서 년도, 월을 추출
--    (3) 추출된 두 값을 그룹화 기준으로 사용 
--    (4) 입시 인원을 구하라 하였으므로 COUNT(*) 그룹함수 사용 
-- a) 년도 추출 : TO_CHAR(e.hiredate, 'YYYY')
--      월 추출 : TO_CHAR(e.hiredate, 'MM')
-- b) 두 가지 기준으로 그룹화 적용 

SELECT TO_CHAR(e.hiredate, 'YYYYY') "입사 년도"
     , TO_CHAR(e.hiredate, 'MM') "입사 월"
     , COUNT(*) "입사 명"
  FROM emp e
 GROUP BY  TO_CHAR(e.hiredate, 'YYYY'), TO_CHAR(e.hiredate, 'MM')
 ORDER BY "입사 년도", "입사 월"
;

--C ) 년도별 ,월별 입사 인원의 출력 형태를 가로표 형태로 변환 

-- a) 년도 추출 : TO_CHAR(e.hiredate, 'YYYY')
--      월 추출 : TO_CHAR(e.hiredate, 'MM')

-- : hiredate 에서 추출한 월의 값이 01이 나올 떄 
--   그 떄의 행의 갯수를 1월 에서 카운트count(*)
--   이 과정을 12월 까지 반복 

SELECT e.empno
     , e.ename 
     , TO_CHAR(e.hiredate, 'YYYY') "입사 년도"
     , TO_CHAR(e.hiredate, 'MM') "입사 월"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '01', 1, 0) "1월"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '02', 1, 0) "2월"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '03', 1, 0) "3월"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '04', 1, 0) "4월"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '05', 1, 0) "5월"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '06', 1, 0) "6월"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '07', 1, 0) "7월"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '08', 1, 0) "8월"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '09', 1, 0) "9월"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '10', 1, 0) "10월"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '11', 1, 0) "11월"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '12', 1, 0) "12월"
  FROM emp e
 ORDER BY "입사 년도"
;

-- 그룹화 기준 칼럼을 "입사 년도"로 잡는다. 
-- 각 행의 1월 ~ 12월 에 1이 등장하는 갯수를 세어야 하므로 COUNT () 사용 
SELECT TO_CHAR(e.hiredate, 'YYYY') "입사 년도"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '01', 1)) "1월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '02', 1)) "2월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '03', 1)) "3월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '04', 1)) "4월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '05', 1)) "5월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '06', 1)) "6월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '07', 1)) "7월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '08', 1)) "8월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '09', 1)) "9월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '10', 1)) "10월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '11', 1)) "11월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '12', 1)) "12월"
  FROM emp e
 GROUP BY TO_CHAR(e.hiredate, 'YYYY')
 ORDER BY "입사 년도"
;

-- 월별 총 입사 인원의 합을 가로로 출력
-- 그룹화 시준 컬럼이 필요 없음 
SELECT '인원 명' AS "입사 월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '01', 1)) "1월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '02', 1)) "2월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '03', 1)) "3월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '04', 1)) "4월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '05', 1)) "5월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '06', 1)) "6월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '07', 1)) "7월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '08', 1)) "8월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '09', 1)) "9월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '10', 1)) "10월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '11', 1)) "11월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '12', 1)) "12월"
  FROM emp e
;
