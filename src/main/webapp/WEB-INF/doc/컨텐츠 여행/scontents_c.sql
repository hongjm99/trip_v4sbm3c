DROP TABLE scontents CASCADE CONSTRAINTS; -- 자식 무시하고 삭제 가능
DROP TABLE scontents;

CREATE TABLE scontents(
        scontentsno                            NUMBER(10)         NOT NULL         PRIMARY KEY,
        managerno                              NUMBER(10)     NOT NULL , -- FK
        tripno                                NUMBER(10)         NOT NULL , -- FK
        title                                 VARCHAR2(200)         NOT NULL,
        content                               CLOB                  NOT NULL,
        recom                                 NUMBER(7)         DEFAULT 0         NOT NULL,
        cnt                                   NUMBER(7)         DEFAULT 0         NOT NULL,
        replycnt                              NUMBER(7)         DEFAULT 0         NOT NULL,
        passwd                                VARCHAR2(15)         NOT NULL,
        word                                  VARCHAR2(100)         NULL ,
        rdate                                 DATE               NOT NULL,
        file1                                   VARCHAR(100)          NULL,  -- 원본 파일명 image
        file1saved                            VARCHAR(100)          NULL,  -- 저장된 파일명, image
        thumb1                              VARCHAR(100)          NULL,   -- preview image
        size1                                 NUMBER(10)      DEFAULT 0 NULL,  -- 파일 사이즈
        price                                 NUMBER(10)      DEFAULT 0 NULL,  
        dc                                    NUMBER(10)      DEFAULT 0 NULL,  
        saleprice                            NUMBER(10)      DEFAULT 0 NULL,  
        point                                 NUMBER(10)      DEFAULT 0 NULL,  
        salecnt                               NUMBER(10)      DEFAULT 0 NULL,
        map                                   VARCHAR2(1000)            NULL,
        youtube                               VARCHAR2(1000)            NULL,
        FOREIGN KEY (managerno) REFERENCES manager(managerno),
        FOREIGN KEY (tripno) REFERENCES trip (tripno)
);

COMMENT ON TABLE scontents is '컨텐츠 - 둘렛길';
COMMENT ON COLUMN scontents.scontentsno is '컨텐츠 번호';
COMMENT ON COLUMN scontents.managerno is '관리자 번호';
COMMENT ON COLUMN scontents.tripno is '태안 번호';
COMMENT ON COLUMN scontents.title is '제목';
COMMENT ON COLUMN scontents.content is '내용';
COMMENT ON COLUMN scontents.recom is '추천수';
COMMENT ON COLUMN scontents.cnt is '조회수';
COMMENT ON COLUMN scontents.replycnt is '댓글수';
COMMENT ON COLUMN scontents.passwd is '패스워드';
COMMENT ON COLUMN scontents.word is '검색어';
COMMENT ON COLUMN scontents.rdate is '등록일';
COMMENT ON COLUMN scontents.file1 is '메인 이미지';
COMMENT ON COLUMN scontents.file1saved is '실제 저장된 메인 이미지';
COMMENT ON COLUMN scontents.thumb1 is '메인 이미지 Preview';
COMMENT ON COLUMN scontents.size1 is '메인 이미지 크기';
COMMENT ON COLUMN scontents.price is '정가';
COMMENT ON COLUMN scontents.dc is '할인률';
COMMENT ON COLUMN scontents.saleprice is '판매가';
COMMENT ON COLUMN scontents.point is '포인트';
COMMENT ON COLUMN scontents.salecnt is '수량';
COMMENT ON COLUMN scontents.map is '지도';
COMMENT ON COLUMN scontents.youtube is 'Youtube 영상';

DROP SEQUENCE scontents_seq;

CREATE SEQUENCE scontents_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지

-- 등록 화면 유형 1: 커뮤니티(공지사항, 게시판, 자료실, 갤러리,  Q/A...)글 등록
INSERT INTO scontents(scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(scontents_seq.nextval, 1, 1, '태안', '태안에서 가까움 명품 산책로', 0, 0, 0, '123',
       '산책', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);

-- 유형 1 전체 목록
SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1
FROM scontents
ORDER BY scontentsno DESC;

-- 유형 2 카테고리별 목록
INSERT INTO scontents(scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(scontents_seq.nextval, 1, 2, '대행사', '흙수저와 금수저의 성공 스토리', 0, 0, 0, '123',
       '드라마,K드라마,넷플릭스', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);
            
INSERT INTO scontents(scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(scontents_seq.nextval, 1, 2, '더글로리', '학폭의 결말', 0, 0, 0, '123',
       '드라마,K드라마,넷플릭스', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);

INSERT INTO scontents(scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(scontents_seq.nextval, 1, 2, '더글로리', '학폭의 결말', 0, 0, 0, '123',
       '드라마,K드라마,넷플릭스', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);

COMMIT;

-- 1번 tripno 만 출력
SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM scontents
WHERE tripno=1
ORDER BY scontentsno DESC;

-- 2번 tripno 만 출력
SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM scontents
WHERE tripno=2
ORDER BY scontentsno ASC;

-- 3번 tripno 만 출력
SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM scontents
WHERE tripno=3
ORDER BY scontentsno ASC;

SELECT scontentsno, tripno, file1, file1saved
FROM scontents
WHERE tripno=7 AND scontentsno = 14 
ORDER BY scontentsno ASC;

-- 모든 레코드 삭제
DELETE FROM scontents;
commit;

-- 삭제
DELETE FROM scontents
WHERE scontentsno = 2;
commit;

DELETE FROM scontents WHERE tripno = 2;

DELETE FROM scontents
WHERE tripno=12 AND scontentsno <= 41;

commit;
-- 여기까지 수정완료

-- ----------------------------------------------------------------------------------------------------
-- 검색, tripno별 검색 목록
-- ----------------------------------------------------------------------------------------------------
-- 모든글
SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, word, rdate,
       file1, file1saved, thumb1, size1, map, youtube
FROM scontents
ORDER BY scontentsno ASC;

-- 카테고리별 목록
SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, word, rdate,
       file1, file1saved, thumb1, size1, map, youtube
FROM scontents
WHERE tripno=2
ORDER BY scontentsno ASC;

-- 1) 검색
-- ① tripno별 검색 목록
-- word 컬럼의 존재 이유: 검색 정확도를 높이기 위하여 중요 단어를 명시
-- 글에 'swiss'라는 단어만 등장하면 한글로 '스위스'는 검색 안됨.
-- 이런 문제를 방지하기위해 'swiss,스위스,스의스,수의스,유럽' 검색어가 들어간 word 컬럼을 추가함.
SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM scontents
WHERE tripno=2 AND word LIKE '%드라마%'
ORDER BY scontentsno DESC;

-- title, content, word column search
SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM scontents
WHERE tripno=2 AND (title LIKE '%드라마%' OR content LIKE '%드라마%' OR word LIKE '%드라마%')
ORDER BY scontentsno DESC;

-- ② 검색 레코드 갯수
-- 전체 레코드 갯수, 집계 함수
SELECT COUNT(*)
FROM scontents
WHERE tripno=2;

  COUNT(*)  <- 컬럼명
----------
         5
         
SELECT COUNT(*) as cnt -- 함수 사용시는 컬럼 별명을 선언하는 것을 권장
FROM scontents
WHERE tripno=2;

       CNT <- 컬럼명
----------
         5

-- tripno 별 검색된 레코드 갯수
SELECT COUNT(*) as cnt
FROM scontents
WHERE tripno=2 AND word LIKE '%드라마%';

SELECT COUNT(*) as cnt
FROM scontents
WHERE tripno=2 AND (title LIKE '%드라마%' OR content LIKE '%드라마%' OR word LIKE '%드라마%');

-- SUBSTR(컬럼명, 시작 index(1부터 시작), 길이), 부분 문자열 추출
SELECT scontentsno, SUBSTR(title, 1, 4) as title
FROM scontents
WHERE tripno=2 AND (content LIKE '%학폭%');

-- SQL은 대소문자를 구분하지 않으나 WHERE문에 명시하는 값은 대소문자를 구분하여 검색
SELECT scontentsno, title, word
FROM scontents
WHERE tripno=8 AND (word LIKE '%FOOD%');

SELECT scontentsno, title, word
FROM scontents
WHERE tripno=8 AND (word LIKE '%food%'); 

SELECT scontentsno, title, word
FROM scontents
WHERE tripno=8 AND (LOWER(word) LIKE '%food%'); -- 대소문자를 일치 시켜서 검색

SELECT scontentsno, title, word
FROM scontents
WHERE tripno=8 AND (UPPER(word) LIKE '%' || UPPER('FOOD') || '%'); -- 대소문자를 일치 시켜서 검색 ★

SELECT scontentsno, title, word
FROM scontents
WHERE tripno=8 AND (LOWER(word) LIKE '%' || LOWER('Food') || '%'); -- 대소문자를 일치 시켜서 검색

SELECT scontentsno || '. ' || title || ' 태그: ' || word as title -- 컬럼의 결합, ||
FROM scontents
WHERE tripno=8 AND (LOWER(word) LIKE '%' || LOWER('Food') || '%'); -- 대소문자를 일치 시켜서 검색


SELECT UPPER('한글') FROM dual; -- dual: 오라클에서 SQL 형식을 맞추기위한 시스템 테이블

-- ----------------------------------------------------------------------------------------------------
-- 검색 + 페이징 + 메인 이미지
-- ----------------------------------------------------------------------------------------------------
-- step 1
SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM scontents
WHERE tripno=1 AND (title LIKE '%단풍%' OR content LIKE '%단풍%' OR word LIKE '%단풍%')
ORDER BY scontentsno DESC;

-- step 2
SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, rownum as r
FROM (
          SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
                     file1, file1saved, thumb1, size1, map, youtube
          FROM scontents
          WHERE tripno=1 AND (title LIKE '%단풍%' OR content LIKE '%단풍%' OR word LIKE '%단풍%')
          ORDER BY scontentsno DESC
);

-- step 3, 1 page
SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM scontents
                     WHERE tripno=1 AND (title LIKE '%단풍%' OR content LIKE '%단풍%' OR word LIKE '%단풍%')
                     ORDER BY scontentsno DESC
           )          
)
WHERE r >= 1 AND r <= 3;

-- step 3, 2 page
SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM scontents
                     WHERE tripno=1 AND (title LIKE '%단풍%' OR content LIKE '%단풍%' OR word LIKE '%단풍%')
                     ORDER BY scontentsno DESC
           )          
)
WHERE r >= 4 AND r <= 6;

-- 대소문자를 처리하는 페이징 쿼리
SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM scontents
                     WHERE tripno=1 AND (UPPER(title) LIKE '%' || UPPER('단풍') || '%' 
                                         OR UPPER(content) LIKE '%' || UPPER('단풍') || '%' 
                                         OR UPPER(word) LIKE '%' || UPPER('단풍') || '%')
                     ORDER BY scontentsno DESC
           )          
)
WHERE r >= 1 AND r <= 3;

-- ----------------------------------------------------------------------------
-- 조회
-- ----------------------------------------------------------------------------
SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM scontents
WHERE scontentsno = 1;

-- ----------------------------------------------------------------------------
-- 다음 지도, MAP, 먼저 레코드가 등록되어 있어야함.
-- map                                   VARCHAR2(1000)         NULL ,
-- ----------------------------------------------------------------------------
-- MAP 등록/수정
UPDATE scontents SET map='카페산 지도 스크립트' WHERE scontentsno=1;

-- MAP 삭제
UPDATE scontents SET map='' WHERE scontentsno=1;

commit;

-- ----------------------------------------------------------------------------
-- Youtube, 먼저 레코드가 등록되어 있어야함.
-- youtube                                   VARCHAR2(1000)         NULL ,
-- ----------------------------------------------------------------------------
-- youtube 등록/수정
UPDATE scontents SET youtube='Youtube 스크립트' WHERE scontentsno=1;

-- youtube 삭제
UPDATE scontents SET youtube='' WHERE scontentsno=1;

commit;

-- 패스워드 검사, id="password_check"
SELECT COUNT(*) as cnt 
FROM scontents
WHERE scontentsno=1 AND passwd='123';

-- 텍스트 수정: 예외 컬럼: 추천수, 조회수, 댓글 수
UPDATE scontents
SET title='기차를 타고', content='계획없이 여행 출발',  word='나,기차,생각' 
WHERE scontentsno = 2;

-- ERROR, " 사용 에러
UPDATE scontents
SET title='기차를 타고', content="계획없이 '여행' 출발",  word='나,기차,생각'
WHERE scontentsno = 1;

-- ERROR, \' 에러
UPDATE scontents
SET title='기차를 타고', content='계획없이 \'여행\' 출발',  word='나,기차,생각'
WHERE scontentsno = 1;

-- SUCCESS, '' 한번 ' 출력됨.
UPDATE scontents
SET title='기차를 타고', content='계획없이 ''여행'' 출발',  word='나,기차,생각'
WHERE scontentsno = 1;

-- SUCCESS
UPDATE scontents
SET title='기차를 타고', content='계획없이 "여행" 출발',  word='나,기차,생각'
WHERE scontentsno = 1;

commit;

-- 파일 수정
UPDATE scontents
SET file1='train.jpg', file1saved='train.jpg', thumb1='train_t.jpg', size1=5000
WHERE scontentsno = 1;

-- 삭제
DELETE FROM scontents
WHERE scontentsno = 42;

commit;

DELETE FROM scontents
WHERE scontentsno >= 7;

commit;

-- 추천
UPDATE scontents
SET recom = recom + 1
WHERE scontentsno = 1;

-- tripno FK 특정 그룹에 속한 레코드 갯수 산출
SELECT COUNT(*) as cnt 
FROM scontents 
WHERE tripno=1;

-- managerno FK 특정 관리자에 속한 레코드 갯수 산출
SELECT COUNT(*) as cnt 
FROM scontents 
WHERE managerno=1;

-- tripno FK 특정 그룹에 속한 레코드 모두 삭제
DELETE FROM scontents
WHERE tripno=1;

-- managerno FK 특정 관리자에 속한 레코드 모두 삭제
DELETE FROM scontents
WHERE managerno=1;

commit;

-- 다수의 카테고리에 속한 레코드 갯수 산출: IN
SELECT COUNT(*) as cnt
FROM scontents
WHERE tripno IN(1,2,3);

-- 다수의 카테고리에 속한 레코드 모두 삭제: IN
SELECT scontentsno, managerno, tripno, title
FROM scontents
WHERE tripno IN(1,2,3);

scontentsNO    managerNO     tripno TITLE                                                                                                                                                                                                                                                                                                       
---------- ---------- ---------- ------------------------
         3             1                   1           인터스텔라                                                                                                                                                                                                                                                                                                  
         4             1                   2           드라마                                                                                                                                                                                                                                                                                                      
         5             1                   3           컨저링                                                                                                                                                                                                                                                                                                      
         6             1                   1           마션       
         
SELECT scontentsno, managerno, tripno, title
FROM scontents
WHERE tripno IN('1','2','3');

scontentsNO    managerNO     tripno TITLE                                                                                                                                                                                                                                                                                                       
---------- ---------- ---------- ------------------------
         3             1                   1           인터스텔라                                                                                                                                                                                                                                                                                                  
         4             1                   2           드라마                                                                                                                                                                                                                                                                                                      
         5             1                   3           컨저링                                                                                                                                                                                                                                                                                                      
         6             1                   1           마션       

-- ----------------------------------------------------------------------------------------------------
-- cate + scontents INNER JOIN
-- ----------------------------------------------------------------------------------------------------
-- 모든글
SELECT c.name,
       t.scontentsno, t.managerno, t.tripno, t.title, t.content, t.recom, t.cnt, t.replycnt, t.word, t.rdate,
       t.file1, t.file1saved, t.thumb1, t.size1, t.map, t.youtube
FROM cate c, scontents t
WHERE c.tripno = t.tripno
ORDER BY t.scontentsno DESC;

-- scontents, manager INNER JOIN
SELECT t.scontentsno, t.managerno, t.tripno, t.title, t.content, t.recom, t.cnt, t.replycnt, t.word, t.rdate,
       t.file1, t.file1saved, t.thumb1, t.size1, t.map, t.youtube,
       a.mname
FROM manager a, scontents t
WHERE a.managerno = t.managerno
ORDER BY t.scontentsno DESC;

SELECT t.scontentsno, t.managerno, t.tripno, t.title, t.content, t.recom, t.cnt, t.replycnt, t.word, t.rdate,
       t.file1, t.file1saved, t.thumb1, t.size1, t.map, t.youtube,
       a.mname
FROM manager a INNER JOIN scontents t ON a.managerno = t.managerno
ORDER BY t.scontentsno DESC;

-- ----------------------------------------------------------------------------------------------------
-- View + paging
-- ----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW vscontents
AS
SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, word, rdate,
        file1, file1saved, thumb1, size1, map, youtube
FROM scontents
ORDER BY scontentsno DESC;
                     
-- 1 page
SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
       file1, file1saved, thumb1, size1, map, youtube, r
FROM (
     SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
            file1, file1saved, thumb1, size1, map, youtube, rownum as r
     FROM vscontents -- View
     WHERE tripno=14 AND (title LIKE '%야경%' OR content LIKE '%야경%' OR word LIKE '%야경%')
)
WHERE r >= 1 AND r <= 3;

-- 2 page
SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
       file1, file1saved, thumb1, size1, map, youtube, r
FROM (
     SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
            file1, file1saved, thumb1, size1, map, youtube, rownum as r
     FROM vscontents -- View
     WHERE tripno=14 AND (title LIKE '%야경%' OR content LIKE '%야경%' OR word LIKE '%야경%')
)
WHERE r >= 4 AND r <= 6;


-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 좋아요(recom) 기준, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT scontentsno, managerno, tripno, title, thumb1, r
FROM (
           SELECT scontentsno, managerno, tripno, title, thumb1, rownum as r
           FROM (
                     SELECT scontentsno, managerno, tripno, title, thumb1
                     FROM scontents
                     WHERE tripno=1
                     ORDER BY recom DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 평점(score) 기준, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM scontents
                     WHERE tripno=1
                     ORDER BY score DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 최신 상품 기준, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM scontents
                     WHERE tripno=1
                     ORDER BY rdate DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 조회수 높은 상품기준, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM scontents
                     WHERE tripno=1
                     ORDER BY cnt DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 낮은 가격 상품 추천, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM scontents
                     WHERE tripno=1
                     ORDER BY price ASC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 높은 가격 상품 추천, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT scontentsno, managerno, tripno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM scontents
                     WHERE tripno=1
                     ORDER BY price DESC
           )          
)
WHERE r >= 1 AND r <= 7;

ROLLBACK;