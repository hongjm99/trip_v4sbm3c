/**********************************/
/* Table Name: 여행 */
/**********************************/
DROP TABLE TRIP;

CREATE TABLE TRIP(
    TRIPNO                          NUMBER(10)     NOT NULL    PRIMARY KEY,
    NAME                              VARCHAR2(30)     NOT NULL,
    CNT                              NUMBER(10)  DEFAULT 0   NOT NULL,
    RDATE                              DATE     NOT NULL
);

COMMENT ON TABLE TRIP is '여행';
COMMENT ON COLUMN TRIP.TRIPNO is '태안 번호';
COMMENT ON COLUMN TRIP.NAME is '태안 이름';
COMMENT ON COLUMN TRIP.CNT is '관련 자료수';
COMMENT ON COLUMN TRIP.RDATE is '등록일';

DROP SEQUENCE TRIP_SEQ;

CREATE SEQUENCE TRIP_SEQ
  START WITH 1         -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2              -- 2번은 메모리에서만 계산
  NOCYCLE;  

-- CREATE

INSERT INTO trip(tripno, name, cnt, rdate) VALUES(trip_seq.nextval, '안면도', 0, sysdate);
INSERT INTO trip(tripno, name, cnt, rdate) VALUES(trip_seq.nextval, '밧개해수욕장', 0, sysdate);
INSERT INTO trip(tripno, name, cnt, rdate) VALUES(trip_seq.nextval, '천리포수목원', 0, sysdate);

-- READ: LIST
SELECT tripno, name, cnt, rdate FROM trip ORDER BY tripno ASC;

-- READ
SELECT tripno, name, cnt, rdate FROM trip WHERE tripno=1;

-- UPDATE
UPDATE trip SET name='보령', cnt=1 WHERE tripno=13;

-- DELETE
DELETE FROM trip WHERE cateno=13;
DELETE FROM trip WHERE cateno>=14;

COMMIT;

SELECT * FROM trip;

DESCRIBE trip;