-- day04 : �ǽ� 4���� 
2 
 
3 -- (6) ������ 2. �񱳿����� 
4 --     �񱳿����ڴ� SELECT ���� ����� �� ���� 
5 --     WHERE, HAVING ������ ����� �� ����. 
6 
 
7 -- 22) �޿��� 2000�� �Ѵ� ������ ���, �̸�, �޿��� ��ȸ 
8 SELECT e.empno ��� 
9      , e.ename �̸� 
10      , e.sal �޿�  
11   FROM emp e 
12  WHERE e.sal > 2000   
13 ;   
14 /* 
15 ���,   �̸�,   �޿� 
16 ---------------------- 
17 7566	JONES	2975 
18 7698	BLAKE	2850 
19 7782	CLARK	2450 
20 7839	KING	5000 
21 7902	FORD	3000 
22 */ 
23 
 
24 
 
25 -- �޿��� 1000 �̻��� ������ ���, �̸�, �޿��� ��ȸ 
26 SELECT e.empno 
27      , e.ename 
28      , e.sal 
29   FROM emp e 
30  WHERE e.sal >= 1000   
31 ;   
32 
 
33 /* 
34 EMPNO,  ENAME,   SAL 
35 --------------------- 
36 7499	ALLEN	1600 
37 7521	WARD	1250 
38 7566	JONES	2975 
39 7654	MARTIN	1250 
40 7698	BLAKE	2850 
41 7782	CLARK	2450 
42 7839	KING	5000 
43 7844	TURNER	1500 
44 7902	FORD	3000 
45 7934	MILLER	1300 
46 */ 
47 
 
48 -- �޿��� 1000 �̻��̸� 2000���� ���� ������  
49 -- ���, �̸�, �޿��� ��ȸ 
50 SELECT e.empno 
51      , e.ename 
52      , e.sal 
53   FROM emp e 
54  WHERE e.sal >= 1000   
55    AND e.sal < 2000 
56 ;   
57 /* 
58 EMPNO,  ENAME,  SAL 
59 -------------------- 
60 7499	ALLEN	1600 
61 7521	WARD	1250 
62 7654	MARTIN	1250 
63 7844	TURNER	1500 
64 7934	MILLER	1300 
65 */ 
66 
 
67 --  comm(����) ���� 0���� ū ������  
68 --  ���, �̸�, �޿�, ������ ��ȸ 
69 SELECT e.empno 
70      , e.ename 
71      , e.sal 
72      , e.comm 
73   FROM emp e 
74  WHERE e.comm > 0   
75 ;   
76 /* 
77 EMPNO,  ENAME,  SAL,   COMM 
78 ---------------------------- 
79 7499	ALLEN	1600	300 
80 7521	WARD	1250	500 
81 7654	MARTIN	1250	1400 
82 */ 
83 
 
84 /* 
85 ==> **���� comm > 0 ������ ���� ������� �� �� �ִ� �� 
86 comm �÷��� ���� (null) �� ������� ���� 
87 ó������ �񱳴�� ���� ������ �����ؾ� �Ѵ�. 
88 (null) ���� �񱳿�����, ��������ڷ� ������ �� ���� ���̴�. 
89 
 
90 ��, ���Ŀ����� null ���� ���� ū ������ ����Ѵ�. 
91 
 
92 */ 
93 
 
94 -- 23) null ������ ���� ���� 
95 --     SALESMAN(�������) ������ ���� ����� ���� ���ɱ��� ����Ͽ� 
96 --     ���, �̸�, ����, �� ���ɱ��� ��ȸ 
97 SELECT e.empno 
98      , e.ename 
99      , e.job 
100      , e.sal 
101      , e.comm 
102      , e.sal + e.comm "�� ���ɱ�" 
103   FROM emp e 
104 ; 
105 -- ==> NULL �����ʹ� ��������ڷ� ���� �Ұ����� �� 
106 SELECT e.empno 
107      , e.ename 
108      , e.job 
109      , e.sal 
110      , e.comm 
111      , e.sal + e.comm "�� ���ɱ�" 
112   FROM emp e 
113  WHERE e.job = 'SALESMAN' 
114 ; 
115 /* 
116 EMPNO,  ENAME,  JOB,        SAL,    COMM,   �� ���ɱ� 
117 ----------------------------------------------------- 
118 7499	ALLEN	SALESMAN	1600	300	    1900 
119 7521	WARD	SALESMAN	1250	500	    1750 
120 7654	MARTIN	SALESMAN	1250	1400	2650 
121 7844	TURNER	SALESMAN	1500	0	    1500 
122 */ 
123 
 
124 -- (6) ������ 3. �������� 
125 --- NOT ������ 
126 
 
127 -- 24) �޿��� 2000 ���� ���� ���� ������ 
128 --     ���, �̸�, �޿��� ��ȸ 
129 SELECT e.empno 
130      , e.ename 
131      , e.sal 
132   FROM emp e 
133  WHERE NOT e.sal < 2000   
134 ; 
135 
 
136 -- ���� ����� ���� �ٸ� ���� 
137 -- NOT �� ������� �ʰ� �ٸ� �񱳿����� ��� 
138 SELECT e.empno 
139      , e.ename 
140      , e.sal 
141   FROM emp e 
142  WHERE e.sal >= 2000   
143 ; 
144 
 
145 /* 
146 EMPNO,  ENAME,  SAL 
147 --------------------- 
148 7566	JONES	2975 
149 7698	BLAKE	2850 
150 7782	CLARK	2450 
151 7839	KING	5000 
152 7902	FORD	3000 
153 */ 
154 
 
155 -- (6) ������ 4. SQL ������ 
156 --- IN ������ : ���ϰ��� �ϴ� ���� ���� 
157 --              ���õ� ��Ͽ� �����ϸ� ������ �Ǵ� 

-- 25) �޿��� 800, 3000, 5000 �߿� �ϳ��� ������ 
--     ���, �̸�, �޿��� ��ȸ 
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

----------------------------------------
--(6) ������ : ���տ����� (||)
--    ����Ŭ���� ����, ���ڿ� ����(����)
--    �ٸ� ���α׷��� ��� (JAVA, C, C++ ��)������ 
--     OR �����ڷ� ���ǹǷ� ȥ���ϸ� �ȵ�!

SELECT 'Hello~, SQL' greeting
  FROM dual
;

SELECT 'Hello~, SQL' || ' in Oracle!' greeting
  FROM dual
;
-- Hello~, SQL in Oracle!

SELECT '�ȳ��ϼ���~, SQL' || ' ����Ŭ���� ���� �־��' greeting
  FROM dual
;
--�ȳ��ϼ���~, SQL ����Ŭ���� ���� �־��
--dual ���̺� Ȱ��, ������ ��¥�� �˷��ִ� ����
--"������ ��¥�� OOOO�Դϴ�." �� ���
SELECT '������ ��¥�� ' || sysdate || '�Դϴ�.' "������ ��¥"  
  FROM dual
;
--������ ��¥�� 19/05/17�Դϴ�.

--��¥ ��� ������ �ٲپ� ���
SELECT '������ ��¥�� '
       || TO_CHAR(sysdate, 'YYYY-MM-D') 
       || '�Դϴ�.' "������ ��¥"  
       FROM dual
;
--������ ��¥�� 2019-05-6�Դϴ�.

-- ������ ��� �˸��̸� ����� �ʹ�.
-- ������ ����� �˷��ִ� ������ ||�� ����Ͽ� �ۼ� 
SELECT '�ȳ��ϼ���.'  || e.ename || '��, ����� ����� '
                      || e.empno || '�Դϴ�.' "��� �˸���" 
  FROM emp e
;
/*
  ��� �˸���
-----------------------------------------------
�ȳ��ϼ���.J_JAMES��, ����� ����� 9999�Դϴ�.
�ȳ��ϼ���.J%JAMES��, ����� ����� 8888�Դϴ�.
�ȳ��ϼ���.SMITH��, ����� ����� 7369�Դϴ�.
�ȳ��ϼ���.ALLEN��, ����� ����� 7499�Դϴ�.
�ȳ��ϼ���.WARD��, ����� ����� 7521�Դϴ�.
�ȳ��ϼ���.JONES��, ����� ����� 7566�Դϴ�.
�ȳ��ϼ���.MARTIN��, ����� ����� 7654�Դϴ�.
�ȳ��ϼ���.BLAKE��, ����� ����� 7698�Դϴ�.
�ȳ��ϼ���.CLARK��, ����� ����� 7782�Դϴ�.
�ȳ��ϼ���.KING��, ����� ����� 7839�Դϴ�.
�ȳ��ϼ���.TURNER��, ����� ����� 7844�Դϴ�.
�ȳ��ϼ���.JAMES��, ����� ����� 7900�Դϴ�.
�ȳ��ϼ���.FORD��, ����� ����� 7902�Դϴ�.
�ȳ��ϼ���.MILLER��, ����� ����� 7934�Դϴ�.
*/
------------------------------------------------
--(6) ������ 6. ���տ����� 
--ù���� ���� : �μ����̺��� ��� ���� ��ȸ => 4�� ������


SELECT d.deptno
     , d.dname
     , d.loc
  FROM dept d
;

-- �ι��� ���� : �μ���ȣ�� 10�� �μ��� ���� ��ȸ  => 1�� ������
SELECT d.deptno
     , d.dname
     , d.loc
  FROM dept d
 WHERE d.deptno = 10 
;

--1) UNION ALL : �ߺ��� ����� ������
SELECT d.deptno
     , d.dname
     , d.loc
  FROM dept d
 UNION ALL
SELECT d.deptno
     , d.dname
     , d.loc
  FROM dept d
 WHERE d.deptno = 10 
;
/*
DEPTNO, DNAME,      LOC
10	    ACCOUNTING	NEW YORK
20	    RESEARCH	DALLAS
30	    SALES	    CHICAGO
40  	OPERATIONS	BOSTON
10  	ACCOUNTING	NEW YORK
*/

-- 2) UNION : �ߺ��� ���� �� ��� ������
SELECT d.deptno
     , d.dname
     , d.loc
  FROM dept d
 UNION 
SELECT d.deptno
     , d.dname
     , d.loc
  FROM dept d
 WHERE d.deptno = 10 
;

--3) INTERSECT : �ߺ��� �����͸� ����(������)
SELECT d.deptno
     , d.dname
     , d.loc
  FROM dept d
INTERSECT
SELECT d.deptno
     , d.dname
     , d.loc
  FROM dept d
 WHERE d.deptno = 10 
;
/*
DEPTNO, DNAME,  LOC
10	    ACCOUNTING	NEW YORK
*/

--4) MINUS : ù���� ���� ���������� 
--           �ι��� ���� �������� �A ������
SELECT d.deptno
     , d.dname
     , d.loc
  FROM dept d
 MINUS
SELECT d.deptno
     , d.dname
     , d.loc
  FROM dept d
 WHERE d.deptno = 10 
;
/*
DEPTNO, DNAME,      LOC
--------------------------
20	    RESEARCH	DALLAS
30	    SALES	    CHICAGO 
40	    OPERATIONS	BOSTON
*/

-- ����! �� �� ������ ��ȸ ����� ī���� ����, ������ Ÿ���� ������ ��ġ 
-- 1)  ������Ȳ : ù���� Į�� �� : 3
-- 2)             �ι��� ���� Į�� �� : 2
SELECT d.deptno
     , d.dname
     , d.loc
  FROM dept d
 MINUS
SELECT d.deptno
     , d.dname
  FROM dept d
 WHERE d.deptno = 10 
;
/*
ORA-01789: ���� ����� ����Ȯ�� ���� ��� ���� ������ �ֽ��ϴ�.
01789. 00000 -  "query block has incorrect number of result columns"
*Cause:    
*Action:
*/

--2) ������Ȳ : ù ������ Į���� ����, ���� ���� 
--              �Ѥ� ������ Į���� ����, ���� ���� 
SELECT d.dname -- �μ��� : ����
     , d.deptno -- �μ���ȣ : ����
  FROM dept d
 MINUS
SELECT d.deptno -- �μ���ȣ : ����
     , d.dname -- �μ��� : ���� 
  FROM dept d 
 WHERE d.deptno = 10 
;
/*
ORA-01790: �����ϴ� �İ� ���� ������ �����̾�� �մϴ�
01790. 00000 -  "expression must have same datatype as corresponding expression"
*Cause:    
*Action:
458��, 8������ ���� �߻�
*/

-- ���� �����ڴ� ���� �ٸ� ���̺��� ��ȸ ����� 
-- ������ �����ϴ�. 
-- ù���� ���� : emp ���̺��� ��ȸ 
SELECT e.empno -- ���� 
     , e.ename -- ����
     , e.job   -- ����
  FROM emp e
  
-- �ι��� ���� : dept ���̺��� ��ȸ 
SELECT d.deptno
     , d.dname
     , d.loc
  FROM dept d
;

-- ���� �ٸ� ���̺��� �ߺ����� �� ��� ������ -
-- UNION
SELECT e.empno -- ���� 
     , e.ename -- ����
     , e.job   -- ����
  FROM emp e
 UNION
SELECT d.deptno -- ����
     , d.dname --  ����
     , d.loc   --  ����
  FROM dept d
;
/* �������� �÷����� ù���� ������ �÷� �̸��� ���õ� 
EMPNO,  ENAME,      JOB
----------------------------
10  	ACCOUNTING	NEW YORK
20  	RESEARCH	DALLAS
30    	SALES	    CHICAGO
40	    OPERATIONS	BOSTON
7369	SMITH	    CLERK
7499	ALLEN   	SALESMAN
7521	WARD    	SALESMAN
7566	JONES   	MANAGER
7654	MARTIN  	SALESMAN
7698	BLAKE   	MANAGER
7782	CLARK    	MANAGER
7839	KING    	PRESIDENT
7844	TURNER  	SALESMAN
7900	JAMES    	CLERK
7902	FORD	    ANALYST
7934	MILLER	    CLERK
8888	J%JAMES  	CLERK
9999	J_JAMES 	CLERK
*/
SELECT e.empno -- ���� 
     , e.ename -- ����
     , e.job   -- ����
  FROM emp e
 MINUS
SELECT d.deptno -- ����
     , d.dname --  ����
     , d.loc   --  ����
  FROM dept d
;
/*
EMPNO,  ENAME,      JOB
----------------------------
7369	SMITH	    CLERK
7499	ALLEN   	SALESMAN
7521	WARD    	SALESMAN
7566	JONES   	MANAGER
7654	MARTIN  	SALESMAN
7698	BLAKE   	MANAGER
7782	CLARK    	MANAGER
7839	KING    	PRESIDENT
7844	TURNER  	SALESMAN
7900	JAMES    	CLERK
7902	FORD	    ANALYST
7934	MILLER	    CLERK
8888	J%JAMES  	CLERK
9999	J_JAMES 	CLERK
*/

-- (3) INTERSECT (������)
SELECT e.empno -- ���� 
     , e.ename -- ����
     , e.job   -- ����
  FROM emp e
 MINUS
SELECT d.deptno -- ����
     , d.dname --  ����
     , d.loc   --  ����
  FROM dept d
;
--> ����� ��� ��:0  ==> ��ȸ����, ����� ���� �� 
-- ���� �ٸ� ���̺��� ������ ��ȸ ������� ���� �����̹Ƿ� 
-- �ߺ��� �����Ͱ� �����Ƿ� ������ ����� 1�൵ ����.
