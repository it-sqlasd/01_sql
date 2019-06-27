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