--���� ) ȸ�翡 �Ŵ����� ������ ������ ����ΰ� 
--       ��Ī : ��簡 �ִ� ������ ��
SELECT COUNT(e.mgr)
  FROM emp e
;

-- ����) �Ŵ������� �ð� �ִ� ������ ����ΰ�?
-- 1.    emp ���̺��� mgr Į���� ������ ���¸� �ľ� 
-- 2.    mrg Į���� �ߺ� ������ ���� 
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
-- 3.    �ߺ� �����Ͱ� ���ŵ� ����� ī��Ʈ 
SELECT COUNT(DISTINCT e.mgr) "�Ŵ��� �� "
  FROM emp e
;
/*
�Ŵ��� �� 
5
*/

--����) �μ��� ������ ������ ����̳� �ִ°�?
SELECT count(e.deptno) "�μ��� ������ ����" 
  FROM emp e
;
/*
�μ��� ������ ����
------------------
12
*/

-- COUNT(*) �� �ƴ� COUNT(expr)�� ����� ��쿡��
SELECT e.deptno
  FROM emp e
 WHERE e.deptno IS NOT NULL
;
--�� ������ ����� ī��Ʈ �� ������ ������ �� ����.

--���� ) ��ü�ο�, �μ� �����ο�, �μ� �̹��� �ο��� ���Ͻÿ� 

SELECT count(*)
     , count(e.deptno)
     , COUNT(*) - COUNT(e.deptno)
  FROM emp e
;


--SUM(expr) : NULL �׸� �����ϰ� 
--            �ջ� ������ ���� ��� ���� ����� ��� 
--SALESMAN ���� ���� ������ ���غ���.
SELECT SUM(e.comm) "���� ����" 
  FROM emp e
;

SELECT SUM(e.comm) "���� ����" 
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
/*



300
500

1400



0           


     --> �ڵ����� NULL �÷� ���� ��
*/

-- ���� ���� ����� ���� ��� ������ ���� $, ���ڸ� ���� �б� ���� 
SELECT TO_CHAR(SUM(e.comm), '$9,999') "���� ����" 
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
/*
���� ����
--------
 $2,200
*/

--3) AVG(expr) : NULL �� �����ϰ� ���� ������ �׸��� ��� ����� ���� 
--   SALESMAN�� ���� ����� ���غ���.
--   ���� ��� ����� ���� ��� ���� $, ���ڸ� ���� �б� ����

SELECT AVG(e.comm) "���� ���" 
  FROM emp e
 WHERE e.job = 'SALESMAN'
;

SELECT TO_CHAR(AVG(e.comm), '$9,999') "���� ���" 
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
/*
���� ����
--------
   $550
*/

--4) MAX(expr) : expr�� ������ �� �� �ִ��� ���� 
--               expr�� ������ ���� ���ĺ��� ���ʿ� ��ġ�� ���ڸ�
--               �ִ����� ���
SELECT MAX(e.ename)
  FROM emp e
;
/*
MAX(E.ENAME)
-----------
WARD
*/

SELECT MIN(e.ename) "�̸��� ���� ���� ����"
  FROM emp e
;
/*
�̸��� ���� ���� ����
=====================
ALLEN
*/

---------3. GROUP BY ���� ��� 
-- ����) �� �μ��� �޿��� ����,���,�ִ�,�ּ� 

--1. �� �μ����� �޿��� ������ ��ȸ�Ϸ��� 
--   ���� SUM()�� ��� 
--   �׷�ȭ ������ �μ���ȣ(deptno)�� ��� 
--   GROUP BY ���� �����ؾ� �� 

-- a) ���� emp ���̺��� �޿� ������ ���ϴ� ���� �ۼ� 
SELECT SUM(e.sal) "�޿� ����"
  FROM emp e
;

-- b) �μ� ��ȣ�� �������� �׷�ȭ ����
--    SUM()�� �׷��Լ���
--    GROUP BY ���� �����ϸ� �׷�ȭ �����ϴ�.
--    �׷�ȭ�� �Ϸ��� �����÷��� GROUP BY ���� �����ؾ� ��.

SELECT e.deptno  �μ���ȣ -- �׷�ȭ �����÷����� SELECT ���� ����
     , SUM(e.sal)  "�μ� �޿� ����" -- �׷��Լ��� ���� �÷�     
  FROM emp e          
 GROUP BY e.deptno -- �׷�ȭ �����÷����� GROUP BY ���� ����
 ORDER BY e.deptno -- �μ���ȣ ����
;

-- GROUP BY ���� �׷�ȭ ���� �÷����� ������ �÷��� �ƴѰ���
-- SELECT ���� �����ϸ� ���� , ����Ұ�


SELECT e.deptno   �μ���ȣ -- �׷�ȭ �����÷����� SELECT ���� ����  
     , e.job       --�׷�ȭ �����÷��� �ƴѵ� SELECT ���� ���� -> ������ ����
     , SUM(e.sal)  "�μ� �޿� ����" -- �׷��Լ��� ���� �÷�     
  FROM emp e          
 GROUP BY e.deptno -- �׷�ȭ �����÷����� GROUP BY ���� ����
 ORDER BY e.deptno -- �μ���ȣ ����
;
/*
ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
00979. 00000 -  "not a GROUP BY expression"
*/

--����) �μ��� �޿��� ����, ��� ,�ִ� ,�ּ�
SELECT e.deptno  �μ���ȣ
     , TO_CHAR(SUM(e.sal), '$9,999')    "�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal), '$9,999')    "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$9,999')    "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$9,999')    "�μ� �޿� �ּ�"
  FROM emp e          
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;
/*
�μ���ȣ, �μ� �޿� ����, �μ� �޿� ���, �μ� �޿� �ִ�, �μ� �޿� �ּ�
10	     $8,750	         $2,917	            $5,000	      $1,300
20	     $6,775	         $2,258	            $3,000	      $800
30	    $9,400	         $1,567	             $2,850	      $950	
*/

--�μ� ��ȣ�� ������ ����
SELECT TO_CHAR(SUM(e.sal), '$9,999')    "�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal), '$9,999.99')    "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$9,999')    "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$9,999')    "�μ� �޿� �ּ�"
  FROM emp e          
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

/*
���� ������ ��������� ��Ȯ�ϰ� ����μ��� ������� �� �� ���ٴ� ������ ���� 
�׷��� , GROUP BY ���� �����ϴ� �����÷��� SELECT ���� �Ȱ��� �����ϴ� ���� 
��� �ؼ��� ���ϴ�.

SELECT ���� ������ �÷��߿��� �׷��Լ��� ������ �ʴ� �÷��� ���� ������ 
���� ������ ����Ǵ� ���̴�.
*/

-- ���� ) �μ���, ������ �޿��� ����, ���,�ִ�, �ּ� �� ���غ���
SELECT e.deptno �μ���ȣ
     , e.job ����
     , SUM(e.sal) "�޿� ����"
     , AVG(e.sal) "�޿� ���"
     , MAX(e.sal) "�޿� �ִ�"
     , MIN(e.sal) "�޿� �ּ�"
  FROM emp e          
 GROUP BY e.deptno , e.job 
 ORDER BY e.deptno 
;
/*
�μ���ȣ, ����,   �޿� ����, �޿����, �޿� �ִ�, �޿� �ּ�
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

--a) GROUP BY ���� �׷�ȭ ������ ������ ��� 
SELECT e.deptno �μ���ȣ
     , e.job ����
     , SUM(e.sal) "�޿� ����"
     , AVG(e.sal) "�޿� ���"
     , MAX(e.sal) "�޿� �ִ�"
     , MIN(e.sal) "�޿� �ּ�"
  FROM emp e          
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

--b) SELECT ���� �׷��Լ��� �Ϲ� �÷��� ���� ����
--   GROUP BT �� ��ü�� ������ ��� 
SELECT e.deptno �μ���ȣ
     , e.job ����             -- SELECT ���� ���� 
     , SUM(e.sal) "�޿� ����"
     , AVG(e.sal) "�޿� ���"
     , MAX(e.sal) "�޿� �ִ�"
     , MIN(e.sal) "�޿� �ּ�"
  FROM emp e          
-- GROUP BY e.deptno  e.job 
 ORDER BY e.deptno 
;
/*
ORA-00937: ���� �׷��� �׷� �Լ��� �ƴմϴ�
00937. 00000 -  "not a single-group group function"
*/

-- ����) ����(job) �� �޿��� ����, ���, �ִ�, �ּҸ� ���غ��� 
--       ��Ī : ����, �޿�����, �޿����, �ִ�޿� , �ּұ޿�
SELECT e.job ����              
     , SUM(e.sal) "�޿� ����"
     , AVG(e.sal) "�޿� ���"
     , MAX(e.sal) "�޿� �ִ�"
     , MIN(e.sal) "�޿� �ּ�"
  FROM emp e
 GROUP BY e.job  
;

-- ������ null ������� ������ ��� '���� �̹���'���� ��� 
SELECT NVL(e.deptno,  '�μ� �̹���') �μ���ȣ
     , TO_CHAR(SUM(e.sal), '$9,999')    "�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal), '$9,999')    "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$9,999')    "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$9,999')    "�μ� �޿� �ּ�"
  FROM emp e          
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;
/* deptno �� ���� , '�μ� �̹�����' ���� �������̹Ƿ� Ÿ�� ����ġ�� 
    NVL()�� �۵����� ���Ѵ�.
ORA-01722: ��ġ�� �������մϴ�
01722. 00000 -  "invalid number"
*/

-- �ذ��� : DEPT ����ȭ 
SELECT NVL(TO_CHAR(e.deptno,  '�μ� �̹���') �μ���ȣ
     , TO_CHAR(SUM(e.sal), '$9,999')    "�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal), '$9,999')    "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$9,999')    "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$9,999')    "�μ� �޿� �ּ�"
  FROM emp e          
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

-- ���ڸ� ���ڷ� ���� : ���տ�����(||)�� ��� 
SELECT NVL(e.deptno || '' ,  '�μ� �̹���') �μ���ȣ
     , TO_CHAR(SUM(e.sal), '$9,999')    "�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal), '$9,999')    "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$9,999')    "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$9,999')    "�μ� �޿� �ּ�"
  FROM emp e          
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

SELECT DECODE(NVL(e.deptno ,  0), e.deptno, TO_CHAR(e.deptno)
                                , 0       , '�μ� �̹���')  �μ���ȣ
     , TO_CHAR(SUM(e.sal), '$9,999')    "�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal), '$9,999')    "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$9,999')    "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$9,999')    "�μ� �޿� �ּ�"
  FROM emp e          
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

-------------4. HAVING ���� ��� 

-- GROUP BY ����� ������ �ɾ 
-- �� ����� ������ �������� ���Ǵ� �� .

-- HAVING ���� WHERE ���� ���������
-- SELECT ������ ���� ���� ������ 
-- GROUP BY �� ���� ���� ����Ǵ� WHERE ���δ� 
-- GROUP BY ����� ������ �� ���� 

-- ���� GROUP BY ���� ��������� ������
-- HAVING ���� �����Ѵ�.

-- ����) �μź� �޿� ����� 2000�̻��� �μ��� ��ȸ�Ͽ���.

-- a) �켱 �μ��� �޿� ����� ���Ѵ�.
SELECT e.deptno "�μ���ȣ"
     , AVG(e.sal) "�޿����"
  FROM emp e
 GROUP BY e.deptno
;

-- b) a�� ������� �޿� ����� 2000�̻��� ���� �����.
--    HAVING ���� ��� ����
SELECT e.deptno "�μ���ȣ"
     , AVG(e.sal) "�޿����"
  FROM emp e
 GROUP BY e.deptno
HAVING AVG(e.sal) >= 2000
;
-- ��� ���� ����
SELECT e.deptno "�μ���ȣ"
     , TO_CHAR(AVG(e.sal), '$9,999.99') "�޿����"
  FROM emp e
 GROUP BY e.deptno
HAVING AVG(e.sal) >= 2000
;

-- ���� : HAVING ���� ��Ī�� ����� �� ����.
SELECT e.deptno "�μ���ȣ"
     , TO_CHAR(AVG(e.sal), '$9,999.99') "�޿����"
  FROM emp e
 GROUP BY e.deptno
HAVING "�޿����" >= 2000 -- HAVING�� ��Ī�� ����� �� ����
;
/*
ORA-00904: "�޿����": �������� �ĺ���
00904. 00000 -  "%s: invalid identifier"
*/

--HAVING ���� �����ϴ� ��� SELECT ������ ���� ���� ���� 
/*
1. FROM     ���� ���̺� �� �� ��θ� ������� 
2. WHERE    ���� ���ǿ� �´� �ุ �����ϰ� 
3. GROUP BY ���� ���� �÷�, ��(�Լ� ��)���� �׷�ȭ ����
4. HAVING   ���� ���ǿ� ������Ű�� �׷��ุ ����
5.          4���� ���õ� �׷������� ���� �࿡ ���ؼ� 
6.SELECT    ���� ��õ� �÷�, ��(�Լ� ��)�� ���
7.ORDER BY  �� �ִٸ� ���� ���ǿ� ���߾� ���� �����Ͽ� ��� ���
*/

-- ������ �ǽ� 

 
 -- 1. �Ŵ�����, ���������� ���� ���ϰ�, ���� ������ ���� 
 --   : mgr �÷��� �׷�ȭ ���� �÷� 
 SELECT e.deptno "�μ���ȣ"
      , COUNT(e.deptno) "��������"
   FROM emp e
  GROUP BY e.deptno
 ORDER BY "��������"
;

-- 2.1 �μ��� �ο��� ���ϰ�, �ο��� ���� ������ ���� 
 --    : deptno �÷��� �׷�ȭ ���� �÷� 540
SELECT e.deptno "�μ���ȣ"
      , COUNT(e.deptno) "��������"
   FROM emp e
  GROUP BY e.deptno
 ORDER BY "��������";

 -- 2.2 �μ� ��ġ �̹��� �ο� ó�� 
 SELECT e.deptno "�μ� ��ġ �̹���" 
   FROM emp e
  WHERE e.deptno is null 
;
 
 -- 3.1 ������ �޿� ��� ���ϰ�, �޿���� ���� ������ ���� 
 --   : job �� �׷�ȭ ���� �÷� 
 SELECT e.job "������"
      , AVG(e.sal) "�޿����"
   FROM emp e
  GROUP BY e.job, e.sal
  ORDER BY "�޿����" DESC   
 ;
 
-- 3.2 job �� null �� ������ ó�� 
 SELECT NVL(TO_CHAR(e.job), '�μ� �̹���') "������"
      , AVG(e.sal) "�޿����"
   FROM emp e
  GROUP BY e.job, e.sal
  ORDER BY "�޿����" DESC   
 ;

 

 
-- 4. ������ �޿� ���� ���ϰ�, ���� ���� ������ ���� 
--   : job �� �׷�ȭ ���� �÷� 
 SELECT e.job
      , SUM(e.sal) "�޿� ��"
   FROM emp e
  GROUP BY e.job, e.sal
  ORDER BY "�޿� ��" DESC   
 ;


-- 5. �޿��� �մ����� 1000�̸�, 1000, 2000, 3000, 5000 ���� �ο����� ���Ͻÿ� 
--    �޿� ���� ������������ ���� 
 SELECT TO_CHAR(e.hiredate, 'YY') "�Ի�⵵" 
      , COUNT(*) "�ο�"
   FROM emp e
 GROUP BY TO_CHAR(e.hiredate, 'YY')
;

 

 
-- 6. ������ �޿� ���� ������ ���ϰ�, �޿� ���� ������ ū ������ ���� 
 SELECT e.job
      , TO_CHAR(SUM(e.sal), '$9,999') "�޿� ��"
   FROM emp e
  GROUP BY e.job, e.sal
  ORDER BY "�޿� ��" DESC   
 ;

-- 7. ������ �޿� ����� 2000������ ��츦 ���ϰ� ����� ���� ������ ���� 
 SELECT e.job
      , TO_CHAR(SUM(e.sal), '$9,999') "�޿� ��"
      , avg(e.sal) "���"
   FROM emp e
 HAVING AVG(e.sal) < 2000
  GROUP BY e.job, e.sal
  ORDER BY "���" DESC   
 ;
 -- 8. �⵵�� �Ի� �ο��� ���Ͻÿ� 
SELECT sum(count(e.hiredate)) "81�⵵"
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

 SELECT TO_CHAR(e.hiredate, 'YY') "�Ի�⵵" 
      , COUNT(*) "�ο�"
   FROM emp e
 GROUP BY TO_CHAR(e.hiredate, 'YY')
;

-- 9. �⵵��, ���� �Ի� �ο��� ���Ͻÿ� 
--  : (1) hiredate�� Ȱ�� 
--    (2) hiredate ���� �⵵, ���� ����
--    (3) ����� �� ���� �׷�ȭ �������� ��� 
--    (4) �Խ� �ο��� ���϶� �Ͽ����Ƿ� COUNT(*) �׷��Լ� ��� 
-- a) �⵵ ���� : TO_CHAR(e.hiredate, 'YYYY')
--      �� ���� : TO_CHAR(e.hiredate, 'MM')
-- b) �� ���� �������� �׷�ȭ ���� 

SELECT TO_CHAR(e.hiredate, 'YYYYY') "�Ի� �⵵"
     , TO_CHAR(e.hiredate, 'MM') "�Ի� ��"
     , COUNT(*) "�Ի� ��"
  FROM emp e
 GROUP BY  TO_CHAR(e.hiredate, 'YYYY'), TO_CHAR(e.hiredate, 'MM')
 ORDER BY "�Ի� �⵵", "�Ի� ��"
;

--C ) �⵵�� ,���� �Ի� �ο��� ��� ���¸� ����ǥ ���·� ��ȯ 

-- a) �⵵ ���� : TO_CHAR(e.hiredate, 'YYYY')
--      �� ���� : TO_CHAR(e.hiredate, 'MM')

-- : hiredate ���� ������ ���� ���� 01�� ���� �� 
--   �� ���� ���� ������ 1�� ���� ī��Ʈcount(*)
--   �� ������ 12�� ���� �ݺ� 

SELECT e.empno
     , e.ename 
     , TO_CHAR(e.hiredate, 'YYYY') "�Ի� �⵵"
     , TO_CHAR(e.hiredate, 'MM') "�Ի� ��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '01', 1, 0) "1��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '02', 1, 0) "2��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '03', 1, 0) "3��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '04', 1, 0) "4��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '05', 1, 0) "5��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '06', 1, 0) "6��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '07', 1, 0) "7��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '08', 1, 0) "8��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '09', 1, 0) "9��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '10', 1, 0) "10��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '11', 1, 0) "11��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '12', 1, 0) "12��"
  FROM emp e
 ORDER BY "�Ի� �⵵"
;

-- �׷�ȭ ���� Į���� "�Ի� �⵵"�� ��´�. 
-- �� ���� 1�� ~ 12�� �� 1�� �����ϴ� ������ ����� �ϹǷ� COUNT () ��� 
SELECT TO_CHAR(e.hiredate, 'YYYY') "�Ի� �⵵"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '01', 1)) "1��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '02', 1)) "2��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '03', 1)) "3��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '04', 1)) "4��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '05', 1)) "5��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '06', 1)) "6��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '07', 1)) "7��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '08', 1)) "8��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '09', 1)) "9��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '10', 1)) "10��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '11', 1)) "11��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '12', 1)) "12��"
  FROM emp e
 GROUP BY TO_CHAR(e.hiredate, 'YYYY')
 ORDER BY "�Ի� �⵵"
;

-- ���� �� �Ի� �ο��� ���� ���η� ���
-- �׷�ȭ ���� �÷��� �ʿ� ���� 
SELECT '�ο� ��' AS "�Ի� ��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '01', 1)) "1��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '02', 1)) "2��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '03', 1)) "3��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '04', 1)) "4��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '05', 1)) "5��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '06', 1)) "6��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '07', 1)) "7��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '08', 1)) "8��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '09', 1)) "9��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '10', 1)) "10��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '11', 1)) "11��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '12', 1)) "12��"
  FROM emp e
;
