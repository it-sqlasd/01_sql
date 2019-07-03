-- day14 view

-----------------------------------------
-- VIEW : �������� �����ϴ� ���� ���̺�

-- SCOTT �� �� ���� ���� �ֱ� 
-- 1. SYS ���� 
CONN sys as sysdba;

-- 2. SCOTT ������ VIEW ���� ���� ���� 
-- (1) ���� �� 
-- (2) sys ������ �ٸ� ����� 
-- (3) SCOTT ���� ������ Ŭ��
-- (4) ����� ����
-- (5) �ý��� ���� ��
-- (6) CREATE VIEW ������ �ο��� üũ�ڽ� ���� - > ���� 

GRANT CREATE VIEW TO SCOTT;
--Grant��(��) �����߽��ϴ�.

-- 3. SCOTT ���� ���� ���� 

CONN SCOTT/TIGER;

-----------------------------------------------------------

-- 1. emp, dept ���̺� ���� 
DROP TABLE new_emp;

CREATE TABLE new_emp
AS
SELECT e.*
  FROM emp e
 WHERE 1 = 1
;

DROP TABLE new_dept;

CREATE TABLE new_dept
AS
SELECT d.*
  FROM dept d
 WHERE 1 = 1
;
/*

Table NEW_EMP��(��) �����Ǿ����ϴ�.


Table NEW_DEPT��(��) �����Ǿ����ϴ�.

*/

-- 2. ���� ���̺��� PK ������ �����Ǿ� �����Ƿ� PK ������ ALTER�� �߰� 
/*
    new_dept : PK_NEW_DEPT   , deptno �÷��� PRIMARY KEY �� ���� 
    new_emp :  PK_NEW_EMP    , empno �÷��� PRIMARY KEY �� ����
               FK_NEW_DEPTNO , deptno �÷��� FOREIGN KEY �� ���� 
                  new_dept ���̺��� deptno �÷� REFERENCES  �ϵ��� ����
               FK_MGR       , mgr �÷��� FOREIGN KEY�� ����
                  new_emp ���̺��� empno �÷��� REFERENCES �ϵ��� ���� 
*/

-- 3.  ���� ���̺��� �⺻ ���̺�� �ϴ� VIEW�� ���� 
--     : ������ �⺻ ���� + ����� �̸� + �μ��̸� + �μ���ġ ���� ��ȸ������ �� 

CREATE OR REPLACE VIEW v_emp_dept 
AS 
SELECT e.empno 
     , e.ename 
     , e1.ename as mgr_name 
     , e.deptno 
     , d.dname 
     , d.loc 
FROM new_emp e 
   , new_dept d 
   , new_emp e1 
WHERE e.deptno = d.deptno(+) 
  AND e.mgr = e1.empno(+) 
WITH READ ONLY    
;     

   
 --������ �ɸ� ����� �Ϲ� ���̺� ��ȸ�ϵ� �並 ���� ��ȸ����
SELECT v.*
  FROM v_emp_dept v
;

SELECT v.empno
     , v.ename
     , v.dname
     , v.loc
  FROM v_emp_dept v
;

--4. VIEW �� �����Ǹ� user_views ��½ý��� ���̺� �߰��� Ȯ�� 
DESC user_views;

SELECT v.view_name
     , v.read_only
  FROM user.views v
;

--5. ������ �信�� DQL  ��ȸ 
-- 1) �μ����� SALES �� �μ� �Ҽ� ������ ��ȸ 
SELECT v.*
  FROM v_emp_dept v
 WHERE v.dname = 'SALES'
;
-- 2) �μ����� NULL �� ������ ��ȸ
SELECT v.*
  FROM v_emp_dept v
 WHERE v.dname IS NULL
;

-- 3) ���(�Ŵ���,MGR)�� NULL�� ������ ��ȸ
SELECT v.*
  FROM v_emp_dept v
 WHERE v.mgr_name   IS NULL
;

DROP TABLE new_dept;