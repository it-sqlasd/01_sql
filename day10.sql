-- day 10 
--  7. ���ΰ� �������� 
-- (1) ���� : JOIN 
--    �ϳ� �̻��� ���̺��� �������� ��� �ϳ��� ���̺��� �� ó�� �ٷ�� ��� 
--    ������ �߻���Ű���� FROM ���� ���ο� ����� ���̺��� ���� 

--    ����) ������ �Ҽ� �μ� ��ȣ�� �ƴ� �μ� ���� ���� ��ȸ�ϰ� �ʹ�.
--    A) FROM ���� ���̺��� ���� 
--       emp, dept �� ���̺��� ���� --> ������ �߻� --> �� ���̺��� ��� ���� 
/* 
9999,8888 ���� ���� ���� 

DELETE FROM "SCOTT"."EMP" WHERE EMPNO = 8888
DELETE FROM "SCOTT"."EMP" WHERE EMPNO = 9999

COMMIT; 
*/
-- a) FROM ���� ���̺� ������ ���� �߻�
SELECT e.empno
     , e.ename
     , e.deptno
     , '|' "������"
     , d.deptno
     , d.dname
  FROM emp e 
     , dept d
;     
-- ==> (emp)12 * (dept)4 = 48  ���� �����Ͱ� �������� ���� 
-- B ) ���� ������ �߰��Ǿ�� ������ �ҼӺμ��� ��Ȯ�� ������ �� �ִ�.

SELECT e.empno
     , e.ename
     , e.deptno
     , '|' "������"
     , d.deptno
     , d.dname
  FROM emp e 
     , dept d
 WHERE e.deptno =d.deptno -- ����Ŭ�� �������� ���� ���� �ۼ� ���
 ORDER BY d.deptno
;     

-- ��� , �̸� , �μ��� �� ����� 

SELECT e.empno
     , e.ename
     , e.deptno
     , d.dname
  FROM emp e 
     , dept d
 WHERE e.deptno =d.deptno -- ����Ŭ�� �������� ���� ���� �ۼ� ���
 ORDER BY d.deptno
;     

-- ���� �����ڸ� ����Ͽ� ����(�ٸ� DBMS ���� �ַ� ���)
SELECT e.empno
     , e.ename
     , e.deptno
     , d.dname
  FROM emp e JOIN dept d ON (e.deptno = d.deptno)
 ORDER BY d.deptno0
;     

-- ���� ������� ACCOUNTING �μ� ������ �˰� �ʹ� .
-- 10�μ� ������ ��ȸ�Ͽ��� 
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e
     , dept d
 WHERE e.deptno = d.deptno     -- ���� ���� 
   AND d.dname = 'ACCOUNTING' -- �Ϲ� ����
;

/*
ACCOUNTING �μ� �Ҽ��� ���� ��ȸ�� 
���� �����ڸ� ����� ������ ���� 
*/
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e JOIN dept d ON (e.deptno = d.deptno)
 WHERE d.dname = 'ACCOUNTING' -- �Ϲ� ����
;
/*
2. ���� : īƼ�� �� (īƼ�� ����)
          ���� ��� ���̺��� �����͸� ������ ��� �������� ���� �� 
          WHERE ���� ���� ���� ������ �߻� 
          CROSS JOIN �����ڷ� �߻� ��Ŵ (����Ŭ 9I ���� ���ķ� ��� ���� )
          emp,dept, salgrads �� ���� ���̺�� īƼ�� �� �߻� 
*/
SELECT e.ename
     , d.dname
     , s.grade
  FROM emp e
     , dept d
     , salgrade s
;
-- ==> 12 x 4 x 5 = 240 ���� ��� �߻�

-- CROSS JOIN �����ڸ� ����ϸ�
SELECT e.ename
     , d.dname
     , s.grade
  FROM emp e CROSS JOIN dept d
             CROSS JOIN salgrade s
;

-- 3) EQUI JOIN : ������ ���� �⺻����
--                ���� ��� ���̺� ������ ���� �÷��� '='�� ����
--                ���� �÷��� (JOIN-ATTRIBUTE) ��� �θ� 
-- A) ����Ŭ ���������� WHERE���� ���� ������ �ִ� ��� 
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e
     , dept d
 WHERE e.deptno = d.deptno     -- ���� ���� 
;

--B) JOIN ~ ON 
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e JOIN dept d ON (e.deptno = d.deptno)
;

-- C) NATURAL JOIN Ű����� �ڵ� ���� 
--    : ON ���� ����
--     JOIN-ATTRIUBUTE �� ����Ŭ DBMS�� �ڵ����� �Ǵ�
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e NATURAL JOIN dept d --���� ��ð� ���� 
;

-- d ) JOIN ~ USING 
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e JOIN dept d USING(deptno)
  -- USING �ڿ� ���� �÷��� ��Ī ���� ��� 
;

-- 4) �� ���� EQUI-JOIN ���� �ۼ� �� 
-- A) ����Ŭ ���� ���� ���� 
SELECT [��Ī1.]�÷���1, [��Ī2.]�÷���2 [, ...]
  FROM ���̺� 1 ��Ī1,���̺�2 ��Ī2 [, ...]
 WHERE ��Ī1.�����÷�1 = ��Ī2.�����÷�1 -- �������� WHERE ���� 
  [AND ��Ī1.�����÷�2 = ��ĪN.�����÷�2] -- ���δ�� ���̺��� �������� ���
  [AND ... ]                              -- WHERE ���� �����Ǵ� �������ǵ� �þ
  [AND ... �߰� ������ �Ϲ� ���ǵ�]
;
-- B) JOIN ~ ON
SELECT [��Ī1.]�÷���1, [��Ī2.]�÷���2 [, ...]
  FROM ���̺� 1 ��Ī1 JOIN ���̺�2 ��Ī2 [, ...] ON (��Ī1.�����÷�1 = ��Ī2.�����÷�1)
                     [JOIN ���̺�2 ��Ī2 [, ...] ON (��Ī1.�����÷�2 = ��Ī3.�����÷�2)]
                     [JOIN ���̺�2 ��Ī2 [, ...] ON (��ĪN-1.�����÷�N-1 = ��ĪN.�����÷�N)]
 [WHERE �Ϲ�����]
   [AND �Ϲ�����]
;
-- C) NATURAL JOIN
SELECT [��Ī1.]�÷���1, [��Ī2.]�÷���2 [, ...]
  FROM ���̺� 1 ��Ī1 NATURAL JOIN ���̺�2 ��Ī2
                     [NATURAL JOIN ���̺�N ��ĪN]
;
-- D) JOIN ~ USING
SELECT [��Ī1.]�÷���1, [��Ī2.]�÷���2 [, ...]
  FROM ���̺� 1 ��Ī1 JOIN ���̺�2 ��Ī2 USING (�����÷�)
                     [JOIN ���̺�2 ��Ī2 USING (�����÷�)] -- ��Ī ��� ���� 
;

---------------------------------------------------------------------------------
/*
5) NON-EQUI JOIN : WHERE �������� JOIN-ATTRIBUTE ����ϴ� ��� 
                   �ٸ� �� �����ڸ� ����Ͽ� ���� ���̺��� ���� ���
   ����) emp, salgrads ���̺��� ����ؼ� ������ �޿��� ���� ������ �Բ� ��ȸ 
*/
SELECT e.empno
     , e.ename
     , e.sal
     , s.grade
  FROM emp e
     , salgrade s
 WHERE e.sal BETWEEN s.losal AND s.hisal    
;
-- emp ���̺��� salgrade ���̺�� ���� �� �ؼ� 
-- ������ �� �մ� ���� ����. ���� EQUI-JOIN �Ұ���

SELECT e.empno
     , e.ename
     , e.sal
     , s.grade
  FROM emp e JOIN salgrade s ON (e.sal BETWEEN s.losal AND s.hisal)
;

--OUTER JOIN ���� ����� ���� �μ���ȣ NULL �� ������ ���� 
/*
7777	JJ	    CLERK	    7702	19/06/27	        900		
8888	J_JAMES	SALESMAN	7698	19/06/07	1250	200	

INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL) VALUES ('7777', 'JJ', 'CLERK', '7702', TO_DATE('2019-06-27 13:09:06', 'YYYY-MM-DD HH24:MI:SS'), '900')
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM) VALUES ('8888', 'J_JAMES', 'SALESMAN', '7698', TO_DATE('2019-06-07 13:10:38', 'YYYY-MM-DD HH24:MI:SS'), '1250', '200')

COMMIT;
*/

/*
6) OUTER JOIN : ���� ��� ���̺��� ���� �÷��� NULL ���� �����͵� ����� ���� �� ����ϴ� ���� ��� 

������ : (+), LEFT OUTER JOIN RIGHT OUTER JOIN

1. (+) : ����Ŭ������ ����ϴ� OUTER JOIN ������ 
         EQUI-JOIN ���ǿ��� NULL �� ����� ���ϴ� �ʿ� �ٿ��� ��� 
*/

-- ������ ������ �μ���� �԰� ��ȸ(�Ϲ� EQUI-JOIN)
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e 
     , dept d
 WHERE e.deptno =d.deptno
;     
-- JJ , J_JAMES �� e.deptno �� NULL �̹Ƿ� dept ���̺� ��ġ�ϴ� ���� �����Ƿ� 
-- ���� ����� �� ������ ��ȸ���� �ʴ´�.

-- �μ� ��ġ�� ���� ���� ������ ��� ����� �ϰ� �ʹ�.
-- �׷����� dept ���̺����� �����Ͱ� NULL �̾ �߰� ����� �ʿ�.
-- �߰� ����� ���ϴ� �ʿ� (+) �����ڸ� ���δ�.
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e JOIN dept d USING(deptno)
  -- USING �ڿ� ���� �÷��� ��Ī ���� ���;
/*
EMPNO,  ENAME,   DNAME
7782	CLARK	ACCOUNTING
7839	KING	ACCOUNTING
7934	MILLER	ACCOUNTING
7369	SMITH	RESEARCH
7566	JONES	RESEARCH
7902	FORD	RESEARCH
7499	ALLEN	SALES
7521	WARD	SALES
7654	MARTIN	SALES
7698	BLAKE	SALES
7844	TURNER	SALES
7900	JAMES	SALES
7777	JJ	
8888	J_JAMES	
*/
--(+) �����ڴ� �����ʿ� �ٴ� NULL ���·� ��µ� ���̺��� �������´�.
--��ü ������ ���ػ�� ���̺��� �����̱� ������
--LEFT OUTER JOIN �߻���.


---- 2. LEFT OUTER JOIN ~ ON 
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e LEFT OUTER JOIN dept d ON (e.deptno = d.deptno)
;     
--ON ���� ���� ���������� EQUI-JOIN �� ���������� 
--LEFT OUTER JOIN �����ڿ� ���� 
--�� ������ ���ʿ� ��ġ�� ���̺��� ��� �����ʹ� ����� ����޴´�.
--����� (+) �����ڸ� �����ʿ� ���� ����� ���� 

-- 3. RIGHT OUTER JOIN

--���� ) ������ ���� �ƹ��� ��ġ���� ���� �μ��� �־ 
--       ��� �μ��� ��µǱ� �ٶ�� 
--(+) �����ڷ� �ذ� : '=' ������ �����ʿ� ����.
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e 
     , dept d
 WHERE e.deptno(+) =d.deptno
;     
/*
EMPNO,  ENAME,  DNAME
---------------------------
7839	KING	ACCOUNTING
7782	CLARK	ACCOUNTING
7934	MILLER	ACCOUNTING
7902	FORD	RESEARCH
7369	SMITH	RESEARCH
7566	JONES	RESEARCH
7900	JAMES	SALES
7844	TURNER	SALES
7654	MARTIN	SALES
7521	WARD	SALES
7499	ALLEN	SALES
7698	BLAKE	SALES
		OPERATIONS
*/

SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e RIGHT OUTER JOIN dept d ON (e.deptno = d.deptno) 
; 
-- ON ������ EQUI-JOIN �� ������ ���� ������ ���� 
-- RIGHT OUTER JOIN �����ڿ� ���� ������ ���̺��� dept ���̺��� 
-- �����ʹ� ��� ����� ����޴´�.


-------4. FULL OUTER JOIN : 

-- ���� ) �μ� ��ġ�� �ȵ� ������ ��ȸ�ϰ� �Ͱ� 
--        ������ �ƹ��� ���� �μ��� ��ȸ�ϰ� ������ 
--        ��, ���� ��� ���� ���̺� �����Ѵ� NULL ������ 
--        ��� �ѹ��� ��ȸ�Ϸ���?

-- (+)�����ڷδ� �Ұ���
ORA-01468: outer-join�� ���̺��� 1���� ������ �� �ֽ��ϴ�
01468. 00000 -  "a predicate may reference only one outer-joined table"

-- FULL OUTER JOIN ~ ON �����ڷ� ����

SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e FULL OUTER JOIN dept d ON (e.deptno = d.deptno)
;
/*
EMPNO,  ENAME,   DNAME
-----------------------
7369	SMITH	RESEARCH
7499	ALLEN	SALES
7521	WARD	SALES
7566	JONES	RESEARCH
7654	MARTIN	SALES
7698	BLAKE	SALES
7782	CLARK	ACCOUNTING
7839	KING	ACCOUNTING
7844	TURNER	SALES
7900	JAMES	SALES
7902	FORD	RESEARCH
7934	MILLER	ACCOUNTING
7777	JJ	
8888	J_JAMES	
		OPERATIONS


/*
���� ) ������ �ƹ��� ���� �μ��� ��� ��ȸ�ϰ� �ʹ�.
       dept ���̺��� ���ʿ� ��ġ�ؼ� ������ �Ŵ� ���
       LEFT OUTER JOIN ���� �ذ��ϸ� �ȴ�.
*/
SELECT d.dname
     , e.ename
  FROM dept d
     , emp e
 WHERE d.deptno = e.deptno(+)
;

--------5. SELF JOIN 
/*
�� ���̺� ������ �ڱ� �ڽ��� �÷����� �����Ͽ� ������ ������ ����� ��� 

-- ���� ) EMP���̺� ���� ������ ��ȸ�� �� 
         �� ������ ���(�Ŵ���) �̸��� ���� ��ȸ�ϰ� �ʹ�.
*/

SELECT e.empno "���"
     , e.ename "�̸�"
     , e.mgr "��� ���"
     , e1.ename "��� �̸�"
  FROM emp e
     , emp e1
 WHERE e.mgr = e1.empno    
;
/*
���,   �̸�,   ��� ���, ��� �̸�
7902	FORD	7566    	JONES
7499	ALLEN	7698    	BLAKE
7521	WARD	7698    	BLAKE
7654	MARTIN	7698    	BLAKE
7844	TURNER	7698    	BLAKE
7900	JAMES	7698    	BLAKE
8888	J_JAMES	7698    	BLAKE
7934	MILLER	7782    	CLARK
7566	JONES	7839    	KING
7698	BLAKE	7839	    KING
7782	CLARK	7839	    KING
7369	SMITH	7902	    FORD
*/
-- ���� ����� SELF - JOIN �̸鼭 EQUI-JOIN �̱� ������ 
-- ��簡 ���� ������ ��ȸ���� �ʴ´�.
-- KING�� ��ȸ���� ����.

-- ��簡 ���� ������ ��ȸ�ϰ� ������ 
-- a) e���̺� �������� ��� �����Ͱ� ��ȸ�Ǿ�� �� 
-- b) (+) �����ʿ� ���̰ų� 
SELECT e.empno "���"
     , e.ename "�̸�"
     , e.mgr "��� ���"
     , e1.ename "��� �̸�"
  FROM emp e
     , emp e1
 WHERE e.mgr = e1.empno(+)    
;
-- c) LEFT OUTER JONI ~ ON �� ���
SELECT e.empno "���"
     , e.ename "�̸�"
     , e.mgr "��� ���"
     , e1.ename "��� �̸�"
  FROM emp e LEFT OUTER JOIN emp e1 ON (e.mgr = e1.empno)
;
/*
���,   �̸�,   �����, ��� �̸�
7902	FORD	7566	  JONES
7499	ALLEN	7698	  BLAKE
7521	WARD	7698   	  BLAKE
7654	MARTIN	7698      BLAKE
7844	TURNER	7698	  BLAKE
7900	JAMES	7698	  BLAKE
8888	J_JAMES	7698	  BLAKE
7934	MILLER	7782	  CLARK
7566	JONES	7839	  KING
7698	BLAKE	7839	  KING
7782	CLARK	7839	  KING
7369	SMITH	7902	  FORD
7839	KING		
7777	JJ	    7702	
*/

-- ���� ������ ���� ������ ��ȸ
SELECT e.empno "���"
     , e.ename "�̸�"
     , e.mgr "��� ���"
     , e1.ename "��� �̸�"
  FROM emp e
     , emp e1
 WHERE e.mgr(+) = e1.empno
 ORDER BY "���" DESC
;
/*
���   , �̸�,  ��� ���, ��� �̸�
                        MARTIN
                    	MILLER
                    	SMITH
                    	JAMES
                    	TURNER
                    	WARD
                    	JJ
                    	J_JAMES
                    	ALLEN
8888	J_JAMES	7698	BLAKE
7934	MILLER	7782	CLARK
7902	FORD	7566	JONES
7900	JAMES	7698	BLAKE
7844	TURNER	7698	BLAKE
7782	CLARK	7839	KING
7698	BLAKE	7839	KING
7654	MARTIN	7698	BLAKE
7566	JONES	7839	KING
7521	WARD	7698	BLAKE
7499	ALLEN	7698	BLAKE
7369	SMITH	7902	FORD
*/
-- RIGHT OUTER JOIN ~ ON ���� ����
SELECT e.empno "���"
     , e.ename "�̸�"
     , e.mgr "��� ���"
     , e1.ename "��� �̸�"
  FROM emp e RIGHT OUTER JOIN emp e1 ON (e.mgr = e1.empno)
 ORDER BY "���" DESC
;

-- ������ �ǽ� ����)
-- 1. ���, �̸�, ����, ����̸�, �μ���, �μ���ġ �� ��ȸ�Ͻÿ�.
-- emp e, emp e1, dept d 
SELECT e.empno "���"
     , e.ename "�̸�"
     , e.job "����"
     , e1.ename "����̸�"
     , d.dname "�μ���"
     , d.loc "�μ���ġ"
  FROM emp e
     , emp e1
     , dept d
 WHERE e.mgr = e1.empno
   AND e.deptno = d.deptno
;
-- �� ������ JOIN ~ ON ���� ����
SELECT e.empno "���"
     , e.ename "�̸�"
     , e.job "����"
     , e1.ename "����̸�"
     , d.dname "�μ���"
     , d.loc "�μ���ġ"
  FROM emp e JOIN emp e1 ON (e.mgr = e1.empno)
             JOIN dept d ON (e.deptno = d.deptno)
;
/*
���,   �̸�,   ����,      ����̸�, �μ���,     �μ���ġ
7902	FORD	ANALYST 	JONES	 RESEARCH	DALLAS
7900	JAMES	CLERK	    BLAKE	 SALES	    CHICAGO
7844	TURNER	SALESMAN	BLAKE	 SALES	    CHICAGO
7654	MARTIN	SALESMAN	BLAKE	 SALES	    CHICAGO
7521	WARD	SALESMAN	BLAKE	 SALES	    CHICAGO
7499	ALLEN	SALESMAN	BLAKE	 SALES  	CHICAGO
7934	MILLER	CLERK	    CLARK	 ACCOUNTING	NEW YORK
7782	CLARK	MANAGER	    KING	 ACCOUNTING	NEW YORK
7566	JONES	MANAGER 	KING	 RESEARCH	DALLAS
7698	BLAKE	MANAGER 	KING	 SALES	    CHICAGO
7369	SMITH	CLERK	    FORD	 RESEARCH	DALLAS
*/
-- 2.���, �̸�, �޿�, �޿����, �μ���, �μ���ġ�� ��ȸ�Ͻÿ�.
--   emp e, dept d ,salgrade s
SELECT e.empno "���"
     , e.ename "�̸�"
     , e.sal "�޿�"
     , s.grade"�޿����"
     , d.dname "�μ���"
     , d.loc "�μ���ġ"
  FROM emp e
     , salgrade s
     , dept d
 WHERE e.sal BETWEEN s.losal AND s.hisal
   AND e.deptno = d.deptno
;
--�� ������ JOIN ~ ON ���� ����
SELECT e.empno "���"
     , e.ename "�̸�"
     , e.sal "�޿�"
     , s.grade"�޿����"
     , d.dname "�μ���"
     , d.loc "�μ���ġ"
  FROM emp e JOIN salgrade s  ON (e.sal BETWEEN s.losal AND s.hisal)
             JOIN dept d     ON (e.deptno = d.deptno)
;
/*
���,   �̸�,   �޿�, �޿����, �μ���,      �μ���ġ
-----------------------------------------------
7839	KING	5000	5	    ACCOUNTING	NEW YORK
7902	FORD	3000	4	    RESEARCH	DALLAS
7566	JONES	2975	4	    RESEARCH	DALLAS
7698	BLAKE	2850	4	    SALES	    CHICAGO
7782	CLARK	2450	4	    ACCOUNTING	NEW YORK
7499	ALLEN	1600	3	    SALES   	CHICAGO
7844	TURNER	1500	3	    SALES   	CHICAGO
7934	MILLER	1300	2   	ACCOUNTING	NEW YORK
7654	MARTIN	1250	2   	SALES	    CHICAGO
7521	WARD	1250	2   	SALES	    CHICAGO
7900	JAMES	950 	1   	SALES	    CHICAGO
7369	SMITH	800	    1	    RESEARCH    DALLAS
*/

--��簡 ���ų� ,�μ��� �������� ���� ������ ��� ����Ͻÿ� 
-- (+)
SELECT e.ename
     , e.sal 
     , e1.ename
     , d.dname
  FROM emp e
     , emp e1
     , dept d
 WHERE e.mgr = e1.empno(+)
   AND e.deptno = d.deptno(+)
;
-- LEFT OUTER JOIN ~ ON 
SELECT e.ename
     , e.sal 
     , e1.ename
     , d.dname
  FROM emp e LEFT OUTER JOIN emp e1 ON (e.mgr = e1.empno)
             LEFT OUTER JOIN dept d ON (e.deptno = d.deptno)
;
SELECT e.ename
     , e.sal 
     , DECODE(e1.ename, NULL, '-', e1.ename) "��� -"
     , DECODE(d.dname, NULL, '-' , d.dname) "��� -"
  FROM emp e
     , emp e1
     , dept d
 WHERE e.mgr = e1.empno(+)
   AND e.deptno = d.deptno(+)
;

--