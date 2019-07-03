-- day14 : dml 지속

--------------------------
--3 ) DELETE : 테이블에서 행단위로 데이터를 삭제 

--DELETE 구문 구조 
DELETE [FROM] 테이블이름 [테이블별칭]
 WHERE 문장
;

-- 1 . WHERE 조건이 있는 DELETE 구문 
-- 삭제 전 커밋 
COMMIT;

--member 테이블에서 gender 'F'인 데이터를 삭제 
DELETE member m 
 WHERE m.gender = 'R'
;
-- 0개 행이 삭제되었습니다.
-- 이 결과는 구문에 오류는 없기떄문에 정상실행은 된다 .
-- 하지만 지워진 행이 0개인 이유는
-- 단지 ,  gender 컬럼에 R값이 있는 행이 없기 떄문에 
-- 정상적인 실행 결과가 맞다 


DELETE member m 
 WHERE m.gender = 'F'
;
/*
1 행 이(가) 삭제되었습니다.
WHERE 조건을 만족하는 모든행이 대하여 삭제 
GENDER 가 'F'인 행이 하나 삭제 
하지만 특정 행 삭제시 PK가 아닌 조건으로 삭제하는것을 주의
*/

ROLLBACK;

--만약 'M004' 행을 삭제하는 것이 목적이면 PK로 삭제해야함 

DELETE member m 
 WHERE m.member_id = 'M004'
;
--1 행 이(가) 삭제되었습니다.
COMMIT;
--커밋 완료.

--2. WHERE 조건이 없는 DELETE 구문
--   WHERE 조건이 아얘 누락된 경우 전체 행을 삭제 
DELETE member;
--8개 행 이(가) 삭제되었습니다.
ROLLBACK;



-- 3. DELETE 의 WHERE 에 서브쿼리 조합 

--예 ) 주소가 '아산시'인 사람을 모두 삭제 
DELETE member m 
 WHERE m.address = '아산시'
 ;
 
 --(1) 주소가 '아산시'인 사람으 조회 
 SELECT m.member_id
   FROM member m
  WHERE m.address = '아산시'
;

--(2)
DELETE member m 
 WHERE m.member_id = ?
;

-- (3) 2번의 메인 쿼리에 1번의 서브쿼리 조합 
DELETE member m
 WHERE m.member_id IN ( SELECT m.member_id
                         FROM member m
                         WHERE m.address = '아산시')
 ;                        
 
 --4개행을 삭제하였습니다.
ROLLBACK;

-------------------------------------------------
--DELETE VS TRUNCATE 
/*
  1. TRUNCATE 는 DDL 에 속하는 명령어
     따라서 ROLLBACK 지점은 생성하지 않음 
     한 번 실행된 DDL은 되돌릴 수 없음 
     
  2. TRUNCATE 는 DDL 이기 떄문에 
     WHERE 조건절 조합이 불가능하므로 
     특정 데이터를 선별하여 삭제하는 것이 불가능 
*/

-- NEW_MEMBER 를 TRUNCATE로 잘라보자 

-- TRUNCATE 실행 후에 되돌아갈 COMMIT 지점 생성 
COMMIT;

-- NEW_MEMBER
TRUNCATE TABLE NEW_MEMBER;
--Table NEW_MEMBER이(가) 잘렸습니다.
ROLLBACK;
--롤백 완료.

--롤백이 성공인 듯 보이지만 
--TRUNCATE 명령은 실행과 동시에 자동커밋 이루어짐으로 
--TRUNCATE 이 후 시점이 롤백 가능한 커밋지점으로 잡힘.

---------------------------------------------------
--TCL : Transaction Control Language
-- 1) COMMIT
-- 2) ROLLBACK

-- 3) SAVEPOINT
-- 1. member 테이블에 1행을 추가 
-- 1.1 INSERT 전에 커밋지점 생성
COMMIT;

--1.2 DML : INSERT 작업 실행 
INSERT INTO MEMBER M (M.MEMBER_ID, M.MEMBER_NAME)
VALUES ('M010', '홍길동')
;
--1행 이(가) 삽입되었습니다.

---1.3 1헹 추가까지 중간 상태 저장
SAVEPOINT do_insert;
--Savepoint이(가) 생성되었습니다.

-- 2.  홍길동의 주소를 업데이트 
-- 2.1 DML : UPDATE 작업 실행 
UPDATE member m 
  SET m.address = '율도국'
WHERE m.member_id = 'M010'
;
--1 행 이(가) 업데이트되었습니다.

--2.2 주소 수정까지 중간 저장
SAVEPOINT do_update_addr;
--Savepoint이(가) 생성되었습니다.

--3. 홍길동의 전화번호 업데이트
UPDATE member m
  SET M.PHONE = '9999'
WHERE M.member_id = 'M010'
;

-- 1 행이 업데이트 되었습니다.

----3.2 전화번호 수정까지 중간 저장 
SAVEPOINT do_update_phone
--Savepoint 생성되었습니다.

UPDATE member m 
   SET m.gender  = 'F'
 WHERE m.member_id = 'M010'
;

/*
1 행 이(가) 업데이트되었습니다.
--4.2 성별 수정까지 중간 저장
*/
SAVEPOINT do_update_gender;

--Savepoint이(가) 생성되었습니다.

-- 여기까지 하나의 트랜잭으로 4개의 DML 쿼리 묶여 있는상황 
-- 아직 COMMIT 되지 않았으므로 트랜잭션의 정상종료가 아닌 상황 
---------------------------------------------------------------
--홍길동의 데이터 ROLLBACK 시나리오 

--1. 주소 수정까지 맞는데, 전화번호, 성별을 잘못 수정했다고 착각 
--   : 사실 성별만 잘못 수정됨
--   : 되돌아갈 SAVEPOINT = do_update_addr
ROLLBACK TO do_update_addr;
--롤백 완료.

--2. 주소 전화번호 수정까지는 맞았고 성별수정만 잘못됨 
ROLLBACK TO do_update_phone;
/*
ORA-01086: 'DO_UPDATE_PHONE' 저장점이 이 세션에 설정되지 않았거나 부적합합니다.
01086. 00000 -  "savepoint '%s' never established in this session or is invalid"

 SAVEPOINT 에는 순서가 존재가 있기떄문에 
 do_update_addr 이 do_update_phone 보다 앞서 생성된 지점이기 떄문에 
 여기까지 ROLLBACK TO 가 일어나면 
 그 후 생성된 SAVEPOINT 는 모두 삭제 됨.
*/

--3. 2번의 ROLLBACK TO 수행 후에 되돌릴 수 있는 지점 
ROLLBACK TO do_insert; -- insert 후 시점
ROLLBACK;              -- 최초 시작 시점 

-----------------------------------------------------
-- 기타 객체 : SEQUENCE , INDEX , VIEW

-- SEQUENCE : 기본키 (PK) 등으로 사용되는 일련번호 생성 객체 

-- 1. 시작번호 : 1, 최대 : 30 , 사이클이 없는 시퀀스 생성
CREATE SEQUENCE seq_member_id
START WITH 1
MAXVALUE 30
NOCYCLE
;

-- Sequence SEQ_MEMBER_ID이(가) 생성되었습니다.

-- 시퀸스는 객체이기 떄문에 DDL 생성한다.
-- 시퀸스가 생성되면 시스템 카탈로그에 저장된다.
-- USER_SEQUENCES 
SELECT s.sequence_name
     , s.min_value
     , s.max_value
     , s.cycle_flag
     , s.increment_by
  FROM user_sequences s
 WHERE s.sequence_name = 'SEQ_MEMBER_ID'
;
/*
SEQUENCE_   NAME,  MIN_  VALUE,  MAX_VALUE, CYCLE_FLAG, INCREMENT_BY
SEQ_MEMBER_ ID	             1	      30           	N        	1
*/

--만약 시퀸스 생성을 한번 더 시도하면

/*
ORA-00955: 기존의 객체가 이름을 사용하고 있습니다.
00955. 00000 -  "name is already used by an existing object"
*/

--------------------------------------------------------
/*
메타 데이터를 저장하는 유저 딕셔너리 
-----------------------------------
무결성 제약조건 : user_constraints
시퀸스 생성정보 : user_sequences
테이블 생성정보 : user_tables
인덱스 생성정보 : user_indexes
객체들 생성정보 : user_objects
-----------------------------------
*/

--2. 시퀸스 사용 
--  : 생성된 시퀸스는 SELECT 구문에서 사용가능 

-- (1)NEXTVAL : 시퀸스의 다음 번호를 얻어냄 
--              CREATE 되고 나서 반드시 최초 1번 
--              NEXTVAL 호출이 되어야 생성이 시작 

--     사용법 : 시퀸스이름.NEXTVAL 
SELECT SEQ_MEMBER_ID.NEXTVAL
  FROM dual
;
-- MAXVALUE 이상 생성하면 다음의 오류가 발생 
/*
ORA-08004: 시퀀스 SEQ_MEMBER_ID.NEXTVAL exceeds MAXVALUE은 사례로 될 수 없습니다
08004. 00000 -  "sequence %s.NEXTVAL %s %sVALUE and cannot be instantiated"
*/

-- (2) CURRVAL : 시퀸스에서 현재 생성된 번호를 확인 
--               시퀸스 생성 후 최초 1번의 NEXTVAL 호출이 없으면            
--               현재의 번호를 얻을 수 없음.
--               즉, 시퀸스는 아직 비활성화 상태 


--   사용법 : 시퀸스 이름. CURRVAL
SELECT SEQ_MEMBER_ID.CURRVAL
  FROM dual
;
/*
ORA-08002 : 시퀸스 SEQ_MEMBER_ID.CURRVAL 은 
            이 세션에서는 정의 되어 있지 않습니다.
*/

-- 3. 시퀸스 수정 : ALTER SEQUECNE
-- 생성한 SEQ_MEMBER_ID 의 MAXVALUE 설정을 NOMAXVALUE로 변경

ALTER SEQUENCE SEQ_MEMBER_ID
NOMAXVALUE
;
--Sequence SEQ_MEMBER_ID이(가) 변경되었습니다.

-- SEQ_MEMBER_ID 의 INCREAMENT 를 10으로 변경하려면 
ALTER SEQUENCE SEQ_MEMBER_ID
INCREMENT BY 10
;
--Sequence SEQ_MEMBER_ID가 변경되었습니다.
ALTER SEQUENCE SEQ_MEMBER_ID
CYCLE
;
--Sequence SEQ_MEMBER_ID이(가) 변경되었습니다.

-- 4. 시퀸스 삭제 : DROP SEQUENCE 
DROP SEQUENCE seq_member_id;
--Sequence SEQ_MEMBER_ID이(가) 삭제되었습니다.

SELECT SEQ_MEMBER_ID.CURRVAL
  FROM dual
;
/*
ORA-02289: 시퀀스가 존재하지 않습니다.
02289. 00000 -  "sequence does not exist"
*/

-------------------------------------------
--new_member 테이블에 데이터 입력시 시퀸스 활용 
--new_member의 id 컬럼에 사용할 시퀸스 신규 생성 
/*
 시퀸스 이름 : seq_new_member_id
 시작 번호   : START WITH 1
 증가  값    : INCREMENT BY 1
 최대 번호   : NOMAXVALUE
 사이클 여부 : NOCYCLE
*/

CREATE SEQUENCE seq_new_member_id
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
;
--Sequence SEQ_NEW_MEMBER_ID이(가) 생성되었습니다.

--new_member 의 member_id 를 M001,M002... 증가하는 형태로 조합
SELECT 'M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL,3.0) AS member_id
  FROM dual;
;

INSERT INTO new_member (member_id, member_name)
VALUES ('M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL,3.0)        
        ,'홍길동')
;

INSERT INTO new_member (member_id, member_name)
VALUES ('M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL,3.0)        
        ,'허균')
;
COMMIT;

------------------------------------------------------------------------------
--INDEX : 데이터의 검색(조회)시 일정한 검색 속도 보장을 위해 
--        DBMS가 관리하는 객체 

-- 1. user_indexes 테이블에서 이미 존재하는 INDEX 조회 
SELECT i.index_name
     , i.index_type
     , i.table_name
     , i.include_column
  FROM user_indexes i
;

/*
INDEX_NAME,      INDEX_TYPE,    TABLE_NAME, INCLUDE_COLUMN
PK_DEPT	         NORMAL     	DEPT	
PK_EMP	N        ORMAL	        EMP	
PK_MAIN3	     NORMAL     	MAIN_TABLE3	
UQ_NICKNAME3	 NORMAL     	MAIN_TABLE3	
PK_MAIN4	     NORMAL	        MAIN_TABLE4	
UQ_NICKNAME4	 NORMAL     	MAIN_TABLE4	
PK_MEMBER	     NORMAL	        MEMBER	
PK_SUB4	         NORMAL	        SUB_TABLE4	
*/

--2. 테이블의 주키 (PRIMARY KEY) 컬럼에 대해서는 DBMS가
--   자동으로 인덱스 생성함을 알 수 있음.
--   UNIQUE 에 대해서도 인덱스를 자동으로 생성함
--   한번 인덱스가 생성된 컬럼에 대해서는 중복 생성 불가능 


--  예) MEMBER 테이블의 MEMBER_ID 컬럼에 대해 인덱스 생성시도 
CREATE INDEX idx_member_id
ON member (member_id)
;
/*
ORA-01408: 열 목록에는 이미 인덱스가 작성되어 있습니다
01408. 00000 -  "such column list already indexed"
==> PK_MEMBER 라는 이름과 다른 IDX_MEMBER_ID로 생성 시도해도 
    같은 컬럼에 대해서는 인덱스가 두개 생성되지 않음.
    
*/

-- 3. 복사 테이블 new_member 에는 PK가 없기 떄문에 인덱스도 없는 상태 
-- (1) new_member 의 member_id 컬럼에 인덱스 생성
CREATE INDEX idx_new_member_id
ON new_member (member_id)
;

--Index IDX_NEW_MEMBER_ID이(가) 생성되었습니다.

DROP INDEX idx_new_member_id;

--Index IDX_NEW_MEMBER_ID이(가) 삭제되었습니다.

CREATE INDEX idx_new_member_id
ON new_member (member_id DESC)
;
--Index IDX_NEW_MEMBER_ID이(가) 생성되었습니다.

--DESC 인덱스 확인 후 DROP
DROP INDEX idx_new_member_id;
--Index IDX_NEW_MEMBER_ID이(가) 삭제되었습니다.

--인덱스 대상 컬럼의 값이 UNIQUE 함이 확실하다면
--UNIQUE INDEX 로 생성가능
CREATE UNIQUE INDEX idx_new_member_id
ON new_member (member_id DESC)
;
--INDEX IDX_NEW_MEMBER_ID이(가) 생성되었습니다.


SELECT i.index_name
     , i.index_type
     , i.table_name
     , i.include_column
  FROM user_indexes i
;
--INDEX 가 SELECT 에 사용될 떄 
--빠른 검색을 위해서 명시적으로 SELECT 에 사용하는 경우 존재 
--HINT 절을 SELECT 에 사용한다.

