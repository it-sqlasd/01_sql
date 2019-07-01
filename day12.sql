--day 12 : DDL (Date Definition Language)
--         ������ ���Ǿ� 

--1. ���̺��� �����ϴ� ��ɾ� 
--2. DBMS�� OBJECT(��ü) �� ����/ �ν��ϴ� ����� 
--   ����, ����, ���� �ϴ� ��ɾ�

--���� CREATE 
--���� ALTER
--���� DROP

-- vs. DML (Date Manipulation Language) ������ ���۾� 
-- ����  INSERT
-- ����  UPDATE
-- ����  DELETE

----------------------------------------------------------------
/* DDL ������ ���� 

   CREATE | ALTER | DROP {������ ��ü�� Ÿ�Ը�}
   
   DBMS�� OBJECT(��ü)�� ���� 
   SHEMA, DOMAIN, TABLE, VIEW, INDEX, SEQUENCE, USER, DATEBASE
   
*/

--CREATE TABLE ���� ���� 
CREATE TABLE  ���̺��̸� 
( �÷�1�̸� ������Ÿ��[(����)] [DEFAULT �⺻��] [�÷��� �������]
[ ,�÷�2�̸� ������Ÿ��[(����)] [DEFAULT �⺻��] [�÷��� �������]]
.....
[ ,�÷�N�̸� ������Ÿ��[(����)] [DEFAULT �⺻��] [�÷��� �������]]
);

/*-----------------
  �÷��� ������� 
 ------------------
 1.PRIMARY KEY : �� �÷��� �ԷµǴ� ���� �ߺ����� �ʰ� 
                 �� ���� �ĺ��� �� �ִ� ������ �����ؾ� �ϸ� 
                 NULL ������ �Է��� �Ұ����� ���̾�� �Ѵ�.
 
 2.FOREIGN KEY : �ַ� JOIN�� ���Ǵ� ������������ 
                 �ٸ� ���̺��� PRIMARY KEY �� ���Ǿ��� ���� 
                 �����ؾ߸� �Ѵ�.
                 
 3.UNIQUE      : �� �÷��� �ԷµǴ� ���� �ߺ����� ������ �����ؾ� �Ѵ�.
                 NULL ������ �Է��� �����ϴ�.
                 ==>������ NULL(���ų�) �Ǵ� 
                    NULL�� �ƴϸ� �ݵ�� ������ ���̾�� �Ѵ�.
                    
 4.NOT FULL    :  �� �÷��� �Էµȴ� ���� �ߺ��� ��������� 
                  NULL ���´� ���� �ʵ��� �����Ѵ�.
                  
 => PK : UNIQUE + NOT NULL ���յ� ���¶�� ���� �� �� �ִ�.                 

*/

-- ��) û���� ���� �����ο� ������ ������ ���̺��� ���� 
/*
    ���̺� �̸� : member 
    1.������̵�         : member_id    : ���� : VARCHAR2 :    PK
    2.��� �̸�          : member_name  : ���� : VARCGAR2 :    NOT NULL
    3.��ȭ��ȣ �x�ڸ�    : phone        : ���� : VARCGAR2
    4.�ý��� ������      : reg_date     : ��¥ : DATE
    5.��� ��(���̸�)    : address      : ���� : VARCGAR2
    6.�����ϴ� ����      : like_number  : ���� : NUMBER
    7.����               : major        : ���� : VARCGAR2
*/

--1. ���̺� ���� ���� : member 
CREATE TABLE member
( member_id     VARCHAR2(4)   PRIMARY KEY
 ,member_name   VARCHAR2(15)  NOT NULL
 ,phone         VARCHAR2(4)   -- NULL ����Ϸ��� ���������� �Ⱦ��� �˴ϴ�.
 ,reg_date      DATE          DEFAULT sysdate
 ,address       VARCHAR2(30)   
 ,like_number   NUMBER
 ,major         VARCHAR2(50)
 );
 
 --2. ���̺� ���� ���� 
 DROP TABLE ���̺��̸�;
 
 DROP TABLE member;
 --Table MEMBER��(��) �����Ǿ����ϴ�.
 
 --3. ���̺� ���� ���� 
 /*----------------------------
   ���� ����
   ----------------------------
   1. �÷��� �߰� : ADD
   2. �÷��� ���� : MODIFY
   3. �÷��� ���� : DROP COLUMN
   ----------------------------
 */
ALTER TABLE ���̺��̸� {ADD | MODIFY | DROP COLUMN} ....; 
-- ��) ������ member ���̺� �÷� 2���� �߰� 
-- ��� �� : birth_month  : NUMBER
-- ����    : gender       : VARCHAR2(1) : F, M  �� ���� �� �ϳ��� �Է� ���� 

-- 1) ADD
--member ���̺� ���� �� �Ʒ� ���� ���� 
ALTER TABLE member ADD
(birth_month NUMBER
,gender      VARCHAR2(1) CHECK (gender IN ('F', 'M'))
);

/*
Table MEMBER��(��) ����Ǿ����ϴ�.
*/

-- 2) MODIFY
-- ��)��� �� �÷��� ����2 �ڸ������� �����ϵ��� ���� 
ALTER TABLE ���̺��̸� MODIFY �÷��̸� ������Ÿ��(ũ��);
ALTER TABLE member MODIFY birth_month NUMBER(2);
--Table MEMBER��(��) ����Ǿ����ϴ�.

-- 3) DROP COLUMN
-- ��) ������ ���̺� member���� like_number �÷��� ���� 
ALTER TABLE ���̺��̸� DROP COLUMN �÷��̸�;
ALTER TABLE member DROP COLUMN like_number;

--Table MEMBER��(��) ����Ǿ����ϴ�.

--------------------------------------------------
--���� ����� member ���̺� �������� 

CREATE TABLE member
( member_id     VARCHAR2(4)   PRIMARY KEY
 ,member_name   VARCHAR2(15)  NOT NULL
 ,phone         VARCHAR2(4)   -- NULL ����Ϸ��� ���������� �Ⱦ��� �˴ϴ�.
 ,reg_date      DATE          DEFAULT sysdate
 ,address       VARCHAR2(30)   
 ,like_number   NUMBER
 ,major         VARCHAR2(50)
 ,birth_month   NUMBER(2)
 ,gender        VARCHAR2(1)   CHECK (gender IN ('F', 'M'))
 );
 
 -- ���� �ܼ�ȭ�� ���̺� ���� ���� 
 -- ���������� �� �÷� �ڿ� �ٷ� �������� �̸� ���� ���� 
 
 --�������ǿ� �̸��� �ο��ؼ� ���� : 
 --�÷��� ���ǰ� ���� �� �������� ���Ǹ� ���Ƽ� �ۼ� 
 
 --���̺� ���� 
 DROP TABLE member;
 --Table MEMBER��(��) �����Ǿ����ϴ�.
 --�������� �̸��� �־� member ���̺� ���� 
 CREATE TABLE member
( member_id     VARCHAR2(4)   
 ,member_name   VARCHAR2(15)  NOT NULL
 ,phone         VARCHAR2(4)  
 ,reg_date      DATE          DEFAULT sysdate
 ,address       VARCHAR2(30)   
 ,major         VARCHAR2(50)
 ,birth_month   NUMBER(2)
 ,gender        VARCHAR2(1)  
 --,CONSTRAINT ���������̸� ��������Ÿ�� (�������� ������ �÷�)
 ,CONSTRAINT pk_member         PRIMARY KEY (member_id)
 ,CONSTRAINT ck_member_gender  CHECK       (gender IN ('M', 'F'))
 );
 -- Table MEMBER��(��) �����Ǿ����ϴ�.
 
 -- ���̺� ���� �� DDL �� ������ ������ �ý��� īŻ�α׿� �����.
 -- user_tables, user_constraints
 -- �� ���� �ý��� īŻ�α� ���̺� ��ȸ 
 -- 1) �� ���̺��� ���� (�÷� �̸�) ��ȸ 
 DESC user_tables;
 /*
 TABLE_NAME                NOT NULL VARCHAR2(128)  
 */
 SELECT t.table_name
   FROM user_tables t
;
/*
TABLE_NAME
------------
DEPT
EMP
BONUS
SALGRADE
MEMBER
*/

-- DROP TABLE member;

 DESC user_constraints;
 /*
�̸�                  ������
OWNER                  VARCHAR2(128)  
CONSTRAINT_NAME        VARCHAR2(128)  
CONSTRAINT_TYPE        VARCHAR2(1)    
TABLE_NAME             VARCHAR2(128) 
 */
 
 SELECT c.constraint_name
      , c.constraint_type
      , c.table_name
   FROM user_constraints c
;
/*
FK_DEPTNO	        R	EMP
PK_DEPT         	P	DEPT
PK_EMP	            P	EMP
CK_MEMBER_GENDER	C	MEMBER
PK_MEMBER	        P	MEMBER
SYS_C007510     	C	MEMBER
*/
--MEMBER ���̺��� �������Ǹ� Ȯ�� 
 SELECT c.constraint_name
      , c.constraint_type
      , c.table_name
   FROM user_constraints c
  WHERE c.table_name = 'MEMBER' 
;

--user_objects : ���� ��밡 ������ �ִ� object���� ������ ����Ǵ� 
--               �ý��� īŻ�α� ���̺� 
DESC user_objects;
/*
OBJECT_NAME          VARCHAR2(128) 
SUBOBJECT_NAME       VARCHAR2(128) 
OBJECT_ID            NUMBER        
DATA_OBJECT_ID       NUMBER        
OBJECT_TYPE          VARCHAR2(23)  
*/
SELECT o.object_name
     , o.object_id
     , o.object_type
  FROM user_objects o
;
/*
DEPT	    73559	TABLE
PK_DEPT 	73560	INDEX
PK_EMP	    73566	INDEX
EMP	        73565	TABLE
BONUS	    73567	TABLE
SALGRADE	73568	TABLE
PK_MEMBER	74533	INDEX
MEMBER	    74532	TABLE
*/

--���̺� ���� ����� �̹� �����ϴ� ���̺�κ��� ���� ����
--���̺� ���� ���� ���� ���� 
CREATE TABLE ���̺��̸� 
AS 
SELECT �÷��̸�...
  FROM ���������̺�
 WHERE �׻� ������ �Ǵ� ���� 
;

-- �� �ռ� ������ member ���̺��� ���� : new_member
CREATE TABLE new_member
AS
SELECT m.*
  FROM member m
 WHERE 1 = 2 --�׻� ������ �Ǵ� ���� 
;
--PK ������ ������� �ʰ� ���̺� ����(��ȸ�� �÷���) �����

/*
Table NEW_MEMBER��(��) �����Ǿ����ϴ�.
new_member ���̺� ���� ��ȸ 
*/
DESC new_member;
/*
MEMBER_ID            VARCHAR2(4)  
MEMBER_NAME NOT NULL VARCHAR2(15) 
PHONE                VARCHAR2(4)  
REG_DATE             DATE         
ADDRESS              VARCHAR2(30) 
LIKE_NUMBER          NUMBER       
MAJOR                VARCHAR2(50) 
BIRTH_MONTH          NUMBER(2)    
GENDER               VARCHAR2(1) 
*/
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M001', '�ڼ���', '9155', '������', '����', '3', 'M'); 
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M002', '������', '1418', '������', '�Ͼ�', '1', 'M'); 
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M003', '�̺���', '0186', 'õ�Ƚ�', '�İ�', '3', 'M'); 
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M004', '�蹮��', '1392', 'û�ֽ�', '�Ͼ�', '3', 'F'); 
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M005', '����ȯ', '0322', '�Ⱦ��', '����', '3', 'F'); 

CREATE TABLE march_member
AS
SELECT m.*
  FROM member m
 WHERE m.birth_month = 3 
;

--Table MARCH_MEMBER��(��) �����Ǿ����ϴ�.

-- �����Ͽ� ���̺� ������ ���� �� �� �ִ� ������ �ָ� 
-- �ش� ������ �����ϴ� ���� �����ͱ��� ����Ǹ鼭 ���̺� ���� 

--�׻� ���� �Ǵ� ������ �ָ� ��� �����͸� �����ϸ鼭 ���̺� ���� 
CREATE TABLE full_member 
AS
SELECT m.*
  FROM member m 
 WHERE  1 = 1 
 ;
 -- Table FULL_MEMBER��(��) �����Ǿ����ϴ�

 DROP TABLE full_member;
 CREATE TABLE full_member
 AS
 SELECT m.*
   FROM member m
;
 -- WHERE �������� �����ϸ� 
 -- �׻� ���� ����� �����ϹǷ� ��� �����Ͱ� ����Ǹ� �� ���̺� ����
 
 -------------------------------------------------------------------
 -- ���̺� ����(ALTER) ���ǻ��� 
 
 -- 1) �÷��� ������ ���� �� 
 --    : ��� ���濡 �����ο� 
 --      ������ Ÿ�Ժ���, ������ ũ�⺯�濡 ��� �����ο�
 -- 
 -- 2) �÷��� �����Ͱ� ���� �� 
 --    : �����Ͱ� �ҽǵǸ� �ȵǹǷ� ���濡 ������ ���� 
 --      Ÿ�� ������ ���� Ÿ�Գ������� ���� 
 --      ���� Ÿ�԰��� CHAR -> VARCHAR2 ���� ���� 
 
 --      ũ�� ������ ���� Ȥ�� Ŀ���� �������θ� ���� 
 --      ���� Ÿ���� ũ�� ������ ���е��� Ŀ���� �������θ� ����

-- ��) MARCH_MEMBER ���̺���
--     ������ Ÿ���� ũ�⸦ NUMBER(1) �� ���̸� 
ALTER TABLE MARCH_MEMBER MODIFY (BIRTH_MONTH NUMBER(1));
/*
ORA-01440: ���� �Ǵ� �ڸ����� ����� ���� ��� �־�� �մϴ�
01440. 00000 -  "column to be modified must be empty to decrease precision or scale"
*/
--     ���� �������� ���е��� �����ϴ� ������ �����ϸ� 
--     2 - > 10�ڸ�, ���� �Ҽ��� 2�ڸ� 

ALTER TABLE MARCH_MEMBER MODIFY (BIRTH_MONTH NUMBER(10,2));
--Table MARCH_MEMBER��(��) ����Ǿ����ϴ�.

--���� �������� BIRTH_MONTH �÷��� ���� �����ͷ� ���� 

ALTER TABLE MARCH_MEMBER MODIFY (BIRTH_MONTH VARCHAR2(1));
/*
ORA-01439: ������ ������ ������ ���� ��� �־�� �մϴ�
01439. 00000 -  "column to be modified must be empty to change datatype"
*/

--MARCH_MEMBER ���̺��� ��� �࿡ ���ؼ� 
--BIRH_MONTH �÷��� ���� NULL �����ͷ� �����ϴ� ���
UPDATE "SCOTT"."MARCH_MEMBER"  
   SET BIRTH_MONTH = ''  
 ; 
 COMMIT; 

/*

6�� �� ��(��) ������Ʈ�Ǿ����ϴ�.
*/
--�����Ͱ� ���� �÷����� ���� �� 
--VARCHAR2(2)���� �÷����� ����
ALTER TABLE MARCH_MEMBER
MODIFY (BIRTH_MONTH VARCHAR2(2))
;

/*
Table MARCH_MEMBER��(��) ����Ǿ����ϴ�.
*/
--NUMBER(1) ���� 1�ڸ� �÷����� ���� 
ALTER TABLE MARCH_MEMBER
MODIFY (BIRTH_MONTH VARCHAR2(1))
;
/*
Table MARCH_MEMBER��(��) ����Ǿ����ϴ�.
*/
-------------------------------------------------------------------
 
 -- 3) �⺻ ��(DEFAULT) ������ ���� 
---------------------------------------------------------------- 
-- 3) �⺻ ��(DEFAULT) ������ ���� ���� ������ ���� ��. 

 
-- ��) 3�� ���� ����� ������ MARCH_MEMBER ���̺��� �����غ���. 
--   : BIRTH_MONTH �÷��� ���� �׻� 3 ���� �����Ǿ �� �� ����. 

 
-- a) 
-- MARCH_MEMBER ���̺�  
-- BIRTH_MONTH �÷��� ���� ���� ��� ���� 1�� �߰� 
INSERT INTO "SCOTT"."MARCH_MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, GENDER)  
VALUES ('M006', '�Կ���', '0437', '������', '�İ�', 'F'); 
COMMIT; 

 
-- b) a�� ��� ���� �߰� �� DEFAULT ���� �߰� 
ALTER TABLE march_member  
MODIFY (BIRTH_MONTH DEFAULT 3); 
-- Table MARCH_MEMBER��(��) ����Ǿ����ϴ�. 

 
-- c) MARCH_MEMBER ���̺� DEFAULT ���� �߰� �� 
--    �� ����� �߰� 
INSERT INTO "SCOTT"."MARCH_MEMBER" (MEMBER_ID, MEMBER_NAME, ADDRESS, MAJOR, GENDER)  
VALUES ('M007', 'ȫ�浿', '������', '����', 'M'); 
COMMIT; 

-------------------------------------------------------------------
/*
   MAIN_TABLE
   ID           VARCHAR2(10)        PRIMARY KEY
   NICKNAME     VARCHAR2(30)        UNIQUE
   REG_DATE     DATE                DEFAULT SYSDATE
   GENDER       VARCHAR2(1)         CHECK (GENDER IN ('M', 'F'))
   MESSAGE      VARCHAR2(300)
   -----------------------------------------------------------------
   
   SUB_TABLE
   --------------------------------------------------------------
   ID           VARCHAR2(10)    REFERENCES MAIN_TABLE(ID)    
                                FK FROM MAIN_TABLE
  ,HOBBY        VARCHAR2(200)
   BIRTH_YEAR   NUMBER(4)
   --------------------------------------------------------------
*/
--1 �÷� ������ �� ���� ���� �̸� ���� �ٷ� ���� 
;
DROP TABLE main_table1l;

CREATE TABLE main_table1
(   ID           VARCHAR2(10)        PRIMARY KEY
,   NICKNAME     VARCHAR2(30)        UNIQUE
,   REG_DATE     DATE                DEFAULT SYSDATE
,   GENDER       VARCHAR2(1)         CHECK (GENDER IN ('M', 'F'))
,   MESSAGE      VARCHAR2(300)
);

DROP TABLE SUB_TABLE1;

CREATE TABLE SUB_TABLE1
( ID         VARCHAR2(10)      REFERENCES MAIN_TABLE1(ID)
, HOBBY      VARCHAR2(200)
, BIRTH_YEAR NUMBER(4)
);

--2. �÷� ������ ��, ���� ���� �̸��� �ָ� ���� 

DROP TABLE main_table12;

CREATE TABLE main_table2
(   ID           VARCHAR2(10)        CONSTRAINT PK_MAIN PRIMARY KEY
,   NICKNAME     VARCHAR2(30)        CONSTRAINT UQ_NICKNAME UNIQUE
,   REG_DATE     DATE                DEFAULT SYSDATE
,   GENDER       VARCHAR2(1)         CONSTRAINT CK_GENDER CHECK (GENDER IN ('M', 'F'))
,   MESSAGE      VARCHAR2(300)
);

DROP TABLE SUB_TABLE2;

CREATE TABLE SUB_TABLE2
( ID         VARCHAR2(10)      CONSTRAINT FK_SUB REFERENCES MAIN_TABLE2(ID)
, HOBBY      VARCHAR2(200)
, BIRTH_YEAR NUMBER(4)
);

-- 3. �÷� ���� �� ���� ���� ���� ���� 

DROP TABLE main_table13;

CREATE TABLE main_table3
(  ID            VARCHAR2(10)       
,   NICKNAME     VARCHAR2(30)       
,   REG_DATE     DATE                DEFAULT SYSDATE
,   GENDER       VARCHAR2(1)        
,   MESSAGE      VARCHAR2(300)
,   CONSTRAINT   PK_MAIN3            PRIMARY KEY(ID)
,   CONSTRAINT   UQ_NICKNAME3        UNIQUE (NICKNAME)    
,   CONSTRAINT   CK_GENDER3          CHECK (GENDER IN ('M', 'F'))
); 

DROP TABLE SUB_TABLE3;

CREATE TABLE SUB_TABLE3
( ID         VARCHAR2(10)     
, HOBBY      VARCHAR2(200)
, BIRTH_YEAR NUMBER(4)
, CONSTRAINT FK_SUB3 FOREIGN KEY(ID) REFERENCES MAIN_TABLE3 (ID)
-- SUB_TABLE3 �� ��� PRIMARY KEY�� ID, BIRTH_YEAR �� ����Ű�� ���� 
-- ����Ű�� PK�� �������� ���� �ݵ�� �������� �߰��θ� �������� 
, CONSTRAINT PK_SUB3 PRIMARY KEY (ID, BIRTH_YEAR)
);


