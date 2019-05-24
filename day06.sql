1 -- day06 
2 ----- 2) �����Լ� 
3 -------- 1. INITCAP(str) : str �� ù ���ڸ� �빮��ȭ(����) 
4 SELECT initcap('the watch') -- The Watch 
5   FROM dual 
6 ; 
7 SELECT initcap('�ȳ��ϼ���. ������') -- �ȳ��ϼ���. ������ 
8   FROM dual 
9 ; 
10 
 
11 -------- 2. LOWER(str) : str�� ��� ���ڸ� �ҹ���ȭ(����) 
12 SELECT lower('MR. SCOTT MCMILLAN') "�ҹ��ڷ� ����" 
13   FROM dual 
14 ; 
15 -- mr. scott mcmillan 
16 
 
17 -------- 3. UPPER(str) : str�� ��� ���ڸ� �빮��ȭ(����) 
18 SELECT upper('lee') "���� �빮�ڷ� ����" 
19   FROM dual 
20 ;   
21 
 
22 SELECT upper('sql is cooooooooooooooool~!!!') "��վ��!" 
23   FROM dual 
24 ;  
25 
 
26 -- smith �� ã�µ� �Է��� �ҹ��ڷ� �� ��쿡 
27 -- SMITH �� �ٸ� ���ڷ� �νĵǹǷ� ã�� �� ����. 
28 SELECT e.empno 
29      , e.ename 
30   FROM emp e 
31  WHERE e.ename = 'smith'   
32 ;   
33 -- ����� ��� ��:0 
34 SELECT e.empno 
35      , e.ename 
36   FROM emp e 
37  WHERE e.ename = 'SMITH'   
38 ; 
39 -- ename �� ���ϴ� ���� �빮�� �̹Ƿ� ������ ��ȸ ��. 
40 SELECT e.empno 
41      , e.ename 
42   FROM emp e 
43  WHERE e.ename = upper('smith') 
44 ;   
45 /* 
46 EMPNO,  ENAME 
47 ---------------- 
48 7369	SMITH 
49 */ 
50 
 
51 -------- 4. LENGTH(str), LENGTHB(str) :  
52 --         str�� ���ڱ���, ������ byte �� ����Ͽ� ���ڷ� ��� 
53 SELECT length('hello, sql') as "���� ����" 
54   FROM dual 
55 ;   
56 --���: 10 ==> Ư����ȣ, ���鵵 ���� ���̷� ��� 
57 SELECT 'hello, sql�� ���� ���̴� ' || length('hello, sql')  
58                                    || '�Դϴ�.' "���� ����" 
59   FROM dual 
60 ; 
61 /* 
62 ���� ���� 
63 ---------------------------------- 
64 hello, sql�� ���� ���̴� 10�Դϴ�. 
65 */ 
66 
 
67 ---- oracle���� �ѱ��� 3byte �� ��� 
68 SELECT lengthb('hello, sql') "���� byte" 
69   FROM dual 
70 ;   
71 -- ��� : 10 ==> �����ڴ� 1byte �Ҵ� 
72 SELECT lengthb('����Ŭ') "���� byte" 
73   FROM dual 
74 ;   
75 -- ��� : 9 ==> �ѱ��� 3byte �Ҵ� 

------------5. CONCAT (str1, st2) : str1�� str2�� ���ڿ� ���� 
--                                  || �����ڿ� ������ ��� 
SELECT concat('�ȳ��ϼ���.','SQL!')"�λ�"
  FROM dual
;
/*
�λ�
--------------
�ȳ��ϼ���.SQL!
--concat('�ȳ��ϼ���.','SQL')�� ���� ����� ���� || ���� ��� 
*/
SELECT ('�ȳ��ϼ���.'|| 'SQL!') "�λ�"
  FROM dual
;

--------6. SUBSTR(str,i,n) : 
--         str ���� i���� ��ġ������ n���� ���ڸ� ����
--         SQL ���� ���ڿ��� �ε���(����)�� 1���� ����
SELECT substr('SQL is cooooooooooooool~!!',3,4)--3���� ���ں��� �����ϴ� 4�� ���� ��� 
  FROM dual
;
/*
L is
*/
---------  SUBSTR(str, i) :
--         str���� i���� ��ġ���� ������ ���ڸ� ����
SELECT substr('SQL is cooooooooooooool~!!',3)
  FROM dual
;
/*
L is cooooooooooooool~!!
*/
-- ���� SQL is cooooooooooooool~! SQL�� ����
SELECT substr('SQL is cooooooooooooool~!!',1,3)
  FROM dual
;

-- ���� SQL is cooooooooooooool~! is�� ����
SELECT substr('SQL is cooooooooooooool~!!',5,2)
  FROM dual
;
-- ���� SQL is cooooooooooooool~! ~!�� ����
SELECT substr('SQL is cooooooooooooool~!!',24)
  FROM dual
;
--���� : EMP ���̺��� ������ �̸��� �� �α��ڱ����� �����Ͽ�
--       ����� �Բ� ��ȸ�Ͻÿ�.
SELECT substr(e.ename,1,2) "�� �α���"
     , e.empno
  FROM emp e
;
/*
�� �α���, EMPNO
---------------
J_	       9999
J%	       8888
SM	       7369
AL	       7499
WA	       7521
JO	       7566
MA	       7654
BL	       7698
CL	       7782
KI	       7839
TU	       7844
JA	       7900
FO	       7902
MI	       7934
*/  

----------- 7. INSTR(str1,str2) : 
--          �ι��� ���ڿ��� str2�� 
--          ù���� ���ڿ��� str1�� ��� ��ġ�ϴ��� 
--          �����ϴ� ��ġ�� ����Ͽ� ���ڷ� ��� 
SELECT instr('SQL is cooooooooooooool~!!','is')  "is ��ġ"
  FROM dual
;
/*
is ��ġ
5
*/
SELECT instr('SQL is cooooooooooooool~!!','io')  "io ��ġ"
  FROM dual
;
/* �ι��� ���ڿ��� ù���� ���ڿ��� ������ 0�� ����Ѵ�.
io�� ��ġ
---------
        0
*/
------------------8. LPAD, RPAD(str, n, c) : 
--                   �Էµ� str�� ���ؼ� ��ü ���ڰ� ������ �ڸ����� n���� ��� 
--                   ��ü ���ڼ� ��� ���� / �����ʿ� ���� �ڸ����� 
--                   c�� ���ڸ� ä���ִ´�.
SELECT lpad('SQL is cool!',20,'*') "20ĭ ���� *�� ä��� ���ʿ�"
  FROM dual
;
/*
20ĭ ���� *�� ä���
--------------------
********SQL is cool!
*/
SELECT rpad('SQL is cool!',20,'*') "20ĭ ���� *�� ä��� �����ʿ�"
  FROM dual
;
/*
20ĭ ���� *�� ä���
--------------------
SQL is cool!********
*/

----------9. LTRIM , RTRIM,  TRIM : �Էµ� ���ڿ���
--           ����,   ������  ���� ������ ����
SELECT '>' || '     sql is cool     ' || '<'
  FROM dual
;
/*
>     sql is cool     <
*/
SELECT '>' || ltrim('     sql is cool     ') || '<'
  FROM dual
;
/*
>sql is cool     <
*/
SELECT '>' || rtrim('     sql is cool     ') || '<'
  FROM dual
;
/*
>     sql is cool<
*/
SELECT '>' || trim('     sql is cool     ') || '<'
  FROM dual
;
/*
>sql is cool<
*/
--
SELECT e.empno
    ,  e.ename
  FROM emp e
 WHERE e.ename = '        SMITH';
--����� ��� �� : 0 ==> ������ �� ���� 'SMITH'�� �ٸ��Ƿ� ��ȸ���� �ʽ��ϴ�.
SELECT e.empno
    ,  e.ename
  FROM emp e
 WHERE e.ename = trim('        SMITH')
;
/*
EMPNO,  ENAME
--------------
7369	SMITH
*/
-- trim �Լ��� �����Ͽ� ��ȸ ����

-- ���� : �񱳰��� '    smith ' �� �� SMITH �� ������ ��ȸ�Ͻÿ�.
SELECT e.ename
  FROM emp e
 WHERE e.ename = upper(trim('    smith ') )
;
/*
ENAME
-----
SMITH
*/
-------------- 10 . NVL(expr1, expr2)
--                  NVL2(expr1, expr2, expr3)
--                  NULLIF(expr1, expr2)
-- NVL(expr1, expr2): ù���� ���� ���� NULL �̸�
--                    �ι��� ������ ��ü�Ͽ� ���

-- �ų���(mgr)�� �������� ���� ������ ��� 
-- 0���� ��ü�Ͽ� ���'�Ŵ��� ����'
SELECT e.empno
    ,  e.ename
    , nvl(e.mgr, 0) "�Ŵ��� ���"
  FROM emp e
;
/*
EMPNO,  ENAME,  �Ŵ��� ���
9999	J_JAMES	0
8888	J%JAMES	0
7369	SMITH	7902
7499	ALLEN	7698
7521	WARD	7698
7566	JONES	7839
7654	MARTIN	7698
7698	BLAKE	7839
7782	CLARK	7839
7839	KING	0
7844	TURNER	7698
7900	JAMES	7698
7902	FORD	7566
7934	MILLER	7782
*/

-- �Ŵ���(mgr)�� �������� ���� ������ 
-- '�Ŵ��� ����' ��� ����Ͻÿ�
SELECT e.empno
    ,  e.ename
    , nvl(e.mgr, '�Ŵ��� ����') "�Ŵ��� ���"
 FROM emp e
;
/*
ORA-01722: ��ġ�� �������մϴ�
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.


=> nvl ó�� ��� �÷��� e.mgr �� ����Ÿ���� ������ �� ���� ����Ÿ���̶� 
-- NULL ���� ��ü�� �� �ش��÷��� Ÿ�԰� ����ġ �ϱ� ������
-- ����� ���������� �߻��մϴ�.
*/

-- ==> �ذ��� e.mgr �� ����Ÿ������ ����
SELECT e.empno
    ,  e.ename
    , nvl(e.mgr || '', '�Ŵ��� ����') "�Ŵ��� ���"
 FROM emp e
;
-- || ���� �����ڵ� mgr �� ���ڸ� �ٿ��� ����Ÿ������ ����
/*
EMPNO,  ENAME,  �Ŵ��� ���
---------------------------
9999	J_JAMES	�Ŵ��� ����
8888	J%JAMES	�Ŵ��� ����
7369	SMITH	7902
7499	ALLEN	7698
7521	WARD	7698
7566	JONES	7839
7654	MARTIN	7698
7698	BLAKE	7839
7782	CLARK	7839
7839	KING	�Ŵ��� ����
7844	TURNER	7698
7900	JAMES	7698
7902	FORD	7566
7934	MILLER	7782
*/
-- ���� : || ������ ��� concat() �Լ��� ����Ͽ� ���� ����� ���ÿ�
SELECT e.empno
    ,  e.ename
    ,  nvl(concat(e.mgr,''), '�Ŵ��� ����') "�Ŵ��� ���" 
 FROM  emp e
;
-- ����Ŭ ������ �� ���ڿ�('')�� NULL �� ���

-- NUL2(expr1,expr2,expr3 ) : 
--     ù���� ���� ���� NOT NULL �̸� �ι��� ���� ������ ���
--                      NULL �̸� ������ ���� ������ ���

-- �Ŵ���(mrg)�� ������ ��쿡�� '�Ŵ��� ����'����
-- �Ŵ����� �������� ���� ���״� '�Ŵ��� ����'���� ���
SELECT e.empno
    ,  e.ename
    ,  nvl2(e.mgr, '�Ŵ��� ����','�Ŵ��� ����') "�Ŵ��� ��/��" 
 FROM  emp e
;
/*
EMPNO,  ENAME,  �Ŵ��� ��/��
---------------------------
9999	J_JAMES	�Ŵ��� ����
8888	J%JAMES	�Ŵ��� ����
7369	SMITH	�Ŵ��� ����
7499	ALLEN	�Ŵ��� ����
7521	WARD	�Ŵ��� ����
7566	JONES	�Ŵ��� ����
7654	MARTIN	�Ŵ��� ����
7698	BLAKE	�Ŵ��� ����
7782	CLARK	�Ŵ��� ����
7839	KING	�Ŵ��� ����
7844	TURNER	�Ŵ��� ����
7900	JAMES	�Ŵ��� ����
7902	FORD	�Ŵ��� ����
7934	MILLER	�Ŵ��� ����
*/

--����Ŭ���� �� ���ڿ�('')�� NULL �� ����ϴ� ���� 
--Ȯ���ϱ� ���� ���� 
SELECT e.empno
    ,  e.ename
    ,  nvl2(e.mgr, '�Ŵ��� ����','�Ŵ��� ����') "�Ŵ��� ��/��" 
 FROM  emp e;
/*
NULL �� ����
-----------
IS NULL
*/
-- �Է��� 1ĭ ¥�� ����
SELECT nvl2(' ','IS NOT NULL','IS NULL') "NULL �� ����"
  FROM dual
;
/*
NULL �� ���� 
-----------
IS NOT NULL
*/

-- NULLIF(expr1, expr2) : 
-- ù���� ��, �ι��� ���� ���� �����ϸ� NULL �� ���
-- �� ���� �ٸ��� ù���� ���� ���� ���
SELECT nullif('AAA','bbb') as "NULLIF ���" ---AAA
  FROM dual
;
/*
NULLIF ��� 
AAA
*/
SELECT nullif('AAA','AAA') as "NULLIF ���" ---AAA
  FROM dual
;
/*
NULLIF ���
-----------
(null)
*/
-- ��ȸ�� ��� ���� 1���� �����ϰ� �װ��� NULL �� ���� 
-- 1���̶� ��ȸ�� �� ���� "����� ��� �� : 0" �� �ٸ��ٴ� �Ϳ� ����

-----------------3) ��¥�Լ� : ��¥�� ���õ� ���/ ��¥�� ���ϱ� ���� ���� ������ 
--                             �� �� �ִ� ����� ���� 

-- ������ �ý��� �ð��� ��� sysdate �Լ� 
SELECT sysdate
  FROM dual
;
/*
SYSDATE
-------
19/05/24 ==>  ����Ŭ�� ���� �⺻ ���� YY/MM/DD
*/

-- TO_CHAR(arg) : arg�� ����, ��¥ Ÿ���� �����Ͱ� �� �� �ִ�.
--                �Էµ� arg�� ����Ÿ������ �������ִ� �Լ�
SELECT to_char(sysdate,'YYYY') "�⵵" --2019
  FROM dual
;
SELECT to_char(sysdate,'YY') "�⵵" --19
  FROM dual
;
SELECT to_char(sysdate,'MM') "��"  -- 05��
  FROM dual
;
SELECT to_char(sysdate,'MONTH') "��"  -- 5��
  FROM dual
;
SELECT to_char(sysdate,'MON') "��"  -- 5��
  FROM dual
;
SELECT to_char(sysdate,'DD') "��"  -- 24��
  FROM dual  
;
  SELECT to_char(sysdate,'D') "����"  -- 6 : �ݿ����� ���ڴ� 6
  FROM dual
;
  SELECT to_char(sysdate,'DY') "����"  -- �ݿ���
  FROM dual
;

  SELECT to_char(sysdate,'YYYY-MM-DD') "���� ��¥" -- 2019/05/24  
  FROM dual
;

  SELECT to_char(sysdate,'YY-MON-DD') "���� ��¥" -- 19/5�� - 24��
  FROM dual
;

  SELECT to_char(sysdate,'YY-MON-DD DY') "���� ��¥" -- 19-5�� -24 ��  
  FROM dual
;

/*
�ð� ���� :
 HH : �ð��� ���ڸ� ǥ�� 
 MI : ���� ���ڸ��� ǥ�� 
 SS : �ʸ� ���ڸ��� ǥ�� 
 HH24 : �ð��� 24�ð� ü��� ǥ�� 
 AM : �������� �������� ǥ�� 
*/

  SELECT to_char(sysdate,'YY-MON-DD DY HH24:MI:SS') "���� ��¥ �ú���" -- 19-5�� -24 �� 15:30:22
  FROM dual
;

 SELECT to_char(sysdate,'YY-MON-DD DY AM:HH:MI:SS') "���� ��¥ �ú���" -- 19-5�� -24 �� 15:30:22
  FROM dual
;
--19-5�� -24 �� ����:03:42:59

  SELECT to_char(sysdate,'YY-MON-DD DY AM:HH24:MI:SS') "���� ��¥ �ú���" -- 19-5�� -24 �� 15:30:22
  FROM dual
;
--19-5�� -24 �� ����:15:42:10 <= AM ���Ϲ��ڸ� �����ϸ� ����/���� ������

-- ��¥ ���� ������ ���� : +,- �����ڸ� ��� 
-- �������κ��� 10�� �� 
SELECT sysdate + 10
  FROM dual
;
/*
19/06/03(���� ��¥ : 19/05/24 �ϋ�)
*/
SELECT sysdate - 10
  FROM dual
;
--19/05/14 
SELECT sysdate + 10/24
  FROM dual
;
--19/05/25 10�ð���

--10�ð� �ĸ� ��/��/�� ���� ���
  SELECT to_char(sysdate+ 10/24,'YY-MON-DD DY AM:HH24:MI:SS') "10�ð� ��" -- 19-5�� -25 �� ����:01:47:45
  FROM dual
;

----------------1. MONTHS_BETWEEN(��¥1, ��¥2) : 
--                 �� ��¥ ������ ���� ���� 

--�� ������ �Ի��� ���κ��� ������� ����� �ٹ��ߴ��� ��ȸ�Ͻÿ�.
SELECT e.empno
     , e.ename
     ,  MONTHS_BETWEEN(sysdate, e.hiredate) "�ټ� ���� �� " 
  FROM emp e
;
/*
EMPNO,  ENAME,  �ټ� ���� �� 
9999	J_JAMES	
8888	J%JAMES	
7369	SMITH	461.247178166069295101553166069295101553
7499	ALLEN	459.150403972520908004778972520908004779
7521	WARD	459.085887843488649940262843488649940263
7566	JONES	457.731049133811230585424133811230585424
7654	MARTIN	451.892339456391875746714456391875746714
7698	BLAKE	456.763307198327359617682198327359617682
7782	CLARK	455.505242682198327359617682198327359618
7839	KING	450.247178166069295101553166069295101553
7844	TURNER	452.537500746714456391875746714456391876
7900	JAMES	449.698791069295101553166069295101553166
7902	FORD	449.698791069295101553166069295101553166
7934	MILLER	448.053629778972520908004778972520908005
*/

--�� ������ �ټ� �������� ���ϵ�
--�Ҽ��� 1�� �ڸ������� ����Ͻÿ�.
--�̋�, �Ҽ��� 2�� �ڸ����� �ݿø�
SELECT e.empno
     , e.ename
     , ROUND(MONTHS_BETWEEN(sysdate, e.hiredate),1) "�ټ� ���� �� " 
  FROM emp e
;

---------------2. ADD_MONTHS(��¥, ����) : 
--                ��¥�� ���ڸ� ���Ѹ�ŭ ���� ��¥�� ���� 
SELECT add_months(sysdate, 3)
  FROM dual
;
-- ��¥ + ���� : ���� ��ŭ�� �� ���� ���Ͽ� ��¥�� ���� 
-- ��¥ + ����/24 : ���� ��ŭ�� �ð��� ���Ͽ� ��¥�� ���� 
-- ADD_MONTHS(��¥, ����) : ���� ��ŭ�� ���� ���Ͽ� ��¥�� ���� 

----------------3. NEXT_DAY , LAST_DAY
--                 ���� ���Ͽ� �ش��ϴ� ��¥�� ���� 
--                 �̴��� ������ ��¥�� ���� 

-- ���� ��¥���� ���ƿ��� ��(4)������ ��¥�� ���� 
SELECT next_day(sysdate, 4) "���ƿ��� ������"
  FROM dual
;

SELECT next_day(sysdate, '������')"���ƿ��� ������"
  FROM dual
;

SELECT last_day(sysdate)"�� ���� ������ ��"
  FROM dual
;

----------- 4. ROUDN, TRUNC : ��¥�� ���� �ݿø�, ���� ���� 
SELECT round(sysdate) "���� �ð����� �ݿø�"
  FROM dual
;

-- ���� : ���� �ð����� �ݿø� �� ��¥�� ��/��/�� ���� ���
SELECT to_char(round(sysdate),'YYYY-MM-DD HH24:MI:SS')
  FROM dual
;

SELECT trunc(sysdate))  "���� �ð����� �ú��� ����" 
 FROM dual
;

SELECT to_char(trunc(sysdate),'YYYY-MM-DD HH24:MI:SS' )  "���� �ð����� �ú��� ����" 
 FROM dual
;