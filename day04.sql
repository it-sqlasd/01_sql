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
-- LIKE ������  : ���� ���� �˻��� �� ���.
--       ��Ȯ�� ���� ���� ���� �� ���.
-- LIKE �������� ���� ���� :���� �� �˻��� ���� 
--                           �����ڿ� �Բ� ����ϴ� ��ȣ 
-- % : �� ��ȣ�� �ڸ��� 0�ڸ��� �̻��� ��� ���ڰ� �� �� ���� 
-- _ : �� ��ȣ�� �ڸ��� 1�ڸ��� ��� ���ڰ� �� �� ����

--26) �̸��� J�� �����ϴ� ������
--    ���, �̸� ��ȸ 
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

--�̸��� M���� �����ϴ� ������ ���, �̸� ��ȸ 
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

-- �Ƹ��� M�� ���� ������ ���, �̸� ��ȸ 
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

--�̸��� ������ �ڸ��� M�� ���� ������ ���, �̸� ��ȸ 
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename LIKE '__M%' -- �����νĹ��� _�� �ι� ����Ͽ�
                           -- M ���ڸ��� 2���ڷ� ����  
;
/*
EMPNO,  ENAME
-------------
7900	JAMES
*/

-- �̸��� �Ѥ� �ڸ����� LA�� ���� �̸��� ���� ������
-- ���,�̸� ��ȸ 

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

-- ������ �Է��� ���� 
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME, JOB) 
VALUES ('9999', 'J_JAMES', 'CLERK')
;
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME, JOB) 
VALUES ('8888', 'J%JAMES', 'CLERK')
;
COMMIT;

-- �̸��� J_�� �����ϴ� ������ ���, �̸��� ��ȸ 
-- : ��ȸ �Ϸ��� ���� �����ν� ����(%, _)�� ����ִ� �����ʹ�
-- ��� ��ȸ�� ���ΰ�?
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename LIKE 'J\_%' ESCAPE '\'
;
-- ==> ��ó�� LIKE ������ �ۼ��ϸ� J�ڿ� ��� 1���ڰ� �ִ� 
--     �̸��� ���� ������ ��� �˻���. ���ϴ� ����� �ƴϴ�
--     ���� �ν� ���ڸ� ��ȸ�Ϸ��� ESCAPE �� ����ؾ� �Ѵ�.
--   =>���� �ν� ���ڸ� ��ȿȭ�Ϸ��� ESCAPE �� ����ؾ��Ѵ�.

SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename LIKE 'J\%%' ESCAPE '\'
;

-- NULL  �� ���õ� SQL ������ 
-- : IS NULL , IS NOT NULL
-- IS NULL : ���Ϸ� �ϴ� �÷��� ���� NULL �� �� TRUE (��)
--           ���Ϸ� �ϴ� �÷��� ���� NULL �� �ƴϸ� FLASE (����)
-- IS NOT NULL ���Ϸ� �ϴ� �÷��� ���� NULL�� �ƴϸ� TRUE (��) 
--             ���Ϸ� �ϴ� �÷��� ���� NULL �� �� FALSE (����)
-- NULL���� ���� �÷��� �񱳿�����(=, !=, <>) �� ���� ������ �Ұ����ϹǷ�
-- NULL�� �񱳸� ���� �����ڰ� ���� �����Կ� ����!

-- col = NULL ==> NULL�� ���ؼ��� ���Ϻ� ������(=)�� ��� ����.
-- col != NULL
-- col <> NULL ==> NULL�� ���ؼ��� 
--                 �ٸ��� ���ϴ� ������(!=,<>)�� ��� ����

-- 27)  ���(mgr)�� �������� ���� ������ ���, �̸�, ����� (mgr) ��ȸ 
SELECT e.empno
    ,  e.ename
    ,  e.mgr
 FROM  emp e
WHERE  e.mgr = NULL -- NULL �����ʹ� �񱳿����ڷ� 
                    -- ������ �� ���� ��
;

SELECT e.empno
    ,  e.ename
    ,  e.mgr
 FROM  emp e
WHERE  e.mgr IS NULL -- NULL �����ʹ� IS�� �� 
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
-- e.mgr != NULL / e.mgr <> NULL ���� ������ ��� ������ �Ǵ� �Ϳ� ����!
-- �� ������ !=, <> ���� ���� �����
-- ����� ��� �� : 0
-- �̷� ��� ������ �Ǳ⋚���� ������ ã�� �����Ƿ�
-- NULL �����͸� �ٷ� �� �׻� �����ؾ� �Ѵ�.

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
--BETWWN a AND b : ���� ���� �� ������ 
-- a <= sal <= b : �̷��� ���� ����� ������ ��� 

-- 28)�޿��� 500 ~ 1200 ������ ������ 
--    ���, �̸� �޿� ��ȸ 
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

-- BETWEEN 500 AND 1200 ���� ����� ���ִ� �񱳿����� ���� 
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
-- EXISTS ������ : � ����(SELECT ����)�� ������ ����� 
--                 1�� �̻��� �� ������ �Ǵ�
--                 ����� ��� ��:0�� ��� �������� �Ǵ�
--                 ���� ���������� �Բ� ����.
-- 29)
--  (1) �޿��� 3000�� �Ѵ� ������ ��ȸ 
SELECT e.empno
     , e.ename
     , e.sal
  FROM emp e
 WHERE e.sal > 3000
 ;
 -- 7839	KING	5000
 -- 29-(1) ������ ����� 1���� ����(EXISTS)
 
 --  (2) �޿��� 3000�� �Ѵ� ������ 1���̶� ������ 
 --      ȭ�鿡 "�޿��� 3000�� �Ѵ� ������ ������"
 --      �̶�� �޽����� ����ϰ� �ʹ�.
 
SELECT '�޿��� 3000�� �Ѵ� ������ ����' AS "�ý��� �޽���"
  FROM dual -- 1�ุ �����Ͱ� ������ ���̴� . 
 WHERE EXISTS (SELECT e.empno
                    , e.ename
                    , e.sal
                 FROM emp e
                WHERE e.sal > 3000)
;
/*
�ý��� �޽���
-------------------------------
�޿��� 3000�� �Ѵ� ������ ������ 
*/

--oracle ���� �����ϴ� dual ���̺� 
-- : 1�� 1���� �����Ͱ� ����ִ� ���� ���̺� 
-- 1) dual ���̺��� ���̺� ������ Ȯ��
DESC dual; 
-- ���� DESC �� ������ Ű���尡 �ƴ� ����Ŭ�� ��ɾ� 
-- ���̺��� ������ Ȯ���ϴ� ���
-- Describe �� ���� 
/*
�̸�    ��? ����          
----- -- ----------- 
DUMMY    VARCHAR2(1) 
*/
SELECT dummy
  FROM dual
;

-- �޿��� 10000�� �Ѵ� ������ ������ 
-- ȭ�鿡 "�޿��� 10000�� �Ѵ� ������ ������������" �̶�� ���
-- (1)�޿��� 10000�� �Ѵ� ������ ���� ��ȸ 
SELECT e.empno
     , e.ename
     , e.sal
  FROM emp e
 WHERE e.sal > 10000
 ;
 
 -- (2) �ý��� �޽����� ����� �� �ֵ��� ���� ���� 
 SELECT '�޿��� 10000�� �Ѵ� ������ ������������' AS "�ý��� �޽���"
   FROM dual
  WHERE NOT EXISTS  (SELECT e.empno
                           , e.ename
                           , e.sal
                           FROM emp e
                           WHERE e.sal > 10000)
;
/*
�ý��� �޽���
�޿��� 10000�� �Ѵ� ������ ������������
*/