SELECT*
    FROM emp
;

--SCOTT 계정 테이블 조회

SELECT*
    FROM dept
;

--1) emp 테이블에서 job 칼럼을 조회 
SELECT*
    FROM emp
;

--2)emp 중복 제거 
--) 칼럼 조회 
SELECT DISTINCT job
 FROM emp
 ;
 -- 조회된 결과
 -- 이결과 다섯종류의 job이 있다 
 
 /*JOB 
 
 CLERK
 SALESMAN
 ALALIST
 MANAAGER
 PRESIDENT
 /*

