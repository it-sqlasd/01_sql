--day 13 

------------------------------------------------
-- ����Ŭ�� Ư���� �÷�2���� 
-- : ����ڰ� ���� �� ��� �ڵ����� �����Ǵ� �÷�

-- 1. ROWID : ���������� ��ũ�� ����� ��ġ�� ����Ű�� �� 
--            ������ ��ġ�̹Ƿ� �� ��� �ݵ�� ������ ���� ���ۿ� ����
--            ORDER BY ���� ���� ������� �ʴ� �� 

-- 2. ROWNUM : ��ȸ�� ����� ù���� ����� 1�� �����ϴ� �� 
-------------------------------------------------------------

--��) emp ���̺��� 'SMITH' �� ��ȸ 

SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
;

-- ROWID �� ���� ��ȸ 

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
-- 2 ename ������ ���� ���� ���� �� rownum �� Ȯ��

SELECT rownum
     , e.empno
     , e.ename
  FROM emp e
 ORDER BY e.ename
;

--ROWNUM �� ORDER BY ����� ������ �ȹ޴� ��ó�� �������� 
--SUB-QUERY �� ����ҋ� ���� ����

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

--�̸��� A�� ���� ������� ��ȸ (ORDER BY)
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

--�̸��� S�� ���� ������� ��ȸ 
-- �̋� ROWNUM ROWID �� Ȯ��
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
--�̸��� S�� ���� ������� ��ȸ ����� 
--SUB-QUERY �� ������ ���� ROWNUM, ROWID Ȯ�� 
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

-- ROWNUM ���� �� �� �ִ� ���� 
-- emp���� �޿��� ���� ���� �޴� ���� 5���� ��ȸ�Ͻÿ�.

--1. �޿��� ���� ���� ���� 
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
--2. 1�� ����� SUB_QUERY�� FROM ���� ����Ͽ� 
--   ���� ���� ROWNUM �� ���� ��ȸ 
SELECT ROWNUM
     , a.*
  FROM (SELECT e.empno
             , e.ename
             , e.sal
          FROM emp e
         ORDER BY e.sal DESC) a
;
--3. �� �� , ROWNUM <=5 ������ �߰�
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
--DML l ������ ���۾�
---------------------

--1) INSERT : ���̺� ������ �� (ROW)�� �߰��ϴ� ���

--   MEMBER ���̺� ������ �߰� ���� 

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
 
 -- 1. INTO ������ �÷��̸� ������ ������ �߰� 
 --    : VALUES ���� �ݵ�� ��ü �÷��� �����͸� ������� ��� ���� 
 
INSERT INTO MEMBER 
VALUES ('M001', '�ڼ���', '9155', sysdate ,'������', '����', 3, 'M')
;
INSERT INTO MEMBER
VALUES ('M002', '������', '1418', sysdate ,'������', NULL, NULL, 'M')
;
INSERT INTO MEMBER
VALUES ('M003', '�̺���', '0186', sysdate ,NULL,NULL ,3, 'M')
;
INSERT INTO MEMBER
VALUES ('M004', '�蹮��', NULL, sysdate ,'û�ֽ�', '�Ͼ�', 3, 'F')
;
INSERT INTO MEMBER
VALUES ('M005', '����ȯ', '0322', sysdate ,'�Ⱦ��', '����', 3, NULL)
;
COMMIT;

/*
1 �� ��(��) ���ԵǾ����ϴ�.
1 �� ��(��) ���ԵǾ����ϴ�.
1 �� ��(��) ���ԵǾ����ϴ�.
1 �� ��(��) ���ԵǾ����ϴ�.
1 �� ��(��) ���ԵǾ����ϴ�.

Ŀ�ԿϷ�
*/

--PK ���� ���ǿ� ����Ǵ� ������ �߰� �õ� : M005 �̹� ���� 
INSERT INTO MEMBER
VALUES ('M005' , 'ȫ�浿' , '0001' , sysdate , '������' ,'����' , 3 , 'M')
;
/*
���Ἲ ���� ����(SCOTT.PK_MEMBER)�� ����˴ϴ�
*/

--GENDER �÷��� CHECK ���� ������ �����ϴ� ������ �߰��õ� 
--GENDER �÷��� F M NULL ���� ���� �߰��ϸ� 
INSERT INTO MEMBER
VALUES ('M006' , 'ȫ�浿' , '0001' , sysdate , '������' ,'����' , 3 , 'G')
;
/*
ORA-02290: üũ ��������(SCOTT.CK_GENDER)�� ����Ǿ����ϴ�
*/

--BIRTH_MONHT �÷��� 1 ~ 12 ���� ���ڰ� �Է½õ� 
INSERT INTO MEMBER
VALUES ('M006' , 'ȫ�浿' , '0001' , sysdate , '������' ,'����' , 13 , 'G')
;
/*
ORA-02290: üũ ��������(SCOTT.CK_BIRTH)�� ����Ǿ����ϴ�
*/

--MEMBER_NAME �� NULL �Է½õ� 
INSERT INTO MEMBER
VALUES ('M006' , NULL , '0001' , sysdate , '������' ,'����' , 3 , 'M')
;
/*
���� ���� -
ORA-01400: NULL�� ("SCOTT"."MEMBER"."MEMBER_NAME") �ȿ� ������ �� �����ϴ�
*/
INSERT INTO MEMBER
VALUES ('M006' , 'ȫ�浿' , '0001' , sysdate , '������' ,'����' , 3 , 'M')
;


--2. INTO ���� �÷� �̸��� ����� ����� ������ �߰� 
--    : VALUES ���� INTO �� �������
--      ���� Ÿ��, Ĺ���� ���߾ �ۼ� 
INSERT INTO MEMBER (member_id, member_name)
VALUES ('M007', '������')
;
COMMIT;
/*
1 �� ��(��) ���ԵǾ����ϴ�.

Ŀ�� �Ϸ�.
*/

INSERT INTO MEMBER (member_id, member_name, gender)
VALUES ('M008', '������', 'M')
;
COMMIT;
/*
1 �� ��(��) ���ԵǾ����ϴ�.

Ŀ�� �Ϸ�.

:����� member_id, member_name, reg_date, gender
 �÷��鿡 ���� �� �� Ȯ��
*/

--���̺� ���� ������ ������� INTO���� �÷��� ������ �� �ִ�.
INSERT INTO MEMBER (birth_month, member_name, member_id)
VALUES (7, '������', 'M009')
;
COMMIT;
/*
1 �� ��(��) ���ԵǾ����ϴ�.

Ŀ�� �Ϸ�.
*/

--INTO ���� �÷� ������ VALUES ���� ���� ���� ����ġ 
INSERT INTO MEMBER (member_id, member_name)
VALUES ('M010', '���', 'M')
;
/*
SQL ����: ORA-00913: ���� ���� �ʹ� �����ϴ�
"too many values"
*/
INSERT INTO MEMBER (member_id, member_name,gender)
VALUES ('M010', '���')
;
/*
SQL ����: ORA-00947: ���� ���� ������� �ʽ��ϴ�
00947. 00000 -  "not enough values"
*/

-- INTO�� VALUES �� ������
-- ���� Ÿ���� ��ġ ���� ���� �� 
-- ���� �����Ϳ� �Ѿ��̶�� ���ڸ� �߰��Ϸ��� �õ� 
INSERT INTO MEMBER (member_id, member_name,birth_month)
VALUES ('M010', '���', '�Ѿ�')
;
/*
ORA-01722: ��ġ�� �������մϴ�
*/
INSERT INTO MEMBER (member_id, member_name,reg_date)
VALUES ('M010', '���', '�Ѿ�')
;
--ORA-01722: ��ġ�� �������մϴ�

--�ʼ� �Է� �÷��� �������� ���� �� 
--member_id : PK , member_name : NOT NULL
INSERT INTO MEMBER (birth_month, address,gender)
VALUES (12, '��������', 'F')
;
/*
���� ���� -
ORA-01400: NULL�� ("SCOTT"."MEMBER"."MEMBER_ID") �ȿ� ������ �� �����ϴ�
*/

---------------------------------------------------------
--���� �� �Է� : SUB-QUERY �� ����Ͽ� ���� 
INSERT INTO ���̺��̸�
SELECT ����; --�������� 

/*
CREATE TABLE ���̺��̸� 
AS
SELECT ����;

 : ���������� �����͸� �����ϸ鼭 �� ���̺��� ���� 

VS.

INSERT INTO ���̺��̸� 
SELECT ����;
 : �̹� ������� ���̺� �����͸� �����ؼ� �߰� 

*/

--new_member ���� 
DROP TABLE new_member;
--Table NEW_MEMBER��(��) �����Ǿ����ϴ�.

--member �����ؼ� ���̺� ���� 
CREATE TABLE new_member
AS
SELECT m.*
  FROM member m 
 WHERE 1 = 2 
;

--Table NEW_MEMBER��(��) �����Ǿ����ϴ�.

--���� �� �Է� ���������� NEW_MEMBER ���̺� ������ �߰��ϱ� 
--�̸� ��� ���ڰ� '��'�� ������� ������ �߰� 
INSERT INTO new_member
SELECT m.*
  FROM member m
 WHERE m.member_name LIKE '_��_'
;
COMMIT;
/*
3�� �� ��(��) ���ԵǾ����ϴ�.

Ŀ�� �Ϸ�.
*/
-- �÷��� ����� ������ �Է�
INSERT INTO new_member (member_id, member_name, phone)
SELECT m.member_id
     , m.member_name
     , m.phone
  FROM member m
 WHERE m.member_id < 'M004'
;
COMMIT;
/*
3�� �� ��(��) ���ԵǾ����ϴ�.

Ŀ�� �Ϸ�.
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

--����) NEW_MEMBER ���̺� 
--      MEMBER ���̺�κ��� �����͸� �����Ͽ� ������ �Է� �ǽ� 
--      ��, MEMBER ���̺��� �����Ϳ��� BIRTH_MONTH �� 
--      Ȧ������ ����鸸 ��ȸ�Ͻÿ�
INSERT INTO new_member
SELECT m.*
  FROM member m
 WHERE MOD(m.birth_month, 2)  = 1
;
COMMIT;
--8���� �� ���ԵǾ����ϴ�.

--Ŀ�ԿϷ�

-------------------------------------
--2) UPDATE : ���̺��� ��(���ڵ�)�� ���� 
--            WHERE �������� ���տ� ���� 

--            1�ุ �����ϰų� ������ ������ ���� 
--            ���� ���� �����Ǵ� �ܿ�� �ſ� ���ǰ� �ʿ�!!

-- UPDATE ���� ���� 
UPDATE ���̺��̸� 
   SET �÷�1 = ��1
    [, �÷�2 = ��2]
    ........
    [, �÷�n = ��n]
[WHERE ����]

-- �� ) ȫ�浿�� �̸��� �����õ� 

UPDATE member m --���̺� ��Ī
  SET m.member_name = '�浿��'
WHERE m.member_id ='M006' -- PK�� ã�ƾ� ��Ȯ�� ã�� �� �ִ�.
;
COMMIT;

/*
1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

Ŀ�� �Ϸ�.
*/

-- �� ) �蹮�� ����� ��ȭ��ȣ �x�ڸ� ������Ʈ 
--      �ʱ⿡ INSERT �� NULL�� �����͸� ���� ���� ���
--      �Ŀ� ������ ������ �߻��� �� �ִ�.
--      �̷� ��� UPDATE �������� ó��.

UPDATE member m
   SET m.phone = '1392'
 WHERE m.member_id = 'M004'
;
COMMIT;

/*
1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

Ŀ�� �Ϸ�.
*/

-- �� ) ������ ����� ������ ���� 
-- ������ 
UPDATE member m
   SET m.major = '������'
-- WHERE m.member_id = 'M009' -- �Ǽ��� WHERE ���� 
;
/*
Ŀ�� �Ϸ�.

9�� �� ��(��) ������Ʈ�Ǿ����ϴ�.
: WHERE ������ ���􋚹��� ��� �࿡ ���ؼ� 
  major �÷��� ��� ������ �Ͼ ���
  
  ==> DML �۾� �Ǽ� 
  -- ���� COMMIT �۾����� �ǵ����� ROLLBACK ������� 
  -- �߸��� ������Ʈ �ǵ����� 
*/

ROLLBACK;

UPDATE member m
   SET m.major = '������'
   WHERE m.member_id = 'M009'
;
-- 1�� �� ������Ʈ �Ǿ����ϴ�.
COMMIT;
-- Ŀ�ԿϷ�

--���� �÷� ������Ʈ 
--��) ������ (M008) ����� ��ȭ��ȣ �ּ� ���� �ѹ��� ������Ʈ 

-- SET ���� ������Ʈ �� �÷��� ���� ����
UPDATE member m 
   SET m.phone = '4119' 
     , m.address = '�ƻ��'
     , m.major = '�Ͼ�'
 WHERE m.member_id = 'M008'
;
-- 1 ���� ������Ʈ �Ǿ����ϴ�.
COMMIT;


-- �� ) '�Ⱦ��' �� ��� '����ȯ' ����� GENDER ���� ���� 
--      WHERE ���ǿ� �ּҸ� ���ϴ� ������ ���� ���
UPDATE member m
   SET m.gender= 'M'
 WHERE m.address = '�Ⱦ��'
 -- WHERE ������ ����(X) , WHERE ������ ���� ���� (X)
 ;
/*
1 �� ��(��) ������Ʈ�Ǿ����ϴ�. 
*/
ROLLBACK;

-- �ѹ� �Ϸ� ;
-- ���� ���� ����� ���� �����۵��� ��ó�� �������� 
-- �����Ͱ� �پ������� ���۵��� �� �ִ�.
-- ���� UPDATE �ۼ��ÿ��� WHERE ������ �ۼ��� 
-- ���Ǹ� ��￩�� �� .

-- 1���� �����ϴ� �����̶�� �ݵ�� PK �÷��� ���ؾ��Ѵ�.
-- PK �÷��� ��ü �࿡�� �����ϰ�
-- NOT NULL �� �����ϴ� �Ǵ� �÷����ν� 
-- �ݵ�� ������ ã�� �� �ִ� ���̱� ������, PK ����� �����

-- UPDATE ������ SELECT ���� ������ ��� 
-- ��) ������ (M008) ����� major �� 
--     ������ (M002) ����� major �� ���� 

-- 1)  M008 �� MAJOR �� ���ϴ� SELECT
SELECT m.major
  FROM member m 
 WHERE m.member_id = 'M008'
;

--2 ) M002 ����� MAJOR �� �����ϴ� UPDATE ���� 
UPDATE member m
   SET m.major = ? 
 WHERE m.member_id = 'M002'
;

--3) (1)�� �����(2) UPDATE ������ ���� 
UPDATE member m
   SET m.major = (SELECT m.major
                    FROM member m 
                   WHERE m.member_id = 'M008')
 WHERE m.member_id = 'M002'
;
-- 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
COMMIT;
-- Ŀ�� �Ϸ�.

-- ���� SET ���� ����ϴ� ���������� �����
-- ��Ȯ�ϰ� 1�� 1���� 1���� ���� �ƴѰ�� ���� ����

UPDATE member m 
    SET m.major = (SELECT m.major 
                     FROM member m) 
  WHERE m.member_id = 'M002' 
 ; 
 -- ORA-01427: ���� �� ���� ���ǿ� 2�� �̻��� ���� ���ϵǾ����ϴ�. 
 
UPDATE member m 
          SET m.major = (SELECT m.member_id 
            , m.major 
  FROM member m 
 WHERE m.member_id = 'M008') 
 WHERE m.member_id = 'M002' 
; 
/* 
SQL ����: ORA-00913: ���� ���� �ʹ� �����ϴ� 
00913. 00000 -  "too many values" 
*/ 

 
-- UPDATE �� �������� �����ϴ� ��� 
-- ��) M001 �� member_id ������ �õ� 
--     : PK �÷����� �ߺ� ������ �����ϴ� ��� 
UPDATE member m 
SET m.member_id = 'M002' 
WHERE m.member_id = 'M001' 
;  
-- ORA-00001: ���Ἲ ���� ���� 
-- (SCOTT.PK_MEMBER)�� ����˴ϴ� 

 
-- ��) NOT NULL �� member_name �� NULL �����ͷ� 
--     ������Ʈ�� �õ��ϴ� ��� 
UPDATE member m 
SET m.member_name = NULL 
WHERE m.member_id = 'M001' 
;  
-- ORA-01407: NULL��  
-- ("SCOTT"."MEMBER"."MEMBER_NAME")��  
-- ������Ʈ�� �� �����ϴ� 

 
-- ��) M001 �����Ϳ� ���ؼ� 
--     birth_month �� -1 �� �����õ� 
UPDATE member m 
SET m.birth_month = -1 
WHERE m.member_id = 'M001' 
;  
-- ORA-02290: üũ ��������(SCOTT.CK_BIRTH)��  
 -- ����Ǿ����ϴ� 

----------------------------------------------------------
--������ �ǽ� 

-- 1)   PHONE �÷��� NULL �λ������ 
--      �ϰ������� '0000'���� ������Ʈ 
--      PK �� �ʿ䰡 ���� 

UPDATE MEMBER M
   SET M.PHONE = '0000'
 WHERE M.phone IS NULL
;
COMMIT;
-- 2)   M001 ����� ������
--      NULL������ ������Ʈ

UPDATE MEMBER M
   SET M.MAJOR = NULL
 WHERE m.member_id = 'M001'
;
COMMIT;
-- 3) ADDRESS �÷��� NULL �λ���� 
--    �ϰ������� '�ƻ�÷�'
--    PK �� �ʿ� ���� 
UPDATE MEMBER M
   SET M.ADDRESS = '�ƻ��'
 WHERE M.ADDRESS IS NULL
;
COMMIT;

-- 4) MOO9 ����� NULL �����͸� 
--    ��� ������Ʈ
--    PHONE : 3581
--    ADDRESS : õ�Ƚ� 
--    GENDER : M

UPDATE MEMBER M
   SET M.PHONE = '3581'
     , M.ADDRESS = 'õ�Ƚ�'
     , M.GENDER = 'M'
 WHERE M.MEMBER_ID = 'M009' 
;
COMMIT;