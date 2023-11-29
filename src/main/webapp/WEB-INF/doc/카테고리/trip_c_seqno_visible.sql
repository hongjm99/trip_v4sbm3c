/**********************************/
/* Table Name: 카테고리 */
/**********************************/
DROP TABLE TRIP;

CREATE TABLE TRIP(
		TRIPNO                        		NUMBER(10)		 NOT NULL PRIMARY KEY,
		NAME                          		VARCHAR2(30)	 NOT NULL,
		CNT                           		NUMBER(7)		 DEFAULT 0 NOT NULL,
		RDATE                         		DATE		     NOT NULL,
        SEQNO                               NUMBER(5)        DEFAULT 1 NOT NULL,
        VISIBLE                             CHAR(1)          DEFAULT 'N' NOT NULL  
);

COMMENT ON TABLE TRIP is '여행';
COMMENT ON COLUMN TRIP.TRIPNO is '태안 번호';
COMMENT ON COLUMN TRIP.NAME is '태안 이름';
COMMENT ON COLUMN TRIP.CNT is '관련 자료수';
COMMENT ON COLUMN TRIP.RDATE is '등록일';
COMMENT ON COLUMN TRIP.SEQNO is '출력 순서';
COMMENT ON COLUMN TRIP.VISIBLE is '출력 모드';

DROP SEQUENCE TRIP_SEQ;

CREATE SEQUENCE TRIP_SEQ
  START WITH 1         -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2              -- 2번은 메모리에서만 계산
  NOCYCLE;             -- 다시 1부터 생성되는 것을 방지
  
-- CREATE
INSERT INTO trip(tripno, name, cnt, rdate) VALUES(trip_seq.nextval, '경기도', 0, sysdate); 
INSERT INTO trip(tripno, name, cnt, rdate) VALUES(trip_seq.nextval, '강원도', 0, sysdate); 
INSERT INTO trip(tripno, name, cnt, rdate) VALUES(trip_seq.nextval, '충청남도', 0, sysdate); 

-- READ: LIST
SELECT * FROM trip;
SELECT tripno, name, cnt, rdate, seqno FROM trip ORDER BY tripno ASC;
    CATENO NAME                                  CNT RDATE              
---------- ------------------------------ ---------- -------------------
         1 경기도                                  0 2023-09-06 12:09:45
         2 강원도                                  0 2023-09-06 12:10:49
         3 충청남도                                0 2023-09-06 12:10:49

-- READ
SELECT tripno, name, cnt, rdate FROM trip WHERE tripno=1;
    CATENO NAME                                  CNT RDATE              
---------- ------------------------------ ---------- -------------------
         1 경기도                                  0 2023-09-06 12:09:45
         
-- UPDATE
UPDATE trip SET name='전라도', cnt=1 WHERE tripno=1;
    CATENO NAME                                  CNT RDATE              
---------- ------------------------------ ---------- -------------------
         1 전라도                                  1 2023-09-06 12:09:45

-- DELETE
DELETE FROM cate WHERE tripno=1;
DELETE FROM cate WHERE tripno >= 10;

COMMIT;

-- COUNT
SELECT COUNT(*) as cnt FROM trip;
       CNT
----------
         2

-- 우선 순위 높임, 10 등 -> 1 등
UPDATE trip SET seqno = seqno - 1 WHERE tripno=1;
SELECT tripno, name, cnt, rdate, seqno FROM trip ORDER BY tripno ASC;

-- 우선 순위 낮춤, 1 등 -> 10 등
UPDATE trip SET seqno = seqno + 1 WHERE tripno=1;
SELECT tripno, name, cnt, rdate, seqno FROM trip ORDER BY tripno ASC;

-- READ: LIST
SELECT tripno, name, cnt, rdate, seqno FROM trip ORDER BY seqno ASC;

COMMIT;

-- 카테고리 공개 설정
UPDATE trip SET visible='Y' WHERE tripno=1;
SELECT tripno, name, cnt, rdate, seqno, visible FROM trip ORDER BY tripno ASC;

-- 카테고리 비공개 설정
UPDATE trip SET visible='N' WHERE tripno=1;
SELECT tripno, name, cnt, rdate, seqno, visible FROM trip ORDER BY tripno ASC;

COMMIT;

-- 비회원/회원 SELECT LIST, id: list_all_y
SELECT tripno, name, cnt, rdate, seqno, visible 
FROM trip 
WHERE visible='Y'
ORDER BY seqno ASC;

    CATENO NAME                                  CNT RDATE                    SEQNO V
---------- ------------------------------ ---------- ------------------- ---------- -
         2 강원도                                  0 2023-09-13 12:18:46          1 Y


         




