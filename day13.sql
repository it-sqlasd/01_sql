--day 13 

------------------------------------------------
-- 오라클의 특별한 컬럼2가지 
-- : 사용자가 만든 적 없어도 자동으로 제공되는 컬럼

-- 1. ROWID : 물리적으로 디스크에 저장된 위치를 가리키는 값 
--            물리적 위치이므로 한 행당 반드시 유일한 값일 수밖에 없음
--            ORDER BY 절에 의해 변경되지 않는 값 

-- 2. ROWNUM : 조회된 결과의 첫번쨰 행부터 1로 증가하는 값 
-------------------------------------------------------------

--예) emp 테이블의 'SMITH' 를 조회 

SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
;

-- ROWID 를 같이 조회 

SELECT e.rowid
     , e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
;

/*
ROWID,              EMPNO,  ENAME
AAAR9dAAHAAAACvAAA	7369	SMITH
*/

SELECT rowid
     , e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
;

/*
AAAR9dAAHAAAACvAAA	7369	SMITH
*/

SELECT rownum
     , e.empno
     , e.ename
  FROM emp e
;

/*
ROWNUM, EMPNO,  ENAME
1   	7369	SMITH
2	    7499	ALLEN
3	    7521	WARD
4	    7566	JONES
5	    7654	MARTIN
6	    7698	BLAKE
7	    7782	CLARK
8	    7839	KING
9	    7844	TURNER
10	    7900	JAMES
11	    7902	FORD
12	    7934	MILLER
13	    7777	JJ
14	    8888	J_JAMES
*/
-- 2 ename 순으로 오름 차순 정렬 후 rownum 값 확인

SELECT rownum
     , e.empno
     , e.ename
  FROM emp e
 ORDER BY e.ename
;

--ROWNUM 이 ORDER BY 결과에 영향을 안받는 것처럼 보이지만 
--SUB-QUERY 로 사용할떄 영향 받음

SELECT rownum
     , a.empno
     , a.ename
     , a.numrow
  FROM(SELECT rownum AS numrow
            , e.empno
            , e.ename
         FROM emp e
     ORDER BY e.ename) a
;

/*
ROWNUM, EMPNO, ENAME, NUMROW
1	    7499	ALLEN	2
2	    7698	BLAKE	6
3	    7782	CLARK	7
4	    7902	FORD	11
5	    7900	JAMES	10
6	    7777	JJ	13
7	    7566	JONES	4
8	    8888	J_JAMES	14
9	    7839	KING	8
10	    7654	MARTIN	5
11	    7934	MILLER	12
12	    7369	SMITH	1
13	    7844	TURNER	9
14	    7521	WARD	3
*/

--이름에 A가 들어가는 사람들을 조회 (ORDER BY)
SELECT ROWNUM
     , e.ename
  FROM emp e
 WHERE e.ename LIKE '%A%'
;

/*
ROWNUM, ENAME
1	    ALLEN
2	    WARD
3	    MARTIN
4	    BLAKE
5	    CLARK
6	    JAMES
7	    J_JAMES
*/

SELECT ROWNUM
     , e.ename
  FROM emp e
 WHERE e.ename LIKE '%A%'
 ORDER BY e.ename
;
/*
ROWNUM, ENAME
-------------
1   	ALLEN
4   	BLAKE
5   	CLARK
6   	JAMES
7   	J_JAMES
3   	MARTIN
2   	WARD
*/

--이름에 S가 들어가는 사람들을 조회 
-- 이떄 ROWNUM ROWID 를 확인
SELECT ROWNUM
     , e.rowid
     , e.ename
  FROM emp e
 WHERE e.ename LIKE '%S%'
 ORDER BY e.ename
;

/*
3	AAAR9dAAHAAAACvAAJ	JAMES
2	AAAR9dAAHAAAACvAAD	JONES
4	AAAR9dAAHAAAACvAAN	J_JAMES
1	AAAR9dAAHAAAACvAAA	SMITH
*/
--이름에 S가 들어가는 사람들의 조회 결과를 
--SUB-QUERY 로 감쌌을 때의 ROWNUM, ROWID 확인 
SELECT ROWNUM
    , a.rowid
    , a.ename
 FROM (SELECT e.rowid
            , e.ename
         FROM emp e
        WHERE e.ename LIKE '%S%'
        ORDER BY e.ename) a
;
/*
ROWNUM, ROWID,               ENAME
-----------------------------
1	    AAAR9dAAHAAAACvAAJ	JAMES
2	    AAAR9dAAHAAAACvAAD	JONES
3	    AAAR9dAAHAAAACvAAN	J_JAMES
4	    AAAR9dAAHAAAACvAAA	SMITH
*/

-- ROWNUM 으로 할 수 있는 쿼리 
-- emp에서 급여를 가장 많이 받는 상위 5명을 조회하시오.

--1. 급여가 많은 역순 정렬 
SELECT e.empno
     , e.ename
     , e.sal
  FROM emp e
 ORDER BY e.sal DESC
;
/*
7839	KING	5000
7902	FORD	3000
7566	JONES	2975
7698	BLAKE	2850
7782	CLARK	2450
7499	ALLEN	1600
7844	TURNER	1500
7934	MILLER	1300
7521	WARD	1250
8888	J_JAMES	1250
7654	MARTIN	1250
7900	JAMES	950
7777	JJ	    900
7369	SMITH	800
*/
--2. 1의 결과를 SUB_QUERY로 FROM 절에 사용하여 
--   메인 쿼리 ROWNUM 을 같이 조회 
SELECT ROWNUM
     , a.*
  FROM (SELECT e.empno
             , e.ename
             , e.sal
          FROM emp e
         ORDER BY e.sal DESC) a
;
--3. 그 떄 , ROWNUM <=5 조건을 추가
SELECT ROWNUM
     , a.*
  FROM (SELECT e.empno
             , e.ename
             , e.sal
          FROM emp e
         ORDER BY e.sal DESC) a
         WHERE ROWNUM <= 5 
;



---------------------
--DML l 데이터 조작어
---------------------

--1) INSERT : 테이블에 데이터 행 (ROW)을 추가하는 명령

--   MEMBER 테이블에 데이터 추가 진행 

DROP TABLE member;

CREATE TABLE member
( member_id     VARCHAR2(4)   
 ,member_name   VARCHAR2(15)  NOT NULL
 ,phone         VARCHAR2(4)  
 ,reg_date      DATE          DEFAULT sysdate
 ,address       VARCHAR2(30)   
 ,major         VARCHAR2(50)
 ,birth_month   NUMBER(2)
 ,gender        VARCHAR2(1)   
 ,CONSTRAINT PK_MEMBER        PRIMARY KEY (member_id)
 ,CONSTRAINT CK_GENDER        CHECK (gender IN ('F', 'M'))
 ,CONSTRAINT CK_BIRTH         CHECK (birth_month BETWEEN 1 AND 12)
 );
 
 -- 1. INTO 구문에 컬럼이름 생략시 데이터 추가 
 --    : VALUES 절에 반드시 전체 컬럼의 데이터를 순서대로 모두 나열 
 
INSERT INTO MEMBER 
VALUES ('M001', '박성협', '9155', sysdate ,'수원시', '행정', 3, 'M')
;
INSERT INTO MEMBER
VALUES ('M002', '오진오', '1418', sysdate ,'군포시', NULL, NULL, 'M')
;
INSERT INTO MEMBER
VALUES ('M003', '이병현', '0186', sysdate ,NULL,NULL ,3, 'M')
;
INSERT INTO MEMBER
VALUES ('M004', '김문정', NULL, sysdate ,'청주시', '일어', 3, 'F')
;
INSERT INTO MEMBER
VALUES ('M005', '송지환', '0322', sysdate ,'안양시', '제약', 3, NULL)
;
COMMIT;

/*
1 행 이(가) 삽입되었습니다.
1 행 이(가) 삽입되었습니다.
1 행 이(가) 삽입되었습니다.
1 행 이(가) 삽입되었습니다.
1 행 이(가) 삽입되었습니다.

커밋완료
*/

--PK 제약 조건에 위배되는 데이터 추가 시도 : M005 이미 존재 
INSERT INTO MEMBER
VALUES ('M005' , '홍길동' , '0001' , sysdate , '율도국' ,'도술' , 3 , 'M')
;
/*
무결성 제약 조건(SCOTT.PK_MEMBER)에 위배됩니다
*/

--GENDER 컬럼에 CHECK 제약 조건을 위배하는 데이터 추가시도 
--GENDER 컬럼에 F M NULL 외의 값을 추가하면 
INSERT INTO MEMBER
VALUES ('M006' , '홍길동' , '0001' , sysdate , '율도국' ,'도술' , 3 , 'G')
;
/*
ORA-02290: 체크 제약조건(SCOTT.CK_GENDER)이 위배되었습니다
*/

--BIRTH_MONHT 컬럼에 1 ~ 12 외의 숫자값 입력시도 
INSERT INTO MEMBER
VALUES ('M006' , '홍길동' , '0001' , sysdate , '율도국' ,'도술' , 13 , 'G')
;
/*
ORA-02290: 체크 제약조건(SCOTT.CK_BIRTH)이 위배되었습니다
*/

--MEMBER_NAME 에 NULL 입력시도 
INSERT INTO MEMBER
VALUES ('M006' , NULL , '0001' , sysdate , '율도국' ,'도술' , 3 , 'M')
;
/*
오류 보고 -
ORA-01400: NULL을 ("SCOTT"."MEMBER"."MEMBER_NAME") 안에 삽입할 수 없습니다
*/
INSERT INTO MEMBER
VALUES ('M006' , '홍길동' , '0001' , sysdate , '율도국' ,'도술' , 3 , 'M')
;


--2. INTO 절에 컬럼 이름을 명시한 경우의 데이터 추가 
--    : VALUES 절에 INTO 의 순서대로
--      값의 타입, 캣수를 맞추어서 작성 
INSERT INTO MEMBER (member_id, member_name)
VALUES ('M007', '김지원')
;
COMMIT;
/*
1 행 이(가) 삽입되었습니다.

커밋 완료.
*/

INSERT INTO MEMBER (member_id, member_name, gender)
VALUES ('M008', '김지우', 'M')
;
COMMIT;
/*
1 행 이(가) 삽입되었습니다.

커밋 완료.

:결과로 member_id, member_name, reg_date, gender
 컬럼들에 값이 들어간 것 확인
*/

--테이블 정의 순서와 상관없이 INTO절에 컬럼을 나열할 수 있다.
INSERT INTO MEMBER (birth_month, member_name, member_id)
VALUES (7, '유현동', 'M009')
;
COMMIT;
/*
1 행 이(가) 삽입되었습니다.

커밋 완료.
*/

--INTO 절의 컬럼 갯수와 VALUES 절의 값의 개수 불일치 
INSERT INTO MEMBER (member_id, member_name)
VALUES ('M010', '허균', 'M')
;
/*
SQL 오류: ORA-00913: 값의 수가 너무 많습니다
"too many values"
*/
INSERT INTO MEMBER (member_id, member_name,gender)
VALUES ('M010', '허균')
;
/*
SQL 오류: ORA-00947: 값의 수가 충분하지 않습니다
00947. 00000 -  "not enough values"
*/

-- INTO절 VALUES 절 같지만
-- 값의 타입이 일치 하지 않을 떄 
-- 숫자 데이터에 한양이라는 문자를 추가하려는 시도 
INSERT INTO MEMBER (member_id, member_name,birth_month)
VALUES ('M010', '허균', '한양')
;
/*
ORA-01722: 수치가 부적합합니다
*/
INSERT INTO MEMBER (member_id, member_name,reg_date)
VALUES ('M010', '허균', '한양')
;
--ORA-01722: 수치가 부적합합니다

--필수 입력 컬럼을 나열하지 않을 떄 
--member_id : PK , member_name : NOT NULL
INSERT INTO MEMBER (birth_month, address,gender)
VALUES (12, '서귀포시', 'F')
;
/*
오류 보고 -
ORA-01400: NULL을 ("SCOTT"."MEMBER"."MEMBER_ID") 안에 삽입할 수 없습니다
*/

---------------------------------------------------------
--다중 행 입력 : SUB-QUERY 를 사용하여 가능 
INSERT INTO 테이블이름
SELECT 문장; --서브쿼리 

/*
CREATE TABLE 테이블이름 
AS
SELECT 문장;

 : 서브쿼리의 데이터를 복사하면서 새 테이블을 생성 

VS.

INSERT INTO 테이블이름 
SELECT 문장;
 : 이미 만들어진 테이블에 데이터만 복사해서 추가 

*/

--new_member 삭제 
DROP TABLE new_member;
--Table NEW_MEMBER이(가) 삭제되었습니다.

--member 복사해서 테이블 생성 
CREATE TABLE new_member
AS
SELECT m.*
  FROM member m 
 WHERE 1 = 2 
;

--Table NEW_MEMBER이(가) 생성되었습니다.

--다중 행 입력 서브쿼리로 NEW_MEMBER 테이블에 데이터 추가하기 
--이름 가운데 글자가 '지'인 사람들의 정보를 추가 
INSERT INTO new_member
SELECT m.*
  FROM member m
 WHERE m.member_name LIKE '_지_'
;
COMMIT;
/*
3개 행 이(가) 삽입되었습니다.

커밋 완료.
*/
-- 컬럼을 명시한 다중행 입력
INSERT INTO new_member (member_id, member_name, phone)
SELECT m.member_id
     , m.member_name
     , m.phone
  FROM member m
 WHERE m.member_id < 'M004'
;
COMMIT;
/*
3개 행 이(가) 삽입되었습니다.

커밋 완료.
*/

DELETE new_member;
COMMIT;

UPDATE "SCOTT"."MEMBER"
   SET BIRTH_MONTH = '1'
 WHERE MEMBER_ID = 'M002'
; 
UPDATE "SCOTT"."MEMBER"
   SET BIRTH_MONTH = '2'
 WHERE MEMBER_ID = 'M007'
; 
UPDATE "SCOTT"."MEMBER"
   SET BIRTH_MONTH = '1'
 WHERE MEMBER_ID = 'M008'
; 
COMMIT
-----------------------------------

--문제) NEW_MEMBER 테이블에 
--      MEMBER 테이블로부터 데이터를 복사하여 다중행 입력 실시 
--      단, MEMBER 테이블의 데이터에서 BIRTH_MONTH 가 
--      홀수달인 사람들만 조회하시오
INSERT INTO new_member
SELECT m.*
  FROM member m
 WHERE MOD(m.birth_month, 2)  = 1
;
COMMIT;
--8개행 이 삽입되었습니다.

--커밋완료

-------------------------------------
--2) UPDATE : 테이블의 행(레코드)을 수정 
--            WHERE 조건절의 조합에 따라서 

--            1행만 수정하거나 대중행 수정이 가능 
--            다중 행이 수정되는 겨우는 매우 주의가 필요!!

-- UPDATE 구문 구조 
UPDATE 테이블이름 
   SET 컬럼1 = 값1
    [, 컬럼2 = 값2]
    ........
    [, 컬럼n = 값n]
[WHERE 조건]

-- 예 ) 홍길동의 이름을 수정시도 

UPDATE member m --테이블 별칭
  SET m.member_name = '길동이'
WHERE m.member_id ='M006' -- PK로 찾아야 정확히 찾을 수 있다.
;
COMMIT;

/*
1 행 이(가) 업데이트되었습니다.

커밋 완료.
*/

-- 예 ) 김문정 멤버의 전화번호 둿자리 업데이트 
--      초기에 INSERT 시 NULL로 데이터를 받지 않을 경우
--      후에 데이터 수정이 발생할 수 있다.
--      이런 경우 UPDATE 구문으로 처리.

UPDATE member m
   SET m.phone = '1392'
 WHERE m.member_id = 'M004'
;
COMMIT;

/*
1 행 이(가) 업데이트되었습니다.

커밋 완료.
*/

-- 예 ) 유현동 멤버의 전공을 수정 
-- 역문컨 
UPDATE member m
   SET m.major = '역문컨'
-- WHERE m.member_id = 'M009' -- 실수로 WHERE 누락 
;
/*
커밋 완료.

9개 행 이(가) 업데이트되었습니다.
: WHERE 조건절 누락떄문에 모든 행에 대해서 
  major 컬럼이 모두 수정이 일어난 결과
  
  ==> DML 작업 실수 
  -- 직전 COMMIT 작업까지 되돌리는 ROLLBACK 명령으로 
  -- 잘못된 업데이트 되돌리기 
*/

ROLLBACK;

UPDATE member m
   SET m.major = '역문컨'
   WHERE m.member_id = 'M009'
;
-- 1행 이 업데이트 되었습니다.
COMMIT;
-- 커밋완료

--다중 컬럼 업데이트 
--예) 김지우 (M008) 멤버의 전화번호 주소 전공 한번에 업데이트 

-- SET 절에 업데이트 할 컬럼과 값을 나열
UPDATE member m 
   SET m.phone = '4119' 
     , m.address = '아산시'
     , m.major = '일어'
 WHERE m.member_id = 'M008'
;
-- 1 행이 업데이트 되었습니다.
COMMIT;


-- 예 ) '안양시' 에 사는 '송지환' 멤버의 GENDER 값을 수정 
--      WHERE 조건에 주소를 비교하는 구문을 쓰는 경우
UPDATE member m
   SET m.gender= 'M'
 WHERE m.address = '안양시'
 -- WHERE 조건절 누락(X) , WHERE 조건절 문법 오류 (X)
 ;
/*
1 행 이(가) 업데이트되었습니다. 
*/
ROLLBACK;

-- 롤백 완료 ;
-- 위의 실행 결과는 얼핏 정상작동된 것처럼 보이지만 
-- 데이터가 다양해지면 오작동할 수 있다.
-- 따라서 UPDATE 작성시에는 WHERE 조건절 작성시 
-- 주의를 기울여야 함 .

-- 1행을 수정하는 목적이라면 반드시 PK 컬럼으 비교해야한다.
-- PK 컬럼은 전체 행에서 유일하고
-- NOT NULL 이 보장하는 되는 컬럼으로써 
-- 반드시 그행을 찾을 수 있는 값이기 떄문에, PK 사용이 권장됨

-- UPDATE 구문에 SELECT 서브 쿼리를 사용 
-- 예) 김지우 (M008) 멤버의 major 를 
--     오진오 (M002) 멤버의 major 로 수정 

-- 1)  M008 의 MAJOR 를 구하는 SELECT
SELECT m.major
  FROM member m 
 WHERE m.member_id = 'M008'
;

--2 ) M002 멤버의 MAJOR 를 수정하는 UPDATE 구문 
UPDATE member m
   SET m.major = ? 
 WHERE m.member_id = 'M002'
;

--3) (1)의 결과를(2) UPDATE 구문에 적용 
UPDATE member m
   SET m.major = (SELECT m.major
                    FROM member m 
                   WHERE m.member_id = 'M008')
 WHERE m.member_id = 'M002'
;
-- 1 행 이(가) 업데이트되었습니다.
COMMIT;
-- 커밋 완료.

-- 만약 SET 절에 사용하는 서브쿼리의 결과가
-- 정확하게 1행 1열의 1개의 값이 아닌경우 구문 오류

UPDATE member m 
    SET m.major = (SELECT m.major 
                     FROM member m) 
  WHERE m.member_id = 'M002' 
 ; 
 -- ORA-01427: 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다. 
 
UPDATE member m 
          SET m.major = (SELECT m.member_id 
            , m.major 
  FROM member m 
 WHERE m.member_id = 'M008') 
 WHERE m.member_id = 'M002' 
; 
/* 
SQL 오류: ORA-00913: 값의 수가 너무 많습니다 
00913. 00000 -  "too many values" 
*/ 

 
-- UPDATE 시 제약조건 위반하는 경우 
-- 예) M001 의 member_id 수정을 시도 
--     : PK 컬럼값을 중복 값으로 수정하는 경우 
UPDATE member m 
SET m.member_id = 'M002' 
WHERE m.member_id = 'M001' 
;  
-- ORA-00001: 무결성 제약 조건 
-- (SCOTT.PK_MEMBER)에 위배됩니다 

 
-- 예) NOT NULL 인 member_name 에 NULL 데이터로 
--     업데이트를 시도하는 경우 
UPDATE member m 
SET m.member_name = NULL 
WHERE m.member_id = 'M001' 
;  
-- ORA-01407: NULL로  
-- ("SCOTT"."MEMBER"."MEMBER_NAME")을  
-- 업데이트할 수 없습니다 

 
-- 예) M001 데이터에 대해서 
--     birth_month 를 -1 로 수정시도 
UPDATE member m 
SET m.birth_month = -1 
WHERE m.member_id = 'M001' 
;  
-- ORA-02290: 체크 제약조건(SCOTT.CK_BIRTH)이  
 -- 위배되었습니다 

----------------------------------------------------------
--수업중 실습 

-- 1)   PHONE 컬럼이 NULL 인사람들은 
--      일관적으로 '0000'으로 업데이트 
--      PK 걸 필요가 없음 

UPDATE MEMBER M
   SET M.PHONE = '0000'
 WHERE M.phone IS NULL
;
COMMIT;
-- 2)   M001 멤버의 전공을
--      NULL값으로 업데이트

UPDATE MEMBER M
   SET M.MAJOR = NULL
 WHERE m.member_id = 'M001'
;
COMMIT;
-- 3) ADDRESS 컬럼이 NULL 인사람을 
--    일관적으로 '아산시로'
--    PK 걸 필요 없음 
UPDATE MEMBER M
   SET M.ADDRESS = '아산시'
 WHERE M.ADDRESS IS NULL
;
COMMIT;

-- 4) MOO9 멤버의 NULL 데이터를 
--    모두 업데이트
--    PHONE : 3581
--    ADDRESS : 천안시 
--    GENDER : M

UPDATE MEMBER M
   SET M.PHONE = '3581'
     , M.ADDRESS = '천안시'
     , M.GENDER = 'M'
 WHERE M.MEMBER_ID = 'M009' 
;
COMMIT;